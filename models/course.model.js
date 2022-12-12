import db from '../utils/db.js'

// knex cheetsheet : web xem 1 so syntax trut gon
export default {
    findByName(name) {

        return name;
    },

    findAll() {
        return db('Khoahoc')
    },

    async countCourseAll() {
        const list = await db('Khoahoc')
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    async countField() {
        const list = await db('Khoahoc')
            .countDistinct({amount : 'LinhVuc'});
        return list[0].amount;
    },

    async countByField(linhVuc) {
        const list = await db('Khoahoc')
            .where('LinhVuc', linhVuc)
            .count({amount : 'MaKhoaHoc'});
        return list[0].amount;
    },

    findPageCourseAll(limit, offset) {
        return db('Khoahoc')
            .select(
                ['Khoahoc.MaKhoaHoc',
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
                'linhvuc.TenLinhVuc']
            )
            .innerJoin('giaovien', {'Khoahoc.GiaoVien': 'MaGiaoVien.id'})
            .innerJoin('taikhoan', {'giaovien.MaTaiKhoan': 'taikhoan.MaTaiKhoan'})
            .innerJoin('linhvuc', {'linhvuc.LinhVuc': 'Khoahoc.LinhVuc'})
            .limit(limit)
            .offset(offset);
    },

    findPageByField(linhVuc, limit, offset) {
        return db('Khoahoc')
            .where('LinhVuc', linhVuc)
            .limit(limit)
            .offset(offset);
    },
}