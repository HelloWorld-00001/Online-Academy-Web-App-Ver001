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
INSERT INTO `KhoaHoc` VALUES (1, 'Introduct To HTML, JS, CSS', 1, 100, 21, 1, '1.jpg', 10, 0, 0, 'Explore how you can create websites from scratch!!!', 0);
INSERT INTO `KhoaHoc` VALUES (2, 'Food Ordering Web', 1, 125, 13, 2, '2.jpg', 10, 0, 0, 'In this course, you will learn to create complete dynamic and fully functional website using PHP programming language and MySQL Database', 0);
INSERT INTO `KhoaHoc` VALUES (3, 'Web Design Course', 1, 120, 19, 3, '3.jpg', 10, 0, 0, 'In this course, you will learn how to create a website and how to design it', 0);
INSERT INTO `KhoaHoc` VALUES (4, 'HTML & CSS Crash Course Tutorial', 1, 100, 11, 4, '4.jpg', 10, 0, 0, 'Throughout this crash course series I will take you from total beginner to create great-looking sites with HTML & CSS. In this video, we will cover what HTML & CSS are, as well as setting up our dev environment.', 0);
INSERT INTO `KhoaHoc` VALUES (5, 'Javascript Nâng Cao', 1, 50, 12, 5, '5.jpg', 10, 0, 0, 'Hiểu sâu hơn về cách Javascript hoạt động, hiểu các khái niệm Javascript nâng cao như: IIFE, closure, reference types, this keyword, bind, call, apply, ...', 0);
INSERT INTO `KhoaHoc` VALUES (6, 'The Complete JavaScript Course 2022: From Zero to Expert', 1, 50, 30, 6, '6.jpg', 10, 0, 0, 'Entire JavaScript course from Zero to Expert! This course will help you learn web development in 2022 and beyond. Mastering these technical skills is vital to your career as a software developer.', 0);
INSERT INTO `KhoaHoc` VALUES (7, 'Shopping web app', 1, 120, 25, 7, '7.jpg', 10, 0, 0, 'Hướng dẫn làm web bán hàng đơn giản cho người mới', 0);
INSERT INTO `KhoaHoc` VALUES (8, 'Hotel booking web using PHP and MySQL', 1, 140, 26, 8, '8.jpg', 10, 0, 0, 'Learn about booking web and how to do it', 0);
INSERT INTO `KhoaHoc` VALUES (9, 'HTML Tutorial for Beginners', 1, 75, 30, 9, '9.jpg', 10, 0, 0, 'In this video we go over the basics of HTML and what you will need to follow along for the entire series. This series will cover the latest concepts including HTML5.', 0);
INSERT INTO `KhoaHoc` VALUES (10, 'Hotel booking web', 1, 130, 34, 10, '10.jpg', 10, 0, 0, 'Learn about booking web and how to do it', 0);

