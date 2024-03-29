import express from 'express';
import courseService from '../services/course.service.js';

const router = express.Router();

router.get('/:id', async function (req, res) {
    const linhVuc = req.params.id || 1;
    const fields = await courseService.countByField();
    const nameField = await courseService.getNameField(linhVuc);

    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;
    let total = 0;

    for(let i = 0; i < fields.length; i++) {
        if( +linhVuc === fields[i].MaLinhVuc) {
            total = fields[i].SLKhoaHoc;
            break;
        }
    }
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

    const courses = await courseService.findPageByField(linhVuc, limit, offset);

    res.render('vwCategories/index' , {
        isField: true,
        nameField,
        courses: courses,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
        fields,
    });
});

router.get('/language/:id', async function (req, res) {
    const language = req.params.id || 1;
    const fields = await courseService.countByLanguage();
    const nameLanguage = await courseService.getNameLanguage(language)
    const limit = 6;
    const page = req.query.page || 1;
    const offset = (page - 1) * limit;
    let total = 0;

    for(let i = 0; i < fields.length; i++) {
        if( +language === fields[i].NgonNgu) {
            total = fields[i].SLKhoaHoc;
            break;
        }
    }
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

    const courses = await courseService.findPageByLanguage(language, limit, offset);

    res.render('vwCategories/index' , {
        courses: courses,
        nameLanguage,
        empty: courses.length === 0,
        pageNumbers,
        nextPageNumber,
        previousPageNumber,
        fields,
    });
});
export default router;
