import express from 'express';
import wishListService from '../services/wishList.service.js';
import courseService from '../services/course.service.js';

const router = express.Router();


async function wishListInfo(req, wl) {
    let  wlFinal = [];
    let rel = { wishList: null, isNull: true};
    const user = req.session.authUser.Username;
    console.log(wl);
    for (let i = 0; i < wl.length; i++) {
        if (wl[i].Username === user) {
            const temp = await courseService.findCourseById(wl[i].MaKhoaHoc);
            wlFinal.push(temp[0]);
        }
    }
    rel = { wishList: wlFinal, isNull: wlFinal.length === 0}
    return rel;

}

 

router.get('/',async function (req, res) {
   
    const wl = await wishListService.getWishList();
    const rel = await wishListInfo(req, wl);
    console.log(rel);
    res.render('courses/wishList', {
        wishList: rel.wishList,
        isNull: rel.isNull
    });
});

router.get('/del', async function (req, res) {
    const id = req.query.MaKH;
    const user = req.session.authUser.Username;
    const x = wishListService.del({MaKhoaHoc: id, Username: user});

    
    res.redirect('/wishList');
});

router.get('/add', async function (req, res) {
    
    const courseID = req.query.MaKH;
    const user = req.session.authUser.Username || 'guest';
    const x = wishListService.add({MaKhoaHoc: courseID, Username: user});


    res.redirect(`/course/detail?id=${courseID}`);
});



export default router;                                      
