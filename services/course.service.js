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

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
        }
        const temp1 = [];
        const temp2 = [];
        const temp3 = [];
        const temp4 = [];
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

            Object.assign(courses[i], {isFieldType: ele1});
            Object.assign(courses[i], {isNoDiscount: ele2});
            Object.assign(courses[i], {finalPrice: ele3});
        }
        const temp1 = [];
        const temp2 = [];
        const temp3 = [];
        const temp4 = [];
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
        return res;
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
        const courses = await db('Khoahoc')
                    .select(
                        'Khoahoc.MaKhoaHoc',
                        'Khoahoc.TenKhoaHoc',
                        'Khoahoc.LinhVuc',
                        'Khoahoc.Gia',
                        'Khoahoc.SoLuongVideo',
                        'Khoahoc.Image',
                        'Khoahoc.KhuyenMai',
                        'Khoahoc.RateTB',
                        'Khoahoc.SLHocSinhDanhGia',
                        'Khoahoc.LuotXem',
                        'taikhoan.Username',
                        'linhvuc.TenLinhVuc'
                    )
                    .innerJoin('giaovien', {'Khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
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
        const courseField = await db('Khoahoc')
            .select(
                'Khoahoc.MaKhoaHoc',
                'Khoahoc.TenKhoaHoc',
                'Khoahoc.LinhVuc',
                'Khoahoc.Gia',
                'Khoahoc.SoLuongVideo',
                'Khoahoc.Image',
                'Khoahoc.KhuyenMai',
                'Khoahoc.RateTB',
                'Khoahoc.SLHocSinhDanhGia',
                'Khoahoc.LuotXem',
                'taikhoan.Username',
                'linhvuc.TenLinhVuc'
            )
            .innerJoin('giaovien', {'Khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .where('LinhVuc', linhVuc)
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
    }

}