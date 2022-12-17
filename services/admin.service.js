import db from '../utils/db.js';

export default {
    async countAllCourse() {
        const list = await db('khoahoc').count({amount: '*'});
        return list[0].amount;
    },
    async countAllStudent() {
        const list = await db('taikhoa').count({amount: 'MaTaiKhoan'}).where('LoaiTaiKhoan', 'Học viên');
        return list[0].amount;
    },
    async countAllTeacher() {
        const list = await db('taikhoa').count({amount: 'MaTaiKhoan'}).where('LoaiTaiKhoan', 'Giáo viên');
        return list[0].amount;
    },
    async countNumofVid() {
        const list = await db('danhsachvideo').count({amount: '*'});
        return list[0].amount
    },
    vwAllVideo() {
        return db('danhsachvideo');
    },
}