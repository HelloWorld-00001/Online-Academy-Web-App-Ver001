DROP DATABASE IF EXISTS `QLKhoaHoc`;
CREATE DATABASE `QLKhoaHoc`;
USE `QLKhoaHoc`;

SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `LinhVuc`;
CREATE TABLE `LinhVuc` (
                           `MaLinhVuc` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                           `TenLinhVuc` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
                           PRIMARY KEY (`MaLinhVuc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `LinhVuc` VALUES (1, 'Lập trình Web');
INSERT INTO `LinhVuc` VALUES (2, 'Lập trình thiết bị di động');
COMMIT;

DROP TABLE IF EXISTS `CapNgonNgu`;
CREATE TABLE `CapNgonNgu` (
                           `MaNgonNgu` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                           `TenNgonNgu` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
                           `MaKhoaHoc` INT UNSIGNED NOT NULL,
                           PRIMARY KEY (`MaNgonNgu`, `TenNgonNgu`),
                           KEY `fk_caplinhvuc_khoahoc_idx`(`MaKhoaHoc`),
                           CONSTRAINT `fk_caplinhvuc_khoahoc` FOREIGN KEY (`MaKhoaHoc`) REFERENCES `KhoaHoc`(`MaKhoaHoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `LVNgonNgu`;
CREATE TABLE `LVNgonNgu` (
    `NgonNgu` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
    `LinhVuc` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`NgonNgu`),
    KEY `fk_lvngonngu_linhvuc_idx`(`LinhVuc`),
    CONSTRAINT `fk_lvngonngu_linhvuc` FOREIGN KEY (`LinhVuc`) REFERENCES `LinhVuc`(`MaLinhVuc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `LVNgonNgu` VALUES ('HTML', 1);
INSERT INTO `LVNgonNgu` VALUES ('CSS', 1);
INSERT INTO `LVNgonNgu` VALUES ('JAVASCRIPT', 1);
INSERT INTO `LVNgonNgu` VALUES ('SwiftUI', 2);
INSERT INTO `LVNgonNgu` VALUES ('Flutter', 2);
COMMIT;

DROP TABLE IF EXISTS `KhoaHoc`;
CREATE TABLE `KhoaHoc` (
                           `MaKhoaHoc` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                           `TenKhoaHoc` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
                           `LinhVuc` INT UNSIGNED NOT NULL,
                           `Gia` FLOAT NOT NULL,
                           `SoLuongVideo` INT,
                           `GiaoVien` INT ,
                           `Image` VARCHAR(255),
                           `KhuyenMai` FLOAT,
                           `RateTB` FLOAT,
                           `SLHocSinhDanhGia` INT,
                           `MoTaNgan` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
                           `LuotXem` INT,
                           `NgonNgu` VARCHAR(255),
                           `TinhTrang` INT UNSIGNED NOT NULL,
                           PRIMARY KEY (`MaKhoaHoc`),
                           KEY `fk_khoahoc_linhvuc_idx`(`LinhVuc`),
                           CONSTRAINT `fk_khoahoc_linhvuc` FOREIGN KEY (`LinhVuc`) REFERENCES `LinhVuc`(`MaLinhVuc`),
                           CONSTRAINT `fk_khoahoc_lvngonngu` FOREIGN KEY (`NgonNgu`) REFERENCES `LVNgonNgu`(`NgonNgu`),
						CONSTRAINT `fk_khoahoc_giaovien` FOREIGN KEY (`LinhVuc`) REFERENCES `giaovien`(`MaGiaoVien`) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `KhoaHoc` VALUES (1, 'Introduct To HTML, JS, CSS', 1, 100, 21, 1, '1.jpg', 10, 4.5, 10, 'Explore how you can create websites from scratch!!!', 0, 'HTML', 1);
INSERT INTO `KhoaHoc` VALUES (2, 'Food Ordering Web', 1, 125, 13, 2, '2.jpg', 10, 4, 20, 'In this course, you will learn to create complete dynamic and fully functional website using PHP programming language and MySQL Database css', 0, 'HTML', 1);
INSERT INTO `KhoaHoc` VALUES (3, 'Web Design Course', 1, 120, 19, 3, '3.jpg', 10, 4.2, 0, 'In this course, you will learn how to create a website and how to design it', 0, 'CSS', 1);
INSERT INTO `KhoaHoc` VALUES (4, 'HTML & CSS Crash Course Tutorial', 1, 100, 11, 4, '4.jpg', 10, 5, 10, 'Throughout this crash course series I will take you from total beginner to create great-looking sites with HTML & CSS. In this video, we will cover what HTML & CSS are, as well as setting up our dev environment.', 0, 'CSS', 1);
INSERT INTO `KhoaHoc` VALUES (5, 'Javascript Nâng Cao', 1, 50, 12, 5, '5.jpg', 10, 4, 10, 'Hiểu sâu hơn về cách Javascript hoạt động, hiểu các khái niệm Javascript nâng cao như: IIFE, closure, reference types, this keyword, bind, call, apply, ...', 0, 'JAVASCRIPT', 1);
INSERT INTO `KhoaHoc` VALUES (6, 'The Complete JavaScript Course 2022: From Zero to Expert', 1, 50, 20, 6, '6.jpg', 10, 3, 10, 'Entire JavaScript course from Zero to Expert! This course will help you learn web development in 2022 and beyond. Mastering these technical skills is vital to your career as a software developer.', 0, 'JAVASCRIPT', 1);
INSERT INTO `KhoaHoc` VALUES (7, 'Shopping web app', 1, 120, 20, 7, '7.jpg', 10, 0, 0, 'Hướng dẫn làm web bán hàng đơn giản cho người mới', 0, 'HTML', 1);
INSERT INTO `KhoaHoc` VALUES (8, 'Hotel booking web using PHP and MySQL', 1, 140, 20, 8, '8.jpg', 10, 3.9, 9, 'Learn about booking web and how to do it', 0, 'CSS', 1);
INSERT INTO `KhoaHoc` VALUES (9, 'HTML Tutorial for Beginners', 1, 75, 20, 9, '9.jpg', 10, 5, 30, 'In this video we go over the basics of HTML and what you will need to follow along for the entire series. This series will cover the latest concepts including HTML5.', 0, 'HTML', 1);
INSERT INTO `KhoaHoc` VALUES (10, 'Hotel booking web', 1, 130, 20, 10, '10.jpg', 10, 4.1, 8, 'Learn about booking web and how to do it', 0, 'JAVASCRIPT', 1);
INSERT INTO `KhoaHoc` VALUES (11, 'How to Make an App for Beginners (SwiftUI)', 2, 50, 14, 11, '11.jpg', 10, 3.7, 21, 'In this 14 day beginner challenge, you’ll learn how to make an app even if you’ve never coded before.', 0, 'SwiftUI', 1);
INSERT INTO `KhoaHoc` VALUES (12, 'Food Delivery App Development for iOS and Android', 2, 499, 8, 12, '12.jpg', 10, 4, 13, 'This is an e-commerce app for food delivery using flutter with backend as crash course tutorial for iOS and Android.', 0, 'SwiftUI', 1);
INSERT INTO `KhoaHoc` VALUES (13, 'Build and Deploy Your First Modern React Native App', 2, 100, 1, 13, '13.jpg', 10, 5, 10, 'Master React Native by building a modern NFT Marketplace iOS and Android ReactNative Application', 0, 'SwiftUI', 1);
INSERT INTO `KhoaHoc` VALUES (14, 'React Native Tutorial Series for Beginners', 2, 599, 10, 14, '14.jpg', 10, 1, 10, 'This is React Native Video Tutorial', 0, 'SwiftUI', 1);
INSERT INTO `KhoaHoc` VALUES (15, 'Flutter Course for Beginners', 2, 349, 1, 15, '15.jpg', 10, 4.3, 7, 'How to use Flutter in this complete course for beginners.', 0, 'Flutter', 1);
INSERT INTO `KhoaHoc` VALUES (16, 'Android App Development for Beginners', 2, 449, 15, 16, '16.jpg', 10, 4.8, 9, 'This is Android App Development for Beginners.', 0, 'Flutter', 1);
INSERT INTO `KhoaHoc` VALUES (17, 'Lộ trình tự học lập trình di động', 2, 5, 1, 17, '17.jpg', 0, 4.6, 21, 'Giới tiệu Lộ trình tự học lập trình di động cơ bản, siêu chi tiếc', 0, 'Flutter', 1);
INSERT INTO `KhoaHoc` VALUES (18, 'How To Make An App for Beginners 2021 - SwiftUI', 2, 299, 14, 18, '18.jpg', 5, 2.2, 1, 'How to make an app even if you’ve never coded before.', 0, 'SwiftUI', 1);
INSERT INTO `KhoaHoc` VALUES (19, 'Full React Native Project Tutorial for beginners.', 2, 399, 1, 19, '19.jpg', 10, 4, 10, 'Get Started with React Native and learn how to build iOS and Android apps!', 0, 'Flutter', 1);
INSERT INTO `KhoaHoc` VALUES (20, 'Xamarin & Xamarin.Forms for Beginners', 2, 549, 15, 20, '20.jpg', 10, 5, 20, 'Build iOS & Android Apps with C#, Visual Studio, and Xamarin.Forms.', 0, 'Flutter', 1);
COMMIT;

DROP TABLE IF EXISTS `ChiTietKhoaHoc`;
CREATE TABLE `ChiTietKhoaHoc` (
                                  `MaKhoaHoc` INT UNSIGNED NOT NULL,
                                  `NgayCapNhat` DATETIME NOT NULL,
                                  `MoTaChiTiet` TEXT COLLATE utf8_general_ci NOT NULL,
                                  `Link` varchar(255) not null,
                                  `SLHocVien` int,
                                  `NgayBD` date,
                                  `NgayKT` date,
                                  `TrangThai` varchar(255),

                                  PRIMARY KEY (`MaKhoaHoc`, `NgayCapNhat`),
                                  KEY `fk_chitietkhoahoc_khoahoc_idx` (`MaKhoaHoc`),
                                  CONSTRAINT `fk_chitietkhoahoc_khoahoc` FOREIGN KEY (`MaKhoaHoc`) REFERENCES `KhoaHoc`(`MaKhoaHoc`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `ChiTietKhoaHoc` VALUES (1, '2022-12-11', '', 'https://www.youtube.com/playlist?list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5', 0, '2022-12-17', '2023-01-21', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (2, '2021-06-13', '', 'https://www.youtube.com/playlist?list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW', 0, '2022-12-10', '2023-01-24', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (3, '2022-06-09', '', 'https://www.youtube.com/playlist?list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI', 0, '2022-12-4', '2023-01-29', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (4, '2019-07-30', '', 'https://www.youtube.com/playlist?list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G', 0, '2022-12-18', '2023-01-28', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (5, '2021-11-08', '', 'https://www.youtube.com/playlist?list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac', 0, '2022-12-14', '2023-01-22', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (6, '2022-11-18', '', 'https://www.youtube.com/playlist?list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ', 0, '2022-12-5', '2023-01-25', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (7, '2021-10-04', '', 'https://www.youtube.com/playlist?list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe', 0, '2022-12-27', '2023-01-21', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (8, '2022-09-07', '', 'https://www.youtube.com/playlist?list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt', 0, '2022-12-11', '2023-01-21', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (9, '2016-09-02', '', 'https://www.youtube.com/playlist?list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB', 0, '2022-12-2', '2023-01-25', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (10, '2022-08-29', '', 'https://www.youtube.com/playlist?list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u', 0, '2022-12-6', '2023-01-27', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (11, '2022-11-20', '', 'https://www.youtube.com/playlist?list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ', 0, '2022-12-24', '2023-01-21', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (12, '2022-09-20', '', 'https://www.dbestech.com/tutorials/flutter-food-delivery-app-e-commerce-for-ios-and-android', 0, '2022-01-28', '2022-09-20', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (13, '2022-04-01', '', 'https://www.youtube.com/watch?v=_ivIUCSOZ78', 0, '2022-04-01', '2022-04-01', 'Chưa hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (14, '2020-02-10', '', 'https://www.youtube.com/playlist?list=PL9fcHFJHtFaZ6DuInqORqFUaKiZO1XCmb', 0, '2020-01-22', '2020-03-18', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (15, '2022-02-24', '', 'https://youtu.be/VPvVD8t02U8', 0, '2022-02-24', '2022-02-27', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (16, '2015-03-04', '', 'https://www.youtube.com/playlist?list=PL6gx4Cwl9DGBsvRxJJOzG4r4k_zLKrnxl', 0, '2014-12-12', '2015-03-04', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (17, '2020-06-02', '', 'https://www.youtube.com/watch?v=lBuj1zoij6Y', 0, '2020-06-02', '2020-06-02', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (18, '2022-11-20', '', 'https://www.youtube.com/playlist?list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ', 0, '2020-11-11', '2020-12-25', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (19, '2021-02-14', '', 'https://www.youtube.com/watch?v=npe3Wf4tpSg', 0, '2021-02-21', '2021-02-23', 'Đã hoàn thành');
INSERT INTO `ChiTietKhoaHoc` VALUES (20, '2022-02-19', '', 'https://www.youtube.com/playlist?list=PLwOF5UVsZWUiHY1CkRVjYJ6dm0iCvAlfw', 0, '2020-11-20', '2022-01-20', 'Đã hoàn thành');
COMMIT;

DROP TABLE IF EXISTS `DanhSachVideo`;
CREATE TABLE `DanhSachVideo` (
                                 `MaKhoaHoc` int unsigned NOT NULL,
                                 `STT` int unsigned NOT NULL,
                                 `Link` varchar(255) not null,
                                 `NgayCapNhat` DATETIME NOT NULL,
                                 `MoTaVideo` text COLLATE utf8_general_ci NOT NULL,
                                 `TenVideo` nvarchar(150) not null,
                                 `File` varchar(255) not null,
                                 PRIMARY KEY (`MaKhoaHoc`, `STT`),
                                 KEY `fk_danhsachvideo_khoahoc_idx` (`MaKhoaHoc`),
                                 CONSTRAINT `fk_danhsachvideo_khoahoc` FOREIGN KEY (`MaKhoaHoc`) REFERENCES `KhoaHoc`(`MaKhoaHoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `DanhSachVideo` VALUES (1, 1, 'https://www.youtube.com/watch?v=gVx72yLou2c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=1', '2021-11-30', '', 'Trở thành DEV tay to, thực chiến hơn 30 dự án cùng với 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 2, 'https://www.youtube.com/watch?v=3odtU8VL3Mc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=2', '2021-11-17', '', 'Day 1: Thiết kế Product Card bắt mắt chưa đầy 1 giờ | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 3, 'https://www.youtube.com/watch?v=DkiLJzL6kv4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=3', '2021-11-18', '', 'Day 2: Đứng hình mất 5s với Profile Card giới thiệu bản thân | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 4, 'https://www.youtube.com/watch?v=gyqMtCmHHUA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=4', '2021-11-19', '', 'Day 3: Bật mí cách tạo Modal Popup Material UI vừa đẹp vừa đơn giản - Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 5, 'https://www.youtube.com/watch?v=0Uhtzrsi-qE&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=5', '2021-11-21', '', 'Day 4: Hiệu ứng show ảnh Image Gallery chuyên nghiệp không phải ai cũng biết | 30 Days Thực chiến', '');
INSERT INTO `DanhSachVideo` VALUES (1, 6, 'https://www.youtube.com/watch?v=rpKjWpOiBSY&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=6', '2021-11-21', '', 'Day 5: Search Box đơn giản mà đẹp, không phải ai cũng biết | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 7, 'https://www.youtube.com/watch?v=p5ivn6UpjQk&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=7', '2021-11-27', '', 'Day 6: Những thông tin quan trọng khi bắt sự kiện keydown | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 8, 'https://www.youtube.com/watch?v=Cad_2CvAoQ8&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=8', '2021-12-08', '', 'Day 7: Search Tags có gì hay ho ? | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 9, 'https://www.youtube.com/watch?v=fRPCVBfD7hw&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=9', '2021-12-08', '', 'Day 8: Validate form có tâm thế này mới đi làm được AE nhé. | 30 Days Thực chiến HTML CSS JS', '');
INSERT INTO `DanhSachVideo` VALUES (1, 10, 'https://www.youtube.com/watch?v=ZKhOuR1UWh4&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=10', '2021-12-25', '', 'Day 9: Đi làm thì phải biết dùng API vậy API là gì? Call API làm cực kỳ đơn giản trong Weather App', '');
INSERT INTO `DanhSachVideo` VALUES (1, 11, 'https://www.youtube.com/watch?v=iO7kgGgHr6w&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=11', '2022-01-15', '', 'Day 10: Todo List bài tập kinh điển mà đi làm ai cũng phải biết. Kỹ thuật sử dụng "This" đơn giản', '');
INSERT INTO `DanhSachVideo` VALUES (1, 12, 'https://www.youtube.com/watch?v=Z-SuiRYaPck&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=12', '2022-02-17', '', 'Day 11: Biết Animation khi đi làm frontend không bao giờ là thừa. Toast Notification Animation', '');
INSERT INTO `DanhSachVideo` VALUES (1, 13, 'https://www.youtube.com/watch?v=b8AjydmGOpA&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=13', '2022-02-18', '', 'Day 12: Tự code từ đầu hay tuỳ chỉnh từ element có sẵn sẽ nhanh và tối ưu hơn', '');
INSERT INTO `DanhSachVideo` VALUES (1, 14, 'https://www.youtube.com/watch?v=SsoCQuwk-3Y&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=14', '2022-02-19', '', 'Day 13: Blob và Base64 là gì? Dùng Blob, Base64 để xử lý validate định dạng, dung lượng media', '');
INSERT INTO `DanhSachVideo` VALUES (1, 15, 'https://www.youtube.com/watch?v=fyAS7cFPJ7c&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=15', '2022-02-20', '', 'Day 14: Thiết kế SlideShow, Carousel hiệu ứng với HTML CSS JS thuần', '');
INSERT INTO `DanhSachVideo` VALUES (1, 16, 'https://www.youtube.com/watch?v=5T1SEvBqA-g&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=16', '2022-02-22', '', 'Day 15: Thế nào là MockData? Filter, tìm kiếm sản phẩm trong dự án shop bán hàng, thương mại điện tử', '');
INSERT INTO `DanhSachVideo` VALUES (1, 17, 'https://www.youtube.com/watch?v=luI-NrSpm34&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=17', '2022-02-23', '', 'Day 16: Tư duy viết thuật toán đơn giản, Chỉ 15 phút Ai cũng tự code được Animation cho riêng mình.', '');
INSERT INTO `DanhSachVideo` VALUES (1, 18, 'https://www.youtube.com/watch?v=nEBPSEPuaIM&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=18', '2022-02-25', '', 'Day 17: Kinh nghiệm đóng gói tính năng là đây? Xây dựng hiệu ứng Number Counter Up', '');
INSERT INTO `DanhSachVideo` VALUES (1, 19, 'https://www.youtube.com/watch?v=18MAAGZkyWs&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=19', '2022-03-04', '', 'Day 18: Kéo thả đơn giản quá, hoá ra code hiệu ứng Drag and drop lại dễ dàng như vậy.', '');
INSERT INTO `DanhSachVideo` VALUES (1, 20, 'https://www.youtube.com/watch?v=4qyVKhIQZqc&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=20', '2022-03-05', '', 'Day 19: Code ứng dụng vẽ Paint thần thánh. Làm quen với cách sử dụng Canvas làm Drawing App đơn giản', '');
INSERT INTO `DanhSachVideo` VALUES (1, 21, 'https://www.youtube.com/watch?v=1qw9J4MfbGU&list=PLodO7Gi1F7R0zA8RkRHcDgnPduNBmjkb5&index=21', '2022-12-12', '', 'Day 20: Phân tích hướng làm Typing Animation - Part 1/2', '');

INSERT INTO `DanhSachVideo` VALUES (2, 1, 'https://www.youtube.com/watch?v=ZBgTzx46B8s&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=1', '2020-11-08', '', '1. Food Order Website with PHP and MySQL (Start Project and Create Database)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 2, 'https://www.youtube.com/watch?v=o-6cL61-uDw&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=2', '2020-11-10', '', '2. Food Order Website with PHP and MySQL (Add and Display Admins)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 3, 'https://www.youtube.com/watch?v=1Aik3MWJTTo&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=3', '2020-11-13', '', '3. Food Order Website with PHP and MySQL (Update/Delete Admin and Change Admin Password)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 4, 'https://www.youtube.com/watch?v=bk_5SAH7Oyk&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=4', '2020-11-17', '', '4. Food Order Website with PHP and MySQL (Login - Authentication and Access Control - Authorization)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 5, 'https://www.youtube.com/watch?v=_Sxo-ASOatc&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=5', '2020-11-21', '', '5. Food Order Website with PHP and MySQL (Add and Display Category)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 6, 'https://www.youtube.com/watch?v=9wlbIb3gCEs&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=6', '2020-11-24', '', '6. Food Order Website with PHP and MySQL (Deleting and Updating Category)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 7, 'https://www.youtube.com/watch?v=YsrPRRLfaG0&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=7', '2020-11-27', '', '7. Food Order Website with PHP and MySQL (Adding and Displaying Foods)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 8, 'https://www.youtube.com/watch?v=UJmVA3bR5HE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=8', '2020-12-01', '', '8. Food Order Website with PHP and MySQL (Delete and Update Food)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 9, 'https://www.youtube.com/watch?v=GxCh9B0ZU6E&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=9', '2020-12-04', '', '9. Food Order Website with PHP and MySQL (Connecting Frontend and Backend)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 10, 'https://www.youtube.com/watch?v=qieZiZxxHy4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=10', '2020-12-08', '', '10. Food Order Website with PHP and MySQL (Search Foods and Display Foods by Category Selected)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 11, 'https://www.youtube.com/watch?v=fv_FjQai2E4&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=11', '2020-12-11', '', '11. Food Order Website with PHP and MySQL (Food Order and Manage Order)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 12, 'https://www.youtube.com/watch?v=zKWV2WJ-5CM&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=12', '2020-12-15', '', '12. Food Order Website with PHP and MySQL (Creating Summary Dashboard on Admin Panel)', '');
INSERT INTO `DanhSachVideo` VALUES (2, 13, 'https://www.youtube.com/watch?v=oVjTcKgLzuE&list=PLBLPjjQlnVXXBheMQrkv3UROskC0K1ctW&index=13', '2021-06-14', '', '13. Food Order Website with PHP and MySQL (Bonus 1: Securing PHP Code)', '');

INSERT INTO `DanhSachVideo` VALUES (3, 1, 'https://www.youtube.com/watch?v=C72WkcUZvco&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=1', '2020-04-15', '', 'FREE Web Design Course: Introduction to Web Design | Episode 1', '');
INSERT INTO `DanhSachVideo` VALUES (3, 2, 'https://www.youtube.com/watch?v=R_gFhRsWLMw&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=2', '2020-04-20', '', 'BASIC WEB DESIGN SOFTWARE: Free Web Design Course | Episode 2', '');
INSERT INTO `DanhSachVideo` VALUES (3, 3, 'https://www.youtube.com/watch?v=mQeplLGXIY4&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=3', '2020-04-22', '', 'BRIEF HISTORY OF WEB DESIGN: Free Web Design Course | Episode 3', '');
INSERT INTO `DanhSachVideo` VALUES (3, 4, 'https://www.youtube.com/watch?v=OUp7ale49lI&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=4', '2020-04-24', '', 'INTRO TO TYPOGRAPHY: Free Web Design Course | Episode 4', '');
INSERT INTO `DanhSachVideo` VALUES (3, 5, 'https://www.youtube.com/watch?v=BN8pC91rJaU&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=5', '2020-04-27', '', 'USING THE RIGHT IMAGE FOR YOUR WEB DESIGN: Free Web Design Course | Episode 5', '');
INSERT INTO `DanhSachVideo` VALUES (3, 6, 'https://www.youtube.com/watch?v=TDRhwSfxYkg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=6', '2020-04-29', '', 'INTRO TO LAYOUT: Free Web Design Course | Episode 6', '');
INSERT INTO `DanhSachVideo` VALUES (3, 7, 'https://www.youtube.com/watch?v=UuPt4RpV4Xc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=7', '2020-05-04', '', 'HOW TO USE COLORS IN WEB DESIGN: Free Web Design Course | Episode 7', '');
INSERT INTO `DanhSachVideo` VALUES (3, 8, 'https://www.youtube.com/watch?v=kOJ4c5THLQk&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=8', '2020-05-08', '', 'WHY HIERARCHY IS SO IMPORTANT IN WEB DESIGN: Free Web Design Course | Episode 8', '');
INSERT INTO `DanhSachVideo` VALUES (3, 9, 'https://www.youtube.com/watch?v=x3Yno9VUYBY&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=9', '2020-05-13', '', 'USING WIREFRAMES IN WEB DESIGN: Free Web Design Course | Episode 9', '');
INSERT INTO `DanhSachVideo` VALUES (3, 10, 'https://www.youtube.com/watch?v=flAcHu-squc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=10', '2020-05-19', '', 'CREATING A GOOD HERO FOR YOUR WEBSITE: Free Web Design Course | Episode 10', '');
INSERT INTO `DanhSachVideo` VALUES (3, 11, 'https://www.youtube.com/watch?v=8A6MxYNooYA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=11', '2020-05-28', '', 'WEBSITE CONTENT STRUCTURE: Free Web Design Course | Episode 11', '');
INSERT INTO `DanhSachVideo` VALUES (3, 12, 'https://www.youtube.com/watch?v=Cn2KgB_01mE&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=12', '2020-06-02', '', 'UX/UI BEST PRACTICES FOR WEB DESIGN: Free Web Design Course | Episode 12', '');
INSERT INTO `DanhSachVideo` VALUES (3, 13, 'https://www.youtube.com/watch?v=ZbQxX7v_dfo&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=13', '2020-06-09', '', 'PHOTO EDITING 101 FOR WEB DESIGNERS: Free Web Design Course | Episode 13', '');
INSERT INTO `DanhSachVideo` VALUES (3, 14, 'https://www.youtube.com/watch?v=l5orEmE7Pq8&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=14', '2020-06-18', '', 'DESIGN A HOMEPAGE WITH ADOBE XD: Free Web Design Course | Episode 14', '');
INSERT INTO `DanhSachVideo` VALUES (3, 15, 'https://www.youtube.com/watch?v=lQzmGrUQUDc&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=15', '2020-07-10', '', 'GETTING YOUR WEBSITE READY FOR DEVELOPMENT: Free Web Design Course | Episode 15', '');
INSERT INTO `DanhSachVideo` VALUES (3, 16, 'https://www.youtube.com/watch?v=ZliIs7jHi1s&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=16', '2020-07-21', '', '5 Website Types & How To Design Them | Free Web Design Course | Episode 16', '');
INSERT INTO `DanhSachVideo` VALUES (3, 17, 'https://www.youtube.com/watch?v=FYOxoJbngAM&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=17', '2020-07-30', '', 'How To Find Web Design Inspiration To Stand Out | Free Web Design Course | Episode 17', '');
INSERT INTO `DanhSachVideo` VALUES (3, 18, 'https://www.youtube.com/watch?v=fqDTN24HQqg&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=18', '2020-08-04', '', '3 Psychology Principles Every Web Designer Must know | Free Web Design Course | Episode 18', '');
INSERT INTO `DanhSachVideo` VALUES (3, 19, 'https://www.youtube.com/watch?v=z2t6eRuwbFA&list=PLXC_gcsKLD6n7p6tHPBxsKjN5hA_quaPI&index=19', '2020-08-15', '', 'Tools To Develop Your Website (Webflow, Wix & More) | Free Web Design Course Episode 19', '');

INSERT INTO `DanhSachVideo` VALUES (4, 1, 'https://www.youtube.com/watch?v=hu-q2zYwEYs&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=1', '2019-07-09', '', 'HTML & CSS Crash Course Tutorial #1 - Introduction', '');
INSERT INTO `DanhSachVideo` VALUES (4, 2, 'https://www.youtube.com/watch?v=mbeT8mpmtHA&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=2', '2019-07-09', '', 'HTML & CSS Crash Course Tutorial #2 - HTML Basics', '');
INSERT INTO `DanhSachVideo` VALUES (4, 3, 'https://www.youtube.com/watch?v=YwbIeMlxZAU&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=3', '2019-07-11', '', 'HTML & CSS Crash Course Tutorial #3 - HTML Forms', '');
INSERT INTO `DanhSachVideo` VALUES (4, 4, 'https://www.youtube.com/watch?v=D3iEE29ZXRM&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=4', '2019-07-12', '', 'HTML & CSS Crash Course Tutorial #4 - CSS Basics', '');
INSERT INTO `DanhSachVideo` VALUES (4, 5, 'https://www.youtube.com/watch?v=FHZn6706e3Q&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=5', '2019-07-17', '', 'HTML & CSS Crash Course Tutorial #5 - CSS Classes & Selectors', '');
INSERT INTO `DanhSachVideo` VALUES (4, 6, 'https://www.youtube.com/watch?v=kGW8Al_cga4&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=6', '2019-07-19', '', 'HTML & CSS Crash Course Tutorial #6 - HTML 5 Semantics', '');
INSERT INTO `DanhSachVideo` VALUES (4, 7, 'https://www.youtube.com/watch?v=25R1Jl5P7Mw&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=7', '2019-07-22', '', 'HTML & CSS Crash Course Tutorial #7 - Chrome Dev Tools', '');
INSERT INTO `DanhSachVideo` VALUES (4, 8, 'https://www.youtube.com/watch?v=XQaHAAXIVg8&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=8', '2019-07-24', '', 'HTML & CSS Crash Course Tutorial #8 - CSS Layout & Position', '');
INSERT INTO `DanhSachVideo` VALUES (4, 9, 'https://www.youtube.com/watch?v=FMu2cKWD90g&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=9', '2019-07-26', '', 'HTML & CSS Crash Course Tutorial #9 - Pseudo Classes & Elements', '');
INSERT INTO `DanhSachVideo` VALUES (4, 10, 'https://www.youtube.com/watch?v=Xig7NsIE6DI&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=10', '2019-07-30', '', 'HTML & CSS Crash Course Tutorial #10 - Intro to Media Queries', '');
INSERT INTO `DanhSachVideo` VALUES (4, 11, 'https://www.youtube.com/watch?v=qES0HypsUK0&list=PL4cUxeGkcC9ivBf_eKCPIAYXWzLlPAm6G&index=11', '2019-07-30', '', 'HTML & CSS Crash Course Tutorial #11 - Next Steps', '');

INSERT INTO `DanhSachVideo` VALUES (5, 1, 'https://www.youtube.com/watch?v=MGhw6XliFgo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=1', '2021-04-03', '', 'Ra mắt khóa Javascript nâng cao (javascript advanced)', '');
INSERT INTO `DanhSachVideo` VALUES (5, 2, 'https://www.youtube.com/watch?v=N-3GU1F1UBY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=2', '2021-04-03', '', 'IIFE trong Javascript là gì?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 3, 'https://www.youtube.com/watch?v=5N8vz_VmszE&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=3', '2021-07-19', '', 'Scope trong Javascript? Hiểu thật rõ về phạm vi nào!', '');
INSERT INTO `DanhSachVideo` VALUES (5, 4, 'https://www.youtube.com/watch?v=xtQtGKL0NCI&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=4', '2021-07-20', '', 'Closure trong Javascript có phải là cái gì "kinh khủng"?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 5, 'https://www.youtube.com/watch?v=3MLhU1DrUxM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=5', '2021-07-26', '', 'Hoisting trong Javascript? Let, const có được hoisted hay không?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 6, 'https://www.youtube.com/watch?v=w1W-j4cSPF0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=6', '2021-07-28', '', '"use strict" hay strict mode trong Javascript?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 7, 'https://www.youtube.com/watch?v=n4tS1Q5-EzY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=7', '2021-01-21', '', 'Primitive Types & Reference Types trong Javascript', '');
INSERT INTO `DanhSachVideo` VALUES (5, 8, 'https://www.youtube.com/watch?v=ii1Ra_zLDIo&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=8', '2021-07-31', '', 'Từ khóa "this" trong Javascript?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 9, 'https://www.youtube.com/watch?v=F5z6YoR8of0&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=9', '2021-08-03', '', 'Fn.bind() method P1? Học rồi thì xem lại cho chắc nha!', '');
INSERT INTO `DanhSachVideo` VALUES (5, 10, 'https://www.youtube.com/watch?v=6j9b2_E34JM&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=10', '2021-08-03', '', 'Fn.bind() method P2? Thêm vài ví dụ "khó" hơn nào!', '');
INSERT INTO `DanhSachVideo` VALUES (5, 11, 'https://www.youtube.com/watch?v=QxLTSdTJDXY&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=11', '2021-08-06', '', 'Fn.call() method trong Javascript?', '');
INSERT INTO `DanhSachVideo` VALUES (5, 12, 'https://www.youtube.com/watch?v=a4FjX4Z-9Rs&list=PL_-VfJajZj0U1MSx1IMu13oLJq2nM97ac&index=12', '2021-08-26', '', 'Fn.apply() method trong Javascript?', '');

INSERT INTO `DanhSachVideo` VALUES (6, 1, 'https://www.youtube.com/watch?v=1976Hf-DR44&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=1', '2022-11-10', '', 'JavaScript Fundamentals Part-1. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 2, 'https://www.youtube.com/watch?v=U5IHV-Ftf7c&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=2', '2022-06-09', '', 'JavaScript Fundamentals Part-2. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 3, 'https://www.youtube.com/watch?v=IHtfy2ywW9s&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=3', '2022-06-22', '', 'JavaScript Fundamentals Part-3. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 4, 'https://www.youtube.com/watch?v=SF4QFxyIyX0&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=4', '2022-06-26', '', 'JavaScript Fundamentals Part-4. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 5, 'https://www.youtube.com/watch?v=Hvxt3JHTCoI&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=5', '2022-07-04', '', 'JavaScript Fundamentals Part-5. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 6, 'https://www.youtube.com/watch?v=WfESlbkyQow&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=6', '2022-07-06', '', 'JavaScript Fundamentals Part-6. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 7, 'https://www.youtube.com/watch?v=hgtcRDqfjeE&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=7', '2022-07-07', '', 'Developer Skills & Editor Setup Part-7. The Complete JavaScript Course 2022:From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 8, 'https://www.youtube.com/watch?v=aVJU__8ERWM&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=8', '2022-07-07', '', 'HTML & CSS Crash Course Part-8. The Complete JavaScript Course 2022: From Zero to Expert!', '');
INSERT INTO `DanhSachVideo` VALUES (6, 9, 'https://www.youtube.com/watch?v=ltI_GM_6xrA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=9', '2022-07-08', '', 'JavaScript in the Browser_ DOM and Events Fundamentals Part-9. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 10, 'https://www.youtube.com/watch?v=2_E_Bird3VU&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=10', '2022-07-09', '', 'JavaScript in the Browser_ DOM and Events Fundamentals Part-10. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 11, 'https://www.youtube.com/watch?v=E_1Zoy5OUNA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=11', '2022-07-18', '', 'How JavaScript Works Behind the Scenes Part-11. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 12, 'https://www.youtube.com/watch?v=rt3NOoQH4Zs&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=12', '2022-07-25', '', 'How JavaScript Works Behind the Scenes Part-12. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 13, 'https://www.youtube.com/watch?v=XhWBgx3Vjrc&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=13', '2022-07-26', '', 'Data Structures, Modern Operators and Strings Part-13. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 14, 'https://www.youtube.com/watch?v=zI2SxDz8uU0&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=14', '2022-07-28', '', 'Data Structures, Modern Operators and Strings Part-14. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 15, 'https://www.youtube.com/watch?v=pHV4rZBwkAo&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=15', '2022-07-30', '', 'Data Structures, Modern Operators and Strings Part-15. The Complete JavaScript Course 2022.', '');
INSERT INTO `DanhSachVideo` VALUES (6, 16, 'https://www.youtube.com/watch?v=0X-xG8jQ0pY&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=16', '2022-08-07', '', 'A Closer Look at Functions Part-16. The Complete JavaScript Course 2022', '');
INSERT INTO `DanhSachVideo` VALUES (6, 17, 'https://www.youtube.com/watch?v=coZUNjZ4i6I&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=17', '2022-08-10', '', 'A Closer Look at Functions Part-17. The Complete JavaScript Course 2022', '');
INSERT INTO `DanhSachVideo` VALUES (6, 18, 'https://www.youtube.com/watch?v=dRFqF3ore78&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=18', '2022-08-16', '', 'Working With Arrays Part-18. The Complete JavaScript Course 2022', '');
INSERT INTO `DanhSachVideo` VALUES (6, 19, 'https://www.youtube.com/watch?v=jX5bED9oYFA&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=19', '2022-08-31', '', 'Working With Arrays Part-19. The Complete JavaScript Course 2022', '');
INSERT INTO `DanhSachVideo` VALUES (6, 20, 'https://www.youtube.com/watch?v=juQBPlnqnzg&list=PLd7dW_Jxkr_Yw6apt7tpzDC6X2mP5UhtQ&index=20', '2022-10-05', '', 'Working With Arrays Part-20. The Complete JavaScript Course 2022', '');

INSERT INTO `DanhSachVideo` VALUES (7, 1, 'https://www.youtube.com/watch?v=6ca7Roj_NfE&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=1', '2020-09-12', '', 'Bài 1: Lập trình website bán hàng full-stack - Giao diện trang chủ (P1)', '');
INSERT INTO `DanhSachVideo` VALUES (7, 2, 'https://www.youtube.com/watch?v=T4RIbr9VIT8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=2', '2020-09-12', '', 'Bài 1: Lập trình website bán hàng full-stack - Giao diện trang chủ (P2)', '');
INSERT INTO `DanhSachVideo` VALUES (7, 3, 'https://www.youtube.com/watch?v=3hx24mRfKGE&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=3', '2020-09-12', '', 'Bài 1: Lập trình website bán hàng full-stack - Giao diện trang chủ (P3)', '');
INSERT INTO `DanhSachVideo` VALUES (7, 4, 'https://www.youtube.com/watch?v=HrzV05lzf2Y&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=4', '2021-06-15', '', 'Lập trình website bán hàng full stack Giao diện trang danh mục sản phẩm', '');
INSERT INTO `DanhSachVideo` VALUES (7, 5, 'https://www.youtube.com/watch?v=rvIyNR4L0KI&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=5', '2021-06-17', '', 'Lập trình website bán hàng full stack Giao diện trang sản phẩm P1', '');
INSERT INTO `DanhSachVideo` VALUES (7, 6, 'https://www.youtube.com/watch?v=hZVtkPv2q0A&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=6', '2021-06-20', '', 'Lập trình website bán hàng full stack Giao diện trang sản phẩm P2', '');
INSERT INTO `DanhSachVideo` VALUES (7, 7, 'https://www.youtube.com/watch?v=oYLwpa0Ug-A&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=7', '2021-07-09', '', 'Lập trình website bán hàng full stack Giao diện trang sản phẩm P3', '');
INSERT INTO `DanhSachVideo` VALUES (7, 8, 'https://www.youtube.com/watch?v=zUVbKfHgA40&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=8', '2021-07-13', '', 'Lập trình website bán hàng full stack Trang giỏ hàng', '');
INSERT INTO `DanhSachVideo` VALUES (7, 9, 'https://www.youtube.com/watch?v=iI_IBe_SW9Q&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=9', '2021-07-14', '', 'Lập trình website bán hàng full stack Trang giao hàng', '');
INSERT INTO `DanhSachVideo` VALUES (7, 10, 'https://www.youtube.com/watch?v=QgM6Gp7lzYw&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=10', '2021-07-16', '', 'Lập trình website bán hàng full stack Trang thanh toán', '');
INSERT INTO `DanhSachVideo` VALUES (7, 11, 'https://www.youtube.com/watch?v=KeO2VAlXBMM&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=11', '2021-07-20', '', 'Lập trình website bán hàng full stack Backend P0', '');
INSERT INTO `DanhSachVideo` VALUES (7, 12, 'https://www.youtube.com/watch?v=v_puS2Wh-SU&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=12', '2021-07-21', '', 'Lập trình website bán hàng full stack Backend P1', '');
INSERT INTO `DanhSachVideo` VALUES (7, 13, 'https://www.youtube.com/watch?v=rgdcz6MTKgg&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=13', '2021-07-22', '', 'Lập trình website bán hàng full stack Backend P2', '');
INSERT INTO `DanhSachVideo` VALUES (7, 14, 'https://www.youtube.com/watch?v=P4LaivJMDos&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=14', '2021-07-23', '', 'Lập trình website bán hàng full stack Backend P3', '');
INSERT INTO `DanhSachVideo` VALUES (7, 15, 'https://www.youtube.com/watch?v=QxIxNjOCCDQ&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=15', '2021-07-24', '', 'Lập trình website bán hàng full stack Backend P4', '');
INSERT INTO `DanhSachVideo` VALUES (7, 16, 'https://www.youtube.com/watch?v=TsWrgF8VZT8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=16', '2021-07-26', '', 'Lập trình website bán hàng full stack Backend P5', '');
INSERT INTO `DanhSachVideo` VALUES (7, 17, 'https://www.youtube.com/watch?v=cSRsf2sbGC4&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=17', '2021-07-27', '', 'Lập trình website bán hàng full stack Backend P6', '');
INSERT INTO `DanhSachVideo` VALUES (7, 18, 'https://www.youtube.com/watch?v=nkqoUtDhch8&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=18', '2021-07-28', '', 'Lập trình website bán hàng full stack Backend P7', '');
INSERT INTO `DanhSachVideo` VALUES (7, 19, 'https://www.youtube.com/watch?v=igV7S5RmvnY&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=19', '2021-07-31', '', 'Lập trình website bán hàng full stack Backend P8', '');
INSERT INTO `DanhSachVideo` VALUES (7, 20, 'https://www.youtube.com/watch?v=Cbcj88qVF48&list=PLPNLZmPSwSkc0jZwYBIxHjACQrq16lJQe&index=20', '2021-07-31', '', 'Lập trình website bán hàng full stack Backend P9', '');

INSERT INTO `DanhSachVideo` VALUES (8, 1, 'https://www.youtube.com/watch?v=MV8AT9a2oSM&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=1', '2021-12-07', '', '01 - Hotel Booking Website using PHP and MySQL (2022) | Introduction', '');
INSERT INTO `DanhSachVideo` VALUES (8, 2, 'https://www.youtube.com/watch?v=BLqDewjag48&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=2', '2021-12-20', '', '02 - Hotel Booking Website using PHP and MySQL | Homepage design', '');
INSERT INTO `DanhSachVideo` VALUES (8, 3, 'https://www.youtube.com/watch?v=2gzS9Z6DRps&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=3', '2022-01-04', '', '03 - Hotel Booking Website using PHP and MySQL | Facilities & About us page design', '');
INSERT INTO `DanhSachVideo` VALUES (8, 4, 'https://www.youtube.com/watch?v=XDF8POggNhA&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=4', '2022-01-12', '', '04 - Hotel Booking Website using PHP and MySQL | Contact us page design', '');
INSERT INTO `DanhSachVideo` VALUES (8, 5, 'https://www.youtube.com/watch?v=5yqjH97vi00&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=5', '2022-01-14', '', '05 - Hotel Booking Website using PHP and MySQL | Rooms page design', '');
INSERT INTO `DanhSachVideo` VALUES (8, 6, 'https://www.youtube.com/watch?v=R6dQF5L1YXE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=6', '2022-01-28', '', '06 - Hotel Booking Website using PHP and MySQL | Admin Login Panel', '');
INSERT INTO `DanhSachVideo` VALUES (8, 7, 'https://www.youtube.com/watch?v=KxTgIgwDzUw&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=7', '2022-02-09', '', '07 - Hotel Booking Website using PHP and MySQL | Settings Page - Part 1', '');
INSERT INTO `DanhSachVideo` VALUES (8, 8, 'https://www.youtube.com/watch?v=NY6qw2l0BsQ&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=8', '2022-02-16', '', '08 - Hotel Booking Website using PHP and MySQL | Settings Page - Part 2', '');
INSERT INTO `DanhSachVideo` VALUES (8, 9, 'https://www.youtube.com/watch?v=Oe6V-roHTaA&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=9', '2022-02-21', '', '09 - Hotel Booking Website using PHP and MySQL | Settings Page - Part 3', '');
INSERT INTO `DanhSachVideo` VALUES (8, 10, 'https://www.youtube.com/watch?v=dxcJcr3d3qg&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=10', '2022-02-24', '', '10 - Hotel Booking Website using PHP and MySQL | Dynamic Front End', '');
INSERT INTO `DanhSachVideo` VALUES (8, 11, 'https://www.youtube.com/watch?v=KgoEqvT5bZk&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=11', '2022-03-03', '', '11 - Hotel Booking Website using PHP and MySQL | Dynamic Carousel', '');
INSERT INTO `DanhSachVideo` VALUES (8, 12, 'https://www.youtube.com/watch?v=MdC3ZGON9SU&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=12', '2022-03-11', '', '12 - Hotel Booking Website using PHP and MySQL | Contact us form backend', '');
INSERT INTO `DanhSachVideo` VALUES (8, 13, 'https://www.youtube.com/watch?v=mqxh-vfyrtM&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=13', '2022-03-16', '', '13 - Hotel Booking Website using PHP and MySQL | Features & Facilities Section', '');
INSERT INTO `DanhSachVideo` VALUES (8, 14, 'https://www.youtube.com/watch?v=56vGOux0dPE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=14', '2022-04-03', '', '14 - Hotel Booking Website using PHP and MySQL | Rooms Backend - Part 1', '');
INSERT INTO `DanhSachVideo` VALUES (8, 15, 'https://www.youtube.com/watch?v=DeyTQ8Kf3so&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=15', '2022-04-20', '', '15 - Hotel Booking Website using PHP and MySQL | Rooms Backend - Part 2', '');
INSERT INTO `DanhSachVideo` VALUES (8, 16, 'https://www.youtube.com/watch?v=5Ou7DlnbHQg&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=16', '2022-06-04', '', '16 - Hotel Booking Website using PHP and MySQL | Rooms Front End', '');
INSERT INTO `DanhSachVideo` VALUES (8, 17, 'https://www.youtube.com/watch?v=RWsdhFUYKQo&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=17', '2022-06-13', '', '17 - Hotel Booking Website using PHP and MySQL | User Registration and Email Verification', '');
INSERT INTO `DanhSachVideo` VALUES (8, 18, 'https://www.youtube.com/watch?v=7PWRKQc8SRU&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=18', '2022-06-19', '', '18 - Hotel Booking Website using PHP and MySQL | User Login and Forgot Password System', '');
INSERT INTO `DanhSachVideo` VALUES (8, 19, 'https://www.youtube.com/watch?v=5qzHB2QIEqE&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=19', '2022-06-26', '', '19 - Hotel Booking Website using PHP and MySQL | User Management & Shutdown Feature', '');
INSERT INTO `DanhSachVideo` VALUES (8, 20, 'https://www.youtube.com/watch?v=KhtPJTj8ofY&list=PLWxTHN2c_6cbh1C7yIskoXszoTl-okogt&index=20', '2022-07-21', '', '20 - Hotel Booking Website using PHP and MySQL | Checkout Page & Payment Gateway Integration', '');

INSERT INTO `DanhSachVideo` VALUES (9, 1, 'https://www.youtube.com/watch?v=dD2EISBDjWM&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=1', '2014-03-29', '', 'HTML Tutorial for Beginners - 00 - Introduction to HTML', '');
INSERT INTO `DanhSachVideo` VALUES (9, 2, 'https://www.youtube.com/watch?v=-USAeFpVf_A&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=2', '2014-03-30', '', 'HTML Tutorial for Beginners - 01 - Creating the first web page', '');
INSERT INTO `DanhSachVideo` VALUES (9, 3, 'https://www.youtube.com/watch?v=i3GE-toQg-o&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=3', '2014-03-31', '', 'HTML Tutorial for Beginners - 02 - Line breaks, spacing, and comments', '');
INSERT INTO `DanhSachVideo` VALUES (9, 4, 'https://www.youtube.com/watch?v=09oErCBjVns&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=4', '2015-06-05', '', 'HTML Tutorial for Beginners - 03 - Ordered and Unordered lists', '');
INSERT INTO `DanhSachVideo` VALUES (9, 5, 'https://www.youtube.com/watch?v=wvR40su_XBM&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=5', '2015-06-13', '', 'HTML Tutorial for Beginners - 04 - Creating a table', '');
INSERT INTO `DanhSachVideo` VALUES (9, 6, 'https://www.youtube.com/watch?v=U4UHoiK6Oo4&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=6', '2014-11-08', '', 'HTML Tutorial for Beginners - 05 - Creating a web link', '');
INSERT INTO `DanhSachVideo` VALUES (9, 7, 'https://www.youtube.com/watch?v=bCt2FnyY7AE&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=7', '2014-04-14', '', 'HTML Tutorial for Beginners - 06 - Creating links within same web page', '');
INSERT INTO `DanhSachVideo` VALUES (9, 8, 'https://www.youtube.com/watch?v=Zy4KJeVN7Gk&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=8', '2014-04-20', '', 'HTML Tutorial for Beginners - 07 - Adding a image to a web page', '');
INSERT INTO `DanhSachVideo` VALUES (9, 9, 'https://www.youtube.com/watch?v=dM12ctixdT4&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=9', '2014-04-20', '', 'HTML Tutorial for Beginners - 08 - Resizing and sizing images', '');
INSERT INTO `DanhSachVideo` VALUES (9, 10, 'https://www.youtube.com/watch?v=rO6_MZLIzCg&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=10', '2014-04-21', '', 'HTML Tutorial for Beginners - 09 - Nested elements', '');
INSERT INTO `DanhSachVideo` VALUES (9, 11, 'https://www.youtube.com/watch?v=wvU1mmJn_UI&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=11', '2015-05-31', '', 'HTML Tutorial for Beginners - 10 - One-line text box', '');
INSERT INTO `DanhSachVideo` VALUES (9, 12, 'https://www.youtube.com/watch?v=f9QXNFVlsls&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=12', '2015-05-31', '', 'HTML Tutorial for Beginners - 11 - Add label to text box', '');
INSERT INTO `DanhSachVideo` VALUES (9, 13, 'https://www.youtube.com/watch?v=onKF88kRK3Q&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=13', '2015-05-31', '', 'HTML Tutorial for Beginners - 12 - Multi-line text box', '');
INSERT INTO `DanhSachVideo` VALUES (9, 14, 'https://www.youtube.com/watch?v=NDAa6EaKce8&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=14', '2015-05-31', '', 'HTML Tutorial for Beginners - 13 - Radio buttons', '');
INSERT INTO `DanhSachVideo` VALUES (9, 15, 'https://www.youtube.com/watch?v=g4UAV1lIHyA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=15', '2015-06-01', '', 'HTML Tutorial for Beginners - 14 - Checkbox', '');
INSERT INTO `DanhSachVideo` VALUES (9, 16, 'https://www.youtube.com/watch?v=NPfy-hKOGfk&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=16', '2015-06-01', '', 'HTML Tutorial for Beginners - 15 - Number input box', '');
INSERT INTO `DanhSachVideo` VALUES (9, 17, 'https://www.youtube.com/watch?v=yWuAsqUnNsA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=17', '2015-12-26', '', 'HTML Tutorial for Beginners - 16 - Drop-down list', '');
INSERT INTO `DanhSachVideo` VALUES (9, 18, 'https://www.youtube.com/watch?v=H6BSr5UOg2Y&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=18', '2015-12-30', '', 'HTML Tutorial for Beginners - 17 - Date and number box', '');
INSERT INTO `DanhSachVideo` VALUES (9, 19, 'https://www.youtube.com/watch?v=x13Uxl6_dyw&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=19', '2016-09-02', '', 'HTML Tutorial for Beginners - 18 - Fieldbox and Legend elements', '');
INSERT INTO `DanhSachVideo` VALUES (9, 20, 'https://www.youtube.com/watch?v=iWWTtYGZ4YA&list=PLr6-GrHUlVf_ZNmuQSXdS197Oyr1L9sPB&index=20', '2015-06-06', '', 'HTML Tutorial for Beginners - 19 - Attributes', '');

INSERT INTO `DanhSachVideo` VALUES (10, 1, 'https://www.youtube.com/watch?v=nQeCtHxC93A&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=1', '2022-07-30', '', '#1 Introduction - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 2, 'https://www.youtube.com/watch?v=x2eoEZU5fIk&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=2', '2022-08-02', '', '#2 React App Setup Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 3, 'https://www.youtube.com/watch?v=Ifxr9bOdwxM&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=3', '2022-08-02', '', '#3 Navbar setup - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 4, 'https://www.youtube.com/watch?v=Y0Xep9cnxyY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=4', '2022-08-02', '', '#4 Node Server Setup - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 5, 'https://www.youtube.com/watch?v=7MMJrFWfbC4&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=5', '2022-08-02', '', '#5 Mongo DB Connection - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 6, 'https://www.youtube.com/watch?v=gpdEVZilQb4&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=6', '2022-08-03', '', '#6 Room Model - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 7, 'https://www.youtube.com/watch?v=CD5h69sijd0&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=7', '2022-08-03', '', '#7 Adding static data to Mongo DB Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 8, 'https://www.youtube.com/watch?v=tc4D8d_hrVc&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=8', '2022-08-03', '', '#8 Get all rooms Backend - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 9, 'https://www.youtube.com/watch?v=mnWmWTYk6OY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=9', '2022-08-03', '', '#9 Get all rooms Front-End - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 10, 'https://www.youtube.com/watch?v=0FDyeOBdjBY&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=10', '2022-08-05', '', '#10 Room model popup in Home screen - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 11, 'https://www.youtube.com/watch?v=58ot93tpomI&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=11', '2022-08-05', '', '#11 Home Screen Design Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 12, 'https://www.youtube.com/watch?v=on8p0I0OR0E&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=12', '2022-08-06', '', '#12 Booking Room Screen Front End - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 13, 'https://www.youtube.com/watch?v=BrndY4j3L2c&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=13', '2022-08-06', '', '#13 Booking Room Screen Backend - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 14, 'https://www.youtube.com/watch?v=AQ3bx-inALs&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=14', '2022-08-06', '', '#14 Success , Error , Loading components - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 15, 'https://www.youtube.com/watch?v=1GRSbdyTy1Y&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=15', '2022-08-07', '', '#15 Register , Login Screens Front End - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 16, 'https://www.youtube.com/watch?v=ywTKDsvm08c&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=16', '2022-08-07', '', '#16 Register , Login Backend - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 17, 'https://www.youtube.com/watch?v=ov5E45V6w8g&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=17', '2022-08-07', '', '#17 User Authentication Final - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 18, 'https://www.youtube.com/watch?v=yo2aEYxBthg&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=18', '2022-08-09', '', '#18 Dates Introduction - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 19, 'https://www.youtube.com/watch?v=wlec1z6GeIE&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=19', '2022-08-09', '', '#19 Booking Model - Full Stack Hotel Booking System React 2022-Premium Course', '');
INSERT INTO `DanhSachVideo` VALUES (10, 20, 'https://www.youtube.com/watch?v=4BX0KFaWzBU&list=PLflVqQLAWzC9qybF40gPXpzntMQIoYG5u&index=20', '2022-08-11', '', '#20 Booking a Room - Full Stack Hotel Booking System React 2022-Premium Course', '');

INSERT INTO `DanhSachVideo` VALUES (11, 1, 'https://www.youtube.com/watch?v=yOYnXoFvmj4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=1', '2020-11-11', '', 'How To Make An App for Beginners 2021 / SwiftUI - Lesson 1', '');
INSERT INTO `DanhSachVideo` VALUES (11, 2, 'https://www.youtube.com/watch?v=tPWUsSELJyY&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=2', '2020-11-13', '', 'How To Make An App - Xcode Tutorial (SwiftUI)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 3, 'https://www.youtube.com/watch?v=K6FXSVc-axM&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=3', '2020-11-17', '', 'Build User Interfaces with SwiftUI - Lesson 3 (How To Make An App)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 4, 'https://www.youtube.com/watch?v=wEF9AXy8-Sc&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=4', '2020-11-19', '', 'SwiftUI Essential Views and Containers - Lesson 4 (How To Make An App)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 5, 'https://www.youtube.com/watch?v=GqWgsWS4aL4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=5', '2020-11-24', '', 'How To Make An App - War Card Game UI Construction (Lesson 5)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 6, 'https://www.youtube.com/watch?v=72JNNU2otF4&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=6', '2020-11-26', '', 'Swift Programming Basics: View Update Lifecycle, Variables and Constants (Lesson 6)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 7, 'https://www.youtube.com/watch?v=ce6W9E82lOA&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=7', '2020-12-02', '', 'Swift Programming Basics: Functions (Lesson 7)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 8, 'https://www.youtube.com/watch?v=voviIrX7bXU&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=8', '2020-12-04', '', 'Swift Programming Basics: Structures (Lesson 8)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 9, 'https://www.youtube.com/watch?v=9KMaGxYTcEI&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=9', '2020-12-09', '', 'Swift Programming Basics: Instances (Lesson 9)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 10, 'https://www.youtube.com/watch?v=Xx9HjAB-Zz0&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=10', '2020-12-11', '', 'SwiftUI Buttons (Lesson 10)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 11, 'https://www.youtube.com/watch?v=2oT32JUH1s0&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=11', '2020-12-16', '', 'SwiftUI State Properties (Lesson 11 of 14)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 12, 'https://www.youtube.com/watch?v=kwz9-EjL7dY&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=12', '2020-12-18', '', 'Swift Programming - If Statements (Lesson 12 of 14)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 13, 'https://www.youtube.com/watch?v=zP1LFgBO8Jg&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=13', '2020-12-23', '', 'Bonus Challenge (Lesson 13)', '');
INSERT INTO `DanhSachVideo` VALUES (11, 14, 'https://www.youtube.com/watch?v=4Evf46kbB3c&list=PLMRqhzcHGw1YqPh-ggQHJPAUxdHov_uNJ&index=14', '2020-12-25', '', 'What’s Next? (14 Day SwiftUI Beginner Challenge)', '');

INSERT INTO `DanhSachVideo` VALUES (12, 1, 'https://youtu.be/7dAt-JMSCVQ', '2022-01-28', '', 'Flutter E-commerce App With Backend | Food Delivery App Development for iOS and Android | Part 1', '');
INSERT INTO `DanhSachVideo` VALUES (12, 2, 'https://youtu.be/GQJovou6zuE', '2022-02-17', '', 'Flutter Shop App With Backend | Delivery App Tutorial | Full Course With API | Part 2', '');
INSERT INTO `DanhSachVideo` VALUES (12, 3, 'https://youtu.be/qapb-_gMZRs', '2022-03-23', '', 'Flutter Ecommerce App With Laravel Backend | Part 3', '');
INSERT INTO `DanhSachVideo` VALUES (12, 4, 'https://youtu.be/sJoJVmk1M8Y', '2022-04-20', '', 'Flutter E-commerce App | Google Map | Get User Location On Selection | Zone Based Service | Part 4', '');
INSERT INTO `DanhSachVideo` VALUES (12, 5, 'https://youtu.be/5VZCpwcZ8dI', '2022-05-09', '', 'Flutter Food Delivery App | Payment With Paypal |Google Search Address | Part 5', '');
INSERT INTO `DanhSachVideo` VALUES (12, 6, 'https://youtu.be/Oggjb7ATVew', '2022-06-11', '', 'Flutter E-commerce App | Place Order & Order History | Shop App With Laravel Backend | Part 6', '');
INSERT INTO `DanhSachVideo` VALUES (12, 7, 'https://youtu.be/ROkGpSy78c0', '2022-07-18', '', 'Install Laravel admin Panel in Windows using Xampp server', '');
INSERT INTO `DanhSachVideo` VALUES (12, 8, 'https://youtu.be/jwTdm6fNx1I', '2022-09-20', '', 'Install Laravel Admin Panel for Mac', '');

INSERT INTO `DanhSachVideo` VALUES (13, 1, 'https://youtu.be/_ivIUCSOZ78', '2022-04-01', '', 'Build and Deploy Your First Modern React Native App | NFT Marketplace Course - Extremely Easy!', '');

INSERT INTO `DanhSachVideo` VALUES (14, 1, 'https://youtu.be/wJwsLVE1r8w', '2020-01-22', '', 'Part 01 React Native Tutorial Series for Beginners in Urdu/Hindi: Introduction | Cross-Platform Apps', '');
INSERT INTO `DanhSachVideo` VALUES (14, 2, 'https://youtu.be/zwP1ctb6k7M', '2020-01-23', '', 'Part 02 React Native Tutorial Series for Beginners in Urdu/Hindi: How To Use EXPO Development Tools', '');
INSERT INTO `DanhSachVideo` VALUES (14, 3, 'https://youtu.be/MjKcKYDg6S4', '2020-01-24', '', 'Part 03 React Native Tutorial Series for Beginners in Urdu/Hindi: Create a Mobile App with EXPO-CLI', '');
INSERT INTO `DanhSachVideo` VALUES (14, 4, 'https://youtu.be/VVzGahVaW6U', '2020-01-25', '', 'Part 04 React Native Tutorial Series for Beginners in Urdu/Hindi: Install React Native in Windows', '');
INSERT INTO `DanhSachVideo` VALUES (14, 5, 'https://youtu.be/gUueGj81T3U', '2020-01-26', '', 'Part 05 React Native Tutorial Series for Beginners in Urdu/Hindi: Install and Run, on Mac and Linux', '');
INSERT INTO `DanhSachVideo` VALUES (14, 6, 'https://youtu.be/DZyIxlXEPJ4', '2020-01-27', '', 'Part 06 React Native Tutorial Series for Beginners in Urdu/Hindi: Learn the Coding Basics of Expo', '');
INSERT INTO `DanhSachVideo` VALUES (14, 7, 'https://youtu.be/Osrg1in6g54', '2020-01-29', '', 'Part 07 React Native Tutorial Series for Beginners in Urdu/Hindi: Class Props vs Function Props', '');
INSERT INTO `DanhSachVideo` VALUES (14, 8, 'https://youtu.be/B2LZrVa-UtU', '2020-01-30', '', 'Part 08 React Native tutorial Series for Beginners in Urdu/Hindi: Function-Based & Class-Based State', '');
INSERT INTO `DanhSachVideo` VALUES (14, 9, 'https://youtu.be/_vaM3phHh6I', '2020-01-30', '', 'Part 09 React Native Tutorial Series for Beginners in Urdu/Hindi: Style Components with Flexbox CSS', '');
INSERT INTO `DanhSachVideo` VALUES (14, 10, 'https://youtu.be/p9_BObgP1DE', '2020-01-31', '', 'Part 10 React Native Tutorial Series for Beginners in Urdu/Hindi: Lets Build a Mobile App | Button', '');
INSERT INTO `DanhSachVideo` VALUES (14, 11, 'https://youtu.be/sA_VrlZkygU', '2020-02-02', '', 'Part 11 React Native Tutorial Series for Beginners in Urdu/Hindi: Lets Build a Simple Calculator', '');
INSERT INTO `DanhSachVideo` VALUES (14, 12, 'https://youtu.be/gJsOFtBPtt4', '2020-02-03', '', 'Part 12 React Native Tutorial Series for Beginners in Urdu/Hindi: Lets Create a Custom Touch Button', '');
INSERT INTO `DanhSachVideo` VALUES (14, 13, 'https://youtu.be/vcjX8owxWU8', '2020-02-05', '', 'Part 13 React Native Tutorial Series for Beginners in Urdu/Hindi: Lets Learn Platform Specific Code', '');
INSERT INTO `DanhSachVideo` VALUES (14, 14, 'https://youtu.be/7Qoop-weQs0', '2020-02-07', '', 'Part 14 React Native Tutorial Series for Beginners in Urdu/Hindi: lets Learn to Work With Images', '');
INSERT INTO `DanhSachVideo` VALUES (14, 15, 'https://youtu.be/iTgM-0NDAKY', '2020-02-10', '', 'Part 15 React Native Tutorial Series for Beginners in Urdu/Hindi: Lets Make Touchable Animated Fish', '');

INSERT INTO `DanhSachVideo` VALUES (15, 1, 'https://youtu.be/VPvVD8t02U8', '2022-02-24', '', 'Flutter Course for Beginners – 37-hour Cross Platform App Development Tutorial', '');

INSERT INTO `DanhSachVideo` VALUES (16, 1, 'https://youtu.be/QAbQgLGKd3Y', '2022-12-12', '', 'Android App Development for Beginners - 1 - Introduction', '');
INSERT INTO `DanhSachVideo` VALUES (16, 2, 'https://youtu.be/zEsDwzjPJ5c', '2022-12-12', '', 'Android App Development for Beginners - 2 - Installing Android Studio', '');
INSERT INTO `DanhSachVideo` VALUES (16, 3, 'https://youtu.be/r4oIez0sfvY', '2022-12-16', '', 'Android App Development for Beginners - 3 - Setting up Your Project', '');
INSERT INTO `DanhSachVideo` VALUES (16, 4, 'https://youtu.be/qKRWC3Q8wRw', '2022-12-16', '', 'Android App Development for Beginners - 4 - Running a Simple App', '');
INSERT INTO `DanhSachVideo` VALUES (16, 5, 'https://youtu.be/-pdTqBq2TFQ', '2022-12-16', '', 'Android App Development for Beginners - 5 - Tour of the Interface', '');
INSERT INTO `DanhSachVideo` VALUES (16, 6, 'https://youtu.be/OUCjk_n3raM', '2022-12-16', '', 'Android App Development for Beginners - 6 - Android Studio Tips', '');
INSERT INTO `DanhSachVideo` VALUES (16, 7, 'https://youtu.be/XWk5hKmgAmE', '2022-12-16', '', 'Android App Development for Beginners - 7 - Create a Custom AVD', '');
INSERT INTO `DanhSachVideo` VALUES (16, 8, 'https://youtu.be/9l1lfWAiHPg', '2022-12-19', '', 'Android App Development for Beginners - 8 - Basic Overview of an App', '');
INSERT INTO `DanhSachVideo` VALUES (16, 9, 'https://youtu.be/NMDPxN8FgXM', '2022-12-19', '', 'Android App Development for Beginners - 9 - Activity States', '');
INSERT INTO `DanhSachVideo` VALUES (16, 10, 'https://youtu.be/9LbETUPM_sY', '2022-12-19', '', 'Android App Development for Beginners - 10 - Running the State Changing Example', '');
INSERT INTO `DanhSachVideo` VALUES (16, 11, 'https://youtu.be/cOYzJN6A-JM', '2022-12-19', '', 'Android App Development for Beginners - 11 - Designing the User Interface', '');
INSERT INTO `DanhSachVideo` VALUES (16, 12, 'https://youtu.be/72mf0rmjNAA', '2022-12-19', '', 'Android App Development for Beginners - 12 - More on User Interface', '');
INSERT INTO `DanhSachVideo` VALUES (16, 13, 'https://youtu.be/MdOxtws4DsI', '2022-12-21', '', 'Android App Development for Beginners - 13 - Create an Interface with Java', '');
INSERT INTO `DanhSachVideo` VALUES (16, 14, 'https://youtu.be/RLDqbEhUjVk', '2022-12-21', '', 'Android App Development for Beginners - 14 - Adding Properties to Widgets', '');
INSERT INTO `DanhSachVideo` VALUES (16, 15, 'https://youtu.be/cXKsFHRG2_c', '2022-12-21', '', 'Android App Development for Beginners - 15 - Adding More Widgets', '');

INSERT INTO `DanhSachVideo` VALUES (17, 1, 'https://youtu.be/lBuj1zoij6Y', '2020-06-02', '', 'Lộ trình tự học lập trình di động (Android, iOS) cơ bản, siêu chi tiết', '');

INSERT INTO `DanhSachVideo` VALUES (18, 1, 'https://youtu.be/yOYnXoFvmj4', '2020-11-11', '', 'How To Make An App for Beginners 2021 / SwiftUI - Lesson 1', '');
INSERT INTO `DanhSachVideo` VALUES (18, 2, 'https://youtu.be/tPWUsSELJyY', '2020-11-13', '', 'How To Make An App - Xcode Tutorial (SwiftUI)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 3, 'https://youtu.be/K6FXSVc-axM', '2020-11-17', '', 'Build User Interfaces with SwiftUI - Lesson 3 (How To Make An App)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 4, 'https://youtu.be/wEF9AXy8-Sc', '2020-11-19', '', 'SwiftUI Essential Views and Containers - Lesson 4 (How To Make An App)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 5, 'https://youtu.be/GqWgsWS4aL4', '2020-11-24', '', 'How To Make An App - War Card Game UI Construction (Lesson 5)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 6, 'https://youtu.be/72JNNU2otF4', '2020-11-26', '', 'Swift Programming Basics: View Update Lifecycle, Variables and Constants (Lesson 6)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 7, 'https://youtu.be/ce6W9E82lOA', '2020-12-02', '', 'Swift Programming Basics: Functions (Lesson 7)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 8, 'https://youtu.be/voviIrX7bXU', '2020-12-04', '', 'Swift Programming Basics: Functions (Lesson 8)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 9, 'https://youtu.be/9KMaGxYTcEI', '2020-12-09', '', 'Swift Programming Basics: Functions (Lesson 9)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 10, 'https://youtu.be/Xx9HjAB-Zz0', '2020-12-11', '', 'SwiftUI Buttons (Lesson 10)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 11, 'https://youtu.be/2oT32JUH1s0', '2020-12-16', '', 'SwiftUI State Properties (Lesson 11 of 14)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 12, 'https://youtu.be/kwz9-EjL7dY', '2020-12-18', '', 'Swift Programming - If Statements (Lesson 12 of 14)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 13, 'https://youtu.be/zP1LFgBO8Jg', '2020-12-23', '', 'Bonus Challenge (Lesson 13)', '');
INSERT INTO `DanhSachVideo` VALUES (18, 14, 'https://youtu.be/4Evf46kbB3c', '2020-12-25', '', 'What’s Next? (14 Day SwiftUI Beginner Challenge)', '');

INSERT INTO `DanhSachVideo` VALUES (19, 1, 'https://youtu.be/npe3Wf4tpSg', '2021-02-14', '', 'Full React Native Project Tutorial for beginners.', '');

INSERT INTO `DanhSachVideo` VALUES (20, 1, 'https://youtu.be/zvp7wvbyceo', '2020-11-20', '', 'Xamarin Tutorial for Beginners - Build iOS & Android Apps with C#, Visual Studio, and Xamarin.Forms', '');
INSERT INTO `DanhSachVideo` VALUES (20, 2, 'https://youtu.be/7kVeC1_14Ag', '2020-11-27', '', 'Configuring & Optimizing Xamarin Projects - Smaller, Faster, Better Apps', '');
INSERT INTO `DanhSachVideo` VALUES (20, 3, 'https://youtu.be/nDfO74TXQUg', '2020-12-04', '', 'Managing & Updating Xamarin NuGet Packages Efficiently', '');
INSERT INTO `DanhSachVideo` VALUES (20, 4, 'https://youtu.be/cRvb9TCvB6c', '2020-12-18', '', 'Preparing a Xamarin.Forms Shell App for Development', '');
INSERT INTO `DanhSachVideo` VALUES (20, 5, 'https://youtu.be/GLfR2uosoSw', '2021-01-01', '', 'Xamarin.Forms XAML 101 + Hello World! (& .NET MAUI)', '');
INSERT INTO `DanhSachVideo` VALUES (20, 6, 'https://youtu.be/Pso1MeX_HvI', '2021-01-08', '', 'MVVM for Beginners: Model-View-ViewModel Architecture for Xamarin.Forms, .NET MAUI, WPF, UWP, & More', '');
INSERT INTO `DanhSachVideo` VALUES (20, 7, 'https://youtu.be/y8ZqEOLDeo8', '2021-01-22', '', 'Better MVVM with MVVM Helpers (or Xamarin Community Toolkit)', '');
INSERT INTO `DanhSachVideo` VALUES (20, 8, 'https://youtu.be/VzFqQv8YJNM', '2021-02-05', '', 'Xamarin.Forms ListView - Everything you need to know (& .NET MAUI)', '');
INSERT INTO `DanhSachVideo` VALUES (20, 9, 'https://youtu.be/71K4PVRLasI', '2021-02-12', '', 'MVVM for the Xamarin.Forms ListView', '');
INSERT INTO `DanhSachVideo` VALUES (20, 10, 'https://youtu.be/_lVM9gpFSbw', '2021-02-19', '', 'Xamarin.Forms ListView vs. CollectionView - Which to use and why!', '');
INSERT INTO `DanhSachVideo` VALUES (20, 11, 'https://youtu.be/7mpe_1okwxk', '2021-02-26', '', 'Turn any Event into a Command in Xamarin.Forms (MVVM All The Things)', '');
INSERT INTO `DanhSachVideo` VALUES (20, 12, 'https://youtu.be/XFP8Np-uRWc', '2021-03-04', '', 'How to Add a Database to Xamarin & .NET MAUI apps with SQLite-net', '');
INSERT INTO `DanhSachVideo` VALUES (20, 13, 'https://youtu.be/a37qBMt0V9w', '2021-03-18', '', 'REST Web Requests with Data Caching with ASP.NET Core Web API | Xamarin & .NET MAUI 101', '');
INSERT INTO `DanhSachVideo` VALUES (20, 14, 'https://youtu.be/8iYpLMKE_ws', '2021-04-08', '', 'Xamarin.Forms & .NET MAUI Shell Navigation for Beginners', '');
INSERT INTO `DanhSachVideo` VALUES (20, 15, 'https://youtu.be/ylbgWHB_gMI', '2021-04-22', '', 'Xamarin.Forms Shell Login Page Flow', '');
COMMIT;

DROP TABLE IF EXISTS `TaiKhoan`;
CREATE TABLE `TaiKhoan` (
                            `MaTaiKhoan` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                            `Username` VARCHAR(50)  NOT NULL,
                            `Password` VARCHAR(255)  NOT NULL,
                            `Name` VARCHAR(150) COLLATE utf8_general_ci NOT NULL,
                            `Email` VARCHAR(150) NOT NULL,
                            `DOB` DATE,
                            `LoaiTaiKhoan` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
                            `Avatar` VARCHAR(150) ,
                            `SDT` CHAR(10) ,
                            `DiaChi` VARCHAR(150),
                            `TinhTrang` INT UNSIGNED NOT NULL,
                            PRIMARY KEY (`MaTaiKhoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `TaiKhoan` VALUES (1, 'ndnamTeacher', '123', 'Nguyễn Đình Nam', 'ndnamPro@gmail.com', '1995-10-25', 'Giáo Viên', '1.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (2, 'vthapaTeacher', '123', 'Vijay Thapa', 'vThapaPro@gmail.com', '2000-12-16', 'Giáo Viên', '2.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (3, 'ranTeacher', '123', 'Ran', 'ranPro@gmail.com', '1990-05-01', 'Giáo Viên', '3.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (4, 'shaunTeacher', '123', 'Shaun', 'shaunPro@gmail.com', '1992-03-03', 'Giáo Viên', '4.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (5, 'dtsonTeacher', '123', 'Đặng Trường Sơn', 'dtrsonPro@gmail.com', '1996-10-20', 'Giáo Viên', '5.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (6, 'euniqaTeacher', '123', 'Euniqa', 'euniqaPro@gmail.com', '1991-11-12', 'Giáo Viên', '6.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (7, 'nsnguyenTeacher', '123', 'Ngô Sỹ Nguyên', 'nsnguyenPro@gmail.com', '1989-07-06', 'Giáo Viên', '7.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (8, 'mtjamalTeacher', '123', 'Mohd Touseef Jamal', 'mtjamalPro@gmail.com', '1997-12-18', 'Giáo Viên', '8.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (9, 'ejTeacher', '123', 'EJ', 'ejPro@gmail.com', '1988-08-13', 'Giáo Viên', '9.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (10, 'ksathyaTeacher', '123', 'Kudos Sathya', 'ksathyaPro@gmail.com', '2000-06-17', 'Giáo Viên', '10.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (11, 'CrishTeacher', '123', 'Crish', 'crishPro@gmail.com', '2003-12-16', 'Giáo Viên', '11.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (12, 'DastagirAhmedTeacher', '123', 'Dastagir Ahmed', 'info@dbestech.com', '1995-10-02', 'Giáo Viên', '12.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (13, 'AdrianHajdinTeacher', '123', 'Adrian Hajdin', 'contact@jsmasterypro.com', '1990-12-21', 'Giáo Viên', '13.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (14, 'ImranQasimTeacher', '123', 'Imran Qasim', 'itsmeleo.qureshi@gmail.com', '1989-06-17', 'Giáo Viên', '14.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (15, 'vandadTeacher', '123', 'Vandad Nahavandipoor', 'beau@freecodecamp.org', '1998-03-27', 'Giáo Viên', '15.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (16, 'buckyTeacher', '123', 'Bucky Roberts', 'thenewboston@.com', '1992-05-21', 'Giáo Viên', '16.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (17, 'phhoangTeacher', '123', 'Phạm Huy Hoàng', 'huyhoang8a5@gmail.com', '1998-11-11', 'Giáo Viên', '17.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (18, 'chrisTeacher', '123', 'Chris Ching', 'chris@codewithchris', '1994-09-21', 'Giáo Viên', '18.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (19, 'CryceTrulyTeacher', '123', 'Cryce Truly', 'crycetruly@gmail.com', '1993-11-30', 'Giáo Viên', '19.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (20, 'JamesMontemagnoTeacher', '123', 'James Montemagno', 'refractoredllc@gmail.com', '1994-02-07', 'Giáo Viên', '20.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (21, 'gojoSatoru', '123', 'Gojo Satoru', 'gojoCute@gmail.com', '2002-12-07', 'Học Viên', '21.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (22, 'uzumakiNaruto', '123', 'Uzumaki Naruto', 'narutoFun@gmail.com', '2003-09-29', 'Học Viên', '22.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (23, 'leviAckerman', '123', 'Levi Ackerman', 'leviCool@gmail.com', '2000-01-01', 'Học Viên', '23.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (24, 'kaitoKid', '123', 'Kaito Kid', 'kaito1412@gmail.com', '2001-12-14', 'Học Viên', '24.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (25, 'loidForger', '123', 'Loid Forger', 'loidSxf@gmail.com', '2002-05-01', 'Học Viên', '25.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (26, 'kenKaneki', '123', 'Ken Kaneki', 'kaneki1000_7@gmail.com', '2004-11-19', 'Học Viên', '26.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (27, 'todorokiShoto', '123', 'Todoroki Shoto', 'shotoBaka@gmail.com', '2005-04-03', 'Học Viên', '27.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (28, 'bakugoKatsuki', '123', 'Bakugo Katsuki', 'kacchanAngry@gmail.com', '2002-12-25', 'Học Viên', '28.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (29, 'sidKagenou', '123', 'Sid Kagenou', 'shadowClown@gmail.com', '2006-08-13', 'Học Viên', '29.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (30, 'sakamotoDesu', '123', 'Sakamoto Desu', 'sakamotoPerfect@gmail.com', '2003-06-01', 'Học Viên', '30.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (31, 'yukihiraSoma', '123', 'Yukihira Soma', 'somaCook@gmail.com', '2003-02-05', 'Học Viên', '31.jpg', '0123456789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (99, 'admin', '$2a$10$zKrIRVL0h9eBKUSxMDhzWOxOsNgKz83cetwYcBfh9qbnCPOSH3BVi', 'Yukihira Soma', 'somaCook23@gmail.com', '2003-02-05', 'Admin', '31.jpg', '0123496789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (98, 'student', '$2a$10$zKrIRVL0h9eBKUSxMDhzWOxOsNgKz83cetwYcBfh9qbnCPOSH3BVi', 'Uzumaki Naruto', 'somaCook273@gmail.com', '2003-02-05', 'Học Viên', '98.jpg', '0923496789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (97, 'student2', '$2a$10$zKrIRVL0h9eBKUSxMDhzWOxOsNgKz83cetwYcBfh9qbnCPOSH3BVi', 'Uchiha Sasuke', 'somaCook274@gmail.com', '2003-02-05', 'Học Viên', '97.jpg', '0823496789', '12345 TPHCM', 1);
INSERT INTO `TaiKhoan` VALUES (96, 'teacher', '$2a$10$zKrIRVL0h9eBKUSxMDhzWOxOsNgKz83cetwYcBfh9qbnCPOSH3BVi', 'Uzumaki Kushina', 'somaCook2qw3@gmail.com', '2003-02-05', 'Giáo Viên', '96.jpg', '0723496789', '12345 TPHCM', 1);

COMMIT;


DROP TABLE IF EXISTS `GiaoVien`;
CREATE TABLE `GiaoVien` (
                            `MaGiaoVien` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                            `MaTaiKhoan` INT UNSIGNED NOT NULL,
                            `SLKhoaHoc` int,
                            `MoTa` VARCHAR(250) COLLATE utf8_general_ci NOT NULL,
                            PRIMARY KEY (`MaGiaoVien`),
                            KEY `fk_giaovien_taikhoa_idx` (`MaTaiKhoan`),
                            CONSTRAINT `fk_giaovien_taikhoa` FOREIGN KEY (`MaTaiKhoan`) REFERENCES `TaiKhoan`(`MaTaiKhoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `GiaoVien` VALUES (1, 1, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (2, 2, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (3, 3, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (4, 4, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (5, 5, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (6, 6, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (7, 7, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (8, 8, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (9, 9, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (10, 10, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (11, 11, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (12, 12, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (13, 13, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (14, 14, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (15, 15, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (16, 16, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (17, 17, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (18, 18, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (19, 19, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (20, 20, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');
INSERT INTO `GiaoVien` VALUES (21, 96, 1, 'Trình độ tiến sĩ, Tốt nghiệp chunin loại xuất sắc, cấp bậc kage');

COMMIT;

DROP TABLE IF EXISTS `HocVien`;
CREATE TABLE `HocVien` (
                           `MaHocVien` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                           `MaTaiKhoan` INT UNSIGNED NOT NULL ,
                           `SLKhoaHoc` INT,
                           PRIMARY KEY (`MaHocVien`),
                           KEY `fk_hocvien_taikhoa_idx` (`MaTaiKhoan`),
                           CONSTRAINT `fk_hocvien_taikhoa` FOREIGN KEY (`MaTaiKhoan`) REFERENCES `TaiKhoan`(`MaTaiKhoan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `HocVien` VALUES (1, 21, 1);
INSERT INTO `HocVien` VALUES (2, 22, 3);
INSERT INTO `HocVien` VALUES (3, 23, 2);
INSERT INTO `HocVien` VALUES (4, 24, 0);
INSERT INTO `HocVien` VALUES (5, 25, 1);
INSERT INTO `HocVien` VALUES (6, 26, 0);
INSERT INTO `HocVien` VALUES (7, 27, 2);
INSERT INTO `HocVien` VALUES (8, 28, 2);
INSERT INTO `HocVien` VALUES (9, 29, 2);
INSERT INTO `HocVien` VALUES (10, 30, 0);
INSERT INTO `HocVien` VALUES (11, 31, 1);
INSERT INTO `HocVien` VALUES (12, 98, 0);
INSERT INTO `HocVien` VALUES (13, 97, 1);
COMMIT;

DROP TABLE IF EXISTS `BangDanhGia`;
CREATE TABLE `BangDanhGia` (
                               `MaHocVien` INT UNSIGNED NOT NULL,
                               `MaKhoaHoc` INT UNSIGNED NOT NULL,
                               `Rate` INT NULL,
                               `Comment` VARCHAR(250) COLLATE utf8_general_ci NOT NULL,
                               PRIMARY KEY (`MaHocVien`, `MaKhoaHoc`),
                               CONSTRAINT `fk_bangdanhgia_hocvien`
                                   FOREIGN KEY (`MaHocVien`)
                                       REFERENCES `HocVien`(`MaHocVien`),
                               CONSTRAINT `fk_bangdanhgia_khoahoc`
                                   FOREIGN KEY (`MaKhoaHoc`)
                                       REFERENCES `KhoaHoc`(`MaKhoaHoc`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;

Begin;
INSERT INTO `BangDanhGia` VALUES (1, 8, 4, 'This courses is very helpful. Thanks teacher a lot.');
INSERT INTO `BangDanhGia` VALUES (2, 8, 3, 'Good but I need more.');
INSERT INTO `BangDanhGia` VALUES (2, 15, 5, 'Wow. This courses open my mind. Excellent');
INSERT INTO `BangDanhGia` VALUES (2, 2, 3, 'Normal');
INSERT INTO `BangDanhGia` VALUES (3, 17, 5, 'Very Good');
INSERT INTO `BangDanhGia` VALUES (3, 15, 5, 'Your videos has been a blessing....thank you so much for the time and effort.');
INSERT INTO `BangDanhGia` VALUES (5, 6, 4, 'This courses is very helpful. Need to learn');
INSERT INTO `BangDanhGia` VALUES (7, 13, 3, 'Thank you for all this amazing courses');
INSERT INTO `BangDanhGia` VALUES (7, 14, 4, 'What can i say except Thank You ?!!');
INSERT INTO `BangDanhGia` VALUES (8, 11, 4, 'I appriaciate this course');
INSERT INTO `BangDanhGia` VALUES (8, 15, 4, 'so,so,so,so UNDERSTANDABLE,I love the way you explain,started to learn today ♥');
INSERT INTO `BangDanhGia` VALUES (9, 9, 3, 'Nice');
INSERT INTO `BangDanhGia` VALUES (9, 7, 3, 'Nice');
INSERT INTO `BangDanhGia` VALUES (11, 12, 3, 'Good');
COMMIT;

DROP TABLE IF EXISTS `DanhSachDangKi`;
CREATE TABLE `DanhSachDangKi` (
                                  `MaHocVien` INT UNSIGNED NOT NULL,
                                  `MaKhoaHoc` INT UNSIGNED NOT NULL,
                                  `NgayDangKy` DATE NOT NULL,
                                  `Note` VARCHAR(100) COLLATE utf8_general_ci NULL,
                                  PRIMARY KEY (`MaHocVien`, `MaKhoaHoc`),
                                  CONSTRAINT `fk_danhsachdangky_hocvien`
                                      FOREIGN KEY (`MaHocVien`)
                                          REFERENCES `HocVien` (`MaHocVien`),
                                  CONSTRAINT `fk_danhsachdangky_khoahoc`
                                      FOREIGN KEY (`MaKhoaHoc`)
                                          REFERENCES `KhoaHoc` (`MaKhoaHoc`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

BEGIN;
INSERT INTO `DanhSachDangKi` VALUES (1, 8, '2022-12-25', '');
INSERT INTO `DanhSachDangKi` VALUES (2, 8, '2022-12-25', '');
INSERT INTO `DanhSachDangKi` VALUES (2, 15, '2022-12-28', '');
INSERT INTO `DanhSachDangKi` VALUES (2, 2, '2022-12-21', '');
INSERT INTO `DanhSachDangKi` VALUES (3, 17, '2022-12-20', '');
INSERT INTO `DanhSachDangKi` VALUES (3, 15, '2022-12-20', '');
INSERT INTO `DanhSachDangKi` VALUES (5, 6, '2022-12-22', '');
INSERT INTO `DanhSachDangKi` VALUES (7, 13, '2022-12-27', '');
INSERT INTO `DanhSachDangKi` VALUES (7, 14, '2022-12-22', '');
INSERT INTO `DanhSachDangKi` VALUES (8, 11, '2022-12-21', '');
INSERT INTO `DanhSachDangKi` VALUES (8, 15, '2022-12-27', '');
INSERT INTO `DanhSachDangKi` VALUES (9, 9, '2022-12-22', '');
INSERT INTO `DanhSachDangKi` VALUES (9, 7, '2022-12-27', '');
INSERT INTO `DanhSachDangKi` VALUES (11, 12, '2022-12-29', '');

insert into danhsachdangki values(1, 2, '2022-12-25', 'No');
insert into danhsachdangki values(1, 15, '2022-12-25', 'No');
insert into danhsachdangki values(1, 4, '2022-12-25', 'No');
insert into danhsachdangki values(1, 7, '2022-12-25', 'No');
insert into danhsachdangki values(2, 4, '2022-12-25', 'No');
insert into danhsachdangki values(2, 7, '2022-12-25', 'No');
COMMIT;

DROP TABLE IF EXISTS `wishList`;
CREATE TABLE `wishList` (
                            `MaKhoaHoc` INT UNSIGNED NOT NULL,
                            `Username` VARCHAR(50)  NOT NULL,
														
								            PRIMARY KEY (`MakhoaHoc`,`Username`),
											 CONSTRAINT `fk_wl_kh` FOREIGN KEY (`MaKhoaHoc`) REFERENCES `khoahoc`(`MaKhoaHoc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE khoahoc
    ADD FULLTEXT(TenKhoaHoc, MoTaNgan);

SET FOREIGN_KEY_CHECKS = 0;