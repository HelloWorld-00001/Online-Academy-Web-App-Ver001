import express from 'express';
import adminService from '../services/admin.service.js';
import studentService from '../services/student.service.js';
import accountService from '../services/account.service.js';
import teacherService from '../services/teacher.service.js';
import mailer from '../services/mail.service.js';

import bcrypt from 'bcryptjs';
import moment from 'moment';
import multer from 'multer';

import courseService from '../services/course.service.js';
const router = express.Router();

function authAdmin(req, res, next) {
    if(req.session.auth === false) {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    if (req.session.authUser.LoaiTaiKhoan !== "Admin") {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    next();
}

router.get('/', authAdmin, async function (req, res) {
    const numofAcc = await adminService.countAllUser();
    const numofTeacher = await adminService.countAllTeacher();
    const numofStudent = await adminService.countAllStudent();
    const numofCate = await adminService.countAllCate();
    const numofCourse = await adminService.countAllCourse();
    const numofVideo = await adminService.countAllVid();
    res.render('vwAdmin/dashboard', {
        layout: 'adminLayout',
        numofAcc,
        numofTeacher,
        numofStudent,
        numofCate,
        numofCourse,
        numofVideo
    });
});

router.get('/allTable', authAdmin, async function(req, res) {

    const studentList = await adminService.findTopThreeStudent();
    const teacherList = await adminService.findTopThreeTeacher();
    const courseList = await adminService.findTopThreeCourse();
    const videoList = await adminService.findTopThreeVideo();

    res.render('vwAdmin/allTable', {
        layout: 'adminLayout',
        teacher: teacherList,
        student: studentList,
        course: courseList,
        video: videoList
    });
});

/* Teacher Management Section */
router.get('/teachers', authAdmin, async function(req, res) {
    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teachers', {
        layout: 'adminLayout',
        teacher: teacherList
    });
});

router.post('/teachers', async function(req, res) {
    const result = req.body;
    const id = result.MaHocVien;

    if(result.lockAccount === "lock") {
        await adminService.lockAccount(req.body.MaTaiKhoan);
    }

    if(result.unlockAccount === "unlock") {
        await adminService.unlockAccount(req.body.MaTaiKhoan);
    }

    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teachers', {
        layout: 'adminLayout',
        teacher: teacherList
    });
});

router.get('/addTeacher', authAdmin, function (req, res){
    res.render('vwAdmin/manage/add', {
        layout: 'adminLayout',
    });
});

router.post('/addTeacher', async function (req, res){
    const rawPassword = req.body.Password;
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(rawPassword, salt);
    req.body.Password = hash;

    const x = await teacherService.addAccount(req.body);
    const MaTk = await teacherService.findIdTeacher(req.body.Username);
    const y = await teacherService.add(req.body, MaTk[0]);
    res.render('vwAdmin/manage/add', {
        layout: 'adminLayout',
    });
});

router.post('/delTeacher', async function (req, res){
    console.log(req.body);
    res.render('vwAdmin/teachers', {
        layout: 'adminLayout',
    });
});
router.get('/delTeacher', authAdmin, async function (req, res){
    const id = req.query.id;
    await teacherService.delTeacher(id);
    await teacherService.delAccount(id);

    res.redirect('/admin/teachers');
});

router.get('/editTeacher', authAdmin, async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: teacher
    });

});

