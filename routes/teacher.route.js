import express from 'express';
// import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', function (req, res) {
    res.render('teacher');
});

router.get('/input', function (req, res){
   res.render('vwTeacher/inputcourse');
});

router.post('/input', function (req, res){
    console.log(req.body);
});

router.get('/profile', function (req, res){
    res.render('vwTeacher/profile');
});

router.post('/profile', function (req, res){
    console.log(req.body);
});

router.get('/courses', function (req, res){
    res.render('vwTeacher/courses', {
        empty: false
    });
});

export default router;