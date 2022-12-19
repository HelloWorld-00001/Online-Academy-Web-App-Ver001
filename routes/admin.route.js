import express from 'express';
import adminService from '../services/admin.service.js';
// import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', function (req, res) {
    res.render('vwAdmin/dashboard', {layout: 'adminLayout'});
});

router.get('/profile', function(req, res) {
    res.render('vwAdmin/profile', {layout: 'adminLayout'});
});

router.get('/allTable', async function(req, res) {

    const studentList = await adminService.findTopThreeStudent();
    const teacherList = await adminService.findTopThreeTeacher();
    const courseList = await adminService.findTopThreeCourse();


    res.render('vwAdmin/allTable', {
        layout: 'adminLayout',
        teacher: teacherList,
        student: studentList,
        course: courseList
    });
});

router.get('/teacher', async function(req, res) {
    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teachers', {layout: 'adminLayout',
        teacher: teacherList
    });
});


export default router;