router.post('/editTeacher', async function (req, res){
    var file_name;
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, './public/img/teachers');
        },
        filename: function (req, file, cb) {
            file_name = file.originalname;
            cb(null, file.originalname);
        }
    });


    const upload = multer({ storage: storage });
    upload.array('Avatar', 5)(req, res, async function (err) {
        console.log(req.body);
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            const teacherId = req.query.id || 0;
            const teacherPre = await teacherService.findTeacherById(teacherId);

            const affected_rows = await teacherService.editGiaovien(obj.Mota, teacherId);
            const accountId = await teacherService.findAccountByIdTeacher(teacherId);
            if (obj.Avatar === null) {
                obj.Avatar = await teacherService.getNameImage(accountId).Avatar;
            } else {
                obj.Avatar = file_name;
            }

            if(teacherPre.Email !== obj.Email) {
                const check = await mailer.isEmailValid(req.body.Email);
                if(check.valid === false) {
                    obj.Email = teacherPre.Email;
                    const affected_rows_= await teacherService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const teacher = await teacherService.findTeacherById(teacherId);

                    return res.render('vwAdmin/manage/edit', {
                        layout: 'adminLayout',
                        info: teacher,
                        err_message: "This Email does not exist"
                    });
                }
                
                const userCheck = await accountService.findByEmail(req.body.Email);
                if(userCheck !== null) {
                    obj.Email = teacherPre.Email;
                    const affected_rows_= await teacherService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const teacher = await teacherService.findTeacherById(teacherId);

                    return res.render('vwAdmin/manage/edit', {
                        layout: 'adminLayout',
                        info: teacher,
                        err_message: "Email has been used."
                    });
                } 
            }

            const affected_rows_= await teacherService.editTaikhoan(obj, accountId.MaTaiKhoan);
            res.redirect('/admin/editTeacher?id=' + teacherId);
        }
    })
});

router.get('/viewTeacher', authAdmin, async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);
    teacher.DOB = moment(teacher.DOB).format('DD/MM/YYYY');

    res.render('vwAdmin/manage/view', {
        layout: 'adminLayout',
        info: teacher
    });

});


/* Category Management Section */
router.get('/categories', async function(req, res) {
    const categories = await adminService.findAllCategory();
    res.render('vwAdmin/categories', {
        layout: 'adminLayout',
        categories: categories
    });
});
router.post('/categories', async function(req, res) {
    console.log(req.body);
    const result = req.body;
    
    if (result.addCategory === 'add') {
        console.log(result.Name);
        await adminService.addCategory(result.Name);
        const categories = await adminService.findAllCategory();
        res.redirect('/admin/categories');
    }
    if (result.btnDelete === 'delete') {
        const id = result.id;
        const amountC = await adminService.countCoursebyCateID(id);
        if (amountC.amount === 0) {
            console.log(amountC.amount, '1');
            await adminService.delCategory(id);
            res.redirect('/admin/categories');
        }
        else {
            console.log(amountC.amount, '2');
            const categories = await adminService.findAllCategory();
            return res.render('vwAdmin/categories', {
                layout: 'adminLayout',
                categories: categories,
                err_message: true,
            });
        }
    }
});

/* Course Management Section */
router.get('/courses', async function(req, res) {
    const courses = await adminService.findAllCourse();
    res.render('vwAdmin/course/courses', {
        layout: 'adminLayout',
        courses: courses
    });
});

//Student
router.get('/students', authAdmin, async function(req, res) {
    const studentList = await studentService.findAll();
    
    res.render('vwAdmin/student/students', {layout: 'adminLayout',
        teacher: studentList
    });
});

router.post('/students', async function(req, res) {
    const result = req.body;
    const idAccount = result.MaTaiKhoan;
    const id = result.MaHocVien;

    if(result.deleteStudent === 'delete') {
        await studentService.delBangDanhGia(id);
        await studentService.delDanhSachDangKi(id);
        await studentService.del(id);
        await accountService.del(idAccount);
    }

    if(result.grantStudent === 'grant') {
        await accountService.grantTeacher(idAccount);
        await studentService.delBangDanhGia(id);
        await studentService.delDanhSachDangKi(id);
        await studentService.del(id);
    
        const teacher = {
            MaTaiKhoan: idAccount,
            SLKhoaHoc: 0,
            MoTa: ""
        }
        await teacherService.addTeacher(teacher);
    }
    
    if(result.grantAdmin === 'grant') {
        await accountService.grantAdmin(idAccount);
        await studentService.delBangDanhGia(id);
        await studentService.delDanhSachDangKi(id);
        await studentService.del(id);
    }

    if(result.lockAccount === "lock") {
        await adminService.lockAccount(req.body.MaTaiKhoan);
    }

    if(result.unlockAccount === "unlock") {
        await adminService.unlockAccount(req.body.MaTaiKhoan);
    }

    const studentList = await studentService.findAll();
    res.render('vwAdmin/student/students', {layout: 'adminLayout',
        teacher: studentList
    });
});


