import express from 'express';
import bcrypt from 'bcryptjs';
import moment from 'moment';
import randomInteger from 'random-int';

import accountService from '../services/account.service.js';
import studentService from '../services/student.service.js';
import mailer from '../services/mail.service.js';

const router = express.Router();
//Register
router.get('/register', NotAuth, async function (req, res) {
  res.render('vwAccount/register', {layout: false});
});

router.post('/register', function (req, res) {
  const rawPassword = req.body.password;
  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(rawPassword, salt);
  const dob = moment(req.body.dob, 'DD-MM-YYYY').format('YYYY-MM-DD');
  
  const user = {
    Username: req.body.username,
    Password: hash,
    Name: req.body.name,
    DOB: dob,
    Email: req.body.email,
    LoaiTaiKhoan: 'Học Viên',
    Avatar: null,
    SDT: null,
    DiaChi: null
  }

  const otp = randomInteger(100000, 999999).toString();
  mailer.sendMail(user.Email,otp);

  req.session.regis = true;
  req.session.temp = user;
  req.session.otp = otp;
  res.redirect('/account/sendOTP');
});

router.get('/is-available', async function (req, res) {
  const username = req.query.username;
  const email = req.query.email;
  const check = req.query.check;

  var checkUsername = true;
  var checkMail = true;

  const user1 = await accountService.findByUsername(username);
  if (user1 !== null) {
    checkUsername = false;
  }

  const user2 = await accountService.findByEmail(email);
  if(user2 !== null) {
    checkMail = false;
  }

  if(checkUsername === false && checkMail === false) { 
    return res.json('FailTwo');
  }
  if(checkUsername === false) {
    return res.json('FailUsername');
  }
  if(checkMail === false) {
    // return res.json('FailEmail');
  }
  
  const checkMailExist = await mailer.isEmailValid(email);
  if(checkMailExist.valid === false) {
    return res.json('EmailNotExist');
  }

  if(check === 'false') {
    return res.json('FailCheck');
  }
    
  res.json(true);
});

//otp
router.get('/sendOTP', regis, async function (req, res) {
  res.render('vwAccount/handleOTP', {layout: false});
});

router.post('/sendOTP', async function (req, res) {
  const newUser = req.session.temp;  
  await accountService.add(newUser);

  const user = await accountService.findByUsername(newUser.Username);
  await studentService.add(user.MaTaiKhoan);

  req.session.regis = false;
  req.session.temp = null;

  req.session.authUser = user;
  req.session.auth = true;
  const student = await accountService.findStudentByID(user.MaTaiKhoan);
  return res.redirect('/student/profile/' + student.MaHocVien);
});

router.get('/is-true-otp', async function (req, res) {
  const otp = req.session.otp;
  const answer = req.query.user;
  if (answer === otp) {
    return res.json(true);
  }

  res.json(false);
});

//login
router.get('/login', NotAuth, async function (req, res) {
  res.render('vwAccount/login', {layout: false});
});

router.post('/login', async function (req, res) {
  const user = await accountService.findByUsername(req.body.username);
  
  if (user === null) {
    return res.render('vwAccount/login', {
      layout: false,
      err_message: 'Invalid username or password.'
    });
  }

  const ret = bcrypt.compareSync(req.body.password, user.Password);
  if (ret === false) {
    return res.render('vwAccount/login', {
      layout: false,
      err_message: 'Invalid username or password.'
    });
  }
  delete user.Password;

  user.DOB = moment(user.DOB).format('DD/MM/YYYY');
  
  req.session.auth=true;
  req.session.authUser=user;

  if(user.LoaiTaiKhoan === 'Admin') {
    return res.redirect('/admin');
  }

  const url = req.session.retUrl || '/';
  res.redirect(url);
});

//logout
router.post('/logout', async function(req, res){
  console.log(req.session.wishList);
  req.session.auth=false;
  req.session.authUser=null;
  
  const url = req.session.retUrl || '/';
  res.redirect(url);
});

function auth(req, res, next) {
  if(req.session.auth === false) {
    req.session.retUrl = req.originalUrl;
    return res.redirect('/');
  }

  next();
}

function NotAuth(req, res, next) {
  if(req.session.auth === true) {
    return res.redirect('/');
  }

  next();
}

function regis(req, res, next) {
  if(req.session.regis === false) {
    return res.redirect('/');
  }

  next();
}

//profile
router.get('/profile', auth, async function(req, res) {
  const user = req.session.authUser;
  var MoTa = null;
  if(user.LoaiTaiKhoan === 'Giáo Viên') {
    const teacher = await accountService.findTeacherByID(user.MaTaiKhoan);
    MoTa = teacher.MoTa;
  }
  
  if(user.DOB != null)
    user.DOB = moment(user.DOB).format('DD/MM/YYYY');

  res.render('vwAccount/profile',{
    MoTa,
    user
  });
})

//changePassword
router.get('/changePassword', auth, function(req, res) {
  return res.render('vwAccount/changePassword');
})

router.post('/changePassword', auth, async function(req, res) {
  const user = await accountService.findByUsername(req.session.authUser.Username);
  const receivePassword = req.body.currentPassword;

  const ret = bcrypt.compareSync(receivePassword, user.Password);
  if(ret === false) {
    return res.render('vwAccount/changePassword', {
      err_message: "Current password you enter is wrong. Try Again"
    });
  }

  const checkSame = (req.body.newPassword === req.body.confirmPassword);
  if(checkSame === false) {
    return res.render('vwAccount/changePassword', {
      err_message: "New password and confirm password are not same. Try Again"
    });
  }

  delete user.Password;
  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(req.body.newPassword, salt);
  await accountService.updatePassword(user.MaTaiKhoan, hash);

  res.render('vwAccount/changePassword', {
    success_message: "Change Password Successful."
  });
})

//Forgot Password 
router.get('/forgotPassword', NotAuth, async function (req, res) {
  res.render('vwAccount/forgotPassword', {layout: false});
});

router.get('/is-exist', async function (req, res) {
  const info = req.query.user;

  var user = await accountService.findByEmail(info);
  if(user !== null) {
    req.session.temp = user;
    return res.json(true);
  }

  user = await accountService.findByUsername(info);
  if(user !== null) {
    req.session.temp = user;
    return res.json(true);
  }

  res.json(false);
});

router.post('/forgotPassword', NotAuth, async function (req, res) {
  const email = req.session.temp.Email;
  const otp = randomInteger(100000, 999999).toString();
  mailer.sendMailChangePassword(email);

  return res.render('vwAccount/forgotPassword', {
    layout:false,
    sendMail: true
  });
});

router.get('/newPassword', NotAuth, function (req, res) {
  res.render('vwAccount/newPassword', {layout:false});
});

router.post('/newPassword', NotAuth, async function (req, res) {
  const checkSame = (req.body.newPassword === req.body.confirmPassword);
  if(checkSame === false) {
    return res.render('vwAccount/newPassword', {
      layout:false,
      err_message: "New password and confirm password are not same. Try Again"
    });
  }
  
  const user = await accountService.findByEmail(req.query.email);
  const salt = bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(req.body.newPassword, salt);
  await accountService.updatePassword(user.MaTaiKhoan, hash);
  delete user.Password;
  
  res.render('vwAccount/newPassword', {
    layout:false,
    success_message: "Change Password Successful."
  });
});

export default router;