import express from 'express';
import courseService from '../services/course.service.js';
const router = express.Router();

router.post('/search', async function (req, res) {
    const courseName = await courseService.findByName(req.body.courseFind);
    console.log(courseName[0]);
    res.render('courses/search.hbs', {
        courses: courseName,
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

``
router.get('/', async function (req, res) {
    const fields = await courseService.countByField();

    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;

    const total = await courseService.countCourseAll();
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
    // const list = await courseService.findCourseList(limit, offset)
    const courses = await courseService.findPageCourseAll(limit, offset);
    res.render('course' , {
        courses,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
        fields,
    });
});



router.get('/detail/:id', async function (req, res) {
    const makhoahoc = req.params.id || 0;
    // makhoahoc = +makhoahoc
    const course = await courseService.findDetailCourseByID(makhoahoc);

    if (course === null) {
        return res.redirect('/');
    }

    const courseVideoList = await courseService.findCourseVideoList(makhoahoc);
    const top5CousresMostView = await courseService.findTop5MostViewWithField(course.LinhVuc, makhoahoc);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);

    for(let i = 0; i < courseVideoList.length; i++) {
        if(i === 0 || i === 1) {
            Object.assign(courseVideoList[i], {isShowVideo: true});
        }
        else {
            Object.assign(courseVideoList[i], {isShowVideo: false});
        }
    }
    res.render('courses/detail', {
        course,
        courseVideoList,
        isVideoListEmpty: courseVideoList.length === 0,
        top5CousresMostView,
        inforStudentsOfTeacher,
    });
});

router.get('/mylearning/:id', async function (req, res) {
    let makhoahoc = req.params.id || 0;
    const course = await courseService.findDetailCourseByID(makhoahoc);

    if (course === null) {
        return res.redirect('/');
    }

    const courseVideoList = await courseService.findCourseVideoList(makhoahoc);


    res.render('courses/mylearning', {
        courseVideoList,
    });
});
export default router;
