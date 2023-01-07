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
    },

    async findStudentById(id) {
        const list = await db('hocvien')
        .select(
            'hocvien.*',
            'taikhoan.*'
        ).where('hocvien.MaHocVien', id)
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'hocvien.MaTaiKhoan'})
        return list[0];
    },

    async findStudentIdByAccountId(AccountId) {
        const list = await db('HocVien')
            .select('hocvien.MaHocVien').where('hocvien.MaTaiKhoan', AccountId)
        return list[0].MaHocVien;
    },

    async findAccountIdByIdStudent(id) {
        const list = await db('hocvien')
            .select('hocvien.MaTaiKhoan').where('hocvien.MaHocVien', id)
        return list[0];
    },

    async getNameImage(accountId) {
        const list = await db('taikhoan')
            .select('taikhoan.Avatar').where('taikhoan.MaTaiKhoan', accountId)
        return list[0];
    },

    async editTaikhoan(account, idAccount) {
        return db('taikhoan')
            .where({MaTaiKhoan: idAccount})
            .update({  Name: account.Name,
                            Email: account.Email,
                            DOB: account.DOB,
                            Avatar: account.Avatar,
                            SDT: account.SDT,
                            DiaChi: account.DiaChi
            })
    },
}