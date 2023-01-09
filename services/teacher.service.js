import db from '../utils/db.js';

export default {
    async findAllTeacher() {
        const list = await db('taikhoan')
            .select('taikhoan.*')
            .where('taikhoan.LoaiTaiKhoan', 'Giáo viên')
        return list;
    },

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

    async findCoursesByIdTeacher(id) {
        const list = await db('khoahoc')
            .select(
                'khoahoc.*',
                'chitietkhoahoc.*',
                'linhvuc.*',
            ).where('khoahoc.GiaoVien', id)
            .innerJoin('chitietkhoahoc', {'chitietkhoahoc.MaKhoaHoc': 'khoahoc.MaKhoaHoc'})
            .innerJoin('linhvuc', {'linhvuc.MaLinhVuc': 'khoahoc.LinhVuc'})
        return list;
    },

    async findTeacherIdByAccountId(AccountId) {
        const list = await db('giaovien')
            .select('giaovien.MaGiaoVien').where('giaovien.MaTaiKhoan', AccountId)
        return list[0].MaGiaoVien;
    },

    async findAccountByIdTeacher(id) {
        const list = await db('giaovien')
            .select('giaovien.MaTaiKhoan').where('giaovien.MaGiaoVien', id)
        return list[0];
    },

    async findCourseId(obj) {
        const list = await db('khoahoc')
            .select('khoahoc.MaKhoaHoc')
            .where({
                TenKhoaHoc: obj.TenKhoaHoc,
                LinhVuc: obj.MaLinhVuc,
                GiaoVien: obj.GiaoVien,
            })
        return list[0].MaKhoaHoc;
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
                            DiaChi: account.DiaChi
            })
    },

    async editKhoaHoc(courseId, obj) {
        return db('khoahoc')
            .where({MaKhoaHoc: courseId})
            .update({
                TenKhoaHoc: obj.TenKhoaHoc,
                LinhVuc: obj.MaLinhVuc,
                Gia: obj.Gia,
                KhuyenMai: obj.KhuyenMai,
                MoTaNgan: obj.MoTaNgan,
                Image: obj.Image,
                SoLuongVideo: obj.SoLuongVideo,
                NgonNgu: obj.NgonNgu,
            })
    },
    async editChiTietKhoaHoc(courseId, obj) {
        return db('chitietkhoahoc')
            .where({MaKhoaHoc: courseId})
            .update({
                NgayCapNhat: obj.dateTime,
                MoTaChiTiet: obj.description,
                NgayBD: obj.NgayBD,
                NgayKT: obj.NgayKT,
                TrangThai: obj.isDone,
            })
    },

    async findAllCoursesByIdTeacher(id) {        
        const sql = `SELECT KH.*, CTKH.*, LV.*, count(DSDK.MaHocVien) as SLHocVien
        FROM khoahoc KH
                    INNER JOIN chitietkhoahoc CTKH ON CTKH.MaKhoaHoc = KH.MaKhoaHoc
                    LEFT JOIN danhsachdangki DSDK ON DSDK.MaKhoaHoc = CTKH.MaKhoaHoc
                    INNER JOIN linhvuc LV ON LV.MaLinhVuc = KH.LinhVuc   
        WHERE KH.GiaoVien = ${id}
        GROUP BY KH.MaKhoaHoc`
        const raw = await db.raw(sql);

        if(raw[0].length === 0)
            return null;
        return raw[0];
        // return list;
    }, 
    
    async deleteDanhSachVideoById(courseId, obj) {
        return db('danhsachvideo')
            .delete()
            .where('MaKhoaHoc', courseId);
    },
    async insertDanhSachVideo(MaKhoaHoc, STT, Link, NgayCapNhat, TenVideo, MoTaVideo, File) {
        return db('danhsachvideo')
            .insert({
                MaKhoaHoc: MaKhoaHoc,
                STT: STT,
                Link: Link,
                NgayCapNhat: NgayCapNhat,
                TenVideo: TenVideo,
                MoTaVideo: MoTaVideo,
                File: File,
            })
    },
    async insertNewCourse(obj) {
        return db('khoahoc')
            .insert({
                TenKhoaHoc: obj.TenKhoaHoc,
                LinhVuc: obj.MaLinhVuc,
                Gia: obj.Gia,
                SoLuongVideo: obj.SoLuongVideo,
                GiaoVien: obj.GiaoVien,
                KhuyenMai: obj.KhuyenMai,
                RateTB: 0,
                SLHocSinhDanhGia: 0,
                MoTaNgan: obj.MoTaNgan,
                Image: obj.Image,
                LuotXem: 0,
                NgonNgu: obj.NgonNgu,
                TinhTrang: 1,
            })
    },
    async insertChiTietKhoaHoc(courseId, obj) {
        return db('chitietkhoahoc')
            .insert({
                MaKhoaHoc: courseId,
                NgayCapNhat: obj.dateTime,
                MoTaChiTiet: obj.description,
                Link: '',
                SLHocVien: 0,
                NgayBD: obj.NgayBD,
                NgayKT: obj.NgayKT,
                TrangThai: obj.isDone,
            })
    },
    async getNameImage(accountId) {
        const list = await db('taikhoan')
            .select('taikhoan.Avatar').where('taikhoan.MaTaiKhoan', accountId)
        return list[0];
    },
    async getNameCourseImage(courseId) {
        const list = await db('khoahoc')
            .select('khoahoc.Image').where('khoahoc.MaKhoaHoc', courseId)
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

    async findNgonNgu() {
        const list = await db('lvngonngu')
            .select('MaNgonNgu', 'NgonNgu')
        return list;
    },

    async findFieldById(courseId) {
        const list = await db('linhvuc')
            .select('MaLinhVuc', 'TenLinhVuc')
        const choose = await db('khoahoc')
            .select('LinhVuc')
            .where('MaKhoaHoc', courseId)

        for (let i = 0; i < list.length; i++) {
            if(list[i].MaLinhVuc === choose[0].LinhVuc) {
                Object.assign(list[i], {isChoose: true});
            } else {
                Object.assign(list[i], {isChoose: false});
            }
        }
        return list;
    },

    async findNgonNguById(courseId) {
        const list = await db('lvngonngu')
            .select('MaNgonNgu', 'NgonNgu')

        const choose = await db('khoahoc')
            .select('NgonNgu')
            .where('MaKhoaHoc', courseId)

        for (let i = 0; i < list.length; i++) {
            if(list[i].MaNgonNgu === choose[0].NgonNgu) {
                Object.assign(list[i], {isChoose: true});
            } else {
                Object.assign(list[i], {isChoose: false});
            }
        }
        return list;
    },

    async findInfoCourseById(courseId) {
      const list = await db('khoahoc')
          .select ('chitietkhoahoc.TrangThai',
              'khoahoc.TenKhoaHoc',
              'khoahoc.Image',
              'chitietkhoahoc.NgayBD',
              'chitietkhoahoc.NgayKT',
              'khoahoc.MoTaNgan',
              'chitietkhoahoc.MoTaChiTiet',
              'khoahoc.Gia',
              'khoahoc.KhuyenMai',
              'khoahoc.MaKhoaHoc',
          )
          .where('khoahoc.MaKhoaHoc', courseId)
          .innerJoin('chitietkhoahoc', {'chitietkhoahoc.MaKhoaHoc' : 'khoahoc.MaKhoaHoc'})
      return list[0];
    },
    async findVideoById(courseId) {
        const list = await db('danhsachvideo')
            .select ('danhsachvideo.TenVideo', 'danhsachvideo.Link', 'danhsachvideo.File')
            .where('danhsachvideo.MaKhoaHoc', courseId)
        for (let i = 0; i < list.length; i++) {
            Object.assign(list[i], {index: i + 2});
        }
        return list;
    },

    async isTeacherOfThisCourse(MaTaiKhoan, MaKhoaHoc) {
        const list = await db('khoahoc')
            .select('khoahoc.MaKhoaHoc', 'taiKhoan.MaTaiKhoan')
            .where('taikhoan.MaTaiKhoan', MaTaiKhoan)
            .where('khoahoc.MaKhoaHoc', MaKhoaHoc)
            .innerJoin('giaovien', {'khoahoc.GiaoVien': 'giaovien.MaGiaoVien'})
            .innerJoin('taikhoan', {'taikhoan.MaTaiKhoan': 'giaovien.MaTaiKhoan'})
        for (let i = 0; i < list.length;i++) {
            return true;
        }
        return false;
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

    addTeacher(teacher) {
        return db('GiaoVien').insert(teacher);
    }
}