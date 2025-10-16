-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: quanlythuvien
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `docgia`
--

DROP TABLE IF EXISTS `docgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docgia` (
  `MaDocGia` int NOT NULL,
  `HoTen` varchar(100) DEFAULT NULL,
  `NgaySinh` date DEFAULT NULL,
  `DiaChi` varchar(200) DEFAULT NULL,
  `DienThoai` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`MaDocGia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docgia`
--

LOCK TABLES `docgia` WRITE;
/*!40000 ALTER TABLE `docgia` DISABLE KEYS */;
INSERT INTO `docgia` VALUES (1,'Nguyen Van A','1995-01-10','Hà Nội','0912345678'),(2,'Tran Thi B','1998-05-12','TP HCM','0987654321'),(3,'Le Van C','2000-03-22','Đà Nẵng','0909090909'),(4,'Pham Thi D','1997-07-11','Hải Phòng','0933333333'),(5,'Hoang Van E','1999-09-09','Cần Thơ','0944444444'),(6,'Nguyen Thi F','2001-04-14','Huế','0955555555'),(7,'Do Van G','1994-12-20','Hà Nội','0966666666'),(8,'Nguyen Thi H','1996-06-30','Nghệ An','0977777777'),(9,'Bui Van I','2002-11-25','Quảng Ninh','0988888888'),(10,'Vu Thi J','1993-10-05','Hà Nội','0999999999'),(11,'Pham Van K','1995-08-15','Hà Tĩnh','0912121212'),(12,'Do Thi L','1997-03-18','Hà Nội','0923232323'),(13,'Hoang Van M','1998-11-09','Nam Định','0934343434'),(14,'Le Thi N','1996-01-01','Hà Nội','0945454545'),(15,'Nguyen Van O','1994-05-05','Thanh Hóa','0956565656'),(16,'Tran Thi P','1999-09-19','Hà Nội','0967676767'),(17,'Bui Van Q','2000-12-12','Hải Dương','0978787878'),(18,'Nguyen Thi R','1998-07-07','Hà Nội','0989898989'),(19,'Pham Van S','1997-02-02','Bắc Giang','0990909090'),(20,'Do Thi T','1995-03-03','Hà Nội','0910101010');
/*!40000 ALTER TABLE `docgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `muontra`
--

DROP TABLE IF EXISTS `muontra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `muontra` (
  `MaMuon` int NOT NULL,
  `MaThe` int DEFAULT NULL,
  `MaSach` int DEFAULT NULL,
  `NgayMuon` date DEFAULT NULL,
  `NgayHenTra` date DEFAULT NULL,
  `NgayTra` date DEFAULT NULL,
  PRIMARY KEY (`MaMuon`),
  KEY `MaThe` (`MaThe`),
  KEY `MaSach` (`MaSach`),
  CONSTRAINT `muontra_ibfk_1` FOREIGN KEY (`MaThe`) REFERENCES `thethuvien` (`MaThe`),
  CONSTRAINT `muontra_ibfk_2` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `muontra`
--

LOCK TABLES `muontra` WRITE;
/*!40000 ALTER TABLE `muontra` DISABLE KEYS */;
INSERT INTO `muontra` VALUES (1,1,1,'2025-01-01','2025-01-15','2025-01-14'),(2,2,2,'2025-01-05','2025-01-20','2025-01-25'),(3,3,3,'2025-02-01','2025-02-15','2025-02-16'),(4,4,4,'2025-02-10','2025-02-25','2025-02-24'),(5,5,5,'2025-03-01','2025-03-15',NULL),(6,6,6,'2025-03-05','2025-03-20','2025-03-22'),(7,7,7,'2025-03-10','2025-03-25','2025-03-24'),(8,8,8,'2025-04-01','2025-04-15','2025-04-20'),(9,9,9,'2025-04-05','2025-04-20','2025-04-19'),(10,10,10,'2025-04-10','2025-04-25','2025-04-26'),(11,11,11,'2025-05-01','2025-05-15','2025-05-15'),(12,12,12,'2025-05-05','2025-05-20',NULL),(13,13,13,'2025-06-01','2025-06-15','2025-06-18'),(14,14,14,'2025-06-10','2025-06-25','2025-06-24'),(15,15,15,'2025-07-01','2025-07-15','2025-07-16'),(16,16,16,'2025-07-05','2025-07-20','2025-07-19'),(17,17,17,'2025-08-01','2025-08-15','2025-08-14'),(18,18,18,'2025-08-10','2025-08-25','2025-08-30'),(19,19,19,'2025-09-01','2025-09-15',NULL),(20,20,20,'2025-09-05','2025-09-20','2025-09-21'),(21,1,21,'2025-09-10','2025-09-25','2025-09-26'),(22,2,22,'2025-10-01','2025-10-15','2025-10-17'),(23,3,23,'2025-10-05','2025-10-20',NULL),(24,4,24,'2025-10-10','2025-10-25','2025-10-30'),(25,5,25,'2025-11-01','2025-11-15','2025-11-16'),(26,6,26,'2025-11-05','2025-11-20','2025-11-20'),(27,7,27,'2025-12-01','2025-12-15',NULL),(28,8,28,'2025-12-05','2025-12-20','2025-12-25'),(29,9,29,'2025-12-10','2025-12-25','2025-12-24'),(30,10,30,'2025-12-20','2025-12-31','2025-12-31');
/*!40000 ALTER TABLE `muontra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nxb`
--

DROP TABLE IF EXISTS `nxb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nxb` (
  `MaNXB` int NOT NULL,
  `TenNXB` varchar(100) NOT NULL,
  `DiaChi` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`MaNXB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nxb`
--

LOCK TABLES `nxb` WRITE;
/*!40000 ALTER TABLE `nxb` DISABLE KEYS */;
INSERT INTO `nxb` VALUES (1,'NXB Trẻ','TP. Hồ Chí Minh'),(2,'NXB Giáo Dục','Hà Nội'),(3,'NXB Khoa Học','Hà Nội'),(4,'NXB Văn Học','TP. HCM'),(5,'NXB Lao Động','Hà Nội'),(6,'NXB Y Học','Hà Nội'),(7,'NXB Kinh Tế','TP. HCM'),(8,'NXB Kim Đồng','Hà Nội');
/*!40000 ALTER TABLE `nxb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sach`
--

DROP TABLE IF EXISTS `sach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sach` (
  `MaSach` int NOT NULL,
  `TenSach` varchar(200) NOT NULL,
  `NamXB` int DEFAULT NULL,
  `MaTheLoai` int DEFAULT NULL,
  `MaNXB` int DEFAULT NULL,
  `Gia` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`MaSach`),
  KEY `MaTheLoai` (`MaTheLoai`),
  KEY `MaNXB` (`MaNXB`),
  CONSTRAINT `sach_ibfk_1` FOREIGN KEY (`MaTheLoai`) REFERENCES `theloai` (`MaTheLoai`),
  CONSTRAINT `sach_ibfk_2` FOREIGN KEY (`MaNXB`) REFERENCES `nxb` (`MaNXB`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sach`
--

LOCK TABLES `sach` WRITE;
/*!40000 ALTER TABLE `sach` DISABLE KEYS */;
INSERT INTO `sach` VALUES (1,'Lập trình Java cơ bản',2020,1,1,120000.00),(2,'Cấu trúc dữ liệu và giải thuật',2019,1,2,150000.00),(3,'Truyện Kiều',2005,2,4,80000.00),(4,'Lịch sử Việt Nam',2018,3,3,130000.00),(5,'Giải tích 1',2021,5,2,110000.00),(6,'Tâm lý học đại cương',2017,9,5,95000.00),(7,'Harry Potter và Hòn đá phù thủy',2001,2,8,180000.00),(8,'Harry Potter và Phòng chứa bí mật',2002,2,8,180000.00),(9,'Harry Potter và Tù nhân ngục Azkaban',2003,2,8,180000.00),(10,'Harry Potter và Chiếc cốc lửa',2004,2,8,180000.00),(11,'Harry Potter và Hội Phượng Hoàng',2005,2,8,180000.00),(12,'Harry Potter và Hoàng tử lai',2006,2,8,180000.00),(13,'Harry Potter và Bảo bối tử thần',2007,2,8,180000.00),(14,'Đắc nhân tâm',2008,9,7,95000.00),(15,'Tư bản luận',2010,6,7,200000.00),(16,'Lịch sử thế giới',2015,3,3,170000.00),(17,'Nhà giả kim',2011,2,4,100000.00),(18,'Dế mèn phiêu lưu ký',2000,10,8,85000.00),(19,'Toán cao cấp tập 1',2016,5,2,140000.00),(20,'Kinh tế học vĩ mô',2018,6,7,160000.00),(21,'Sức khỏe & đời sống',2017,8,6,120000.00),(22,'Vật lý lượng tử',2014,4,3,180000.00),(23,'Thiên văn học cho mọi người',2019,4,3,150000.00),(24,'Tiếng Anh giao tiếp',2020,7,2,90000.00),(25,'Ngữ pháp tiếng Anh',2018,7,2,95000.00),(26,'Lập trình Python nâng cao',2021,1,1,130000.00),(27,'Thuật toán máy học',2022,1,3,200000.00),(28,'Giải tích 2',2020,5,2,120000.00),(29,'Đại số tuyến tính',2019,5,2,125000.00),(30,'Phân tích dữ liệu',2021,1,1,170000.00),(31,'Văn học hiện đại Việt Nam',2016,2,4,100000.00),(32,'Chí Phèo',2005,2,4,70000.00),(33,'Số đỏ',2004,2,4,75000.00),(34,'Ông già và biển cả',1990,2,4,85000.00),(35,'Romeo và Juliet',1995,2,4,90000.00),(36,'Hamlet',1998,2,4,95000.00),(37,'Giấc mơ Mỹ',2013,2,4,110000.00),(38,'Phân tâm học nhập môn',2012,9,5,130000.00),(39,'Phương pháp nghiên cứu khoa học',2018,4,3,145000.00),(40,'Y học cổ truyền',2016,8,6,140000.00),(41,'Sinh học cơ bản',2017,4,3,135000.00),(42,'Tài chính doanh nghiệp',2015,6,7,155000.00),(43,'Marketing căn bản',2016,6,7,145000.00),(44,'Kinh tế lượng',2017,6,7,165000.00),(45,'Lập trình Web với JSP',2022,1,1,180000.00),(46,'Cơ sở dữ liệu',2019,1,2,170000.00),(47,'Mạng máy tính',2020,1,2,175000.00),(48,'Trí tuệ nhân tạo',2022,1,3,220000.00),(49,'Machine Learning cơ bản',2021,1,3,200000.00),(50,'Deep Learning nâng cao',2022,1,3,250000.00);
/*!40000 ALTER TABLE `sach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sach_tacgia`
--

DROP TABLE IF EXISTS `sach_tacgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sach_tacgia` (
  `MaSach` int NOT NULL,
  `MaTacGia` int NOT NULL,
  PRIMARY KEY (`MaSach`,`MaTacGia`),
  KEY `MaTacGia` (`MaTacGia`),
  CONSTRAINT `sach_tacgia_ibfk_1` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`),
  CONSTRAINT `sach_tacgia_ibfk_2` FOREIGN KEY (`MaTacGia`) REFERENCES `tacgia` (`MaTacGia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sach_tacgia`
--

LOCK TABLES `sach_tacgia` WRITE;
/*!40000 ALTER TABLE `sach_tacgia` DISABLE KEYS */;
INSERT INTO `sach_tacgia` VALUES (21,1),(3,2),(7,3),(8,3),(9,3),(10,3),(11,3),(12,3),(13,3),(37,4),(22,5),(23,5),(39,5),(40,5),(41,5),(4,6),(16,6),(18,7),(1,8),(2,8),(5,8),(19,8),(26,8),(27,8),(28,8),(29,8),(30,8),(45,8),(46,8),(47,8),(48,8),(49,8),(50,8),(15,9),(20,9),(42,9),(43,9),(44,9),(6,10),(38,10),(31,11),(32,12),(33,12),(17,13),(34,13),(35,14),(36,14),(14,15),(24,15),(25,15);
/*!40000 ALTER TABLE `sach_tacgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tacgia`
--

DROP TABLE IF EXISTS `tacgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tacgia` (
  `MaTacGia` int NOT NULL,
  `TenTacGia` varchar(100) NOT NULL,
  PRIMARY KEY (`MaTacGia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tacgia`
--

LOCK TABLES `tacgia` WRITE;
/*!40000 ALTER TABLE `tacgia` DISABLE KEYS */;
INSERT INTO `tacgia` VALUES (1,'Nguyễn Nhật Ánh'),(2,'Nguyễn Du'),(3,'J.K. Rowling'),(4,'George Orwell'),(5,'Stephen Hawking'),(6,'Trần Đình Sử'),(7,'Tô Hoài'),(8,'Ngô Bảo Châu'),(9,'Adam Smith'),(10,'Sigmund Freud'),(11,'Nguyễn Minh Châu'),(12,'Nam Cao'),(13,'Ernest Hemingway'),(14,'William Shakespeare'),(15,'Nguyễn Hiến Lê');
/*!40000 ALTER TABLE `tacgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taikhoan` (
  `MaTK` int NOT NULL AUTO_INCREMENT,
  `TenDangNhap` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL COMMENT 'BCrypt hash (60 chars)',
  `VaiTro` enum('ADMIN','NHANVIEN') NOT NULL,
  PRIMARY KEY (`MaTK`),
  UNIQUE KEY `unique_tendangnhap` (`TenDangNhap`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taikhoan`
--

LOCK TABLES `taikhoan` WRITE;
/*!40000 ALTER TABLE `taikhoan` DISABLE KEYS */;
/*!40000 ALTER TABLE `taikhoan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theloai`
--

DROP TABLE IF EXISTS `theloai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theloai` (
  `MaTheLoai` int NOT NULL,
  `TenTheLoai` varchar(100) NOT NULL,
  PRIMARY KEY (`MaTheLoai`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theloai`
--

LOCK TABLES `theloai` WRITE;
/*!40000 ALTER TABLE `theloai` DISABLE KEYS */;
INSERT INTO `theloai` VALUES (1,'Công nghệ'),(2,'Văn học'),(3,'Lịch sử'),(4,'Khoa học'),(5,'Toán học'),(6,'Kinh tế'),(7,'Ngoại ngữ'),(8,'Y học'),(9,'Tâm lý'),(10,'Thiếu nhi');
/*!40000 ALTER TABLE `theloai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thethuvien`
--

DROP TABLE IF EXISTS `thethuvien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `thethuvien` (
  `MaThe` int NOT NULL,
  `MaDocGia` int DEFAULT NULL,
  `NgayCap` date DEFAULT NULL,
  `NgayHetHan` date DEFAULT NULL,
  PRIMARY KEY (`MaThe`),
  KEY `MaDocGia` (`MaDocGia`),
  CONSTRAINT `thethuvien_ibfk_1` FOREIGN KEY (`MaDocGia`) REFERENCES `docgia` (`MaDocGia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thethuvien`
--

LOCK TABLES `thethuvien` WRITE;
/*!40000 ALTER TABLE `thethuvien` DISABLE KEYS */;
INSERT INTO `thethuvien` VALUES (1,1,'2025-01-01','2025-12-31'),(2,2,'2025-01-01','2025-12-31'),(3,3,'2025-01-01','2025-12-31'),(4,4,'2025-01-01','2025-12-31'),(5,5,'2025-01-01','2025-12-31'),(6,6,'2025-01-01','2025-12-31'),(7,7,'2025-01-01','2025-12-31'),(8,8,'2025-01-01','2025-12-31'),(9,9,'2025-01-01','2025-12-31'),(10,10,'2025-01-01','2025-12-31'),(11,11,'2025-01-01','2025-12-31'),(12,12,'2025-01-01','2025-12-31'),(13,13,'2025-01-01','2025-12-31'),(14,14,'2025-01-01','2025-12-31'),(15,15,'2025-01-01','2025-12-31'),(16,16,'2025-01-01','2025-12-31'),(17,17,'2025-01-01','2025-12-31'),(18,18,'2025-01-01','2025-12-31'),(19,19,'2025-01-01','2025-12-31'),(20,20,'2025-01-01','2025-12-31');
/*!40000 ALTER TABLE `thethuvien` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-21 14:53:51
