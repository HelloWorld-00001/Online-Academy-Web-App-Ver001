import db from '../utils/db.js';

export default {
    async findTop10MostViewCourse() {
        const sql = `SELECT KH.*, TK.Username, LV.TenLinhVuc
                     FROM khoahoc KH
                              INNER JOIN giaovien GV ON GV.MaGiaoVien = KH.GiaoVien
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

    async findTop3LastWeek() {
        const sql = `SELECT *, DATEDIFF(CURDATE(), CTKH.NgayBD) AS Day, TK.Username, LV.TenLinhVuc
                     FROM khoahoc KH
                         INNER JOIN giaovien GV ON GV.MaGiaoVien = KH.GiaoVien
                         INNER JOIN taikhoan TK ON GV.MaTaiKhoan = TK.MaTaiKhoan
                         INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc
                         INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                     HAVING Day between 0 AND 7
                     ORDER BY Day ASC, SLHocVien DESC
                     LIMIT 3`;
        const ret = await db.raw(sql);
        const courses = ret[0];
        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
        }

        return courses;
    },

    async findTop10LastedCourse() {
        const sql = `SELECT *, DATEDIFF(CURDATE(), CTKH.NgayBD) AS Day, TK.Username, LV.TenLinhVuc
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
        const courses = await db('khoahoc')
                            .select(
                                'khoahoc.*',
                                'taikhoan.Username',
                                'linhvuc.TenLinhVuc'
                            )
                            .where('LinhVuc', field)
                            .whereNot('MaKhoaHoc', +idCourse)
                            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
                            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
                            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})

                            .limit(5);

        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
        }
        return courses;
    },

    async findTopFiedls() {
        const sql =  `select lv.MaLinhVuc, lv.TenLinhVuc, count(k.MaKhoaHoc) as SLKhoaHoc
                        from khoahoc k right join linhvuc lv on k.LinhVuc = lv.MaLinhVuc
                        Group by lv.MaLinhVuc, lv.TenLinhVuc
                        LIMIT 1`;
        const raw = await db.raw(sql);
        return raw[0] ;
    },

    findAll() {
        return db('Khoahoc')
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
        return raw[0] ;
    },



    async findPageCourseAll(limit, offset) {
        const courses = await db('khoahoc')
                    .select(
                        'khoahoc.*',
                        'taikhoan.Username',
                        'linhvuc.TenLinhVuc'
                    )
                    .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
                    .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
                    .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
                    .limit(limit)
                    .offset(offset);

        for(let i = 0; i < courses.length; i++) {
            const ele1 = courses[i].LinhVuc === 1;
            const ele2 = courses[i].KhuyenMai === 0;
            const ele3 = courses[i].Gia * (1 - courses[i].KhuyenMai / 100);

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
        }
        return courses;
    },

    async findPageByField(linhVuc, limit, offset) {
        const courseField = await db('khoahoc')
            .select(
                'khoahoc.*',
                'taikhoan.Username',
                'linhvuc.TenLinhVuc'
            )
            .where('LinhVuc', linhVuc)
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);

        for(let i = 0; i < courseField.length; i++) {
            const ele1 = courseField[i].LinhVuc === 1;
            const ele2 = courseField[i].KhuyenMai === 0;
            const ele3 = courseField[i].Gia * (1 - courseField[i].KhuyenMai / 100);

            Object.assign(courseField[i], {isFieldType: ele1});
            Object.assign(courseField[i], {isNoDiscount: ele2});
            Object.assign(courseField[i], {finalPrice: ele3});
        }
        return courseField;
    },

    /// find by name --  not full text search
    async findByName(name) {
        const sql = await db('KhoaHoc')
        .where('TenKhoaHoc', name );
        return sql;
    },

    async findDetailCourseByID(makhoahoc) {
        const detailList = await db.select('*')
                                .from('khoahoc')
                                .where('khoahoc.MaKHoaHoc', makhoahoc)
                                .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
                                .innerJoin('chitietkhoahoc', {'khoahoc.MaKhoaHoc': 'chitietkhoahoc.MaKhoaHoc'})
                                .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
                                .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'khoahoc.LinhVuc'})
        detailList[0]['DOB'] = detailList[0]['DOB'].getDay() + '/' + detailList[0]['DOB'].getMonth() + '/' + detailList[0]['DOB'].getFullYear();
        detailList[0]['NgayBD'] = detailList[0]['NgayBD'].getDay() + '/' + detailList[0]['NgayBD'].getMonth() + '/' + detailList[0]['NgayBD'].getFullYear();
        detailList[0]['NgayKT'] = detailList[0]['NgayKT'].getDay() + '/' + detailList[0]['NgayKT'].getMonth() + '/' + detailList[0]['NgayKT'].getFullYear();
        detailList[0]['NgayCapNhat'] = detailList[0]['NgayCapNhat'].getDay() + '/' + detailList[0]['NgayCapNhat'].getMonth() + '/' + detailList[0]['NgayCapNhat'].getFullYear();

        if (detailList.length === 0)
            return null;

        return detailList[0];
    },

    async findCourseVideoList(idCourse) {
        const videoList = await db('danhsachvideo').where('MaKhoaHoc', idCourse);
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
        // const amountStudent = knex('Khoahoc').sum('products')
        // Outputs:
        //     select sum("products") from "users"
        amountCourse[0]['ratings'] = Math.round(amountCourse[0]['ratings'] / amountCourse[0]['amountCourses'] *10) / 10
        return amountCourse[0];
    },

}