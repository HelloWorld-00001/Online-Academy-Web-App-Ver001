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

  add(taikhoan) {
    return db('TaiKhoan').insert(taikhoan);
  },
}