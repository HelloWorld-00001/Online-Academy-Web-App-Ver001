import express from 'express';
import { engine } from 'express-handlebars';

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
import categoryUserRoute from "./routes/category-user.route.js"

const app = express();
app.use(express.urlencoded({
    extended: true
}));

app.use('/public', express.static('public'));

app.engine('hbs', engine({
    // defaultLayout: 'index.hbs'
    extname: 'hbs',
    defaultLayout: 'index',
    helpers: {
        format_number(val) {
            return numeral(val).format('0,0');
        }
    }
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

    res.render('home', {
        listTop10CourseView1: listTop10CourseView[0],
        listTop10CourseView2: listTop10CourseView[1],
        listTop10CourseView3: listTop10CourseView[2],
        listTop10CourseView4: listTop10CourseView[3]
    });
    console.log(listTop10CourseView[0]);
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

app.use('/course', courseRoute);
app.use('/account', accountRoute);
app.use('/categories', categoryUserRoute);
//
// app.get('/bs4', function (req, res) {
//     const __dirname = dirname(fileURLToPath(import.meta.url));
//     res.sendFile(__dirname + '/bs4.html');
// });
//
// app.get('/err', function (req, res) {
//     throw new Error('Something broke!!!');
// })


// app.use('/admin/categories', categoryRoute);
// app.use('/admin/products', productRoute);
// app.use('/products', productUserRoute);
//
// app.use(function (req, res, next) {
//     res.render('404', { layout: false });
// });
//
// app.use(function (err, req, res, next) {
//     // console.error(err.stack);
//     res.status(500).render('500', {
//         stack: err.stack,
//         layout: false
//     });
// });

const PORT = 3000;
app.listen(PORT, function () {
    console.log(`Online Academy application listening at http://localhost:${PORT}`);
})