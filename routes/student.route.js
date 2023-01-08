import express from 'express';
import multer from 'multer';
import studentService from '../services/student.service.js';
import accountService from '../services/account.service.js';
import moment from 'moment';
import mailer from '../services/mail.service.js';

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

router.post('/profile/:id',async function (req, res){
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
            
            if(req.session.authUser.Email !== obj.Email) {
                const check = await mailer.isEmailValid(req.body.Email);
                if(check.valid === false) {
                    obj.Email = req.session.authUser.Email;
                    const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const student = await studentService.findStudentById(studentId);
                    
                    req.session.authUser = student;
                    return res.render('vwAccount/editProfile', {
                        info: student,
                        err_message: "This Email does not exist"
                    });
                }
                
                const userCheck = await accountService.findByEmail(req.body.Email);
                if(userCheck !== null) {
                    obj.Email = req.session.authUser.Email;
                    const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
                    const student = await studentService.findStudentById(studentId);
                    
                    req.session.authUser = student;
                    return res.render('vwAccount/editProfile', {
                        info: student,
                        err_message: "Email has been used."
                    });
                } 
            }

            const affected_rows_= await studentService.editTaikhoan(obj, accountId.MaTaiKhoan);
            const user = await studentService.findByID(studentId);
            user.DOB = moment(user.DOB).format('DD/MM/YYYY');
            
            req.session.authUser = user;
            res.redirect('/student/profile/' + studentId);
        }
    })
});

export default router;