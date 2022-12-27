import express from 'express';
import multer from 'multer';
import teacherService from '../services/teacher.service.js';
const router = express.Router();


router.get('/', function (req, res) {
    res.render('teacher');
});

router.get('/input', async function (req, res){
   const field = await teacherService.findField();
   res.render('vwTeacher/inputcourse', {
       linhVuc: field,
    });
});

router.get('/input/:id', async function (req, res){
    const courseId = req.params.id || 0;
    const field = await teacherService.findFieldById(courseId);
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
    console.log(req.body);
    res.render('vwTeacher/inputcourse');
});

router.get('/profile', function (req, res){
    res.render('vwTeacher/profile');
});

router.get('/profile/:id', async function (req, res){
    const teacherId = req.params.id || 0;
    const teacher = await teacherService.findTeacherById(teacherId);

    res.render('vwTeacher/profile', {
        teacher: teacher
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
            res.redirect('/teacher/profile/' + teacherId);
        }
    })
});

router.post('/profile', function (req, res){
    console.log(req.body);
    res.render('vwTeacher/profile');
});

router.get('/courses', function (req, res){
    res.render('vwTeacher/courses', {
        empty: false
    });
});

export default router;