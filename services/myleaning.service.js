import db from "../utils/db.js";

export default {
    async countStarRate(idCourse, numberRate) {
        const numberStar= await db('Khoahoc')
            .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('khoahoc.MaKhoaHoc', idCourse)
            .where('bangdanhgia.Rate', numberRate)
            .count({amount : 'bangdanhgia.MaHocVien'});

        return numberStar[0].amount;
    },

    async countStudentRating(idCourse) {
        const numberStar= await db('Khoahoc')
            .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('khoahoc.MaKhoaHoc', idCourse)
            .count({amount : 'bangdanhgia.MaHocVien'});

        return numberStar[0].amount;
    },

    async sumStudentRating(idCourse) {
        const totalRate= await db('Khoahoc')
            .innerJoin('bangdanhgia', {'khoahoc.MaKhoaHoc': 'bangdanhgia.MaKhoaHoc'})
            .where('khoahoc.MaKhoaHoc', idCourse)
            .sum({total : 'bangdanhgia.Rate'});

        return totalRate[0].total;
    },

    addRating(idCourse, rateTB, amountStudentRating) {
        return db('khoahoc')
            .where('MaKhoaHoc', idCourse)
            .update({ RateTB: rateTB, SLHocSinhDanhGia: amountStudentRating })

    },
}