import db from '../utils/db.js';

export default {
    async findAll() {
        return db('TaiKhoan')
        .select('HocVien.*', 'TaiKhoan.*')
        .innerJoin('HocVien', {'TaiKhoan.MaTaiKhoan': 'HocVien.MaTaiKhoan'});
    },

    async findByID(id) {
        const list = await db('HocVien')
        .select(
            'HocVien.*',
            'TaiKhoan.*'
        ).where('HocVien.MaHocVien', id)
        .innerJoin('TaiKhoan', {'TaiKhoan.MaTaiKhoan': 'HocVien.MaTaiKhoan'})
        return list[0];
    },
    
    add(accountID) {
        return db('HocVien').insert({
            MaTaiKhoan: accountID,
            SLKhoaHoc: 0
        });
    },

    del(studentID) {
        return db('HocVien').where('MaHocVien', studentID).del();
    },

    delBangDanhGia(studentID) {
        return db('BangDanhGia').where('MaHocVien', studentID).del();
    },

    delDanhSachDangKi(studentID) {
        return db('DanhSachDangKi').where('MaHocVien', studentID).del();
    },

    edit(studentID, slkh) {
        return db('HocVien')
        .where({MaHocVien: studentID})
        .update({SLKhoaHoc: slkh});
    }
}