import express from 'express';
// import bcrypt from 'bcryptjs';
// import moment from 'moment';

// import userService from '../services/user.service.js';

const router = express.Router();

router.get('/register', async function (req, res) {
  res.render('vwAccount/register', {layout: false});
});

router.get('/login', async function (req, res) {
  res.render('vwAccount/login', {layout: false});
});

// router.post('/register', async function (req, res) {
//   const rawPassword = req.body.password;
//   const salt = bcrypt.genSaltSync(10);
//   const hash = bcrypt.hashSync(rawPassword, salt);

//   const dob = moment(req.body.dob, 'DD/MM/YYYY').format('YYYY-MM-DD');
//   const user = {
//     username: req.body.username,
//     password: hash,
//     name: req.body.name,
//     dob: dob,
//     email: req.body.email,
//     permission: 0
//   }
//   await userService.add(user);
//   res.render('vwAccount/register');
// });

// router.get('/profile', async function (req, res) {
//   res.render('vwAccount/profile');
// });


// // eg: /is-available?user=ryu
// router.get('/is-available', async function (req, res) {
//   const username = req.query.user;
//   const user = await userService.findByUsername(username);
//   if (user === null) {
//     return res.json(true);
//   }

//   res.json(false);
// });

export default router;