INSERT INTO `KhoaHoc` VALUES (11, 'How to Make an App for Beginners (SwiftUI)', 2, 50, 14, 11, '11.jpg', 10, 0, 0, 'In this 14 day beginner challenge, you’ll learn how to make an app even if you’ve never coded before.', 0);
INSERT INTO `KhoaHoc` VALUES (12, 'Food Delivery App Development for iOS and Android', 2, 499, 8, 12, '12.jpg', 10, 0, 0, 'This is an e-commerce app for food delivery using flutter with backend as crash course tutorial for iOS and Android.', 0 );
INSERT INTO `KhoaHoc` VALUES (13, 'Build and Deploy Your First Modern React Native App', 2, 100, 1, 13, '13.jpg', 10, 0, 0, 'Master React Native by building a modern NFT Marketplace iOS and Android ReactNative Application', 0 );
INSERT INTO `KhoaHoc` VALUES (14, 'React Native Tutorial Series for Beginners', 2, 599, 10, 14, '14.jpg', 10, 0, 0, 'This is React Native Video Tutorial', 0 );
INSERT INTO `KhoaHoc` VALUES (15, 'Flutter Course for Beginners', 2, 349, 1, 15, '15.jpg', 10, 0, 0, 'How to use Flutter in this complete course for beginners.', 0 );
INSERT INTO `KhoaHoc` VALUES (16, 'Android App Development for Beginners', 2, 449, 15, 16, '16.jpg', 10, 0, 0, 'This is Android App Development for Beginners.', 0 );
INSERT INTO `KhoaHoc` VALUES (17, 'Lộ trình tự học lập trình di động', 2, 5, 1, 17, '17.jpg', 0, 0, 0, 'Giới tiệu Lộ trình tự học lập trình di động cơ bản, siêu chi tiếc', 0 );
INSERT INTO `KhoaHoc` VALUES (18, 'How To Make An App for Beginners 2021 - SwiftUI', 2, 299, 14, 18, '18.jpg', 5, 0, 0, 'How to make an app even if you’ve never coded before.', 0 );
INSERT INTO `KhoaHoc` VALUES (19, 'Full React Native Project Tutorial for beginners.', 2, 399, 1, 19, '19.jpg', 10, 0, 0, 'Get Started with React Native and learn how to build iOS and Android apps!', 0 );
INSERT INTO `KhoaHoc` VALUES (20, 'Xamarin & Xamarin.Forms for Beginners', 2, 549, 10, 20, '20.jpg', 10, 0, 0, 'Build iOS & Android Apps with C#, Visual Studio, and Xamarin.Forms.', 0 );
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

