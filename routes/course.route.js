import express from 'express';
import courseService from '../services/course.service.js';
import studentService from '../services/student.service.js';
import mylearningService from "../services/myleaning.service.js";
const router = express.Router();

function assingNewBest(courseList, bsl, newList) {
    let checkBest = false, checkNew = false;
    for (let i = 0; i < courseList.length; i++) {
        for (let j = 0; j < bsl.length; j++) {
            if (courseList[i].MaKhoaHoc === bsl[j].MaKhoaHoc) {
                checkBest = true;
            }
            if (courseList[i].MaKhoaHoc === newList[j].MaKhoaHoc){
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



router.post('/search', async function (req, res) {
    const courseList = await courseService.courseFullTextSearch(req.body.courseFind);
    const bsl = await courseService.findTop5BestSeller();
    const newCo = await courseService.findTop5new();


    const courseTemp = assingNewBest(courseList[0], bsl, newCo);
    const courseFinal = courseService.assignDiscount(courseTemp);

    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;

    const total =courseList.length;
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


    res.render('courses/search.hbs', {
        courses: courseFinal,
        isNull: courseFinal.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber
    });


});

// dang lam
router.post('/orderByPrice', async function (req, res) {
    const courseName = await courseService.courseFullTextSearch(req.body.courseFind);
    res.render('courses/search.hbs', {
        courses: courseName[0],
        isNull: courseName[0].length === 0
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

router.get('/wishList', async function (req, res) {
    let wl = [];
    const storage = req.session.wisList;
    if (storage) {
        wl = JSON.parse(storage);
    }
    const myWL = [];
    for (let i = 0; i < wl.length; i++) {
        if (wl[i].MaTK == req.session.authUser.MaTaiKhoan)
            myWL.push(wl[i].course)
    }

    res.render('courses/wishList', {
        courses: myWL
    });
});

router.get('/addToWishList', async function (req, res) {
    
    let wishList = [];

    let storage = req.session.wisList;
    const MaTK = req.query.MaTK;
    const MaKH = req.query.MaKH;
    // Lay wl tu local storeage
    if (storage) {
        wishList = JSON.parse(storage);
    }

    let courses = await courseService.findCourseById(MaKH);
    const course = courses[0];
    let item = wishList.find(c =>(c.course.MaKhoaHoc == MaKH && c.MaTK == MaTK));
    if (item) {
        console.log('Course was added')
    }
    else {
        wishList.push({course, MaTK});
    }

    req.session.wisList = JSON.stringify(wishList);

    res.redirect(`/course/detail?id=${req.query.MaKH}`);
});


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
    res.render('courses/index' , {
        courses,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
        fields,
    });
});

router.get('/detail', async function (req, res) {
    const makhoahoc = req.query.id || 0;
    // makhoahoc = +makhoahoc
    const course = await courseService.findDetailCourseByID(makhoahoc);

    if (course === null) {
        return res.redirect('/');
    }

    const courseVideoList = await courseService.findCourseVideoList(makhoahoc);
    const top5CousresMostView = await courseService.findTop5MostViewWithField(course.LinhVuc, makhoahoc);
    const inforStudentsOfTeacher = await courseService.inforStudentsOfTeacher(course.GiaoVien);
    const studentReviewList = await courseService.getStudentReviewList(makhoahoc);

    for(let i = 0; (courseVideoList !== null)  && i < courseVideoList.length; i++) {
        if(i === 0 || i === 1) {
            courseVideoList[i].isShowVideo= true;
        }
        else {
            courseVideoList[i].isShowVideo = false;
        }
    }

    var isCoursesRegister = false;
    
    if(req.session.auth === true){
        if(req.session.authUser.LoaiTaiKhoan === 'Học Viên') {
            const idStudent = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
            const courseRegistered = await courseService.isCourseRegister(makhoahoc, idStudent.MaHocVien);
            if(courseRegistered !== null)
                isCoursesRegister = true;
        }
    }

    res.render('courses/detail', {
        isCoursesRegister,
        course,
        courseVideoList,
        isVideoListEmpty: courseVideoList === null,
        top5CousresMostView,
        inforStudentsOfTeacher,
        studentReviewList,
    });
});

router.post('/detail', async function (req, res) {
    const makhoahoc = req.query.id || 0;
    const today = new Date().toISOString().slice(0, 10);

    const idStudent = await studentService.findByIDAccount(req.session.authUser.MaTaiKhoan);
    const ret1 = await courseService.updateSLKhoaHoc(idStudent.MaHocVien, idStudent.SLKhoaHoc + 1);
    const dangsachdangki = {MaHocVien: idStudent.MaHocVien, MaKhoaHoc: makhoahoc, NgayDangKy: today, Note: ''};
    const ret2 = await courseService.addBangDanhSachDangKi(dangsachdangki);


    return res.redirect('/mylearning');
});

export default router;
