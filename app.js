import express from "express";
import { engine } from "express-handlebars";
import session from "express-session";
import hbs_sections from "express-handlebars-sections";
import fnMySQLStore from "express-mysql-session";
import passport from "passport";
import { connectionInfo } from "./utils/db.js";
import { dirname } from "path";
import { fileURLToPath } from "url";
import numeral from "numeral";

// import categoryRoute from './routes/category.route.js';
// import productRoute from './routes/product.route.js';
// import productUserRoute from './routes/product-user.route.js';
// import categoryService from './services/category.service.js';

import courseService from "./services/course.service.js";

import accountRoute from "./routes/account.route.js";
import authRoute from "./routes/auth.route.js";
import courseRoute from "./routes/course.route.js";
import categoryUserRoute from "./routes/category-user.route.js";
import teacherRoute from "./routes/teacher.route.js";
import studentRoute from "./routes/student.route.js";
import adminRoute from "./routes/admin.route.js"
import mylearningRoute from './routes/mylearning-course.route.js'
import studentService from "./services/student.service.js";
import teacherService from "./services/teacher.service.js";
import searchRoute from "./routes/search.route.js";
import wishListRoute from "./routes/wishList.route.js";
import myleaningService from "./services/myleaning.service.js";


const app = express();
app.use(
  express.urlencoded({
    extended: true,
  })
);

app.use("/public", express.static("public"));

const MySQLStore = fnMySQLStore(session);
const sessionStore = new MySQLStore(connectionInfo);

app.set("trust proxy", 1); // trust first proxy
app.use(
  session({
    secret: "keyboard cat",
    resave: false,
    store: sessionStore,
    saveUninitialized: true,
    cookie: {
      // secure: true
    },
  })
);

app.use(async function (req, res, next) {
  if (typeof req.session.auth === "undefined") {
    req.session.auth = false;
  }
  if (typeof req.session.regis === "undefined") {
    req.session.regis = false;
  }
  if (typeof req.session.wishList === "undefined") {
    req.session.wishList = [];
  }
  req.session.lv1 = await myleaningService.findLV(1);
  req.session.lv2 = await myleaningService.findLV(2);

  res.locals.lv1 = req.session.lv1;
  res.locals.lv2 = req.session.lv2;
  res.locals.regis = req.session.regis;
  res.locals.temp = req.session.temp;
  res.locals.auth = req.session.auth;
  res.locals.authUser = req.session.authUser;
  res.locals.wishList = req.session.wishList;

  next();
});

app.engine(
  "hbs",
  engine({
    extname: "hbs",
    defaultLayout: "index",
    helpers: {
        section: hbs_sections(),
        format_number(val) {
            return numeral(val).format('0,0');
        },
        convertDate(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("/");
        },
        for(from, to, incr, block) {
            var accum = '';
            for(var i = from; i < to; i += incr)
                accum += block.fn(i);
            return accum;
        },
        ifGreaterThan(x, y, options) {
            if (x >= y)
                return options.fn(this);
            return options.inverse(this);
        },
        isStudent(LoaiTaiKhoan, options) {
            if(LoaiTaiKhoan === "Học Viên") {
                return options.fn(this);
            }
            return options.inverse(this);
        },
        isTeacherAndAdmin(LoaiTaiKhoan, options) {
            if(LoaiTaiKhoan === "Giáo Viên" || LoaiTaiKhoan === "Admin") {
                return options.fn(this);
            }
            return options.inverse(this);
        },
        isTeacher(LoaiTaiKhoan, options) {
            if(LoaiTaiKhoan === "Giáo Viên") {
                return options.fn(this);
            }
            return options.inverse(this);
        },
        isAdmin(LoaiTaiKhoan, options) {
          if(LoaiTaiKhoan === "Admin") {
              return options.fn(this);
          }
          return options.inverse(this);
        },
        isActive(TinhTrang, options) {
          if(TinhTrang === 1) {
            return options.fn(this);
        }
        return options.inverse(this);
        },
  }}));

app.set("view engine", "hbs");
app.set("views", "./views");

app.get('/err', function (req, res) {
  throw new Error('Something broke!!!');
})



app.get("/", async function (req, res) {
  // res.send('Hello World.');
  const listTop10CourseView = await courseService.findTop10MostViewCourse();
  const listTop3CourseLastWeek = await courseService.findTop3LastWeek();
  const listTop10LastedCourse = await courseService.findTop10LastedCourse();
  const fields = await courseService.findTopFiedls();
  res.render("home", {
    listTop10CourseView1: listTop10CourseView[0],
    listTop10CourseView2: listTop10CourseView[1],
    listTop10CourseView3: listTop10CourseView[2],
    listTop10CourseView4: listTop10CourseView[3],
    numPage: listTop10CourseView[4],
    listTop3CourseLastWeek: listTop3CourseLastWeek,
    listTop10LastedCourse1: listTop10LastedCourse[0],
    listTop10LastedCourse2: listTop10LastedCourse[1],
    listTop10LastedCourse3: listTop10LastedCourse[2],
    listTop10LastedCourse4: listTop10LastedCourse[3],
    fields: fields,
  });
});

// app.get('/home', function (req, res) {
//     res.render('home');
// });

app.get("/about", function (req, res) {
  res.render("about");
});

// app.get('/teacher', function (req, res) {
//     res.render('teacher');
// })

app.get("/blog", function (req, res) {
  //const x =  courseService.test500err();
  res.render("blog");
});


app.get("/single", function (req, res) {
  res.render("single");
});

app.get("/contact", function (req, res) {
  res.render("contact");
});

app.get("/detail", function (req, res) {
  res.render("detail");
});

app.use(passport.initialize());
app.use(passport.session());

passport.serializeUser(function (user, done) {
  done(null, user);
});

passport.deserializeUser(function (obj, done) {
  done(null, obj);
});

app.use("/auth", authRoute);
app.use("/course", courseRoute);
app.use("/account", accountRoute);
app.use("/categories", categoryUserRoute);
app.use("/teacher", teacherRoute);
app.use("/admin", adminRoute);
app.use("/mylearning", mylearningRoute);
app.use("/search", searchRoute);
app.use("/student", studentRoute);
app.use("/wishList", wishListRoute);

app.use(function (req, res, next) {
  res.render('404', { layout: false });
});

app.use(function (err, req, res, next) {
  //console.error(err.stack);
  res.status(500).render('500', {
    stack: err.stack,
    layout: false
  });
});



const PORT = 3000;
app.listen(PORT, function () {
  console.log(
    `Online Academy application listening at http://localhost:${PORT}`
  );
});
