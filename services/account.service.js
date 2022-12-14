import db from '../utils/db.js';

export default {
  findAll() {
    return db('TaiKhoan');
  },

  async findByUsername(username) {
    const list = await db('TaiKhoan').where('Username', username);
    if(list.length === 0) 
      return null;
    
    return list[0];
  },

  add(taikhoan) {
    return db('TaiKhoan').insert(taikhoan);
  }
}