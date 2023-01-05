import courseService from "../services/course.service";

let wishList = [];

// wishList = [{MaTK, MaKH}];

const addToWishList = async (MaKH, MaTK) => {

    let storage = localStorage.getItem('wishList');

    // Lay wl tu local storeage
    if (storage) {
        wishList = JSON.parse(storage);
    }

    let course = await courseService.findCourseById(req.query.MaKH);
    console.log(course);
    let item = wishList.find(c => (c.KhoaHoc.MaKhoaHoc === MaKH && c.MaTaiKhoan === MaTK));
    if (item) {
        console.log('Course was added')
    }
    else {
        wishList.push({course, MaTK});
    }

    localStorage.setItem('wishList', JSON.stringify(wishList));


}