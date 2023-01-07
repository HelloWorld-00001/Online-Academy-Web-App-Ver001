import express from 'express';
import multer from 'multer';
import studentService from '../services/student.service.js';
import moment from 'moment';
const router = express.Router();

function authStudent(req, res, next) {
    if(req.session.auth === false) {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    if (req.session.authUser.LoaiTaiKhoan !== "Học Viên") {
        req.session.retUrl = req.originalUrl;
        return res.redirect('/');
    }
    next();
}

router.get('/profile', authStudent, async function (req, res){
    const accountId = req.session.authUser.MaTaiKhoan || 1;
    const studentId = await studentService.findStudentIdByAccountId(accountId);
    res.redirect('/student/profile/' + studentId);
    console.log(studentId);
});

router.get('/profile/:id', authStudent, async function (req, res){
    const studentId = req.params.id || 0;
    const student = await studentService.findStudentById(studentId);

    res.render('vwAccount/editProfile', {
        info: student
    });
});

router.post('/profile/:id', function (req, res){
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
        console.log(req.body);
        if (err) {
            console.error(err);
        } else {
            const obj = JSON.parse(JSON.stringify(req.body));
            const studentId = req.params.id || 0;
            const accountId = await studentService.findAccountIdByIdStudent(studentId);
            if (obj.Avatar === null) {
                obj.Avatar = await studentService.getNameImage(accountId).Avatar;
            } else {
                obj.Avatar = file_name;
            }
            const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
            
            const user = await studentService.findByID(studentId);
            delete user.Password;
            user.DOB = moment(user.DOB).format('DD/MM/YYYY');
            
            req.session.authUser = user;
            res.redirect('/student/profile/' + studentId);
        }
    })
});

router.post('/profile', function (req, res){
    console.log(req.body);
    res.render('vwAccount/editProfile');
});

export default router;