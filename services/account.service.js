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
    return db('TaiKhoan').insert(taikhoan);
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

  grant(id) {
    return db('TaiKhoan').where('MaTaiKhoan', id).update({LoaiTaiKhoan: 'Giáo Viên'})
  }
}