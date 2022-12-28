import express from 'express';
import adminService from '../services/admin.service.js';
import studentService from '../services/student.service.js';
import accountService from '../services/account.service.js';
import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', async function (req, res) {
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

router.get('/profile', function(req, res) {
    res.render('vwAdmin/profile', {
        layout: 'adminLayout'
    });
});

router.get('/allTable', async function(req, res) {

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
router.get('/teachers', async function(req, res) {
    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teachers', {
        layout: 'adminLayout',
        teacher: teacherList
    });
});

router.get('/addTeacher', function (req, res){
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
router.get('/delTeacher', async function (req, res){
    const id = req.query.id;
    await teacherService.delTeacher(id);
    await teacherService.delAccount(id);

    res.redirect('/admin/teachers');
});

router.get('/editTeacher', async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: teacher
    });

});

router.post('/editTeacher', async function (req, res){
    const id = req.query.id;
    var teacher = req.body;
    
    await accountService.edit(teacher.MaTaiKhoan, teacher);
    await teacherService.editGiaovien(req.body.MoTa, id);

    teacher = await teacherService.findTeacherById(id);
    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: teacher
    });

});

router.get('/viewTeacher', async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);
    console.log(teacher);

    res.render('vwAdmin/manage/view', {
        layout: 'adminLayout',
        info: teacher
    });

});
router.post('/teachers', async function(req, res) {
    //await teacherService.del(req.body.MaGiaoVien);
    //await teacherService.delAccount(req.body.MaTaiKhoan);
    res.render('vwAdmin/manage/teachers', {
        layout: 'adminLayout',
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
router.get('/students', async function(req, res) {
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

    const studentList = await studentService.findAll();
    res.render('vwAdmin/student/students', {layout: 'adminLayout',
        teacher: studentList
    });
});


router.get('/addStudent', async function (req, res){
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

router.get('/editStudent', async function (req, res){
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
    const student = req.body;
    console.log(student);
    await accountService.edit(student.MaTaiKhoan, student);

    res.render('vwAdmin/manage/edit', {
        layout: 'adminLayout',
        info: student,
        isStudent: true
    });
});

router.get('/viewStudent', async function (req, res){
    const id = req.query.id;
    const student = await studentService.findByID(id);
    const isStudent = true;

    res.render('vwAdmin/manage/view', {
        layout: 'adminLayout',
        info: student,
        isStudent
    });

});

router.get('/addStudent', async function (req, res){
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

export default router;