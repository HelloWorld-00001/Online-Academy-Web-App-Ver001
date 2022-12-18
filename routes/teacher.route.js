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


export default router;