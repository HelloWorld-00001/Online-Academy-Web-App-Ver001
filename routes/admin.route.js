import express from 'express';

// import teacherService from '../services/teacher.service.js';
const router = express.Router();

router.get('/', function (req, res) {
    res.render('vwAdmin/dashboard', {layout: false});
});

router.get('/profile', function(req, res) {
    res.render('vwAdmin/profile', {layout: false});
});

router.get('/usertable', function(req, res) {
    res.render('vwAdmin/usertable', {layout: false});
});
export default router;