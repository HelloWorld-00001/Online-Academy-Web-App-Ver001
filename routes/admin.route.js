import express from 'express';
import adminService from '../services/admin.service.js';
// import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', async function (req, res) {
    const numofAcc = await adminService.countAllUser();
    const numofTeacher = await adminService.countAllTeacher();
    const numofStudent = await adminService.countAllStudent();
    const numofCate = await adminService.countAllCate();
    const numofCourse = await adminService.countAllCourse();
    const numofVideo = await adminService.countAllVid();
    res.render('vwAdmin/dashboard', {
        layout: 'adminLayout',
        numofAcc,
        numofTeacher,
        numofStudent,
        numofCate,
        numofCourse,
        numofVideo
    });
});

router.get('/profile', function(req, res) {
    res.render('vwAdmin/profile', {
        layout: 'adminLayout'
    });
});

router.get('/allTable', async function(req, res) {

    const studentList = await adminService.findTopThreeStudent();
    const teacherList = await adminService.findTopThreeTeacher();
    const courseList = await adminService.findTopThreeCourse();
    const videoList = await adminService.findTopThreeVideo();

    res.render('vwAdmin/allTable', {
        layout: 'adminLayout',
        teacher: teacherList,
        student: studentList,
        course: courseList,
        video: videoList
    });
});

router.get('/teachers', async function(req, res) {
    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teacher/teachers', {layout: 'adminLayout',
        teacher: teacherList
    });
});

router.post('/teachers/add', function (req, res){

    res.render('vwAdmin/teacher/add', {
        layout: 'adminLayout',

    });
});

router.get('/addTeacher', function (req, res){
    res.render('vwAdmin/teacher/add', {
        layout: 'adminLayout',
    });
});

router.get('/categories', async function(req, res) {
    const categories = await adminService.findAllCategory();
    res.render('vwAdmin/categories', {layout: 'adminLayout',
        categories: categories
    });
});

router.get('/courses', async function(req, res) {
    const courses = await adminService.findAllCourse();
    res.render('vwAdmin/courses', {layout: 'adminLayout',
        courses: courses
    });
});
export default router;