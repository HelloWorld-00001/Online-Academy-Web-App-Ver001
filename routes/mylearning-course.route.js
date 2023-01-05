import mylearningService from "../services/myleaning.service.js";
import courseService from '../services/course.service.js';
import express from "express";
import studentService from "../services/student.service.js";
const router = express.Router();

router.get('/', async function (req, res) {
    // const idStudent = 1;
    const student = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
    const idStudent = student.MaHocVien;

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
        empty: courses.length === 0 ? true : false,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
    });
});

router.get('/course', async function (req, res) {
    let makhoahoc = req.query.id || 0;
    if(req.session.auth === true){
        if(req.session.authUser.LoaiTaiKhoan === 'Học Viên') {
            const idStudent = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
            const courseRegistered = await courseService.isCourseRegister(makhoahoc, idStudent.MaHocVien);
            if(courseRegistered !== null) {
                const mahocvien = idStudent.MaHocVien;
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
            }
            else {
                return res.redirect(`/course/detail/course?id=${makhoahoc}`);
            }
        }
        else {
            return res.redirect(`/mylearning/course?id=${makhoahoc}`);
        }
    }
    else {
        return res.redirect(`/course/detail/course?id=${makhoahoc}`);
    }

});

// router.post('/course', async function (req, res) {
//     let makhoahoc = req.query.id || 0;
//     const student = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
//     const mahocvien = student.MaHocVien;
//
//     const result = req.body;
//     const data = {
//         'MaHocVien': mahocvien,
//         'MaKhoaHoc': makhoahoc,
//         'Rate': result.Rate,
//         'Comment': result.Comment,
//     }
//
//     let userRating = await mylearningService.getUserRating(makhoahoc, mahocvien);
//     let checkStudentReview = userRating ===  null ? true : false;
//
//     if (checkStudentReview) {
//         const ret1 = await mylearningService.addBangDanhGia(data);
//         checkStudentReview = false;
//         userRating = await mylearningService.getUserRating(makhoahoc, mahocvien);
//     }
//     else {
//         if(result.submitBtn === 'delete') {
//             const ret1 = await mylearningService.delBangDanhGia(makhoahoc, mahocvien);
//         } else {
//             const ret1 = await mylearningService.updateBangDanhGia(data);
//         }
//     }
//
//     const courseVideoList = await courseService.findCourseVideoList(makhoahoc);
//     const oneStarRate = await mylearningService.countStarRate(makhoahoc,1);
//     const twoStarRate = await mylearningService.countStarRate(makhoahoc,2);
//     const threeStarRate = await mylearningService.countStarRate(makhoahoc,3);
//     const fourStarRate = await mylearningService.countStarRate(makhoahoc,4);
//     const fiveStarRate = await mylearningService.countStarRate(makhoahoc,5);
//
//     const amountStudentRating = await mylearningService.countStudentRating(makhoahoc);
//
//     const oneStarRatePer = Math.round(oneStarRate / amountStudentRating * 100)
//     const twoStarRatePer = Math.round(twoStarRate / amountStudentRating * 100)
//     const threeStarRatePer = Math.round(threeStarRate / amountStudentRating * 100)
//     const fourStarRatePer = Math.round(fourStarRate / amountStudentRating * 100)
//     const fiveStarRatePer = Math.round(fiveStarRate / amountStudentRating * 100)
//
//     const starRatingList  = {oneStarRatePer, twoStarRatePer, threeStarRatePer, fourStarRatePer, fiveStarRatePer};
//     const firstVideo = courseVideoList[0].Link;
//
//     // const sumRating = oneStarRate + twoStarRate + threeStarRate + fourStarRate + fiveStarRate;
//     const totalRate = await  mylearningService.sumStudentRating(makhoahoc);
//     let RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;
//     // RateTB = RateTB !== 0 ? Number((RateTB).toFixed(1)) : 0;
//
//     const ret2 = await mylearningService.updateKhoaHoc(makhoahoc, RateTB, amountStudentRating);
//     const course = await courseService.findDetailCourseByID(makhoahoc);
//     const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);
//     const studentReviewList = await courseService.getStudentReviewList(makhoahoc);
//
//
//     res.render('vwMylearning/mylearning', {
//         courseVideoList,
//         course,
//         firstVideo,
//         starRatingList,
//         inforStudentsOfTeacher,
//         userRating,
//         checkStudentReview,
//         studentReviewList,
//     });
// });

router.post('/course', async function (req, res) {
    let makhoahoc = req.query.id || 0;
    const student = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
    const mahocvien = student.MaHocVien;

    const result = req.body;
    const data = {
        'MaHocVien': mahocvien,
        'MaKhoaHoc': makhoahoc,
        'Rate': result.Rate,
        'Comment': result.Comment,
    }

    let userRating = await mylearningService.getUserRating(makhoahoc, mahocvien);
    let checkStudentReview = userRating ===  null ? true : false;

    if (checkStudentReview) {
        const ret1 = await mylearningService.addBangDanhGia(data);
    }
    else {
        if(result.submitBtn === 'delete') {
            const ret1 = await mylearningService.delBangDanhGia(makhoahoc, mahocvien);
        } else {
            const ret1 = await mylearningService.updateBangDanhGia(data);
        }
    }

    const amountStudentRating = await mylearningService.countStudentRating(makhoahoc);

    // const sumRating = oneStarRate + twoStarRate + threeStarRate + fourStarRate + fiveStarRate;
    const totalRate = await  mylearningService.sumStudentRating(makhoahoc);
    let RateTB = Math.round(totalRate / amountStudentRating *10) / 10  || 0;
    // RateTB = RateTB !== 0 ? Number((RateTB).toFixed(1)) : 0;

    const ret2 = await mylearningService.updateKhoaHoc(makhoahoc, RateTB, amountStudentRating);

    res.redirect(`/mylearning/course?id=${makhoahoc}`);
});

export default router;