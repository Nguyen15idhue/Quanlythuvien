# Hướng dẫn thêm cột MaTK làm khóa chính tự động tăng

## 📋 Tổng quan
Thêm cột `MaTK` (Mã Tài Khoản) làm khóa chính với AUTO_INCREMENT vào bảng `taikhoan`.

## 🗂️ Cấu trúc bảng mới

### Trước khi thay đổi:
```sql
CREATE TABLE taikhoan (
  TenDangNhap VARCHAR(50) PRIMARY KEY,
  MatKhau VARCHAR(50) NOT NULL,
  VaiTro ENUM('ADMIN','NHANVIEN') NOT NULL
);
```

### Sau khi thay đổi:
```sql
CREATE TABLE taikhoan (
  MaTK INT AUTO_INCREMENT PRIMARY KEY,
  TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
  MatKhau VARCHAR(50) NOT NULL,
  VaiTro ENUM('ADMIN','NHANVIEN') NOT NULL
);
```

## 🔧 Cách 1: Nếu database đã tồn tại (ALTER TABLE)

### Chạy script SQL:
```sql
-- File: alter_taikhoan_add_matk.sql
USE quanlythuvien;

-- Xóa khóa chính cũ
ALTER TABLE taikhoan DROP PRIMARY KEY;

-- Thêm cột MaTK làm khóa chính AUTO_INCREMENT
ALTER TABLE taikhoan 
ADD COLUMN MaTK INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- Thêm UNIQUE constraint cho TenDangNhap
ALTER TABLE taikhoan 
ADD UNIQUE KEY unique_tendangnhap (TenDangNhap);
```

### Chạy trong MySQL:
```bash
mysql -u root -p quanlythuvien < src/database/alter_taikhoan_add_matk.sql
```

## 🔧 Cách 2: Tạo database mới (khuyến nghị)

### Bước 1: Xóa database cũ và tạo mới
```sql
DROP DATABASE IF EXISTS quanlythuvien;
CREATE DATABASE quanlythuvien CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### Bước 2: Import file SQL mới
```bash
mysql -u root -p quanlythuvien < src/database/quanlythuvien.sql
```

### Bước 3: Thêm dữ liệu mặc định
```bash
mysql -u root -p quanlythuvien < src/database/insert_default_accounts.sql
```

## 📝 Thay đổi trong Code

### 1. Model (User.java)
```java
public class User {
    private int maTK;              // ✅ THÊM MỚI
    private String tenDangNhap;
    private String matKhau;
    private String vaiTro;
    
    // Getters & Setters
    public int getMaTK() { return maTK; }
    public void setMaTK(int maTK) { this.maTK = maTK; }
}
```

### 2. UserDAO.java
```java
// Cập nhật checkLogin() để lấy MaTK
public User checkLogin(String tenDangNhap, String matKhau) {
    String sql = "SELECT MaTK, TenDangNhap, MatKhau, VaiTro FROM taikhoan...";
    // ...
    u.setMaTK(rs.getInt("MaTK"));  // ✅ THÊM MỚI
}

// createUser() không cần sửa vì MaTK tự động tăng
INSERT INTO taikhoan (TenDangNhap, MatKhau, VaiTro) VALUES (?, ?, ?)
```

### 3. LoginController.java
```java
// Lưu MaTK vào session
newSession.setAttribute("maTK", user.getMaTK());      // ✅ THÊM MỚI
newSession.setAttribute("tenDangNhap", user.getTenDangNhap());
newSession.setAttribute("vaiTro", user.getVaiTro());
```

### 4. home.jsp
```jsp
<%
    Integer maTK = (Integer) session.getAttribute("maTK");  // ✅ THÊM MỚI
    String tenDangNhap = (String) session.getAttribute("tenDangNhap");
%>

<p>Mã tài khoản: <b><%= maTK %></b></p>  <!-- ✅ HIỂN THỊ -->
```

## 🧪 Test

### 1. Compile project
```powershell
mvn clean compile
```

### 2. Chạy server
```powershell
mvn tomcat7:run
```

### 3. Test đăng nhập
- Mở: http://localhost:8080/quanlythuvien/jsp/login.jsp
- Đăng nhập: admin / admin123
- Kiểm tra trang home có hiển thị "Mã tài khoản" không

### 4. Kiểm tra database
```sql
USE quanlythuvien;

-- Xem cấu trúc bảng
DESCRIBE taikhoan;

-- Xem dữ liệu
SELECT * FROM taikhoan;

-- Kết quả mong đợi:
-- MaTK | TenDangNhap | MatKhau      | VaiTro
-- 1    | admin       | admin123     | ADMIN
-- 2    | nhanvien1   | nhanvien123  | NHANVIEN
-- 3    | nhanvien2   | nhanvien123  | NHANVIEN
```

## ✅ Lợi ích của việc thêm MaTK

1. **Khóa chính tự nhiên**: Số nguyên tự tăng, không trùng lặp
2. **Hiệu suất tốt hơn**: INDEX trên INT nhanh hơn VARCHAR
3. **Dễ join**: Khi có bảng khác tham chiếu đến tài khoản
4. **Cho phép đổi username**: TenDangNhap không còn là PRIMARY KEY
5. **Theo chuẩn**: Giống các bảng khác (MaDocGia, MaSach, etc.)

## 🔗 Ví dụ sử dụng trong tương lai

```java
// Trong session chỉ cần lưu maTK
session.setAttribute("maTK", user.getMaTK());

// Khi cần lấy thông tin user đầy đủ
int maTK = (Integer) session.getAttribute("maTK");
User user = userDAO.getUserById(maTK);

// Tạo bảng liên kết (ví dụ: lịch sử hoạt động)
CREATE TABLE lichsu_hoatdong (
    MaLS INT AUTO_INCREMENT PRIMARY KEY,
    MaTK INT,
    HanhDong VARCHAR(255),
    ThoiGian DATETIME,
    FOREIGN KEY (MaTK) REFERENCES taikhoan(MaTK)
);
```

## ⚠️ Lưu ý quan trọng

1. **Không hardcode MaTK**: Luôn để database tự động tạo
2. **TenDangNhap vẫn UNIQUE**: Không cho phép trùng lặp
3. **Migration data cẩn thận**: Nếu có dữ liệu cũ, backup trước
4. **Test kỹ**: Đảm bảo tất cả chức năng login/register hoạt động

## 📂 Files đã được cập nhật

- ✅ `src/database/quanlythuvien.sql` - Cấu trúc bảng mới
- ✅ `src/database/insert_default_accounts.sql` - Script insert có MaTK
- ✅ `src/database/alter_taikhoan_add_matk.sql` - Script ALTER TABLE
- ✅ `src/main/java/model/User.java` - Thêm field maTK
- ✅ `src/main/java/dao/UserDAO.java` - Cập nhật SQL queries
- ✅ `src/main/java/controller/LoginController.java` - Lưu maTK vào session
- ✅ `src/main/webapp/jsp/home.jsp` - Hiển thị maTK

## 🎯 Kết luận

Với việc thêm cột `MaTK` làm khóa chính tự động tăng:
- ✅ Database có cấu trúc chuẩn hơn
- ✅ Dễ mở rộng chức năng trong tương lai
- ✅ Tương thích với các bảng khác trong hệ thống
- ✅ Không ảnh hưởng đến chức năng hiện tại
