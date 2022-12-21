import express from 'express';
import bcrypt from 'bcryptjs';
import moment from 'moment';
import randomInteger from 'random-int';

import accountService from '../services/account.service.js';
import mailer from '../services/mail.service.js';

const router = express.Router();
//Register
router.get('/register', async function (req, res) {
  res.render('vwAccount/register', {layout: false});
});

router.post('/register', async function (req, res) {
  const rawPassword = req.body.password;
  const salt = await bcrypt.genSaltSync(10);
  const hash = bcrypt.hashSync(rawPassword, salt);
  const dob = req.body.dob;
  
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

router.get('/is-available-username', async function (req, res) {
  const username = req.query.user;

  const user = await accountService.findByUsername(username);
  if (user === null) {
    return res.json(true);
  }

  res.json(false);
});

router.get('/is-available-email', async function (req, res) {
  const email = req.query.user;

  const user = await accountService.findByEmail(email);
  if (user === null) {
    return res.json(true);
  }

  res.json(false);
});

//Email
router.get('/sendOTP', regis, async function (req, res) {
  res.render('vwAccount/handleOTP', {layout: false});
});

router.post('/sendOTP', async function (req, res) {
  const newUser = req.session.temp;  
  await accountService.add(newUser);

  req.session.regis = false;
  req.session.temp = null;

  res.redirect('/account/login');
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
router.get('/login', async function (req, res) {
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

  req.session.auth=true;
  req.session.authUser=user;
  console.log(user);

  const url = req.session.retUrl || '/';
  res.redirect(url);
});

//logout
router.post('/logout', async function(req, res){
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

function regis(req, res, next) {
  if(req.session.regis === false) {
    req.session.retUrl = req.originalUrl;
    return res.redirect('/');
  }

  next();
}

//profile
router.get('/profile', auth, async function(req, res) {
  res.render('vwAccount/profile');
})

export default router;