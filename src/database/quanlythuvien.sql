-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 16, 2025 at 04:52 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quanlythuvien`
--

-- --------------------------------------------------------

--
-- Table structure for table `doc_gia`
--

CREATE TABLE `doc_gia` (
  `ma_doc_gia` int NOT NULL,
  `ho_ten` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `dia_chi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dien_thoai` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ma_tk` int DEFAULT NULL COMMENT 'Liên kết với tài khoản đăng nhập (nếu có)',
  `ngay_cap_the` date NOT NULL DEFAULT (curdate()),
  `ngay_het_han_the` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doc_gia`
--

INSERT INTO `doc_gia` (`ma_doc_gia`, `ho_ten`, `ngay_sinh`, `dia_chi`, `dien_thoai`, `email`, `ma_tk`, `ngay_cap_the`, `ngay_het_han_the`) VALUES
(1, 'Nguyễn Văn A', '1995-01-10', 'Hà Nội', '0912345678', 'nguyenvana@email.com', 3, '2024-01-01', '2025-12-31'),
(2, 'Trần Thị B', '1998-05-12', 'TP HCM', '0987654321', 'tranthib@email.com', 4, '2024-01-01', '2025-12-31'),
(3, 'Lê Văn C', '2000-03-22', 'Đà Nẵng', '0909090909', 'levanc@email.com', NULL, '2024-02-15', '2026-02-14'),
(4, 'Nguyên', '2025-10-09', 'aa', '0987654322', 'test2@gmail.com', 7, '2025-10-16', '2026-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `nha_xuat_ban`
--

CREATE TABLE `nha_xuat_ban` (
  `ma_nxb` int NOT NULL,
  `ten_nxb` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dia_chi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nha_xuat_ban`
--

INSERT INTO `nha_xuat_ban` (`ma_nxb`, `ten_nxb`, `dia_chi`) VALUES
(1, 'NXB Trẻ', 'TP. Hồ Chí Minh'),
(2, 'NXB Giáo Dục', 'Hà Nội'),
(3, 'NXB Kim Đồng', 'Hà Nội'),
(4, 'NXB Văn Học', 'TP. HCM');

-- --------------------------------------------------------

--
-- Table structure for table `phieu_muon`
--

