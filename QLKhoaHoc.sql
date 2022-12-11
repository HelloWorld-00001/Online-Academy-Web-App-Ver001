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

BEGIN;
INSERT INTO `LinhVuc` VALUES (1, 'Lập trình Web');
INSERT INTO `LinhVuc` VALUES (2, 'Lập trình thiết bị di động');
COMMIT;

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `KhoaHoc`;
CREATE TABLE `KhoaHoc` (
  MaKhoaHoc int(11) unsigned NOT NULL AUTO_INCREMENT,
  TenKhoaHoc VARCHAR(100) COLLATE UTF8_GENERAL_CI NOT NULL,
  LinhVuc int,
  Gia float not null,
  SoLuongVideo int,
  GiaoVien int(11) not null,
  Image varchar(255),
  KhuyenMai float,
  RateTB float,
  SLHocSinhDanhGia int,
  MoTaNgan varchar(255) COLLATE utf8_general_ci NOT NULL,
  LuotXem int,
  
  PRIMARY KEY (`MaKhoaHoc`),
  Foreign key(LinhVuc) references LinhVuc
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

BEGIN;
INSERT INTO `KhoaHoc` VALUES (1, 'Introduct To HTML, JS, CSS', 1, 100, 21, 1, null, 10, 0, 0, 'Explore how you can create websites from scratch!!!', 0);
INSERT INTO `KhoaHoc` VALUES (2, 'Food Ordering Web', 1, 125, 13, 2, null, 10, 0, 0, 'In this course, you will learn to create complete dynamic and fully functional website using PHP programming language and MySQL Database', 0);
INSERT INTO `KhoaHoc` VALUES (3, 'Web Design Course', 1, 120, 19, 3, null, 10, 0, 0, 'In this course, you will learn how to create a website and how to design it', 0);
INSERT INTO `KhoaHoc` VALUES (4, 'HTML & CSS Crash Course Tutorial', 1, 100, 11, 4, null, 10, 0, 0, 'Throughout this crash course series I will take you from total beginner to create great-looking sites with HTML & CSS. In this video, we will cover what HTML & CSS are, as well as setting up our dev environment.', 0);
INSERT INTO `KhoaHoc` VALUES (5, 'Javascript Nâng Cao', 1, 50, 12, 5, null, 10, 0, 0, 'Hiểu sâu hơn về cách Javascript hoạt động, hiểu các khái niệm Javascript nâng cao như: IIFE, closure, reference types, this keyword, bind, call, apply, ...', 0);
INSERT INTO `KhoaHoc` VALUES (6, 'The Complete JavaScript Course 2022: From Zero to Expert', 1, 50, 30, 6, null, 10, 0, 0, 'Entire JavaScript course from Zero to Expert! This course will help you learn web development in 2022 and beyond. Mastering these technical skills is vital to your career as a software developer.', 0);
INSERT INTO `KhoaHoc` VALUES (7, 'Shopping web app', 1, 120, 25, 7, null, 10, 0, 0, 'Hướng dẫn làm web bán hàng đơn giản cho người mới', 0);
INSERT INTO `KhoaHoc` VALUES (8, 'Hotel booking web using PHP and MySQL', 1, 140, 26, 8, null, 10, 0, 0, 'Learn about booking web and how to do it', 0);
INSERT INTO `KhoaHoc` VALUES (9, 'HTML Tutorial for Beginners', 1, 75, 30, 9, null, 10, 0, 0, 'In this video we go over the basics of HTML and what you will need to follow along for the entire series. This series will cover the latest concepts including HTML5.', 0);
INSERT INTO `KhoaHoc` VALUES (10, 'Hotel booking web', 1, 130, 34, 10, null, 10, 0, 0, 'Learn about booking web and how to do it', 0);
INSERT INTO `KhoaHoc` VALUES (11, 'How to Make an App for Beginners (SwiftUI)', 2, 50, 14, 11, null, 10, 0, 0, 'In this 14 day beginner challenge, you’ll learn how to make an app even if you’ve never coded before.', 0);
COMMIT;
-- ----------------------------
-- Table structure for CourseDetail
-- ----------------------------
DROP TABLE IF EXISTS `ChiTietKhoaHoc`;
CREATE TABLE `ChiTietKhoaHoc` (
  MaKhoaHoc int not null,
  NgayCapNhat datetime NOT NULL,
  MoTaChiTiet text COLLATE utf8_general_ci NOT NULL,
  Link varchar(255) not null,
  SLHocVien int,
  NgayBD date,
  NgayKT date,
  
  PRIMARY KEY (MaKhoaHoc, NgayCapNhat),
  foreign key(MaKhoaHoc) references KhoaHoc
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `DanhSachVideo`;
CREATE TABLE `DanhSachVideo` (
   MaKhoaHoc int not null,
   STT int,
   Link varchar(255) not null,
   NgayCapNhat datetime NOT NULL,
   MoTaVideo varchar(255) COLLATE utf8_general_ci NOT NULL,
  TrangThai varchar(50),
  PRIMARY KEY (MaKhoaHoc, STT),
  foreign key(MaKhoaHoc) references KhoaHoc
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

BEGIN;
INSERT INTO `DanhSachVideo` VALUES (1, 1, 'https://www.youtube.com/watch?v=gVx72yLou2c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=1', '2021-11-30', '','Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 2, 'https://www.youtube.com/watch?v=3odtU8VL3Mc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=2', '2021-11-17', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 3, 'https://www.youtube.com/watch?v=DkiLJzL6kv4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=3', '2021-11-18', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 4, 'https://www.youtube.com/watch?v=gyqMtCmHHUA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=4', '2021-11-19', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 5, 'https://www.youtube.com/watch?v=0Uhtzrsi-qE&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=5', '2021-11-21', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 6, 'https://www.youtube.com/watch?v=rpKjWpOiBSY&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=6', '2021-11-21', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 7, 'https://www.youtube.com/watch?v=p5ivn6UpjQk&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=7', '2021-11-27', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 8, 'https://www.youtube.com/watch?v=Cad_2CvAoQ8&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=8', '2021-12-08', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 9, 'https://www.youtube.com/watch?v=fRPCVBfD7hw&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=9', '2021-12-08', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 10, 'https://www.youtube.com/watch?v=ZKhOuR1UWh4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=10', '2021-12-25', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 11, 'https://www.youtube.com/watch?v=iO7kgGgHr6w&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=11', '2022-01-15', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 12, 'https://www.youtube.com/watch?v=Z-SuiRYaPck&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=12', '2022-02-17', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 13, 'https://www.youtube.com/watch?v=b8AjydmGOpA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=13', '2022-02-18', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 14, 'https://www.youtube.com/watch?v=SsoCQuwk-3Y&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=14', '2022-02-19', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 15, 'https://www.youtube.com/watch?v=fyAS7cFPJ7c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=15', '2022-02-20', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 16, 'https://www.youtube.com/watch?v=5T1SEvBqA-g&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=16', '2022-02-22', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 17, 'https://www.youtube.com/watch?v=luI-NrSpm34&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=17', '2022-02-23', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 18, 'https://www.youtube.com/watch?v=nEBPSEPuaIM&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=18', '2022-02-25', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 19, 'https://www.youtube.com/watch?v=18MAAGZkyWs&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=19', '2022-03-04', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 20, 'https://www.youtube.com/watch?v=4qyVKhIQZqc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=20', '2022-03-05', '', 'Chưa hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (1, 21, 'https://www.youtube.com/watch?v=1qw9J4MfbGU&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=21', '2022-12-12', '', 'Chưa hoàn thành');

INSERT INTO `DanhSachVideo` VALUES (2, 1, 'https://www.youtube.com/watch?v=ZBgTzx46B8s&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=1', '2020-11-08', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 2, 'https://www.youtube.com/watch?v=o-6cL61-uDw&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=2', '2020-11-10', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 3, 'https://www.youtube.com/watch?v=1Aik3MWJTTo&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=3', '2020-11-13', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 4, 'https://www.youtube.com/watch?v=bk_5SAH7Oyk&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=4', '2020-11-17', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 5, 'https://www.youtube.com/watch?v=_Sxo-ASOatc&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=5', '2020-11-21', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 6, 'https://www.youtube.com/watch?v=9wlbIb3gCEs&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=6', '2020-11-24', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 7, 'https://www.youtube.com/watch?v=YsrPRRLfaG0&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=7', '2020-11-27', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 8, 'https://www.youtube.com/watch?v=UJmVA3bR5HE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=8', '2020-12-01', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 9, 'https://www.youtube.com/watch?v=GxCh9B0ZU6E&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=9', '2020-12-04', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 10, 'https://www.youtube.com/watch?v=qieZiZxxHy4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=10', '2020-12-08', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 11, 'https://www.youtube.com/watch?v=fv_FjQai2E4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=11', '2020-12-11', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 12, 'https://www.youtube.com/watch?v=zKWV2WJ-5CM&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=12', '2020-12-15', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (2, 13, 'https://www.youtube.com/watch?v=oVjTcKgLzuE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=13', '2021-06-14', '', 'Hoàn thành');

INSERT INTO `DanhSachVideo` VALUES (3, 1, 'https://www.youtube.com/watch?v=C72WkcUZvco&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=1', '2020-04-15', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 2, 'https://www.youtube.com/watch?v=R_gFhRsWLMw&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=2', '2020-04-20', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 3, 'https://www.youtube.com/watch?v=mQeplLGXIY4&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=3', '2020-04-22', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 4, 'https://www.youtube.com/watch?v=OUp7ale49lI&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=4', '2020-04-24', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 5, 'https://www.youtube.com/watch?v=BN8pC91rJaU&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=5', '2020-04-27', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 6, 'https://www.youtube.com/watch?v=TDRhwSfxYkg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=6', '2020-04-29', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 7, 'https://www.youtube.com/watch?v=UuPt4RpV4Xc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=7', '2020-05-04', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 8, 'https://www.youtube.com/watch?v=kOJ4c5THLQk&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=8', '2020-05-08', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 9, 'https://www.youtube.com/watch?v=x3Yno9VUYBY&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=9', '2020-05-13', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 10, 'https://www.youtube.com/watch?v=flAcHu-squc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=10', '2020-05-19', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 11, 'https://www.youtube.com/watch?v=8A6MxYNooYA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=11', '2020-05-28', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 12, 'https://www.youtube.com/watch?v=Cn2KgB_01mE&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=12', '2020-06-02', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 13, 'https://www.youtube.com/watch?v=ZbQxX7v_dfo&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=13', '2020-06-09', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 14, 'https://www.youtube.com/watch?v=l5orEmE7Pq8&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=14', '2020-06-18', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 15, 'https://www.youtube.com/watch?v=lQzmGrUQUDc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=15', '2020-07-10', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 16, 'https://www.youtube.com/watch?v=ZliIs7jHi1s&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=16', '2020-07-21', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 17, 'https://www.youtube.com/watch?v=FYOxoJbngAM&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=17', '2020-07-30', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 18, 'https://www.youtube.com/watch?v=fqDTN24HQqg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=18', '2020-08-04', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (3, 19, 'https://www.youtube.com/watch?v=z2t6eRuwbFA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=19', '2020-08-15', '', 'Hoàn thành');

INSERT INTO `DanhSachVideo` VALUES (4, 1, 'https://www.youtube.com/watch?v=hu-q2zYwEYs&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=1', '2019-07-09', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 2, 'https://www.youtube.com/watch?v=mbeT8mpmtHA&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=2', '2019-07-09', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 3, 'https://www.youtube.com/watch?v=YwbIeMlxZAU&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=3', '2019-07-11', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 4, 'https://www.youtube.com/watch?v=D3iEE29ZXRM&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=4', '2019-07-12', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 5, 'https://www.youtube.com/watch?v=FHZn6706e3Q&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=5', '2019-07-17', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 6, 'https://www.youtube.com/watch?v=kGW8Al_cga4&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=6', '2019-07-19', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 7, 'https://www.youtube.com/watch?v=25R1Jl5P7Mw&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=7', '2019-07-22', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 8, 'https://www.youtube.com/watch?v=XQaHAAXIVg8&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=8', '2019-07-24', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 9, 'https://www.youtube.com/watch?v=FMu2cKWD90g&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=9', '2019-07-26', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 10, 'https://www.youtube.com/watch?v=Xig7NsIE6DI&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=10', '2019-07-30', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (4, 11, 'https://www.youtube.com/watch?v=qES0HypsUK0&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=11', '2019-07-30', '', 'Hoàn thành');

INSERT INTO `DanhSachVideo` VALUES (5, 1, 'https://www.youtube.com/watch?v=MGhw6XliFgo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=1', '2021-04-03', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 2, 'https://www.youtube.com/watch?v=N-3GU1F1UBY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=2', '2021-04-03', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 3, 'https://www.youtube.com/watch?v=5N8vz_VmszE&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=3', '2021-07-19', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 4, 'https://www.youtube.com/watch?v=xtQtGKL0NCI&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=4', '2021-07-20', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 5, 'https://www.youtube.com/watch?v=3MLhU1DrUxM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=5', '2021-07-26', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 6, 'https://www.youtube.com/watch?v=w1W-j4cSPF0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=6', '2021-07-28', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 7, 'https://www.youtube.com/watch?v=n4tS1Q5-EzY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=7', '2021-01-21', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 8, 'https://www.youtube.com/watch?v=ii1Ra_zLDIo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=8', '2021-07-31', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 9, 'https://www.youtube.com/watch?v=F5z6YoR8of0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=9', '2021-08-03', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 10, 'https://www.youtube.com/watch?v=6j9b2_E34JM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=10', '2021-08-03', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 11, 'https://www.youtube.com/watch?v=QxLTSdTJDXY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=11', '2021-08-06', '', 'Hoàn thành');
INSERT INTO `DanhSachVideo` VALUES (5, 12, 'https://www.youtube.com/watch?v=a4FjX4Z-9Rs&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=12', '2021-08-26', '', 'Hoàn thành');
COMMIT;
-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `TaiKhoan`;
CREATE TABLE `TaiKhoan` (
  MaTaiKhoan int(11) NOT NULL AUTO_INCREMENT,
  Username varchar(50) COLLATE utf8_general_ci NOT NULL,
  Password varchar(255) COLLATE utf8_general_ci NOT NULL,
  Name varchar(150) COLLATE utf8_general_ci NOT NULL,
  Email varchar(150) COLLATE utf8_general_ci NOT NULL,
  DOB date NOT NULL,
  LoaiTaiKhoan varchar(50) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (MaTaiKhoan)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

BEGIN;
INSERT INTO `TaiKhoan` VALUES (1, 'ndnamTeacher', '123', 'Nguyễn Đình Nam', 'ndnamPro@gmail.com', '1995-10-25', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (2, 'vthapaTeacher', '123', 'Vijay Thapa', 'vThapaPro@gmail.com', '2000-12-16', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (3, 'ranTeacher', '123', 'Ran', 'ranPro@gmail.com', '1990-05-01', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (4, 'shaunTeacher', '123', 'Shaun', 'shaunPro@gmail.com', '1992-03-03', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (5, 'dtsonTeacher', '123', 'Đặng Trường Sơn', 'dtrsonPro@gmail.com', '1996-10-20', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (6, 'euniqaTeacher', '123', 'Euniqa', 'euniqaPro@gmail.com', '1991-11-12', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (7, 'nsnguyenTeacher', '123', 'Ngô Sỹ Nguyên', 'nsnguyenPro@gmail.com', '1989-07-06', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (8, 'mtjamalTeacher', '123', 'Mohd Touseef Jamal', 'mtjamalPro@gmail.com', '1997-12-18', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (9, 'ejTeacher', 'EJ', '123', 'ejPro@gmail.com', '1988-08-13', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (10, 'ksathyaTeacher', '123', 'Kudos Sathya', 'ksathyaPro@gmail.com', '2000-06-17', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (11, 'CrishTeacher', '123', 'Crish', 'crishPro@gmail.com', '2003-12-16', 'Giáo viên');

INSERT INTO `TaiKhoan` VALUES (21, 'gojoSatoru', '123', 'Gojo Satoru', 'gojoCute@gmail.com', '2002-12-07', 'Học niên');
INSERT INTO `TaiKhoan` VALUES (22, 'uzumakiNaruto', '123', 'Uzumaki Naruto', 'narutoFun@gmail.com', '2003-09-30', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (23, 'leviAckerman', '123', 'Levi Ackerman', 'leviCool@gmail.com', '2000-01-01', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (24, 'kaitoKid', '123', 'Kaito Kid', 'kaito1412@gmail.com', '2001-12-14', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (25, 'loidForger', '123', 'Loid Forger', 'loidSxf@gmail.com', '2002-05-01', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (26, 'kenKaneki', '123', 'Ken Kaneki', 'kaneki1000_7@gmail.com', '2004-11-19', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (27, 'todorokiShoto', '123', 'Todoroki Shoto', 'shotoBaka@gmail.com', '2005-04-03', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (28, 'bakugoKatsuki', '123', 'Bakugo Katsuki', 'kacchanAngry@gmail.com', '2002-12-25', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (29, 'sidKagenou', '123', 'Sid Kagenou', 'shadowClown@gmail.com', '2006-08-13', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (30, 'sakamotoDesu', '123', 'Sakamoto Desu', 'sakamotoPerfect@gmail.com', '2003-06-01', 'Học viên');
INSERT INTO `TaiKhoan` VALUES (31, 'yukihiraSoma', '123', 'Yukihira Soma', 'somaCook@gmail.com', '2003-02-05', 'Học viên');
COMMIT;

-- ----------------------------
-- Table structure for Teacher
-- ----------------------------
DROP TABLE IF EXISTS `GiaoVien`;
CREATE TABLE `GiaoVien` (
  MaGiaoVien int(11) NOT NULL AUTO_INCREMENT,
  MaTaiKhoan int(11) NOT NULL ,
  SLKhoaHoc int,
  PRIMARY KEY (MaGiaoVien),
  foreign key(MaTaiKhoan) references TaiKhoan(MaTaiKhoan)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

BEGIN;
INSERT `GiaoVien` VALUES (1, 1, 1);
INSERT `GiaoVien` VALUES (2, 2, 1);
INSERT `GiaoVien` VALUES (3, 3, 1);
INSERT `GiaoVien` VALUES (4, 4, 1);
INSERT `GiaoVien` VALUES (5, 5, 1);
INSERT `GiaoVien` VALUES (6, 6, 1);
INSERT `GiaoVien` VALUES (7, 7, 1);
INSERT `GiaoVien` VALUES (8, 8, 1);
INSERT `GiaoVien` VALUES (9, 9, 1);
INSERT `GiaoVien` VALUES (10, 10, 1);
INSERT `GiaoVien` VALUES (11, 11, 1);
COMMIT;

-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `HocVien`;
CREATE TABLE `HocVien` (
  MaHocVien int(11) NOT NULL AUTO_INCREMENT,
  MaTaiKhoan int(11) NOT NULL ,
  SLKhoaHoc int,
  PRIMARY KEY (MaHocVien),
  foreign key(MaTaiKhoan) references TaiKhoan(MaTaiKhoan)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for Account
-- ----------------------------
DROP TABLE IF EXISTS `BangDanhGia`;
CREATE TABLE `BangDanhGia` (
  MaHocVien int(11) NOT NULL ,
  MaKhoaHoc int(11) NOT NULL ,
  Rate int,
  Comment varchar(250) COLLATE utf8_general_ci NOT NULL,
  
  PRIMARY KEY (MaHocVien, MaKhoaHoc),
  foreign key(MaHocVien) references HocVien(MaHocVien),
  foreign key(MaKhoaHoc) references KhoaHoc(MaKhoaHoc)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for Danh sach dang ki
-- ----------------------------
DROP TABLE IF EXISTS `DanhSachDangKi`;
CREATE TABLE `DanhSachDangKi` (
  MaHocVien int(11) NOT NULL,
  MaKhoaHoc int(11) NOT NULL ,
  NgayDangKy date not null,
  Note varchar(100) COLLATE utf8_general_ci NOT NULL,
  
  PRIMARY KEY (MaHocVien, MaKhoaHoc),
  foreign key(MaHocVien) references HocVien(MaHocVien),
  foreign key(MaKhoaHoc) references KhoaHoc(MaKhoaHoc)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
SET FOREIGN_KEY_CHECKS = 1;
