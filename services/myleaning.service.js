import db from "../utils/db.js";

export default {
    async countStudentCourseAll(idStudent) {
        const list = await db('danhsachdangki')
            .where('MaHocVien', idStudent)
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    async findPageStudentCourseAll(idStudent, limit, offset) {
        const studentCourse = await db('danhsachdangki')
            .select(
                'khoahoc.*',
                'taikhoan.Username',
                'linhvuc.TenLinhVuc'
            )
            .where('danhsachdangki.MaHocVien', idStudent)
            .innerJoin('khoahoc', {'khoahoc.MaKhoaHoc': 'danhsachdangki.MaKhoaHoc'})
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);
        if(studentCourse.length === 0) {
            return null;
        }
        for(let i = 0; i < studentCourse.length; i++) {
            Object.assign(studentCourse[i], {isFieldType: studentCourse[i].LinhVuc === 1});
        }
        return studentCourse;
    },


    async countStarRate(idCourse, numberRate) {
        const numberStar= await db('bangdanhgia')
            // .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('MaKhoaHoc', idCourse)
            .where('Rate', numberRate)
            .count({amount : 'MaHocVien'});

        return numberStar[0].amount;
    },

    async countStudentRating(idCourse) {
        const numberStar= await db('bangdanhgia')
            // .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('MaKhoaHoc', idCourse)
            .count({amount : 'MaHocVien'});

        return numberStar[0].amount;
    },

    async sumStudentRating(idCourse) {
        const totalRate= await db('bangdanhgia')
            // .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('MaKhoaHoc', idCourse)
            .sum({total : 'Rate'});

        return totalRate[0].total;
    },

    async getUserRating(idCourse, idStudent) {
        const userReview = await db('bangdanhgia')
            .select('Rate', 'Comment')
            .where('MaKhoaHoc', idCourse)
            .where('MaHocVien', idStudent)
        if(userReview.length === 0) {
            return null;
        }
        return userReview[0];
    },

    addBangDanhGia(newRating) {
        return db('bangdanhgia').insert(newRating);
    },


    updateKhoaHoc(idCourse, rateTB, amountStudentRating) {
        return db('khoahoc')
            .where('MaKhoaHoc', idCourse)
            .update({ RateTB: rateTB, SLHocSinhDanhGia: amountStudentRating })
    },

    delBangDanhGia(idCourse, idStudent) {
        return db('bangdanhgia')
            .where('MaKhoaHoc', idCourse)
            .where('MaHocVien', idStudent)
            .del();
    },

    updateBangDanhGia(studentReview) {
        const idStudent = studentReview.MaHocVien;
        const idCourse = studentReview.MaKhoaHoc;

        delete studentReview.MaHocVien;
        delete studentReview.MaKhoaHoc;

        return db('bangdanhgia')
            .where('MaKhoaHoc', idCourse)
            .where('MaHocVien', idStudent)
            .update(studentReview);
    }

}