CREATE TABLE `phieu_muon` (
  `ma_phieu_muon` int NOT NULL,
  `ma_doc_gia` int NOT NULL,
  `ma_sach` int NOT NULL,
  `ngay_muon` date NOT NULL DEFAULT (curdate()),
  `ngay_hen_tra` date NOT NULL,
  `ngay_tra_thuc_te` date DEFAULT NULL,
  `trang_thai` enum('Đang mượn','Đã trả','Quá hạn') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Đang mượn',
  `tien_phat` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `phieu_muon`
--

INSERT INTO `phieu_muon` (`ma_phieu_muon`, `ma_doc_gia`, `ma_sach`, `ngay_muon`, `ngay_hen_tra`, `ngay_tra_thuc_te`, `trang_thai`, `tien_phat`) VALUES
(1, 1, 1, '2025-10-01', '2025-10-15', '2025-10-14', 'Đã trả', 0.00),
(2, 1, 3, '2025-10-05', '2025-10-20', NULL, 'Đang mượn', 0.00),
(3, 2, 1, '2025-09-01', '2025-09-15', '2025-09-20', 'Quá hạn', 10000.00);

-- --------------------------------------------------------

--
-- Table structure for table `sach`
--

CREATE TABLE `sach` (
  `ma_sach` int NOT NULL,
  `ten_sach` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ma_the_loai` int DEFAULT NULL,
  `ma_nxb` int DEFAULT NULL,
  `nam_xb` smallint DEFAULT NULL,
  `gia_bia` decimal(12,2) DEFAULT '0.00',
  `so_luong` int NOT NULL DEFAULT '0' COMMENT 'Tổng số lượng sách này trong thư viện',
  `so_luong_con_lai` int NOT NULL DEFAULT '0' COMMENT 'Số lượng sẵn có để cho mượn'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sach`
--

INSERT INTO `sach` (`ma_sach`, `ten_sach`, `ma_the_loai`, `ma_nxb`, `nam_xb`, `gia_bia`, `so_luong`, `so_luong_con_lai`) VALUES
(1, 'Lập trình Java cơ bản', 1, 1, 2020, 120000.00, 10, 8),
(2, 'Harry Potter và Hòn đá phù thủy', 2, 3, 2001, 180000.00, 5, 5),
(3, 'Dế mèn phiêu lưu ký', 6, 3, 2000, 85000.00, 15, 12),
(4, 'Đắc nhân tâm', 5, 4, 2008, 95000.00, 20, 20);

-- --------------------------------------------------------

--
-- Table structure for table `sach_tac_gia`
--

CREATE TABLE `sach_tac_gia` (
  `ma_sach` int NOT NULL,
  `ma_tac_gia` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sach_tac_gia`
--

INSERT INTO `sach_tac_gia` (`ma_sach`, `ma_tac_gia`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tac_gia`
--

CREATE TABLE `tac_gia` (
  `ma_tac_gia` int NOT NULL,
  `ten_tac_gia` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quoc_tich` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tac_gia`
--

INSERT INTO `tac_gia` (`ma_tac_gia`, `ten_tac_gia`, `quoc_tich`) VALUES
(1, 'Nguyễn Nhật Ánh', 'Việt Nam'),
(2, 'J.K. Rowling', 'Anh'),
(3, 'Tô Hoài', 'Việt Nam'),
(4, 'Dale Carnegie', 'Mỹ');

-- --------------------------------------------------------

--
-- Table structure for table `taikhoan`
--

CREATE TABLE `taikhoan` (
  `ma_tk` int NOT NULL,
  `ten_dang_nhap` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mat_khau` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Lưu mật khẩu đã được băm (hashed)',
  `vai_tro` enum('ADMIN','NHANVIEN','DOCGIA') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DOCGIA'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taikhoan`
--

INSERT INTO `taikhoan` (`ma_tk`, `ten_dang_nhap`, `mat_khau`, `vai_tro`) VALUES
(1, 'admin', '$2y$10$abc...', 'ADMIN'),
(2, 'nhanvien1', '$2y$10$def...', 'NHANVIEN'),
(3, 'docgia_a', '$2y$10$ghi...', 'DOCGIA'),
(4, 'docgia_b', '$2y$10$jkl...', 'DOCGIA'),
(5, 'admin123456', '$2a$12$YpXdU2hCiRFBj8Hp9ji9Zu3gwET0eImqJ0bFrf04LnTQ8I0IedyQ6', 'NHANVIEN'),
(6, 'admin1212', '$2a$12$7ECksv9XR05l8YUXNy.U1eEpHS0yXrkBvjZm3J.CJzJ6NFcPzKOXi', 'NHANVIEN'),
(7, 'admin12121', '$2a$12$3ogm9thBRbUyaNCdDWPY5e7UuGx2RBL5bSRKZWy3RPRzn0OSll6Ni', 'DOCGIA');

-- --------------------------------------------------------

--
-- Table structure for table `the_loai`
--

CREATE TABLE `the_loai` (
  `ma_the_loai` int NOT NULL,
  `ten_the_loai` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `the_loai`
--

INSERT INTO `the_loai` (`ma_the_loai`, `ten_the_loai`) VALUES
(1, 'Công nghệ thông tin'),
(4, 'Khoa học'),
(5, 'Kinh tế'),
(3, 'Lịch sử'),
(6, 'Thiếu nhi'),
(2, 'Văn học kinh điển');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doc_gia`
--
ALTER TABLE `doc_gia`
  ADD PRIMARY KEY (`ma_doc_gia`),
  ADD UNIQUE KEY `uq_dien_thoai` (`dien_thoai`),
  ADD UNIQUE KEY `uq_email` (`email`),
  ADD KEY `fk_doc_gia_taikhoan_idx` (`ma_tk`);

--
-- Indexes for table `nha_xuat_ban`
--
ALTER TABLE `nha_xuat_ban`
  ADD PRIMARY KEY (`ma_nxb`),
  ADD UNIQUE KEY `uq_ten_nxb` (`ten_nxb`);

--
-- Indexes for table `phieu_muon`
--
ALTER TABLE `phieu_muon`
  ADD PRIMARY KEY (`ma_phieu_muon`),
  ADD KEY `fk_phieu_muon_doc_gia_idx` (`ma_doc_gia`),
  ADD KEY `fk_phieu_muon_sach_idx` (`ma_sach`);

--
-- Indexes for table `sach`
--
ALTER TABLE `sach`
  ADD PRIMARY KEY (`ma_sach`),
  ADD KEY `fk_sach_the_loai_idx` (`ma_the_loai`),
  ADD KEY `fk_sach_nxb_idx` (`ma_nxb`);

--
-- Indexes for table `sach_tac_gia`
--
ALTER TABLE `sach_tac_gia`
  ADD PRIMARY KEY (`ma_sach`,`ma_tac_gia`),
  ADD KEY `fk_sach_tac_gia_tac_gia_idx` (`ma_tac_gia`);

--
-- Indexes for table `tac_gia`
--
ALTER TABLE `tac_gia`
  ADD PRIMARY KEY (`ma_tac_gia`);

--
-- Indexes for table `taikhoan`
--
ALTER TABLE `taikhoan`
  ADD PRIMARY KEY (`ma_tk`),
  ADD UNIQUE KEY `uq_ten_dang_nhap` (`ten_dang_nhap`);

--
-- Indexes for table `the_loai`
--
ALTER TABLE `the_loai`
  ADD PRIMARY KEY (`ma_the_loai`),
  ADD UNIQUE KEY `uq_ten_the_loai` (`ten_the_loai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doc_gia`
--
ALTER TABLE `doc_gia`
  MODIFY `ma_doc_gia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `nha_xuat_ban`
--
ALTER TABLE `nha_xuat_ban`
  MODIFY `ma_nxb` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `phieu_muon`
--
ALTER TABLE `phieu_muon`
  MODIFY `ma_phieu_muon` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sach`
--
ALTER TABLE `sach`
  MODIFY `ma_sach` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tac_gia`
--
ALTER TABLE `tac_gia`
  MODIFY `ma_tac_gia` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `taikhoan`
--
ALTER TABLE `taikhoan`
  MODIFY `ma_tk` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `the_loai`
--
ALTER TABLE `the_loai`
  MODIFY `ma_the_loai` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doc_gia`
--
ALTER TABLE `doc_gia`
  ADD CONSTRAINT `fk_doc_gia_taikhoan` FOREIGN KEY (`ma_tk`) REFERENCES `taikhoan` (`ma_tk`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `phieu_muon`
--
ALTER TABLE `phieu_muon`
  ADD CONSTRAINT `fk_phieu_muon_doc_gia` FOREIGN KEY (`ma_doc_gia`) REFERENCES `doc_gia` (`ma_doc_gia`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_phieu_muon_sach` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`ma_sach`) ON DELETE CASCADE;

--
-- Constraints for table `sach`
--
ALTER TABLE `sach`
  ADD CONSTRAINT `fk_sach_nxb` FOREIGN KEY (`ma_nxb`) REFERENCES `nha_xuat_ban` (`ma_nxb`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_sach_the_loai` FOREIGN KEY (`ma_the_loai`) REFERENCES `the_loai` (`ma_the_loai`) ON DELETE SET NULL;

--
-- Constraints for table `sach_tac_gia`
--
ALTER TABLE `sach_tac_gia`
  ADD CONSTRAINT `fk_sach_tac_gia_sach` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`ma_sach`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_sach_tac_gia_tac_gia` FOREIGN KEY (`ma_tac_gia`) REFERENCES `tac_gia` (`ma_tac_gia`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
