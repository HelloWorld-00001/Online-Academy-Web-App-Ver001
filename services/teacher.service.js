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

    async findIdTeacher(Username) {
        const list = await db('taikhoan')
        .select('MaTaiKhoan'
        ).where('Username', Username)
        //.limit(3);
        return list;
    },

    async findField() {
        const list = await db('linhvuc')
            .select('MaLinhVuc', 'TenLinhVuc')
        return list;
    },


    addAccount(entity) {
        return db('taikhoan').insert({
            Username: entity.Username,
            Password: entity.Password,
            Name: entity.Name,
            Email: entity.Email,
            DOB: '2002-08-12',
            LoaiTaiKhoan: entity.LoaiTaiKhoan,
            Avatar: entity.Avatar,
            SDT: entity.SDT,
            DiaChi: entity.DiaChi,
        });
    },

    add(entity, MaTk) {
        return db('giaovien').insert({
            MaTaiKhoan: MaTk.MaTaiKhoan,
            MoTa: entity.MoTa,
            SLKhoaHoc: entity.SLKhoaHoc
        });
     },
 
    delTeacher(idtk) {
         return  db('giaovien').where('MaTaiKhoan', idtk).del();
    },
    delAccount(id) {
        return  db('taikhoan').where('MaTaiKhoan', id).del();
   },
    patch(entity) {
         return  db('categories').where('CatID', entity.CatID).update('CatName', entity.CatName);
 
         //or
         //const id = entity.CatID;
         //delete entity.CatID;
         //return  db('categories').where('CatID', id).update(entity;
     },
}