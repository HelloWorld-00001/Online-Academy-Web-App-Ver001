import db from '../utils/db.js';

export default {
    async countAllUser() {
        const list = await db('taikhoan').count({amount: '*'});
        return list[0].amount;
    },
    async countAllCourse() {
        const list = await db('khoahoc').count({amount: '*'});
        return list[0].amount;
    },
    async countAllStudent() {
        const list = await db('taikhoan').count({amount: 'MaTaiKhoan'}).where('LoaiTaiKhoan', 'Học viên');
        return list[0].amount;
    },
    async countAllTeacher() {
        const list = await db('taikhoan').count({amount: 'MaTaiKhoan'}).where('LoaiTaiKhoan', 'Giáo viên');
        return list[0].amount;
    },
    async countAllVid() {
        const list = await db('danhsachvideo').count({amount: '*'});
        return list[0].amount
    },
    async countAllCate() {
        const list = await db('linhvuc').count({amount: '*'});
        return list[0].amount
    },
    vwAllVideo() {
        return db('danhsachvideo');
    },
    async findAllTeacher() {
        const list = await db('taikhoan')
        .select(
            'giaovien.MaGiaoVien',
            'taikhoan.MaTaiKhoan',
            'taikhoan.Name',
            'taikhoan.Username',
            'taikhoan.Email',
            'giaovien.SLKhoaHoc'
        )
        .innerJoin('giaovien', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'});
        return list;
    },
    async findAllCategory() {
        return db('linhvuc');
    },


    async findAllCourse() {
        const sql = `SELECT kh.MaKhoaHoc, kh.TenKhoaHoc, lv.TenLinhVuc, kh.SoLuongVideo, COUNT(b.MaHocVien) as SLHocVien
                        FROM khoahoc kh LEFT JOIN danhsachdangki b on kh.MaKhoaHoc = b.MaKhoaHoc
                        JOIN linhvuc lv on kh.LinhVuc = lv.MaLinhVuc
                        GROUP BY kh.MaKhoaHoc, kh.TenKhoaHoc, lv.TenLinhVuc, kh.SoLuongVideo`;
        const raw = await db.raw(sql);
        return raw[0];
    },
    async findTopThreeTeacher() {
        const list = await db('giaovien')
        .select(
            'giaovien.MaGiaoVien',
            'taikhoan.Name',
            'taikhoan.Username',
            'taikhoan.Email',
        )
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'})
        //.limit(3);
        return list;
    },
    async findTopThreeStudent() {
        const list = await db('hocvien')
        .select(
            'hocvien.MaHocVien',
            'taikhoan.Name',
            'taikhoan.Username',
            'taikhoan.Email',
        )
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'hocvien.MaTaiKhoan'})
        //.limit(3);
        return list;
    },
    
    async findTopThreeCourse() {
        const list = await db('KhoaHoc')
        .select(
            'MaKhoaHoc',
            'TenKhoaHoc',
            'Gia',
            'taikhoan.Username',
        )
        .innerJoin('taikhoan', {'KhoaHoc.GiaoVien': 'taikhoan.MaTaiKhoan'})
        //.limit(3);
        return list;
    },
    async findTopThreeVideo() {
        const list = await db('danhsachvideo')
        .select(
            'TenVideo',
            'khoahoc.TenKhoaHoc',
            'STT',
            'NgayCapNhat',
        )
        .innerJoin('khoahoc', {'khoahoc.MaKhoaHoc': 'danhsachvideo.MaKhoaHoc'})
        //.limit(3);
        return list;
    },
    addCategory(entity) {
        return db('linhvuc').insert({
            TenLinhVuc: entity.TenLinhVuc,
        });
    },
}