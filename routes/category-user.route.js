import express from 'express';
import courseModel from '../services/course.service.js';

const router = express.Router();

router.get('/:id', async function (req, res) {
    const linhVuc = req.params.id || 1;

    // for(const c of res.locals.lcCategories) {
    //     if(c.CatID === +linhVuc) {
    //         c.isActive = true;
    //         break;
    //     }
    // }

    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;

    const total = await courseModel.countByField(linhVuc);
    const nPages = Math.ceil(total / limit);

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

    const list = await courseModel.findPageByField(linhVuc, limit, offset);
    const courses = [];
    for(let course of list) {
        courses.push({
            value: course,
            isFieldType: course.LinhVuc === 1
        })
    }
    res.render('vwCategories/index' , {
        courses: courses,
        empty: list.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
    });
});

export default router;
