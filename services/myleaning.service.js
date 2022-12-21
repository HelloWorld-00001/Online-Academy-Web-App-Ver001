import db from "../utils/db.js";

export default {
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

    // addRating(idCourse, rateTB, amountStudentRating) {
    //     return db('khoahoc')
    //         .where('MaKhoaHoc', idCourse)
    //         .update({ RateTB: rateTB, SLHocSinhDanhGia: amountStudentRating })
    //
    // },
    addBangDanhGia(newRating) {
        return db('bangdanhgia').insert(newRating);
    },

    updateKhoaHoc(idCourse, rateTB, amountStudentRating) {
        return db('khoahoc')
            .where('MaKhoaHoc', idCourse)
            .update({ RateTB: rateTB, SLHocSinhDanhGia: amountStudentRating })
    },
}