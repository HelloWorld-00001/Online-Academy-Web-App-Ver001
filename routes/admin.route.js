import express from 'express';
// import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', function (req, res) {
    res.render('vwAdmin/index');
});


export default router;