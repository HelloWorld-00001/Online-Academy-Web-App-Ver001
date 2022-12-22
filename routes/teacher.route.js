import express from 'express';
import multer from 'multer';
import teacherService from '../services/teacher.service.js';
const router = express.Router();


router.get('/', function (req, res) {
    res.render('teacher');
});

router.get('/input', function (req, res){
   res.render('vwTeacher/inputcourse');
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
    // console.log(teacher);
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
            if (obj.Avatar === '') {
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