router.get('/addStudent', authAdmin, async function (req, res){
    res.render('vwAdmin/manage/add', {
        layout: 'adminLayout',
        isStudent: true,
    });
});

router.post('/addStudent', async function (req, res){
    const student = req.body;
    console.log(student);

    const rawPassword = student.Password;
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(rawPassword, salt);
    student.Password = hash;

    await accountService.add(student);
    const account = await accountService.findByUsername(student.Username);
    console.log(account);
    await studentService.add(account.MaTaiKhoan);

    res.render('vwAdmin/manage/add', {
        layout: 'adminLayout',
        info: student,
        isStudent: true
    });
});

router.get('/editStudent', authAdmin, async function (req, res){
    const id = req.query.id;
    const student = await studentService.findByID(id);
    console.log(student);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: student,
        isStudent: true
    });
});

router.post('/editStudent', async function (req, res){
    var file_name;
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, './public/img/students');
        },
        filename: function (req, file, cb) {
            file_name = file.originalname;
            cb(null, file.originalname);
        }
    });


    const upload = multer({ storage: storage });
    upload.array('Avatar', 5)(req, res, async function (err) {
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            const studentId = req.query.id || 0;
            const studentPre = await studentService.findStudentById(studentId);
            const accountId = await studentService.findAccountIdByIdStudent(studentId);

            if (obj.Avatar === null) {
                obj.Avatar = await studentService.getNameImage(accountId).Avatar;
            } else {
                obj.Avatar = file_name;
            }

            if(studentPre.Email !== obj.Email) {
                const check = await mailer.isEmailValid(req.body.Email);
                if(check.valid === false) {
                    obj.Email = studentPre.Email;
                    const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const student = await studentService.findStudentById(studentId);
                    
                    return res.render('vwAdmin/manage/edit', {
                        layout: 'adminLayout',
                        info: student,
                        err_message: "This Email does not exist"
                    });
                }
                
                const userCheck = await accountService.findByEmail(req.body.Email);
                if(userCheck !== null) {
                    obj.Email = studentPre.Email;
                    const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const student = await studentService.findStudentById(studentId);
                    
                    return res.render('vwAdmin/manage/edit', {
                        layout: 'adminLayout',
                        info: student,
                        err_message: "Email has been used."
                    });
                } 
            }
            const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
            
            res.redirect('/admin/editStudent?id=' + studentId);
        }
    })
});

router.get('/viewStudent', authAdmin, async function (req, res){
    const id = req.query.id;
    const student = await studentService.findByID(id);
    const isStudent = true;
    student.DOB = moment(student.DOB, 'YYYY-MM-DD').format('DD-MM-YYYY');
    res.render('vwAdmin/manage/view', {
        layout: 'adminLayout',
        info: student,
        isStudent
    });

});

router.get('/addStudent', authAdmin, async function (req, res){
    const id = req.query.id;

    res.render('vwAdmin/manage/add', {
        layout: 'adminLayout',
        isStudent: true
    });
});

router.post('/addStudent', async function (req, res){
    const student = req.body;
    console.log(student);
    await accountService.edit(student.MaTaiKhoan, student);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: student,
        isStudent: true
    });
});

router.post('/delCourse', async function (req, res){
    console.log(req.body);
    //await teacherService.del(req.body.MaGiaoVien);
    //await teacherService.delAccount(req.body.MaTaiKhoan);

    res.render('vwAdmin/course/courses', {
        layout: 'adminLayout',
    });
});
router.get('/delCourse', async function (req, res){
    console.log(req.query);
    const id = req.query.id;
    await courseService.delAllVidCoursebyID(id);
    await courseService.delDetailCoursebyID(id);
    await courseService.delRegCoursebyID(id);
    await courseService.delRatingCoursebyID(id);
    await courseService.delCoursebyID(id)

    res.redirect('/admin/courses');
});

