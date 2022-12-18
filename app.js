import express from 'express';
import { engine } from 'express-handlebars';
import hbs_sections from 'express-handlebars-sections'
import session from 'express-session';
import fnKnexStore from 'connect-session-knex';

import db from './utils/db.js';

import { dirname } from 'path';
import { fileURLToPath } from 'url';
import numeral from 'numeral';

// import categoryRoute from './routes/category.route.js';
// import productRoute from './routes/product.route.js';
// import productUserRoute from './routes/product-user.route.js';
// import categoryService from './services/category.service.js';

import courseService from "./services/course.service.js";
import accountRoute from './routes/account.route.js';
import courseRoute from "./routes/course.route.js";

const app = express();
app.use(express.urlencoded({
    extended: true
}));

app.use('/public', express.static('public'));

const KnexStore = fnKnexStore(session);
const store = new KnexStore({ knex: db });

app.set('trust proxy', 1) // trust first proxy
app.use(session({
secret: 'keyboard cat',
resave: false,
saveUninitialized: true,
store: store,
cookie: {
    // secure: true
}
}))

app.engine('hbs', engine({
    extname: 'hbs',
    defaultLayout: 'index',
    helpers: {
        format_number(val) {
            return numeral(val).format('0,0');
        }
    },
    section: hbs_sections()
}));

app.set('view engine', 'hbs');
app.set('views', './views');

// app.use(async function (req, res, next) {
//     res.locals.lcCategories = await categoryService.findAllWithDetails();
//     next();
// });

app.get('/', async function (req, res) {
    // res.send('Hello World.');
    const listTop10CourseView = await courseService.findTop10MostViewCourse();
    const listTop3CourseLastWeek = await courseService.findTop3LastWeek();
    const listTop10LastedCourse = await courseService.findTop10LastedCourse();
    const fields = await  courseService.findTopFiedls();
    res.render('home', {
        listTop10CourseView1: listTop10CourseView[0],
        listTop10CourseView2: listTop10CourseView[1],
        listTop10CourseView3: listTop10CourseView[2],
        listTop10CourseView4: listTop10CourseView[3],
        listTop3CourseLastWeek: listTop3CourseLastWeek,
        listTop10LastedCourse1: listTop10LastedCourse[0],
        listTop10LastedCourse2: listTop10LastedCourse[1],
        listTop10LastedCourse3: listTop10LastedCourse[2],
        listTop10LastedCourse4: listTop10LastedCourse[3],
        fields: fields
    });
});

// app.get('/home', function (req, res) {
//     res.render('home');
// });

app.get('/about', function (req, res) {
    res.render('about');
})

app.get('/teacher', function (req, res) {
    res.render('teacher');
})

app.get('/blog', function (req, res) {
    res.render('blog');
})

app.get('/single', function (req, res) {
    res.render('single');
})

app.get('/contact', function (req, res) {
    res.render('contact');
})

app.get('/detail', function (req, res) {
    res.render('detail');
})

app.use('/course', courseRoute);
app.use('/account', accountRoute);


const PORT = 3000;
app.listen(PORT, function () {
    console.log(`Online Academy application listening at http://localhost:${PORT}`);
})