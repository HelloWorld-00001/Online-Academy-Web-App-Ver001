import mylearningService from "../services/myleaning.service.js";
import courseService from '../services/course.service.js';

import express from "express";
const router = express.Router();

router.get('/', async function (req, res) {
    const idStudent = 1;
    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;

    const total = await mylearningService.countStudentCourseAll(idStudent);
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
    // const list = await mylearningService.findCourseList(limit, offset)
    const courses = await mylearningService.findPageStudentCourseAll(idStudent,limit, offset);
    res.render('vwMylearning/index' , {
        courses,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
    });
});

router.get('/:id', async function (req, res) {
    let makhoahoc = req.params.id || 0;
    const mahocvien = 10;
    const course = await courseService.findDetailCourseByID(makhoahoc);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);

    if (course === null) {
        return res.redirect('/');
    }

    const courseVideoList = await courseService.findCourseVideoList(makhoahoc);
    const oneStarRate = await mylearningService.countStarRate(makhoahoc,1);
    const twoStarRate = await mylearningService.countStarRate(makhoahoc,2);
    const threeStarRate = await mylearningService.countStarRate(makhoahoc,3);
    const fourStarRate = await mylearningService.countStarRate(makhoahoc,4);
    const fiveStarRate = await mylearningService.countStarRate(makhoahoc,5);

    const amountStudentRating = await mylearningService.countStudentRating(makhoahoc);

    const oneStarRatePer = Math.round(oneStarRate / amountStudentRating * 100)
    const twoStarRatePer = Math.round(twoStarRate / amountStudentRating * 100)
    const threeStarRatePer = Math.round(threeStarRate / amountStudentRating * 100)
    const fourStarRatePer = Math.round(fourStarRate / amountStudentRating * 100)
    const fiveStarRatePer = Math.round(fiveStarRate / amountStudentRating * 100)

    const starRatingList  = {oneStarRatePer, twoStarRatePer, threeStarRatePer, fourStarRatePer, fiveStarRatePer};
    const firstVideo = courseVideoList[0].Link;
    const userRating = await mylearningService.getUserRating(makhoahoc, mahocvien);
    const checkStudentReview = userRating ===  null ? true : false;

    let limit = 2;
    const studentReviewList = await courseService.getStudentReviewList(makhoahoc);

    res.render('vwMylearning/mylearning', {
        courseVideoList,
        course,
        firstVideo,
        starRatingList,
        inforStudentsOfTeacher,
        userRating,
        checkStudentReview,
        studentReviewList,
    });
});

router.post('/:id', async function (req, res) {
    let makhoahoc1 = req.params.id || 0;
    const mahocvien = 10;

    const result = req.body;
    const data = {
        'MaHocVien': mahocvien,
        'MaKhoaHoc': makhoahoc1,
        'Rate': result.Rate,
        'Comment': result.Comment,
    }

    let userRating = await mylearningService.getUserRating(makhoahoc1, mahocvien);
    let checkStudentReview = userRating ===  null ? true : false;

    if (checkStudentReview) {
        const ret1 = await mylearningService.addBangDanhGia(data);
        checkStudentReview = false;
        userRating = await mylearningService.getUserRating(makhoahoc1, mahocvien);
    }
    else {
        if(result.submitBtn === 'delete') {
            const ret1 = await mylearningService.delBangDanhGia(makhoahoc1, mahocvien);
        } else {
            const ret1 = await mylearningService.updateBangDanhGia(data);
        }
    }

    const courseVideoList = await courseService.findCourseVideoList(makhoahoc1);
    const oneStarRate = await mylearningService.countStarRate(makhoahoc1,1);
    const twoStarRate = await mylearningService.countStarRate(makhoahoc1,2);
    const threeStarRate = await mylearningService.countStarRate(makhoahoc1,3);
    const fourStarRate = await mylearningService.countStarRate(makhoahoc1,4);
    const fiveStarRate = await mylearningService.countStarRate(makhoahoc1,5);

    const amountStudentRating = await mylearningService.countStudentRating(makhoahoc1);

    const oneStarRatePer = Math.round(oneStarRate / amountStudentRating * 100)
    const twoStarRatePer = Math.round(twoStarRate / amountStudentRating * 100)
    const threeStarRatePer = Math.round(threeStarRate / amountStudentRating * 100)
    const fourStarRatePer = Math.round(fourStarRate / amountStudentRating * 100)
    const fiveStarRatePer = Math.round(fiveStarRate / amountStudentRating * 100)

    const starRatingList  = {oneStarRatePer, twoStarRatePer, threeStarRatePer, fourStarRatePer, fiveStarRatePer};
    const firstVideo = courseVideoList[0].Link;

    const sumRating = oneStarRate + twoStarRate + threeStarRate + fourStarRate + fiveStarRate;
    const totalRate = await  mylearningService.sumStudentRating(makhoahoc1);
    let RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;
    // RateTB = RateTB !== 0 ? Number((RateTB).toFixed(1)) : 0;
    const ret2 = await mylearningService.updateKhoaHoc(makhoahoc1, RateTB, amountStudentRating);
    const course = await courseService.findDetailCourseByID(makhoahoc1);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);

    res.render('vwMylearning/mylearning', {
        courseVideoList,
        course,
        firstVideo,
        starRatingList,
        inforStudentsOfTeacher,
        userRating,
        checkStudentReview,
    });
});


export default router;