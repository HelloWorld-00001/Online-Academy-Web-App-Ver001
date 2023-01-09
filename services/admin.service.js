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
    async countCoursebyCateID(idlv) {
        const list = await db('khoahoc').count({amount: 'MaKhoaHoc'}).where('LinhVuc', idlv);
        return list[0];
    },
    async countCoursebyCateID1(idlv) {
        const list = await db('khoahoc').count({amount: 'MaKhoaHoc'}).where('NgonNgu', idlv);
        return list[0];
    },
    async countChildrent(idlv) {
        const list = await db('lvngonngu').count({amount: 'NgonNgu'}).where('LinhVuc', idlv);
        return list[0];
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
            'giaovien.SLKhoaHoc',
            'taikhoan.TinhTrang'
        )
        .innerJoin('giaovien', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'});
        return list;
    },
    async findAllCategory() {
        return db('linhvuc');
    },
    async findAllCategory1() {
        return db('lvngonngu').select(
            'lvngonngu.NgonNgu',
            'linhvuc.TenLinhVuc',
            'linhvuc.MaLinhVuc'
        ).innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'lvngonngu.LinhVuc'})
    },
    
    async findAllCourse() {
        const sql = `SELECT kh.MaKhoaHoc, kh.TenKhoaHoc, lv.TenLinhVuc, kh.SoLuongVideo, COUNT(b.MaHocVien) as SLHocVien, kh.TinhTrang
                        FROM khoahoc kh LEFT JOIN danhsachdangki b on kh.MaKhoaHoc = b.MaKhoaHoc
                        JOIN linhvuc lv on kh.LinhVuc = lv.MaLinhVuc
                        GROUP BY kh.MaKhoaHoc, kh.TenKhoaHoc, lv.TenLinhVuc, kh.SoLuongVideo`;
        const raw = await db.raw(sql);
        return raw[0];
    },
    async findTopFiveTeacher() {
        const list = await db('giaovien')
        .select(
            'giaovien.MaGiaoVien',
            'taikhoan.Name',
            'taikhoan.Username',
            'taikhoan.Email',
        )
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'})
        .limit(5);
        return list;
    },
    async findTopFiveStudent() {
        const list = await db('hocvien')
        .select(
            'hocvien.MaHocVien',
            'taikhoan.Name',
            'taikhoan.Username',
            'taikhoan.Email',
        )
        .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'hocvien.MaTaiKhoan'})
        .limit(5);
        return list;
    },
    
    async findTopFiveCourse() {
        const list = await db('KhoaHoc')
        .select(
            'MaKhoaHoc',
            'TenKhoaHoc',
            'Gia',
            'taikhoan.Username',
        )
        .innerJoin('taikhoan', {'KhoaHoc.GiaoVien': 'taikhoan.MaTaiKhoan'})
        .limit(5);
        return list;
    },
    async findTopFiveVideo() {
        const list = await db('danhsachvideo')
        .select(
            'TenVideo',
            'khoahoc.TenKhoaHoc',
            'STT',
            'NgayCapNhat',
        )
        .innerJoin('khoahoc', {'khoahoc.MaKhoaHoc': 'danhsachvideo.MaKhoaHoc'})
        .limit(5);
        return list;
    },

    // Category management
    addCategory(entity) {
        return db('linhvuc').insert({
            TenLinhVuc: entity,
        });
    },
    addCategory1(entityparent, entitychildren){
        return db('lvngonngu').insert({
            NgonNgu: entitychildren,
            LinhVuc: entityparent
        })
    },
    delCategory(id) {
        return db('linhvuc').where('MaLinhVuc', id).del();
    },
    delCategory1(id) {
        return db('lvngonngu').where('NgonNgu', id).del();
    },
    async findCatebyID(id) {
        return await db('linhvuc').select('TenLinhVuc').where('MaLinhVuc', id);
    },
    async findAllVideo() {
        const sql = `select dsvd.TenVideo, kh.TenKhoaHoc, tk.Name, lv.TenLinhVuc, dsvd.NgayCapNhat
                        from danhsachvideo dsvd
                        join khoahoc kh on dsvd.MaKhoaHoc = kh.MaKhoaHoc
                        join giaovien gv on gv.MaGiaoVien = kh.GiaoVien
                        join taikhoan tk on gv.MaTaiKhoan = tk.MaTaiKhoan
                        join linhvuc lv on lv.MaLinhVuc = kh.LinhVuc`;
        const raw = await db.raw(sql);
        return raw[0];
    },

    //account
    lockAccount(id) {
        return db('TaiKhoan')
        .where({MaTaiKhoan: id})
        .update({TinhTrang: 0});
    },

    unlockAccount(id) {
        return db('TaiKhoan')
        .where({MaTaiKhoan: id})
        .update({TinhTrang: 1});
    },

    disableCourse(id) {
        return db('KhoaHoc').where({MaKhoaHoc: id}).update({TinhTrang: 0});
    },
    enableCouse(id) {
        return db('KhoaHoc').where({MaKhoaHoc: id}).update({TinhTrang: 1});
    },
    editCategory(id, name) {
        return db('linhvuc').where({MaLinhVuc: id}).update({TenLinhVuc: name})
    }

}
