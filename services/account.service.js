import db from '../utils/db.js';

export default {
  findAll() {
    return db('TaiKhoan');
  },

  async findByID(id) {
    const list = await db('TaiKhoan').where('MaTaiKhoan', id);
    if(list.length === 0) 
      return null;
    
    return list[0];
  },

  async findByUsername(username) {
    const list = await db('TaiKhoan').where('Username', username);
    if(list.length === 0) 
      return null;
    
    return list[0];
  },

  async findByEmail(email) {
    const list = await db('TaiKhoan').where('Email', email);
    if(list.length === 0) 
      return null;
    
    return list[0];
  },

  del(MaTaiKhoan) {
    return db('TaiKhoan').where('MaTaiKhoan', MaTaiKhoan).del();
  },

  add(taikhoan) {
    return db('TaiKhoan').insert({
      Username: taikhoan.Username,
      Password: taikhoan.Password,
      LoaiTaiKhoan: taikhoan.LoaiTaiKhoan,
      Name: taikhoan.Name,
      Email: taikhoan.Email,
      DOB: taikhoan.DOB,
      Avatar: taikhoan.Avatar,
      DiaChi: taikhoan.DiaChi,
      SDT: taikhoan.SDT      
    });
  },

  edit(id, entity) {
    return db('TaiKhoan')
    .where({MaTaiKhoan: id})
    .update({
      Name: entity.Name,
      Email: entity.Email,
      DOB: entity.DOB,
      Avatar: entity.Avatar,
      DiaChi: entity.DiaChi,
      SDT: entity.SDT
    })
  },

  grantTeacher(id) {
    return db('TaiKhoan').where('MaTaiKhoan', id).update({LoaiTaiKhoan: 'Giáo Viên'})
  },

  grantAdmin(id) {
    return db('TaiKhoan').where('MaTaiKhoan', id).update({LoaiTaiKhoan: 'Admin'})
  },

  updatePassword(id, newPassword) {
    return db('TaiKhoan').where('MaTaiKhoan', id).update({Password: newPassword});
  },

  async findTeacherByID(id) {
    const list = await db('GiaoVien').where('MaTaiKhoan', id);
    if(list.length === 0) {
      return null;
    }
    return list[0];
  }
}