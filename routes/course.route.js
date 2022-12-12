import express from 'express';
import courseModel from '../models/course.model.js';
const router = express.Router();

router.post('/search', function (req, res) {
    const courseName = courseModel.findByName(req.body.courseFind);
    res.render('courses/search.hbs', {
        course: courseName,
        isNull: courseName.length === 0
    });
});

router.get('/search', function (req, res) {
    
    //console.log(productList);
    // res.render('courses/search.hbs', {
    //     product: productList,
    //     isNull: productList.length === 0
    // });
    res.render('/');
});
export default router;
