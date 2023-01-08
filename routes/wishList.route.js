import express from 'express';
import courseService from '../services/course.service.js';

const router = express.Router();


async function wishListInfo(req) {
    let wishList = [];
    let wlFinal = [];
    const storage = req.session.wishList;
    let rel = { wishList: null, isNull: true}

    if (storage.length != 0) {
        wishList = JSON.parse(storage);
        const user = req.session.authUser.Username;

        for (let i = 0; i < wishList.length; i++) {
            if (wishList[i].user === user && typeof wishList[i].courseID != 'undefined') {
                const temp = await courseService.findCourseById(wishList[i].courseID);
                wlFinal.push(temp[0]);
            }
        }
        rel = { wishList: wlFinal, isNull: wlFinal.length === 0}
        return rel;
    } 

    return rel;
}



router.get('/',async function (req, res) {
   
    const rel = await wishListInfo(req);
    res.render('courses/wishList', {
        wishList: rel.wishList,
        isNull: rel.isNull,
        total: rel.total
    });
});

router.get('/del', async function (req, res) {
    let wishList = [];
    const id = req.query.MaKH;
    const storage = req.session.wishList;

    if (storage.length != 0) {
        wishList = JSON.parse(storage);
        const user = req.session.authUser.Username;

        for (let i = 0; i < wishList.length; i++) {
            if ((wishList[i].courseID == id && wishList[i].user === user) || typeof wishList[i].courseID === 'undefined') {
                wishList.splice(i, 1);
                req.session.wishList = JSON.stringify(wishList);
            }
         }
         console.log(wishList);
    } 
    res.redirect('/wishList');
});

router.get('/add', async function (req, res) {
    
    let wishList = [];
    let flag = true;
    let storage = req.session.wishList;
    const courseID = req.query.MaKH;
    const user = req.session.authUser.Username || 'guest';
    // Lay wl tu local storeage
    if (storage.length != 0) {
        wishList = JSON.parse(storage); 
    }
   
    for (var i = 0; i < wishList.length; i++) {
        if (wishList[i].courseID == courseID && wishList[i].user === user) {
            flag = false;
            break;
        }
    }
    if(flag) {
        wishList.push({courseID: courseID, user: user});
    }

    req.session.wishList = JSON.stringify(wishList);


    res.redirect(`/course/detail?id=${courseID}`);
});



export default router;                                      