router.get('/viewCourse', async function (req, res){
    console.log(req.query);
    const mkh = req.query.id;
    const course = await courseService.findDetailCourseByID(mkh);
    if (course === null) {
        return res.redirect('/');
    }

    const courseVideoList = await courseService.findCourseVideoList(mkh);
    const top5CousresMostView = await courseService.findTop5MostViewWithField(course.LinhVuc, mkh);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);
    const studentReviewList = await courseService.getStudentReviewList(mkh);

    for(let i = 0; i < courseVideoList.length; i++) {
        if(i === 0 || i === 1) {
            Object.assign(courseVideoList[i], {isShowVideo: true});
        }
        else {
            Object.assign(courseVideoList[i], {isShowVideo: false});
        }
    }

    var isCoursesRegister = false;
    
    if(req.session.auth === true){
        if(req.session.authUser.LoaiTaiKhoan === 'Học Viên') {
            const idStudent = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
            const courseRegistered = await courseService.isCourseRegister(makhoahoc, idStudent.MaHocVien);
            if(courseRegistered !== null)
                isCoursesRegister = true;
        }
    }
    res.render('vwAdmin/course/view', {
        layout: 'adminLayout',
        course: course,
        courseVideoList: courseVideoList,
        isVideoListEmpty: courseVideoList.length === 0,
        top5CousresMostVie: top5CousresMostView,
        inforStudentsOfTeacher: inforStudentsOfTeacher,
        studentReviewList: studentReviewList,
    });
});

router.get('/videos', function(req, res) {
    res.render('vwAdmin/videos', {
        layout: 'adminLayout'
    })
});

//admin info
router.get('/profile', authAdmin, function(req, res) {
    const user = req.session.authUser;
    if(user.DOB !== null)
        user.DOB = moment(user.DOB).format('DD/MM/YYYY');
  
    res.render('vwAdmin/manage/view',{
        layout: 'adminLayout',
        info: user
    });
});

router.get('/changePassword', authAdmin, function(req, res) {
    return res.render('vwAdmin/changePassword', {
        layout:'adminLayout'
    });
})
  
  router.post('/changePassword', async function(req, res) {
    const user = await accountService.findByUsername(req.session.authUser.Username);
    const receivePassword = req.body.currentPassword;
  
    const ret = bcrypt.compareSync(receivePassword, user.Password);
    if(ret === false) {
      return res.render('vwAdmin/changePassword', {
        layout: 'adminLayout',
          err_message: "Current password you enter is wrong. Try Again"
      });
    }
  
    const checkSame = (req.body.newPassword === req.body.confirmPassword);
    if(checkSame === false) {
      return res.render('vwAdmin/changePassword', {
        layout: 'adminLayout',
          err_message: "New password and confirm password are not same. Try Again"
      });
    }
  
    delete user.Password;
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(req.body.newPassword, salt);
    await accountService.updatePassword(user.MaTaiKhoan, hash);
  
    res.render('vwAdmin/changePassword', {
        layout: 'adminLayout',
        success_message: "Change Password Successful."
    });
})

router.get('/editProfile', authAdmin, async function (req, res){
    const admin = await accountService.findByID(req.session.authUser.MaTaiKhoan);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: admin,
        isAdmin: true
    });
});

router.post('/editProfile', function (req, res){
    var file_name;
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, './public/img/admins');
        },
        filename: function (req, file, cb) {
            file_name = file.originalname;
            cb(null, file.originalname);
        }
    });


    const upload = multer({ storage: storage });
    upload.array('Avatar', 5)(req, res, async function (err) {
        console.log(req.body);
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            const accountID = req.session.authUser.MaTaiKhoan;
            if (obj.Avatar === null) {
                obj.Avatar = await studentService.getNameImage(accountID).Avatar;
            } else {
                obj.Avatar = file_name;
            }
            const affected_rows_= await accountService.edit(accountID, obj);
            
            const user = await accountService.findByID(accountID);
            delete user.Password;
            user.DOB = moment(user.DOB).format('DD/MM/YYYY');
            
            req.session.authUser = user;
            res.redirect('/admin/editProfile');
        }
    })
});
export default router;