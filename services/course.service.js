import db from '../utils/db.js';

export default {
    async findTop10MostViewCourse() {
        const sql = `SELECT KH.*, TK.Name, LV.TenLinhVuc,CTKH.TrangThai
                     FROM khoahoc KH
                              INNER JOIN GiaoVien GV ON GV.MaGiaoVien = KH.GiaoVien
                              INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                              INNER JOIN taikhoan TK ON GV.MaTaiKhoan = TK.MaTaiKhoan
                              INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc
                     ORDER BY KH.LuotXem DESC
                     LIMIT 10`;
        const ret = await db.raw(sql);
        const courses = ret[0];
        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);
            const ele4 = true;

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {completedStatus: courses[i] === 'Đã hoàn thành'});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
            Object.assign(courses[i], {isExist: ele4});
        }
        const temp1 = [];
        const temp2 = [];
        const temp3 = [];
        const temp4 = [];
        const temp5 = courses.length / 3 + 1;
        const res = [];
        for (let i = 0; i < 10; i++) {
            if (i < 3)
                temp1.push(courses[i]);
            if (i >=3 && i < 6)
                temp2.push(courses[i]);
            if (i >= 6 && i < 9)
                temp3.push(courses[i]);
            if (i == 9)
                temp4.push(courses[i]);
        }
        res.push(temp1);
        res.push(temp2);
        res.push(temp3);
        res.push(temp4);
        res.push(temp5);
        return res;
    },

    assignDiscount(courses) {
        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);
            const status = courses[i].TrangThai === "Đã hoàn thành"

            courses[i].isFieldType = ele1;
            courses[i].completedStatus = status;
            courses[i].isNoDiscount= ele2;
            courses[i].finalPrice= ele3;
        }
        return courses;

    },

    async findTop3LastWeek() {
        const sql = `SELECT *, DATEDIFF(CURDATE(), CTKH.NgayBD) AS Day, TK.Name, LV.TenLinhVuc
                     FROM khoahoc KH
                         INNER JOIN giaovien GV ON GV.MaGiaoVien = KH.GiaoVien
                         INNER JOIN taikhoan TK ON GV.MaTaiKhoan = TK.MaTaiKhoan
                         INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc
                         INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                     ORDER BY Day ASC, SLHocVien DESC
                         LIMIT 3`;
        const ret = await db.raw(sql);
        const courses = this.assignDiscount(ret[0]);

        return courses;
    },

    async findTop10LastedCourse() {
        const sql = `SELECT *, DATEDIFF(CURDATE(), CTKH.NgayBD) AS Day, TK.Name, LV.TenLinhVuc
                     FROM khoahoc KH
                         INNER JOIN giaovien GV ON GV.MaGiaoVien = KH.GiaoVien
                         INNER JOIN taikhoan TK ON GV.MaTaiKhoan = TK.MaTaiKhoan
                         INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc
                         INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                     ORDER BY Day ASC
                    LIMIT 10`;
        const ret = await db.raw(sql);
        const courses = ret[0];
        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);
            const ele4 = true;

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {completedStatus: courses[i] === 'Đã hoàn thành'});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
            Object.assign(courses[i], {isExist: ele4});
        }
        const temp1 = [];
        const temp2 = [];
        const temp3 = [];
        const temp4 = [];
        const temp5 = courses.length / 3 + 1;
        const res = [];
        for (let i = 0; i < 10; i++) {
            if (i < 3)
                temp1.push(courses[i]);
            if (i >=3 && i < 6)
                temp2.push(courses[i]);
            if (i >= 6 && i < 9)
                temp3.push(courses[i]);
            if (i == 9)
                temp4.push(courses[i]);
        }
        res.push(temp1);
        res.push(temp2);
        res.push(temp3);
        res.push(temp4);
        res.push(temp5);
        return res;
    },

    async findTop5MostViewWithField(field, idCourse) {
        const sql = `SELECT KH.*, TK.Name, LV.TenLinhVuc,CTKH.TrangThai, count(DSDK.MaHocVien) as SLKhoaHoc
                     FROM khoahoc KH
                              INNER JOIN GiaoVien GV ON GV.MaGiaoVien = KH.GiaoVien
                              INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                              INNER JOIN danhsachdangki DSDK ON DSDK.MaKhoaHoc = CTKH.MaKhoaHoc
                              INNER JOIN taikhoan TK ON GV.MaTaiKhoan = TK.MaTaiKhoan
                              INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc
                     WHERE LV.MaLinhVuc = ${field} and KH.MaKhoaHoc != ${idCourse}
                     GROUP BY TK.Name, LV.TenLinhVuc,CTKH.TrangThai
                     ORDER BY SLKhoaHoc DESC
                     LIMIT 5`;
        const raw = await db.raw(sql);

        const course = this.assignDiscount(raw[0]);

        return course;
    },

    async findTopFiedls() {
        const sql =  `select lv.NgonNgu, count(k.MaKhoaHoc) as SLKhoaHoc, sum(k.LuotXem) AS SLLuotXem
                      from khoahoc k right join lvngonngu lv on k.NgonNgu = lv.NgonNgu
                      Group by lv.NgonNgu
                      ORDER BY SLLuotXem DESC
                          LIMIT 5`;
        const raw = await db.raw(sql);
        return raw[0] ;
    },

    findAll() {
        return db('Khoahoc')
    },

    async getNameField(idField) {
        const nameField = await db('linhvuc').select('TenLinhVuc').where('MaLinhVuc', idField)
        console.log(nameField[0])
        return nameField[0].TenLinhVuc;
    },

    async getNameLanguage(nameLanguage) {
        const nameField = await db('lvngonngu')
                    .select('linhvuc.TenLinhVuc', 'lvngonngu.NgonNgu')
                    .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'lvngonngu.LinhVuc'})
                    .where('lvngonngu.NgonNgu', nameLanguage);
        console.log(nameField[0])
        return nameField[0];
    },

    async countCourseAll() {
        const list = await db('Khoahoc')
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    async countByField() {
        const sql =  `select lv.MaLinhVuc, lv.TenLinhVuc, count(k.MaKhoaHoc) as SLKhoaHoc
                      from khoahoc k right join linhvuc lv on k.LinhVuc = lv.MaLinhVuc
                      Group by lv.MaLinhVuc, lv.TenLinhVuc`;
        const raw = await db.raw(sql);
        return raw[0];
    },

    async countByLanguage() {
        const sql =  `select k.NgonNgu , lv.MaLinhVuc, lv.TenLinhVuc, count(k.MaKhoaHoc) as SLKhoaHoc
                      from khoahoc k right join linhvuc lv on k.LinhVuc = lv.MaLinhVuc
                      Group by k.NgonNgu,lv.MaLinhVuc, lv.TenLinhVuc`;
        const raw = await db.raw(sql);
        return raw[0];
    },

    async findPageCourseAll(limit, offset) {
        const courses = await db('khoahoc')
            .select(
                'khoahoc.*',
                'taikhoan.Name',
                'linhvuc.TenLinhVuc',
                'chitietkhoahoc.TrangThai',
            )
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('chitietkhoahoc', {'khoahoc.MaKhoaHoc': 'chitietkhoahoc.MaKhoaHoc'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);

        const course = this.assignDiscount(courses);
        return course;
    },

    async findPageByField(linhVuc, limit, offset) {
        const courseField = await db('khoahoc')
            .select(
                'khoahoc.*',
                'taikhoan.Name',
                'linhvuc.TenLinhVuc',
                'chitietkhoahoc.TrangThai',
            )
            .where('LinhVuc', linhVuc)
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('chitietkhoahoc', {'khoahoc.MaKhoaHoc': 'chitietkhoahoc.MaKhoaHoc'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);

        const course = this.assignDiscount(courseField);
        return course;
    },

    async findPageByLanguage(language, limit, offset) {
        const courseField = await db('khoahoc')
            .select(
                'khoahoc.*',
                'taikhoan.Name',
                'linhvuc.TenLinhVuc'
            )
            .where('NgonNgu', language)
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);

        const course = this.assignDiscount(courseField);
        return course;
    },

    /// find by name --  not full text search
    async findByName(name) {
        const sql = await db('KhoaHoc')
            .where('TenKhoaHoc', name );
        return sql;
    },

    async findDetailCourseByID(idCourse) {
        const detailList = await db.select('*')
            .from('khoahoc')
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('chitietkhoahoc', {'khoahoc.MaKhoaHoc': 'chitietkhoahoc.MaKhoaHoc'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'khoahoc.LinhVuc'})
            .where('khoahoc.MaKHoaHoc', idCourse)
        if (detailList.length === 0)
            return null;
        // if(detailList[0]['DOB'] !== null) {
        //     detailList[0]['DOB'] = detailList[0]['DOB'].getDay() + '/' + detailList[0]['DOB'].getMonth() + '/' + detailList[0]['DOB'].getFullYear();
        //     detailList[0]['NgayBD'] = detailList[0]['NgayBD'].getDay() + '/' + detailList[0]['NgayBD'].getMonth() + '/' + detailList[0]['NgayBD'].getFullYear();
        //     detailList[0]['NgayKT'] = detailList[0]['NgayKT'].getDay() + '/' + detailList[0]['NgayKT'].getMonth() + '/' + detailList[0]['NgayKT'].getFullYear();
        //     detailList[0]['NgayCapNhat'] = detailList[0]['NgayCapNhat'].getDay() + '/' + detailList[0]['NgayCapNhat'].getMonth() + '/' + detailList[0]['NgayCapNhat'].getFullYear();
        // }

        Object.assign(detailList[0], {isFieldType: detailList[0].LinhVuc === 1});
        Object.assign(detailList[0], {completedStatus: detailList[0].TrangThai === "Đã hoàn thành"});
        Object.assign(detailList[0], {isNoDiscount: detailList[0].KhuyenMai === 0});
        Object.assign(detailList[0], {finalPrice: detailList[0].Gia * (1 - detailList[0].KhuyenMai / 100)});
        return detailList[0];
    },

    async findTop5BestSeller() {
        const courseList = await db.select('MaKhoaHoc').count('MaKhoaHoc as sldk')
            .from('danhsachdangki')
            .groupBy('MaKhoaHoc')
            .orderBy('sldk', 'desc')
            .limit(5)

        return courseList;
    },
    async findTop5new() {
        const courseList = await db.select('MaKhoaHoc')
            .from('khoahoc')
            .orderBy('MaKhoaHoc', 'desc')
            .limit(5)

        return courseList;
    },


    async findCourseVideoList(idCourse) {
        const videoList = await db('danhsachvideo').where('MaKhoaHoc', idCourse);

        for(let i = 0; i < videoList.length; i++) {
            let regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            let match = videoList[i].Link.match(regExp);

            if (match && match[2].length === 11) {
                videoList[i]['Link'] =  "//www.youtube.com/embed/" + match[2];
            } else {
                videoList[i]['Link'] =  "//www.youtube.com/embed/" + 'error';
            }

            if (videoList[i].File === '')
                Object.assign(videoList[i], {isFile: false});
            else
                Object.assign(videoList[i], {isFile: true});
        }

        if(videoList.length === 0)
            return null;
        return videoList;
    },

    async inforStudentsOfTeacher(idTeacher) {
        const amountCourse = await db('Khoahoc')
            .innerJoin('chitietkhoahoc', {'khoahoc.MaKhoaHoc': 'chitietkhoahoc.MaKhoaHoc'})
            .where('GiaoVien', idTeacher)
            .count({amountCourses : 'GiaoVien'})
            .sum({amountReview: 'SLHocSinhDanhGia'})
            .sum({ratings: 'RateTB'})
            .sum({amountStudents: 'SLHocVien'})
            .groupBy('GiaoVien')

        amountCourse[0]['ratings'] = Math.round(amountCourse[0]['ratings'] / amountCourse[0]['amountCourses'] *10) / 10
        return amountCourse[0];
    },

    async getStudentReviewList(idCourse) {
        const userReview = await db('bangdanhgia')
            .select('bangdanhgia.Rate', 'bangdanhgia.Comment', 'taikhoan.Avatar', 'taikhoan.Name')
            .innerJoin('hocvien', {'bangdanhgia.MaHocVien': 'hocvien.MaHocVien'})
            .innerJoin('taikhoan', {'hocvien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .where('bangdanhgia.MaKhoaHoc', idCourse)
        // .limit(limit)
        if(userReview.length === 0) {
            return null;
        }
        return userReview;
    },

    async findByIDTeacherAccount(idUser) {
        const teacher = await db('GiaoVien').where('MaTaiKhoan', idUser);
        if(teacher.length === 0)
            return null;
        return teacher[0].MaGiaoVien;
    },

    async findCourseById(id) {
        const courses = await db('khoahoc')
            .select(
                'khoahoc.*',
                'taikhoan.Name',
                'linhvuc.TenLinhVuc'
            )
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .where('khoahoc.MaKhoaHoc', id);

        const course = this.assignDiscount(courses);
        return course;
    },

    async courseFullTextSearch(name, limit, offset) {
        const sql = `SELECT *
                     FROM khoahoc
                     WHERE
                         MATCH(TenKhoaHoc, MoTaNgan)
                         AGAINST('` + name + `')
        LIMIT ${limit}
        OFFSET ${offset};`
        const rel = await db.raw(sql);
        return rel;
    },
    async SearchOrderByPrice(name, limit, offset) {
        const sql = `SELECT * from
            (SELECT MaKhoaHoc
             FROM khoahoc
             WHERE MATCH(TenKhoaHoc, MoTaNgan)
                 AGAINST('` + name + `')) M
        INNER JOIN khoahoc k USING(MaKhoaHoc)
        ORDER BY k.Gia
        LIMIT ${limit}
        OFFSET ${offset};`
        const rel = await db.raw(sql);
        return rel;
    },
    async SearchOrderByRate(name, limit, offset) {
        const sql = `SELECT * from
            (SELECT MaKhoaHoc
             FROM khoahoc
             WHERE MATCH(TenKhoaHoc, MoTaNgan)
                 AGAINST('` + name + `')) M
        INNER JOIN khoahoc k USING(MaKhoaHoc)
        ORDER BY k.RateTB DESC
        LIMIT ${limit}
        OFFSET ${offset};`
        const rel = await db.raw(sql);
        return rel;
    },

    async findLangByCat(catId) {
        const list = await db('LVNgonNgu').where('LinhVuc', catId);
        if(list.length === 0)
            return null;
        return list;
    },

    async findCourseBySubCate(nameCat) {
        const list = await db('KhoaHoc')
        .select('KhoaHoc.*',
                'ChiTietKhoaHoc.*',
                'LinhVuc.*')
        .innerJoin('ChiTietKhoaHoc', {'KhoaHoc.MaKhoaHoc': 'ChiTietKhoaHoc.MaKhoaHoc'})
        .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'khoahoc.LinhVuc'})
        .where('NgonNgu', nameCat);

        if(list.length === 0)
            return null;
        return list;
    },

    async isCourseRegister(maKhoaHoc, maHocVien) {
        const list = await db('DanhSachDangKi')
            .where('MaKhoaHoc', maKhoaHoc).andWhere('MaHocVien', maHocVien);

        if(list.length === 0)
            return null;
        return list[0];
    },

    addBangDanhSachDangKi(newDanhsachdangki) {
        return db('danhsachdangki').insert(newDanhsachdangki);
    },
    updateSLKhoaHoc(idStudent, amountCourse) {
        return db('hocvien').where('MaHocVien', idStudent).update({SLKhoaHoc: amountCourse});
    },
    // Process To Delete Course
    delAllVidCoursebyID(idkh) {
        return db('danhsachvideo').where('MaKhoaHoc', idkh).del();
    },
    delRatingCoursebyID(idkh) {
        return db('bangdanhgia').where('MaKhoaHoc', idkh).del();
    },
    delRegCoursebyID(idkh) {
        return db('danhsachdangki').where('MaKhoaHoc', idkh).del();
    },
    delDetailCoursebyID(idkh) {
        return db('chitietkhoahoc').where('MaKhoaHoc', idkh).del();
    },
    delCoursebyID(idkh) {
        return db('khoahoc').where('MaKhoaHoc', idkh).del();
    },

}