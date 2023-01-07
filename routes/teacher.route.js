import express from 'express';
import multer from 'multer';
import moment from 'moment';
import teacherService from '../services/teacher.service.js';
const router = express.Router();

function authTeacher(req, res, next) {
    if(req.session.auth === false) {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    if (req.session.authUser.LoaiTaiKhoan !== "Giáo Viên") {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    next();
}

async function isYourCourse(req, res, next) {
    const courseId = req.params.id || 0;
    if (await teacherService.isTeacherOfThisCourse(req.session.authUser.MaTaiKhoan, courseId) === false) {
        return res.redirect('/');
    }
    next();
}

async function isYourProfile(req, res, next) {
    const teacherId = req.params.id || 0;
    const accountID = await teacherService.findAccountByIdTeacher(teacherId);
    console.log(req.session.authUser.MaTaiKhoan, '      ', accountID.MaTaiKhoan);
    if (req.session.authUser.MaTaiKhoan !== accountID.MaTaiKhoan)
        return res.redirect('/');
    next();
}

router.get('/', async function (req, res) {
    const teacher = await teacherService.findAllTeacher();
    res.render('vwTeacher/teacher', {
        teacher : teacher
    });
});

router.get('/input', authTeacher, async function (req, res){
   const field = await teacherService.findField();
   const ngonNgu = await teacherService.findNgonNgu();
   res.render('vwTeacher/inputcourse', {
       linhVuc: field,
       ngonNgu: ngonNgu,
    });
});

router.get('/input/:id', authTeacher, isYourCourse,async function (req, res){
    const courseId = req.params.id || 0;
    const field = await teacherService.findFieldById(courseId);
    const ngonNgu = await teacherService.findNgonNguById(courseId);
    const info = await teacherService.findInfoCourseById(courseId);
    const video = await teacherService.findVideoById(courseId);
    let checked = true;
    if (info.TrangThai === 'Chưa hoàn thành') {
        checked = false;
    }
    const numVideo = video.length;
    // console.log(field);
    // console.log(info);
    // console.log(video);
    res.render('vwTeacher/inputcourse', {
        linhVuc: field,
        ngonNgu: ngonNgu,
        info: info,
        checked,
        video: video,
        numVideo: numVideo,
    });
});

router.post('/input/:id', function (req, res){
    var file_name;
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, './public/img/courses');
        },
        filename: function (req, file, cb) {
            file_name = file.originalname;
            cb(null, file.originalname);
        }
    });

    const upload = multer({ storage: storage });
    upload.array('Image', 5)(req, res, async function (err) {
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            const courseId = req.params.id || 0;
            if (obj.Image === '') {
                obj.Image = await teacherService.getNameCourseImage(courseId).Image;
            } else {
                obj.Image = file_name;
            }

            if (obj.check === 'on')
                obj.isDone = 'Đã hoàn thành';
            else
                obj.isDone = 'Chưa hoàn thành';

            if (obj.url_no[obj.url_no.length - 1] === '')
                obj.SoLuongVideo = obj.url_no.length - 1;
            else
                obj.SoLuongVideo = obj.url_no.length;

            var currentdate = new Date();
            var datetime = currentdate.getFullYear() + "-"
                + (currentdate.getMonth()+1)  + "-"
                + currentdate.getDate() + " "
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds();
            obj.dateTime = datetime;


            const affected_rows_khoahoc = await teacherService.editKhoaHoc(courseId, obj);
            const affected_rows_chitietkhoahoc = await teacherService.editChiTietKhoaHoc(courseId, obj);
            const affected_rows_del_danhsachvideo = await teacherService.deleteDanhSachVideoById(courseId);
            for(let i = 0; i < obj.topic_no.length; i++) {
                if (obj.topic_no[i] === '')
                    continue;
                    await teacherService.insertDanhSachVideo(courseId, i, obj.url_no[i], datetime, obj.topic_no[i], "");
            }
            console.log(obj);
            res.redirect('/teacher/input/' + courseId);
        }
    })
});

