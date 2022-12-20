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
}