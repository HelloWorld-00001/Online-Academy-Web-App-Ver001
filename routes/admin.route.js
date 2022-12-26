import express from 'express';
import adminService from '../services/admin.service.js';
import teacherService from '../services/teacher.service.js';
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

/* Teacher Management Section */
router.get('/teachers', async function(req, res) {
    const teacherList = await adminService.findAllTeacher();
    res.render('vwAdmin/teacher/teachers', {layout: 'adminLayout',
        teacher: teacherList
    });
});

router.get('/addTeacher', function (req, res){
    res.render('vwAdmin/teacher/add', {
        layout: 'adminLayout',
    });
});

router.post('/addTeacher', async function (req, res){
    const x = await teacherService.addAccount(req.body);
    const MaTk = await teacherService.findIdTeacher(req.body.Username);
    const y = await teacherService.add(req.body, MaTk[0]);
    res.render('vwAdmin/teacher/add', {
        layout: 'adminLayout',
    });
});
router.post('/delTeacher', async function (req, res){
    console.log(req.body);
    //await teacherService.del(req.body.MaGiaoVien);
    //await teacherService.delAccount(req.body.MaTaiKhoan);

    res.render('vwAdmin/teacher/teachers', {
        layout: 'adminLayout',
    });
});
router.get('/delTeacher', async function (req, res){
    const id = req.query.id;
    await teacherService.delTeacher(id);
    await teacherService.delAccount(id);

    res.redirect('/admin/teachers');
});

router.get('/editTeacher', async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);


    res.render('vwAdmin/teacher/edit', {
        layout: 'adminLayout',
        teacher: teacher
    });

});

router.get('/viewTeacher', async function (req, res){
    const id = req.query.id;
    const teacher = await teacherService.findTeacherById(id);
    console.log(teacher);

    res.render('vwAdmin/teacher/view', {
        layout: 'adminLayout',
        teacher: teacher
    });

});
router.post('/teachers', async function(req, res) {
    //await teacherService.del(req.body.MaGiaoVien);
    //await teacherService.delAccount(req.body.MaTaiKhoan);
    res.render('vwAdmin/teacher/teachers', {
        layout: 'adminLayout',
    });
});


/* Category Management Section */
router.get('/categories', async function(req, res) {
    const categories = await adminService.findAllCategory();
    res.render('vwAdmin/categories', {layout: 'adminLayout',
        categories: categories
    });
});
router.get('/addCategory', function (req, res){
    res.render('vwAdmin/categories', {
        layout: 'adminLayout',
    });
});
router.post('/addCategory', async function (req, res){
    const addCate = await adminService.addCategory(req.body)
    res.render('vwAdmin/categories', {
        layout: 'adminLayout',
    });
});


router.get('/courses', async function(req, res) {
    const courses = await adminService.findAllCourse();
    res.render('vwAdmin/courses', {layout: 'adminLayout',
        courses: courses
    });
});
export default router;