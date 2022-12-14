/*
 Navicat Premium Data Transfer

 Source Server         : mamp
 Source Server Type    : MySQL
 Source Server Version : 50638
 Source Host           : 127.0.0.1:8889
 Source Schema         : qlbh

 Target Server Type    : MySQL
 Target Server Version : 50638
 File Encoding         : 65001

 Date: 23/08/2018 18:56:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for
-- ----------------------------
DROP TABLE IF EXISTS `LinhVuc`;
CREATE TABLE `LinhVuc` (
    `MaLinhVuc` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `TenLinhVuc` VARCHAR(50) COLLATE UTF8_GENERAL_CI NOT NULL,
    PRIMARY KEY (`MaLinhVuc`)
)  ENGINE=MYISAM AUTO_INCREMENT=22 DEFAULT CHARSET=UTF8 COLLATE = UTF8_GENERAL_CI;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `KhoaHoc`;
CREATE TABLE `KhoaHoc` (
  `MaKhoaHoc`int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TenKhoaHoc` VARCHAR(100) COLLATE UTF8_GENERAL_CI NOT NULL,
  `LinhVuc` int,
  `Gia` float not null,
  `SoLuongVideo` int,
  `GiaoVien` int(11) not null,
  `Image` varchar(255),
  `KhuyenMai` float,
  `RateTB` float,
  `SLHocSinhDanhGia` int,
  `MoTaNgan` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `LuotXem` int,
  
  PRIMARY KEY (`MaKhoaHoc`),
  Foreign key(`LinhVuc`) references LinhVuc(`MaLinhVuc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
-- ----------------------------
-- Table structure for CourseDetail
-- ----------------------------
DROP TABLE IF EXISTS `ChiTietKhoaHoc`;
CREATE TABLE `ChiTietKhoaHoc` (
  `MaKhoaHoc` int not null,
  `NgayCapNhat` datetime NOT NULL,
  `MoTaChiTiet` text COLLATE utf8_general_ci NOT NULL,
  `Link` varchar(255) not null,
  `SLHocVien` int,
  `NgayBD` date,
  `NgayKT` date,
  
  PRIMARY KEY (`MaKhoaHoc`, `NgayCapNhat`),
  foreign key(`MaKhoaHoc`) references KhoaHoc(`MaKhoaHoc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `DanhSachVideo`;
CREATE TABLE `DanhSachVideo` (
  `MaKhoaHoc` int not null,
  `STT` int,
  `Link` varchar(255) not null,
  `NgayCapNhat` datetime NOT NULL,
  `MoTaVideo` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `TrangThai` varchar(50),
  PRIMARY KEY (`MaKhoaHoc`, STT),
  foreign key(`MaKhoaHoc`) references KhoaHoc(`MaKhoaHoc`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `TaiKhoan`;
CREATE TABLE `TaiKhoan` (
  `MaTaiKhoan` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(255) COLLATE utf8_general_ci NOT NULL,
  `Name` varchar(150) COLLATE utf8_general_ci NOT NULL,
  `Email` varchar(150) COLLATE utf8_general_ci NOT NULL,
  `DOB` date NOT NULL,
  `LoaiTaiKhoan` varchar(50) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`MaTaiKhoan`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for Teacher
-- ----------------------------
DROP TABLE IF EXISTS `GiaoVien`;
CREATE TABLE `GiaoVien` (
  `MaGiaoVien` int(11) NOT NULL AUTO_INCREMENT,
  `MaTaiKhoan` int(11) NOT NULL ,
  `SLKhoaHoc` int,
  PRIMARY KEY (`MaGiaoVien`),
  foreign key(`MaTaiKhoan`) references TaiKhoan(`MaTaiKhoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `HocVien`;
CREATE TABLE `HocVien` (
  `MaHocVien` int(11) NOT NULL AUTO_INCREMENT,
  `MaTaiKhoan` int(11) NOT NULL ,
  `SLKhoaHoc` int,
  PRIMARY KEY (`MaHocVien`),
  foreign key(`MaTaiKhoan`) references TaiKhoan(`MaTaiKhoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `BangDanhGia`;
CREATE TABLE `BangDanhGia` (
  `MaHocVien` int(11) NOT NULL ,
  `MaKhoaHoc` int(11) NOT NULL ,
  `Rate` int,
  `Comment` varchar(250) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`MaHocVien`, `MaKhoaHoc`),
  foreign key(`MaHocVien`) references HocVien(`MaHocVien`),
  foreign key(`MaKhoaHoc`) references KhoaHoc(`MaKhoaHoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for Danh sach dang ki
-- ----------------------------
DROP TABLE IF EXISTS `DanhSachDangKi`;
CREATE TABLE `DanhSachDangKi` (
  `MaHocVien` int(11) NOT NULL,
  `MaKhoaHoc` int(11) NOT NULL ,
  `NgayDangKy` date not null,
  `Note` varchar(100) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`MaHocVien`, `MaKhoaHoc`),
  foreign key(`MaHocVien`) references HocVien(`MaHocVien`),
  foreign key(`MaKhoaHoc`) references KhoaHoc(`MaKhoaHoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

SET FOREIGN_KEY_CHECKS = 1;