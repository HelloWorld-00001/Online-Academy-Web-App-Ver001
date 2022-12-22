import db from '../utils/db.js';

export default {
    
    async findTeacherById(id) {
        const list = await db('giaovien')
        .select(
            'giaovien.*',
            'taikhoan.*'
        ).where('giaovien.MaGiaoVien', id)
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'})
        //.limit(3);
        return list[0];
    },

    async findAccountByIdTeacher(id) {
        const list = await db('giaovien')
            .select('giaovien.MaTaiKhoan').where('giaovien.MaGiaoVien', id)
        return list[0];
    },

    async editGiaovien(account, idTeacher) {
        return db('giaovien')
            .where({MaGiaoVien: idTeacher})
            .update({ MoTa: account })
    },

    async editTaikhoan(account, idAccount) {
        return db('taikhoan')
            .where({MaTaiKhoan: idAccount})
            .update({  Name: account.Name,
                            Email: account.Email,
                            DOB: account.DOB,
                            Avatar: account.Avatar,
                            SDT: account.SDT,
                            DiaChi: account.Diachi
            })
    },
    async getNameImage(accountId) {
        const list = await db('taikhoan')
            .select('taikhoan.Avatar').where('taikhoan.MaTaiKhoan', accountId)
        return list[0];
    },
}