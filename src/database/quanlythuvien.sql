-- Cài đặt môi trường
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00"; -- Đặt múi giờ Việt Nam

--
-- Database: `quanlythuvien`
--
DROP DATABASE IF EXISTS `quanlythuvien`;
CREATE DATABASE `quanlythuvien` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `quanlythuvien`;

-- --------------------------------------------------------

--
-- Bảng: `taikhoan` (Accounts)
--
CREATE TABLE `taikhoan` (
  `ma_tk` INT NOT NULL AUTO_INCREMENT,
  `ten_dang_nhap` VARCHAR(50) NOT NULL,
  `mat_khau` VARCHAR(255) NOT NULL COMMENT 'Lưu mật khẩu đã được băm (hashed)',
  `vai_tro` ENUM('ADMIN', 'NHANVIEN', 'DOCGIA') NOT NULL DEFAULT 'DOCGIA',
  PRIMARY KEY (`ma_tk`),
  UNIQUE KEY `uq_ten_dang_nhap` (`ten_dang_nhap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `doc_gia` (Readers) - Đã gộp thông tin thẻ thư viện
--
CREATE TABLE `doc_gia` (
  `ma_doc_gia` INT NOT NULL AUTO_INCREMENT,
  `ho_ten` VARCHAR(100) NOT NULL,
  `ngay_sinh` DATE DEFAULT NULL,
  `dia_chi` VARCHAR(255) DEFAULT NULL,
  `dien_thoai` VARCHAR(15) DEFAULT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `ma_tk` INT DEFAULT NULL COMMENT 'Liên kết với tài khoản đăng nhập (nếu có)',
  `ngay_cap_the` DATE NOT NULL DEFAULT (CURRENT_DATE),
  `ngay_het_han_the` DATE NOT NULL,
  PRIMARY KEY (`ma_doc_gia`),
  UNIQUE KEY `uq_dien_thoai` (`dien_thoai`),
  UNIQUE KEY `uq_email` (`email`),
  KEY `fk_doc_gia_taikhoan_idx` (`ma_tk`),
  CONSTRAINT `fk_doc_gia_taikhoan` FOREIGN KEY (`ma_tk`) REFERENCES `taikhoan` (`ma_tk`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `nha_xuat_ban` (Publishers)
--
CREATE TABLE `nha_xuat_ban` (
  `ma_nxb` INT NOT NULL AUTO_INCREMENT,
  `ten_nxb` VARCHAR(100) NOT NULL,
  `dia_chi` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`ma_nxb`),
  UNIQUE KEY `uq_ten_nxb` (`ten_nxb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `the_loai` (Categories)
--
CREATE TABLE `the_loai` (
  `ma_the_loai` INT NOT NULL AUTO_INCREMENT,
  `ten_the_loai` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ma_the_loai`),
  UNIQUE KEY `uq_ten_the_loai` (`ten_the_loai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `tac_gia` (Authors)
--
CREATE TABLE `tac_gia` (
  `ma_tac_gia` INT NOT NULL AUTO_INCREMENT,
  `ten_tac_gia` VARCHAR(100) NOT NULL,
  `quoc_tich` VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`ma_tac_gia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `sach` (Books)
--
CREATE TABLE `sach` (
  `ma_sach` INT NOT NULL AUTO_INCREMENT,
  `ten_sach` VARCHAR(200) NOT NULL,
  `ma_the_loai` INT DEFAULT NULL,
  `ma_nxb` INT DEFAULT NULL,
  `nam_xb` SMALLINT DEFAULT NULL,
  `gia_bia` DECIMAL(12,2) DEFAULT 0.00,
  `so_luong` INT NOT NULL DEFAULT 0 COMMENT 'Tổng số lượng sách này trong thư viện',
  `so_luong_con_lai` INT NOT NULL DEFAULT 0 COMMENT 'Số lượng sẵn có để cho mượn',
  PRIMARY KEY (`ma_sach`),
  KEY `fk_sach_the_loai_idx` (`ma_the_loai`),
  KEY `fk_sach_nxb_idx` (`ma_nxb`),
  CONSTRAINT `fk_sach_the_loai` FOREIGN KEY (`ma_the_loai`) REFERENCES `the_loai` (`ma_the_loai`) ON DELETE SET NULL,
  CONSTRAINT `fk_sach_nxb` FOREIGN KEY (`ma_nxb`) REFERENCES `nha_xuat_ban` (`ma_nxb`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng trung gian `sach_tac_gia` (Book-Author relationship)
--
CREATE TABLE `sach_tac_gia` (
  `ma_sach` INT NOT NULL,
  `ma_tac_gia` INT NOT NULL,
  PRIMARY KEY (`ma_sach`, `ma_tac_gia`),
  KEY `fk_sach_tac_gia_tac_gia_idx` (`ma_tac_gia`),
  CONSTRAINT `fk_sach_tac_gia_sach` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`ma_sach`) ON DELETE CASCADE,
  CONSTRAINT `fk_sach_tac_gia_tac_gia` FOREIGN KEY (`ma_tac_gia`) REFERENCES `tac_gia` (`ma_tac_gia`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Bảng: `phieu_muon` (Borrowing Slips)
--
CREATE TABLE `phieu_muon` (
  `ma_phieu_muon` INT NOT NULL AUTO_INCREMENT,
  `ma_doc_gia` INT NOT NULL,
  `ma_sach` INT NOT NULL,
  `ngay_muon` DATE NOT NULL DEFAULT (CURRENT_DATE),
  `ngay_hen_tra` DATE NOT NULL,
  `ngay_tra_thuc_te` DATE DEFAULT NULL,
  `trang_thai` ENUM('Đang mượn', 'Đã trả', 'Quá hạn') NOT NULL DEFAULT 'Đang mượn',
  `tien_phat` DECIMAL(10,2) DEFAULT 0.00,
  PRIMARY KEY (`ma_phieu_muon`),
  KEY `fk_phieu_muon_doc_gia_idx` (`ma_doc_gia`),
  KEY `fk_phieu_muon_sach_idx` (`ma_sach`),
  CONSTRAINT `fk_phieu_muon_doc_gia` FOREIGN KEY (`ma_doc_gia`) REFERENCES `doc_gia` (`ma_doc_gia`) ON DELETE CASCADE,
  CONSTRAINT `fk_phieu_muon_sach` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`ma_sach`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
--            THÊM DỮ LIỆU MẪU (DUMPING DATA)
-- --------------------------------------------------------

-- Chèn dữ liệu cho `taikhoan`
-- LƯU Ý QUAN TRỌNG: Mật khẩu phải được HASH ở phía ứng dụng trước khi lưu.
-- Ví dụ dưới đây dùng mật khẩu giả, bạn phải thay thế bằng mật khẩu đã hash.
INSERT INTO `taikhoan` (`ma_tk`, `ten_dang_nhap`, `mat_khau`, `vai_tro`) VALUES
(1, 'admin', '$2y$10$abc...', 'ADMIN'), -- Mật khẩu đã được hash
(2, 'nhanvien1', '$2y$10$def...', 'NHANVIEN'),
(3, 'docgia_a', '$2y$10$ghi...', 'DOCGIA'),
(4, 'docgia_b', '$2y$10$jkl...', 'DOCGIA');

-- Chèn dữ liệu cho `doc_gia`
INSERT INTO `doc_gia` (`ho_ten`, `ngay_sinh`, `dia_chi`, `dien_thoai`, `email`, `ma_tk`, `ngay_cap_the`, `ngay_het_han_the`) VALUES
('Nguyễn Văn A', '1995-01-10', 'Hà Nội', '0912345678', 'nguyenvana@email.com', 3, '2024-01-01', '2025-12-31'),
('Trần Thị B', '1998-05-12', 'TP HCM', '0987654321', 'tranthib@email.com', 4, '2024-01-01', '2025-12-31'),
('Lê Văn C', '2000-03-22', 'Đà Nẵng', '0909090909', 'levanc@email.com', NULL, '2024-02-15', '2026-02-14');

-- Chèn dữ liệu cho `nha_xuat_ban`
INSERT INTO `nha_xuat_ban` (`ten_nxb`, `dia_chi`) VALUES
('NXB Trẻ', 'TP. Hồ Chí Minh'),
('NXB Giáo Dục', 'Hà Nội'),
('NXB Kim Đồng', 'Hà Nội'),
('NXB Văn Học', 'TP. HCM');

-- Chèn dữ liệu cho `the_loai`
INSERT INTO `the_loai` (`ten_the_loai`) VALUES
('Công nghệ thông tin'), ('Văn học kinh điển'), ('Lịch sử'), ('Khoa học'), ('Kinh tế'), ('Thiếu nhi');

-- Chèn dữ liệu cho `tac_gia`
INSERT INTO `tac_gia` (`ten_tac_gia`, `quoc_tich`) VALUES
('Nguyễn Nhật Ánh', 'Việt Nam'), ('J.K. Rowling', 'Anh'), ('Tô Hoài', 'Việt Nam'), ('Dale Carnegie', 'Mỹ');

-- Chèn dữ liệu cho `sach`
INSERT INTO `sach` (`ten_sach`, `ma_the_loai`, `ma_nxb`, `nam_xb`, `gia_bia`, `so_luong`, `so_luong_con_lai`) VALUES
('Lập trình Java cơ bản', 1, 1, 2020, 120000.00, 10, 8),
('Harry Potter và Hòn đá phù thủy', 2, 3, 2001, 180000.00, 5, 5),
('Dế mèn phiêu lưu ký', 6, 3, 2000, 85000.00, 15, 12),
('Đắc nhân tâm', 5, 4, 2008, 95000.00, 20, 20);

-- Chèn dữ liệu cho `sach_tac_gia`
INSERT INTO `sach_tac_gia` (`ma_sach`, `ma_tac_gia`) VALUES
(1, 1), -- Giả sử
(2, 2),
(3, 3),
(4, 4);

-- Chèn dữ liệu cho `phieu_muon`
-- Giả sử độc giả 1 mượn 2 cuốn sách
INSERT INTO `phieu_muon` (`ma_doc_gia`, `ma_sach`, `ngay_muon`, `ngay_hen_tra`, `ngay_tra_thuc_te`, `trang_thai`) VALUES
(1, 1, '2025-10-01', '2025-10-15', '2025-10-14', 'Đã trả'),
(1, 3, '2025-10-05', '2025-10-20', NULL, 'Đang mượn');
-- Giả sử độc giả 2 mượn 1 cuốn
INSERT INTO `phieu_muon` (`ma_doc_gia`, `ma_sach`, `ngay_muon`, `ngay_hen_tra`, `ngay_tra_thuc_te`, `trang_thai`, `tien_phat`) VALUES
(2, 1, '2025-09-01', '2025-09-15', '2025-09-20', 'Quá hạn', 10000.00);


COMMIT;