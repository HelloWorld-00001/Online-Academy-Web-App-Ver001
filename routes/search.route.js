import express from 'express';
import courseService from '../services/course.service.js';

const router = express.Router();
const BESTSELLER = await courseService.findTop5BestSeller();
const NEWLIST = await courseService.findTop5new();
const LIMIT = 6;

function assingNewBest(courseList) {
    let checkBest = false, checkNew = false;
    for (let i = 0; i < courseList.length; i++) {
        for (let j = 0; j < BESTSELLER.length; j++) {
            if (courseList[i].MaKhoaHoc === BESTSELLER[j].MaKhoaHoc) {
                checkBest = true;
            }
            if (courseList[i].MaKhoaHoc === NEWLIST[j].MaKhoaHoc){
                checkNew = true;
            }
        }
        courseList[i].isBestSeller = checkBest;
        courseList[i].isNew = checkNew;
        checkBest = false;
        checkNew = false;
    }

    return courseList;

}

function pagination(current) {
    const page = current || 0;//req.query.page || 1;
    const offset = +page + LIMIT;

    const nextPageNumber = {
        offset: offset,
        isNextPage:   true
    }
    const previousPageNumber = {
        offset: page - LIMIT,
        isPreviousPage:   true,
    }

    const rel = {
        nextPage: nextPageNumber,
        previousPage: previousPageNumber
    };
    
    return rel;
}


router.post('/', async function (req, res) {
    const findName = req.body.findName;
    const offsetNow = req.query.offset || 0;
    const paging = pagination(offsetNow);
    const courseList = await courseService.courseFullTextSearch(findName, LIMIT, offsetNow);
    const courseTemp = assingNewBest(courseList[0]);
    const courseFinal = courseService.assignDiscount(courseTemp);

    if (courseFinal.length < LIMIT) {
        paging.nextPage.isNextPage = false;
    }
    if (paging.previousPage.offset < 0) {
        paging.previousPage.isPreviousPage = false;
    }

    res.render('courses/search.hbs', {
        courses: courseFinal,
        isNull: courseFinal.length === 0,
        nextPageNumber: paging.nextPage,
        previousPageNumber: paging.previousPage,
        findName
    });


});

router.get('/', async function (req, res) {
    const findName = req.query.findName;
    const offsetNow = req.query.offset || 0;
    const paging = pagination(offsetNow);
    const courseList = await courseService.courseFullTextSearch(findName, LIMIT, offsetNow);
    const courseTemp = assingNewBest(courseList[0]);
    const courseFinal = courseService.assignDiscount(courseTemp);

    if (courseFinal.length < LIMIT) {
        paging.nextPage.isNextPage = false;
    }
    if (paging.previousPage.offset < 0) {
        paging.previousPage.isPreviousPage = false;
    }

    res.render('courses/search.hbs', {
        courses: courseFinal,
        isNull: courseFinal.length === 0 && offsetNow == 0,
        nextPageNumber: paging.nextPage,
        previousPageNumber: paging.previousPage,
        findName
    });


});

// dang lam
router.get('/orderByPrice', async function (req, res) {
    const findName = req.query.findName;
    const offsetNow = req.query.offset || 0;
    const paging = pagination(offsetNow);
    const courseList = await courseService.SearchOrderByPrice(findName, LIMIT, offsetNow);
    const courseTemp = assingNewBest(courseList[0]);
    const courseFinal = courseService.assignDiscount(courseTemp);

    if (courseFinal.length < LIMIT) {
        paging.nextPage.isNextPage = false;
    }
    if (paging.previousPage.offset < 0) {
        paging.previousPage.isPreviousPage = false;
    }

    res.render('courses/search.hbs', {
        courses: courseFinal,
        isNull: courseFinal.length === 0 && offsetNow == 0,
        nextPageNumber: paging.nextPage,
        previousPageNumber: paging.previousPage,
        findName
    });

});

router.get('/orderByRate', async function (req, res) {
    const findName = req.query.findName;
    const offsetNow = req.query.offset || 0;
    const paging = pagination(offsetNow);
    const courseList = await courseService.SearchOrderByRate(findName, LIMIT, offsetNow);
    const courseTemp = assingNewBest(courseList[0]);
    const courseFinal = courseService.assignDiscount(courseTemp);

    if (courseFinal.length < LIMIT) {
        paging.nextPage.isNextPage = false;
    }
    if (paging.previousPage.offset < 0) {
        paging.previousPage.isPreviousPage = false;
    }

    res.render('courses/search.hbs', {
        courses: courseFinal,
        isNull: courseFinal.length === 0 && offsetNow == 0,
        nextPageNumber: paging.nextPage,
        previousPageNumber: paging.previousPage,
        findName
    });

});

router.get('/', function (req, res) {
    
    // const courseTemp = assingNewBest(req.body);
    // const courseFinal = courseService.assignDiscount(courseTemp);
    console.log('here');

    res.render('/');
});

export default router;