import mylearningService from "../services/myleaning.service.js";
import courseService from "../services/course.service.js";
import express from "express";
const router = express.Router();


router.get('/:id', async function (req, res) {
    let makhoahoc = req.params.id || 0;
    // console.log(makhoahoc)
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
    // const sumRating = oneStarRate + twoStarRate + threeStarRate + fourStarRate + fiveStarRate;
    // const totalRate = await  mylearningService.sumStudentRating(makhoahoc);
    //
    // const RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;
    // const ret = await mylearningService.addRating(makhoahoc, RateTB, amountStudentRating);

    const oneStarRatePer = Math.round(oneStarRate / amountStudentRating * 100)
    const twoStarRatePer = Math.round(twoStarRate / amountStudentRating * 100)
    const threeStarRatePer = Math.round(threeStarRate / amountStudentRating * 100)
    const fourStarRatePer = Math.round(fourStarRate / amountStudentRating * 100)
    const fiveStarRatePer = Math.round(fiveStarRate / amountStudentRating * 100)

    const starRatingList  = {oneStarRatePer, twoStarRatePer, threeStarRatePer, fourStarRatePer, fiveStarRatePer};
    const firstVideo = courseVideoList[0].Link;
    res.render('vwMylearning/mylearning', {
        courseVideoList,
        course,
        firstVideo,
        starRatingList,
        inforStudentsOfTeacher,
    });
});

router.post('/:id', async function (req, res) {
    let makhoahoc1 = req.params.id || 0;
    const course = await courseService.findDetailCourseByID(makhoahoc1);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);

    if (course === null) {
        return res.redirect('/');
    }

    const result = req.body;
    const data = {
        'MaHocVien': 2,
        'MaKhoaHoc': makhoahoc1,
        'Rate': result.Rate,
        'Comment': result.Comment,
    }

    const ret1 = await mylearningService.addBangDanhGia(data);

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
    console.log({totalRate, amountStudentRating})
    const RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;


    console.log({RateTB, amountStudentRating})
    const ret2 = await mylearningService.updateKhoaHoc(makhoahoc1, RateTB, amountStudentRating);

    res.render('vwMylearning/mylearning', {
        courseVideoList,
        course,
        firstVideo,
        starRatingList,
        inforStudentsOfTeacher,
    });
});


export default router;