BEGIN;
INSERT INTO `ChiTietKhoaHoc` VALUES (1, '2022-12-11', '', 'https://www.youtube.com/playlist?list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5', 0, '2022-12-17', '2023-01-21');
INSERT INTO `ChiTietKhoaHoc` VALUES (2, '2021-06-13', '', 'https://www.youtube.com/playlist?list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW', 0, '2022-12-10', '2023-01-24');
INSERT INTO `ChiTietKhoaHoc` VALUES (3, '2022-06-09', '', 'https://www.youtube.com/playlist?list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI', 0, '2022-12-4', '2023-01-29');
INSERT INTO `ChiTietKhoaHoc` VALUES (4, '2019-07-30', '', 'https://www.youtube.com/playlist?list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G', 0, '2022-12-18', '2023-01-28');
INSERT INTO `ChiTietKhoaHoc` VALUES (5, '2021-11-08', '', 'https://www.youtube.com/playlist?list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac', 0, '2022-12-14', '2023-01-22');
INSERT INTO `ChiTietKhoaHoc` VALUES (6, '2022-11-18', '', 'https://www.youtube.com/playlist?list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ', 0, '2022-12-5', '2023-01-25');
INSERT INTO `ChiTietKhoaHoc` VALUES (7, '2021-10-04', '', 'https://www.youtube.com/playlist?list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe', 0, '2022-12-27', '2023-01-21');
INSERT INTO `ChiTietKhoaHoc` VALUES (8, '2022-09-07', '', 'https://www.youtube.com/playlist?list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt', 0, '2022-12-11', '2023-01-21');
INSERT INTO `ChiTietKhoaHoc` VALUES (9, '2016-09-02', '', 'https://www.youtube.com/playlist?list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB', 0, '2022-12-2', '2023-01-25');
INSERT INTO `ChiTietKhoaHoc` VALUES (10, '2022-08-29', '', 'https://www.youtube.com/playlist?list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u', 0, '2022-12-6', '2023-01-27');
INSERT INTO `ChiTietKhoaHoc` VALUES (11, '2022-11-20', '', 'https://www.youtube.com/playlist?list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ', 0, '2022-12-24', '2023-01-21');
COMMIT;

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
INSERT INTO `DanhSachVideo` VALUES (1, 1, 'https://www.youtube.com/watch?v=gVx72yLou2c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=1', '2021-11-30', '','Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 2, 'https://www.youtube.com/watch?v=3odtU8VL3Mc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=2', '2021-11-17', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 3, 'https://www.youtube.com/watch?v=DkiLJzL6kv4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=3', '2021-11-18', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 4, 'https://www.youtube.com/watch?v=gyqMtCmHHUA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=4', '2021-11-19', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 5, 'https://www.youtube.com/watch?v=0Uhtzrsi-qE&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=5', '2021-11-21', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 6, 'https://www.youtube.com/watch?v=rpKjWpOiBSY&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=6', '2021-11-21', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 7, 'https://www.youtube.com/watch?v=p5ivn6UpjQk&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=7', '2021-11-27', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 8, 'https://www.youtube.com/watch?v=Cad_2CvAoQ8&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=8', '2021-12-08', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 9, 'https://www.youtube.com/watch?v=fRPCVBfD7hw&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=9', '2021-12-08', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 10, 'https://www.youtube.com/watch?v=ZKhOuR1UWh4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=10', '2021-12-25', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 11, 'https://www.youtube.com/watch?v=iO7kgGgHr6w&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=11', '2022-01-15', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 12, 'https://www.youtube.com/watch?v=Z-SuiRYaPck&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=12', '2022-02-17', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 13, 'https://www.youtube.com/watch?v=b8AjydmGOpA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=13', '2022-02-18', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 14, 'https://www.youtube.com/watch?v=SsoCQuwk-3Y&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=14', '2022-02-19', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 15, 'https://www.youtube.com/watch?v=fyAS7cFPJ7c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=15', '2022-02-20', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 16, 'https://www.youtube.com/watch?v=5T1SEvBqA-g&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=16', '2022-02-22', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 17, 'https://www.youtube.com/watch?v=luI-NrSpm34&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=17', '2022-02-23', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 18, 'https://www.youtube.com/watch?v=nEBPSEPuaIM&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=18', '2022-02-25', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 19, 'https://www.youtube.com/watch?v=18MAAGZkyWs&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=19', '2022-03-04', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 20, 'https://www.youtube.com/watch?v=4qyVKhIQZqc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=20', '2022-03-05', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (1, 21, 'https://www.youtube.com/watch?v=1qw9J4MfbGU&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=21', '2022-12-12', '', 'Chưa Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (2, 1, 'https://www.youtube.com/watch?v=ZBgTzx46B8s&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=1', '2020-11-08', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 2, 'https://www.youtube.com/watch?v=o-6cL61-uDw&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=2', '2020-11-10', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 3, 'https://www.youtube.com/watch?v=1Aik3MWJTTo&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=3', '2020-11-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 4, 'https://www.youtube.com/watch?v=bk_5SAH7Oyk&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=4', '2020-11-17', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 5, 'https://www.youtube.com/watch?v=_Sxo-ASOatc&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=5', '2020-11-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 6, 'https://www.youtube.com/watch?v=9wlbIb3gCEs&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=6', '2020-11-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 7, 'https://www.youtube.com/watch?v=YsrPRRLfaG0&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=7', '2020-11-27', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 8, 'https://www.youtube.com/watch?v=UJmVA3bR5HE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=8', '2020-12-01', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 9, 'https://www.youtube.com/watch?v=GxCh9B0ZU6E&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=9', '2020-12-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 10, 'https://www.youtube.com/watch?v=qieZiZxxHy4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=10', '2020-12-08', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 11, 'https://www.youtube.com/watch?v=fv_FjQai2E4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=11', '2020-12-11', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 12, 'https://www.youtube.com/watch?v=zKWV2WJ-5CM&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=12', '2020-12-15', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (2, 13, 'https://www.youtube.com/watch?v=oVjTcKgLzuE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=13', '2021-06-14', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (3, 1, 'https://www.youtube.com/watch?v=C72WkcUZvco&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=1', '2020-04-15', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 2, 'https://www.youtube.com/watch?v=R_gFhRsWLMw&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=2', '2020-04-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 3, 'https://www.youtube.com/watch?v=mQeplLGXIY4&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=3', '2020-04-22', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 4, 'https://www.youtube.com/watch?v=OUp7ale49lI&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=4', '2020-04-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 5, 'https://www.youtube.com/watch?v=BN8pC91rJaU&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=5', '2020-04-27', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 6, 'https://www.youtube.com/watch?v=TDRhwSfxYkg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=6', '2020-04-29', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 7, 'https://www.youtube.com/watch?v=UuPt4RpV4Xc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=7', '2020-05-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 8, 'https://www.youtube.com/watch?v=kOJ4c5THLQk&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=8', '2020-05-08', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 9, 'https://www.youtube.com/watch?v=x3Yno9VUYBY&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=9', '2020-05-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 10, 'https://www.youtube.com/watch?v=flAcHu-squc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=10', '2020-05-19', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 11, 'https://www.youtube.com/watch?v=8A6MxYNooYA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=11', '2020-05-28', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 12, 'https://www.youtube.com/watch?v=Cn2KgB_01mE&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=12', '2020-06-02', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 13, 'https://www.youtube.com/watch?v=ZbQxX7v_dfo&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=13', '2020-06-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 14, 'https://www.youtube.com/watch?v=l5orEmE7Pq8&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=14', '2020-06-18', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 15, 'https://www.youtube.com/watch?v=lQzmGrUQUDc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=15', '2020-07-10', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 16, 'https://www.youtube.com/watch?v=ZliIs7jHi1s&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=16', '2020-07-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 17, 'https://www.youtube.com/watch?v=FYOxoJbngAM&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=17', '2020-07-30', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 18, 'https://www.youtube.com/watch?v=fqDTN24HQqg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=18', '2020-08-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (3, 19, 'https://www.youtube.com/watch?v=z2t6eRuwbFA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=19', '2020-08-15', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (4, 1, 'https://www.youtube.com/watch?v=hu-q2zYwEYs&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=1', '2019-07-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 2, 'https://www.youtube.com/watch?v=mbeT8mpmtHA&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=2', '2019-07-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 3, 'https://www.youtube.com/watch?v=YwbIeMlxZAU&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=3', '2019-07-11', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 4, 'https://www.youtube.com/watch?v=D3iEE29ZXRM&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=4', '2019-07-12', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 5, 'https://www.youtube.com/watch?v=FHZn6706e3Q&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=5', '2019-07-17', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 6, 'https://www.youtube.com/watch?v=kGW8Al_cga4&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=6', '2019-07-19', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 7, 'https://www.youtube.com/watch?v=25R1Jl5P7Mw&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=7', '2019-07-22', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 8, 'https://www.youtube.com/watch?v=XQaHAAXIVg8&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=8', '2019-07-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 9, 'https://www.youtube.com/watch?v=FMu2cKWD90g&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=9', '2019-07-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 10, 'https://www.youtube.com/watch?v=Xig7NsIE6DI&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=10', '2019-07-30', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (4, 11, 'https://www.youtube.com/watch?v=qES0HypsUK0&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=11', '2019-07-30', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (5, 1, 'https://www.youtube.com/watch?v=MGhw6XliFgo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=1', '2021-04-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 2, 'https://www.youtube.com/watch?v=N-3GU1F1UBY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=2', '2021-04-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 3, 'https://www.youtube.com/watch?v=5N8vz_VmszE&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=3', '2021-07-19', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 4, 'https://www.youtube.com/watch?v=xtQtGKL0NCI&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=4', '2021-07-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 5, 'https://www.youtube.com/watch?v=3MLhU1DrUxM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=5', '2021-07-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 6, 'https://www.youtube.com/watch?v=w1W-j4cSPF0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=6', '2021-07-28', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 7, 'https://www.youtube.com/watch?v=n4tS1Q5-EzY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=7', '2021-01-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 8, 'https://www.youtube.com/watch?v=ii1Ra_zLDIo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=8', '2021-07-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 9, 'https://www.youtube.com/watch?v=F5z6YoR8of0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=9', '2021-08-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 10, 'https://www.youtube.com/watch?v=6j9b2_E34JM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=10', '2021-08-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 11, 'https://www.youtube.com/watch?v=QxLTSdTJDXY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=11', '2021-08-06', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (5, 12, 'https://www.youtube.com/watch?v=a4FjX4Z-9Rs&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=12', '2021-08-26', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (6, 1, 'https://www.youtube.com/watch?v=1976Hf-DR44&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=1', '2022-11-10', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 2, 'https://www.youtube.com/watch?v=U5IHV-Ftf7c&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=2', '2022-06-09', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 3, 'https://www.youtube.com/watch?v=IHtfy2ywW9s&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=3', '2022-06-22', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 4, 'https://www.youtube.com/watch?v=SF4QFxyIyX0&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=4', '2022-06-26', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 5, 'https://www.youtube.com/watch?v=Hvxt3JHTCoI&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=5', '2022-07-04', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 6, 'https://www.youtube.com/watch?v=WfESlbkyQow&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=6', '2022-07-06', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 7, 'https://www.youtube.com/watch?v=hgtcRDqfjeE&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=7', '2022-07-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 8, 'https://www.youtube.com/watch?v=aVJU__8ERWM&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=8', '2022-07-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 9, 'https://www.youtube.com/watch?v=ltI_GM_6xrA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=9', '2022-07-08', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 10, 'https://www.youtube.com/watch?v=2_E_Bird3VU&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=10', '2022-07-09', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 11, 'https://www.youtube.com/watch?v=E_1Zoy5OUNA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=11', '2022-07-18', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 12, 'https://www.youtube.com/watch?v=rt3NOoQH4Zs&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=12', '2022-07-25', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 13, 'https://www.youtube.com/watch?v=XhWBgx3Vjrc&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=13', '2022-07-26', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 14, 'https://www.youtube.com/watch?v=zI2SxDz8uU0&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=14', '2022-07-28', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 15, 'https://www.youtube.com/watch?v=pHV4rZBwkAo&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=15', '2022-07-30', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 16, 'https://www.youtube.com/watch?v=0X-xG8jQ0pY&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=16', '2022-08-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 17, 'https://www.youtube.com/watch?v=coZUNjZ4i6I&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=17', '2022-08-10', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 18, 'https://www.youtube.com/watch?v=dRFqF3ore78&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=18', '2022-08-16', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 19, 'https://www.youtube.com/watch?v=jX5bED9oYFA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=19', '2022-08-31', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (6, 20, 'https://www.youtube.com/watch?v=juQBPlnqnzg&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=20', '2022-10-05', '', 'Chưa Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (7, 1, 'https://www.youtube.com/watch?v=6ca7Roj_NfE&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=1', '2020-09-12', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 2, 'https://www.youtube.com/watch?v=T4RIbr9VIT8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=2', '2020-09-12', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 3, 'https://www.youtube.com/watch?v=3hx24mRfKGE&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=3', '2020-09-12', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 4, 'https://www.youtube.com/watch?v=HrzV05lzf2Y&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=4', '2021-06-15', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 5, 'https://www.youtube.com/watch?v=rvIyNR4L0KI&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=5', '2021-06-17', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 6, 'https://www.youtube.com/watch?v=hZVtkPv2q0A&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=6', '2021-06-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 7, 'https://www.youtube.com/watch?v=oYLwpa0Ug-A&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=7', '2021-07-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 8, 'https://www.youtube.com/watch?v=zUVbKfHgA40&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=8', '2021-07-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 9, 'https://www.youtube.com/watch?v=iI_IBe_SW9Q&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=9', '2021-07-14', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 10, 'https://www.youtube.com/watch?v=QgM6Gp7lzYw&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=10', '2021-07-16', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 11, 'https://www.youtube.com/watch?v=KeO2VAlXBMM&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=11', '2021-07-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 12, 'https://www.youtube.com/watch?v=v_puS2Wh-SU&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=12', '2021-07-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 13, 'https://www.youtube.com/watch?v=rgdcz6MTKgg&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=13', '2021-07-22', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 14, 'https://www.youtube.com/watch?v=P4LaivJMDos&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=14', '2021-07-23', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 15, 'https://www.youtube.com/watch?v=QxIxNjOCCDQ&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=15', '2021-07-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 16, 'https://www.youtube.com/watch?v=TsWrgF8VZT8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=16', '2021-07-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 17, 'https://www.youtube.com/watch?v=cSRsf2sbGC4&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=17', '2021-07-27', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 18, 'https://www.youtube.com/watch?v=nkqoUtDhch8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=18', '2021-07-28', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 19, 'https://www.youtube.com/watch?v=igV7S5RmvnY&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=19', '2021-07-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (7, 20, 'https://www.youtube.com/watch?v=Cbcj88qVF48&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=20', '2021-07-31', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (8, 1, 'https://www.youtube.com/watch?v=MV8AT9a2oSM&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=1', '2021-12-07', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 2, 'https://www.youtube.com/watch?v=BLqDewjag48&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=2', '2021-12-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 3, 'https://www.youtube.com/watch?v=2gzS9Z6DRps&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=3', '2022-01-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 4, 'https://www.youtube.com/watch?v=XDF8POggNhA&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=4', '2022-01-12', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 5, 'https://www.youtube.com/watch?v=5yqjH97vi00&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=5', '2022-01-14', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 6, 'https://www.youtube.com/watch?v=R6dQF5L1YXE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=6', '2022-01-28', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 7, 'https://www.youtube.com/watch?v=KxTgIgwDzUw&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=7', '2022-02-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 8, 'https://www.youtube.com/watch?v=NY6qw2l0BsQ&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=8', '2022-02-16', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 9, 'https://www.youtube.com/watch?v=Oe6V-roHTaA&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=9', '2022-02-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 10, 'https://www.youtube.com/watch?v=dxcJcr3d3qg&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=10', '2022-02-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 11, 'https://www.youtube.com/watch?v=KgoEqvT5bZk&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=11', '2022-03-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 12, 'https://www.youtube.com/watch?v=MdC3ZGON9SU&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=12', '2022-03-11', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 13, 'https://www.youtube.com/watch?v=mqxh-vfyrtM&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=13', '2022-03-16', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 14, 'https://www.youtube.com/watch?v=56vGOux0dPE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=14', '2022-04-03', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 15, 'https://www.youtube.com/watch?v=DeyTQ8Kf3so&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=15', '2022-04-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 16, 'https://www.youtube.com/watch?v=5Ou7DlnbHQg&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=16', '2022-06-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 17, 'https://www.youtube.com/watch?v=RWsdhFUYKQo&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=17', '2022-06-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 18, 'https://www.youtube.com/watch?v=7PWRKQc8SRU&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=18', '2022-06-19', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 19, 'https://www.youtube.com/watch?v=5qzHB2QIEqE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=19', '2022-06-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (8, 20, 'https://www.youtube.com/watch?v=KhtPJTj8ofY&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=20', '2022-07-21', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (9, 1, 'https://www.youtube.com/watch?v=dD2EISBDjWM&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=1', '2014-03-29', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 2, 'https://www.youtube.com/watch?v=-USAeFpVf_A&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=2', '2014-03-30', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 3, 'https://www.youtube.com/watch?v=i3GE-toQg-o&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=3', '2014-03-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 4, 'https://www.youtube.com/watch?v=09oErCBjVns&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=4', '2015-06-05', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 5, 'https://www.youtube.com/watch?v=wvR40su_XBM&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=5', '2015-06-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 6, 'https://www.youtube.com/watch?v=U4UHoiK6Oo4&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=6', '2014-11-08', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 7, 'https://www.youtube.com/watch?v=bCt2FnyY7AE&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=7', '2014-04-14', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 8, 'https://www.youtube.com/watch?v=Zy4KJeVN7Gk&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=8', '2014-04-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 9, 'https://www.youtube.com/watch?v=dM12ctixdT4&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=9', '2014-04-20', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 10, 'https://www.youtube.com/watch?v=rO6_MZLIzCg&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=10', '2014-04-21', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 11, 'https://www.youtube.com/watch?v=wvU1mmJn_UI&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=11', '2015-05-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 12, 'https://www.youtube.com/watch?v=f9QXNFVlsls&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=12', '2015-05-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 13, 'https://www.youtube.com/watch?v=onKF88kRK3Q&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=13', '2015-05-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 14, 'https://www.youtube.com/watch?v=NDAa6EaKce8&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=14', '2015-05-31', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 15, 'https://www.youtube.com/watch?v=g4UAV1lIHyA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=15', '2015-06-01', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 16, 'https://www.youtube.com/watch?v=NPfy-hKOGfk&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=16', '2015-06-01', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 17, 'https://www.youtube.com/watch?v=yWuAsqUnNsA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=17', '2015-12-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 18, 'https://www.youtube.com/watch?v=H6BSr5UOg2Y&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=18', '2015-12-30', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 19, 'https://www.youtube.com/watch?v=x13Uxl6_dyw&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=19', '2016-09-02', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (9, 20, 'https://www.youtube.com/watch?v=iWWTtYGZ4YA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=20', '2015-06-06', '', 'Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (10, 1, 'https://www.youtube.com/watch?v=nQeCtHxC93A&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=1', '2022-07-30', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 2, 'https://www.youtube.com/watch?v=x2eoEZU5fIk&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=2', '2022-08-02', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 3, 'https://www.youtube.com/watch?v=Ifxr9bOdwxM&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=3', '2022-08-02', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 4, 'https://www.youtube.com/watch?v=Y0Xep9cnxyY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=4', '2022-08-02', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 5, 'https://www.youtube.com/watch?v=7MMJrFWfbC4&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=5', '2022-08-02', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 6, 'https://www.youtube.com/watch?v=gpdEVZilQb4&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=6', '2022-08-03', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 7, 'https://www.youtube.com/watch?v=CD5h69sijd0&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=7', '2022-08-03', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 8, 'https://www.youtube.com/watch?v=tc4D8d_hrVc&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=8', '2022-08-03', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 9, 'https://www.youtube.com/watch?v=mnWmWTYk6OY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=9', '2022-08-03', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 10, 'https://www.youtube.com/watch?v=0FDyeOBdjBY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=10', '2022-08-05', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 11, 'https://www.youtube.com/watch?v=58ot93tpomI&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=11', '2022-08-05', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 12, 'https://www.youtube.com/watch?v=on8p0I0OR0E&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=12', '2022-08-06', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 13, 'https://www.youtube.com/watch?v=BrndY4j3L2c&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=13', '2022-08-06', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 14, 'https://www.youtube.com/watch?v=AQ3bx-inALs&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=14', '2022-08-06', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 15, 'https://www.youtube.com/watch?v=1GRSbdyTy1Y&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=15', '2022-08-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 16, 'https://www.youtube.com/watch?v=ywTKDsvm08c&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=16', '2022-08-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 17, 'https://www.youtube.com/watch?v=ov5E45V6w8g&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=17', '2022-08-07', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 18, 'https://www.youtube.com/watch?v=yo2aEYxBthg&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=18', '2022-08-09', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 19, 'https://www.youtube.com/watch?v=wlec1z6GeIE&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=19', '2022-08-09', '', 'Chưa Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (10, 20, 'https://www.youtube.com/watch?v=4BX0KFaWzBU&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=20', '2022-08-11', '', 'Chưa Hoàn Thành');

INSERT INTO `DanhSachVideo` VALUES (11, 1, 'https://www.youtube.com/watch?v=yOYnXoFvmj4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=1', '2020-11-11', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 2, 'https://www.youtube.com/watch?v=tPWUsSELJyY&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=2', '2020-11-13', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 3, 'https://www.youtube.com/watch?v=K6FXSVc-axM&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=3', '2020-11-17', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 4, 'https://www.youtube.com/watch?v=wEF9AXy8-Sc&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=4', '2020-11-19', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 5, 'https://www.youtube.com/watch?v=GqWgsWS4aL4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=5', '2020-11-24', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 6, 'https://www.youtube.com/watch?v=72JNNU2otF4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=6', '2020-11-26', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 7, 'https://www.youtube.com/watch?v=ce6W9E82lOA&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=7', '2020-12-02', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 8, 'https://www.youtube.com/watch?v=voviIrX7bXU&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=8', '2020-12-04', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 9, 'https://www.youtube.com/watch?v=9KMaGxYTcEI&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=9', '2020-12-09', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 10, 'https://www.youtube.com/watch?v=Xx9HjAB-Zz0&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=10', '2020-12-11', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 11, 'https://www.youtube.com/watch?v=2oT32JUH1s0&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=11', '2020-12-16', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 12, 'https://www.youtube.com/watch?v=kwz9-EjL7dY&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=12', '2020-12-18', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 13, 'https://www.youtube.com/watch?v=zP1LFgBO8Jg&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=13', '2020-12-23', '', 'Hoàn Thành');
INSERT INTO `DanhSachVideo` VALUES (11, 14, 'https://www.youtube.com/watch?v=4Evf46kbB3c&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=14', '2020-12-25', '', 'Hoàn Thành');
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
INSERT INTO `TaiKhoan` VALUES (12, 'DastagirAhmedTeacher', '123', 'info@dbestech.com', 'Dastagir Ahmed', '1995-10-02', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (13, 'AdrianHajdinTeacher', '123', 'contact@jsmasterypro.com', 'Adrian Hajdin', '1990-12-21', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (14, 'ImranQasimTeacher', '123', 'itsmeleo.qureshi@gmail.com', 'Imran Qasim', '1989-06-17', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (15, 'vandadTeacher', '123', 'beau@freecodecamp.org', 'Vandad Nahavandipoor', '1998-03-27', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (16, 'buckyTeacher', '123', 'thenewboston@.com', 'Bucky Roberts', '1992-05-21', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (17, 'phhoangTeacher', '123', 'huyhoang8a5@gmail.com', 'Phạm Huy Hoàng', '1998-11-11', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (18, 'chrisTeacher', '123', 'chris@codewithchris', 'Chris Ching', '1994-09-21', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (19, 'CryceTrulyTeacher', '123', 'crycetruly@gmail.com', 'Cryce Truly', '1993-11-30', 'Giáo viên');
INSERT INTO `TaiKhoan` VALUES (20, 'JamesMontemagnoTeacher', '123', 'refractoredllc@gmail.com', 'James Montemagno', '1994-02-07', 'Giáo viên');

INSERT INTO `TaiKhoan` VALUES (21, 'gojoSatoru', '123', 'Gojo Satoru', 'gojoCute@gmail.com', '2002-12-07', 'Học viên');
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
INSERT INTO `GiaoVien` VALUES (1, 1, 1);
INSERT INTO `GiaoVien` VALUES (2, 2, 1);
INSERT INTO `GiaoVien` VALUES (3, 3, 1);
INSERT INTO `GiaoVien` VALUES (4, 4, 1);
INSERT INTO `GiaoVien` VALUES (5, 5, 1);
INSERT INTO `GiaoVien` VALUES (6, 6, 1);
INSERT INTO `GiaoVien` VALUES (7, 7, 1);
INSERT INTO `GiaoVien` VALUES (8, 8, 1);
INSERT INTO `GiaoVien` VALUES (9, 9, 1);
INSERT INTO `GiaoVien` VALUES (10, 10, 1);
INSERT INTO `GiaoVien` VALUES (11, 11, 1);
INSERT INTO `GiaoVien` VALUES (12, 12, 1);
INSERT INTO `GiaoVien` VALUES (13, 13, 1);
INSERT INTO `GiaoVien` VALUES (14, 14, 1);
INSERT INTO `GiaoVien` VALUES (15, 15, 1);
INSERT INTO `GiaoVien` VALUES (16, 16, 1);
INSERT INTO `GiaoVien` VALUES (17, 17, 1);
INSERT INTO `GiaoVien` VALUES (18, 18, 1);
INSERT INTO `GiaoVien` VALUES (19, 19, 1);
INSERT INTO `GiaoVien` VALUES (20, 20, 1);
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