router.post('/input', function (req, res){
    var file_name;
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, './public/img/courses');
        },
        filename: function (req, file, cb) {
            file_name = file.originalname;
            cb(null, file.originalname);
        }
    });

    const upload = multer({ storage: storage });
    upload.array('Image', 5)(req, res, async function (err) {
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            var currentdate = new Date();
            var date = currentdate.getFullYear() + "/"
                + (currentdate.getMonth()+1)  + "/"
                + currentdate.getDate();
            var datetime = currentdate.getFullYear() + "-"
                + (currentdate.getMonth()+1)  + "-"
                + currentdate.getDate() + " "
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds();
            obj.dateTime = datetime;
            obj.Image = file_name;

            if (obj.check === 'on')
                obj.isDone = 'Đã hoàn thành';
            else
                obj.isDone = 'Chưa hoàn thành';
            if (obj.Gia === '')
                obj.Gia = 0;
            if (obj.KhuyenMai === '')
                obj.KhuyenMai = 0;
            if (obj.url_no[obj.url_no.length - 1] === '')
                obj.SoLuongVideo = obj.url_no.length - 1;
            else
                obj.SoLuongVideo = obj.url_no.length;

            if (obj.NgayBD === '____/__/__')
                obj.NgayBD = date;
            if (obj.NgayKT === '____/__/__')
                obj.NgayKT = date;

            const accountId = req.session.authUser.MaTaiKhoan || 1;
            console.log(accountId);
            const teacherId = await teacherService.findTeacherIdByAccountId(accountId);
            console.log(await teacherService.findTeacherIdByAccountId(accountId));
            obj.GiaoVien = teacherId;
            await teacherService.insertNewCourse(obj);
            const courseId = await teacherService.findCourseId(obj) || 0;



            const affected_rows_chitietkhoahoc = await teacherService.insertChiTietKhoaHoc(courseId, obj);
            const affected_rows_del_danhsachvideo = await teacherService.deleteDanhSachVideoById(courseId);
            for(let i = 0; i < obj.topic_no.length; i++) {
                if (obj.topic_no[i] === '')
                    continue;
                await teacherService.insertDanhSachVideo(courseId, i, obj.url_no[i], datetime, obj.topic_no[i], "");
            }
            console.log(obj);
            res.redirect(`/teacher/input/${courseId}`);
        }
    })
});

router.get('/profile', authTeacher, async function (req, res){
    const accountId = req.session.authUser.MaTaiKhoan || 1;
    const teacherId = await teacherService.findTeacherIdByAccountId(accountId);
    res.redirect('/teacher/profile/' + teacherId);
});

router.get('/profile/:id', authTeacher, isYourProfile, async function (req, res){
    const teacherId = req.params.id || 0;
    const teacher = await teacherService.findTeacherById(teacherId);

    res.render('vwAccount/editProfile', {
        info: teacher
    });
});

router.post('/profile/:id', function (req, res){
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
            const teacherId = req.params.id || 0;
            const affected_rows = await teacherService.editGiaovien(obj.Mota, teacherId);
            const accountId = await teacherService.findAccountByIdTeacher(teacherId);
            if (obj.Avatar === null) {
                obj.Avatar = await teacherService.getNameImage(accountId).Avatar;
            } else {
                obj.Avatar = file_name;
            }
            const affected_rows_= await teacherService.editTaikhoan(obj, accountId.MaTaiKhoan);
            
            var user = await teacherService.findTeacherById(teacherId);
            delete user.Password;
            user.DOB = moment(user.DOB, 'YYYY/MM/DD').format('DD/MM/YYYY');
            user.Mota = obj.Mota;
            user.Website = obj.Website;
            console.log(user);

            req.session.authUser = user;
            res.redirect('/teacher/profile/' + teacherId);
        }
    })
});

router.post('/profile', authTeacher, function (req, res){
    console.log(req.body);
    res.render('vwAccount/editProfile');
});

router.get('/courses', authTeacher, async function (req, res){
    const accountId = req.session.authUser.MaTaiKhoan || 0;
    // const accountId = 1; // temp
    const teacherId = await teacherService.findTeacherIdByAccountId(accountId);
    const courses = await teacherService.findCoursesByIdTeacher(teacherId);
    console.log(courses);
    res.render('vwTeacher/courses', {
        empty: false,
        courses: courses,
    });
});
export default router;