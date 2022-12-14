import express from 'express';
import courseModel from '../services/course.service.js';
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


router.get('/', async function (req, res) {
    const fields = await courseModel.countByField();

    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;

    const total = await courseModel.countCourseAll();
    let nPages = Math.ceil(total / limit);

    const pageNumbers = [];
    for(let i = 1; i <= nPages; i++) {
        pageNumbers.push({
            value: i,
            isCurrent: i === +page,
        })
    }
    const nextPageNumber = {
        value: +page + 1,
        isNextPage:   +page + 1 <= +nPages,
    }
    const previousPageNumber = {
        value: +page - 1,
        isPreviousPage:   +page - 1 > 0,
    }
    // const list = await courseModel.findCourseList(limit, offset)
    const courses = await courseModel.findPageCourseAll(limit, offset);
    res.render('course' , {
        courses,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
        fields,
    });
});

router.get('/detail', function (req, res) {
    res.render('courses/detail')
})

export default router;
