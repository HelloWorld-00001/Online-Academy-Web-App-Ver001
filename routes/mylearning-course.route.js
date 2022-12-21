import mylearningService from "../services/myleaning.service.js";
import courseService from "../services/course.service.js";
import express from "express";
const router = express.Router();

router.post('/id', async function (req, res) {
    let makhoahoc = req.params.id || 0;
    const oneStarRate = await mylearningService.countStarRate(makhoahoc,1);
    const twoStarRate = await mylearningService.countStarRate(makhoahoc,2);
    const threeStarRate = await mylearningService.countStarRate(makhoahoc,3);
    const fourStarRate = await mylearningService.countStarRate(makhoahoc,4);
    const fiveStarRate = await mylearningService.countStarRate(makhoahoc,5);

    const amountStudentRating = await mylearningService.countStudentRating(makhoahoc);
    const sumRating = oneStarRate + twoStarRate + threeStarRate + fourStarRate + fiveStarRate;
    const totalRate = await  mylearningService.sumStudentRating(makhoahoc);

    const RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;
    const ret = await mylearningService.addRating(makhoahoc, RateTB, amountStudentRating);
    res.render('vwMylearning/mylearning',);
});

router.get('/:id', async function (req, res) {
    let makhoahoc = req.params.id || 0;
    const course = await courseService.findDetailCourseByID(makhoahoc);

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
console.log(starRatingList)
    const firstVideo = courseVideoList[0].Link;
    console.log(firstVideo)
    res.render('vwMylearning/mylearning', {
        courseVideoList,
        course,
        firstVideo,
        starRatingList,
    });
});
export default router;