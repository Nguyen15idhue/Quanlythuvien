# Hướng Dẫn Thêm Chức Năng Mới Vào Hệ Thống

## Quy Trình Chung
1. **Phân Tích Yêu Cầu**
   - Xác định chức năng cần thêm
   - Liệt kê các thông tin cần lưu trữ
   - Xác định quyền truy cập (ADMIN/NHANVIEN/DOCGIA)

2. **Thiết Kế Database**
   - Tạo bảng mới trong MySQL
   - Thêm các ràng buộc và khóa ngoại
   - Cập nhật file SQL

3. **Tạo Model**
   - Tạo file Java Bean trong model
   - Đặt tên theo quy ước PascalCase (VD: `SachMuon.java`)

4. **Tạo DAO**
   - Tạo file DAO trong dao
   - Đặt tên dạng `TenBangDAO.java`

5. **Tạo Controller**
   - Tạo folder mới trong controller (nếu cần)
   - Tạo file Controller đặt tên `TenBangController.java`
   - Cập nhật web.xml để map servlet

6. **Tạo View**
   - Tạo folder mới trong jsp (nếu cần)
   - Tạo các file JSP cần thiết

7. **Cập Nhật Navigation**
   - Thêm menu item vào `home.jsp`
   - Cập nhật quyền truy cập

## Ví Dụ: Thêm Chức Năng Quản Lý Sách

### Bước 1: Database
```sql
-- Tạo file: src/database/update_sach.sql
CREATE TABLE sach (
    ma_sach INT PRIMARY KEY AUTO_INCREMENT,
    ...
);
```

### Bước 2: Tạo Files
1. **Model**
   ```
   src/main/java/model/Sach.java
   ```

2. **DAO**
   ```
   src/main/java/dao/SachDAO.java
   ```

3. **Controller**
   ```
   src/main/java/controller/sach/SachController.java
   ```

4. **Views**
   ```
   src/main/webapp/jsp/sach/
   ├── sach.jsp          # Trang danh sách/xem
   ├── themsach.jsp      # Form thêm mới
   └── suasach.jsp       # Form chỉnh sửa
   ```

### Bước 3: Cập Nhật web.xml
```xml
<!-- Thêm vào src/main/webapp/WEB-INF/web.xml -->
<servlet>
    <servlet-name>SachController</servlet-name>
    <servlet-class>controller.sach.SachController</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>SachController</servlet-name>
    <url-pattern>/SachController</url-pattern>
</servlet-mapping>
```

### Bước 4: Cập Nhật Navigation
```jsp
<!-- Trong src/main/webapp/jsp/home.jsp -->
<div class="nav-item">
    <a href="${pageContext.request.contextPath}/SachController">
        Quản lý sách
    </a>
</div>
```

### Bước 5: Kiểm Tra & Test
1. Build project:
   ```
   mvn clean compile
   ```

2. Khởi động Tomcat:
   ```
   mvn tomcat7:run
   ```

3. Test các chức năng:
   - Truy cập /SachController
   - Thử thêm/sửa/xóa
   - Kiểm tra phân quyền

### Bước 6: Debug Các Lỗi Thường Gặp

1. **404 Not Found**
   - Kiểm tra web.xml
   - Kiểm tra package declaration
   - Rebuild project

2. **500 Internal Server Error**
   - Kiểm tra log Tomcat
   - Verify database connection
   - Check SQL syntax

3. **Lỗi Encoding**
   - Thêm UTF-8 filter
   - Set characterEncoding

## Tips & Tricks

### 1. Tổ Chức Code
- Đặt tên file rõ ràng
- Phân chia package logic
- Comment đầy đủ

### 2. Database
- Backup trước khi thay đổi
- Test SQL trước khi chạy
- Sử dụng foreign key

### 3. Testing
- Test từng chức năng nhỏ
- Kiểm tra các trường hợp đặc biệt
- Validate dữ liệu input

### 4. Security
- Kiểm tra session
- Validate quyền truy cập
- Escape SQL input

## Quy Trình Review Code

1. **Self Review**
   - Code đúng chuẩn
   - Không có hard-coded values
   - Xử lý lỗi đầy đủ

2. **Functional Test**
   - Tất cả chức năng hoạt động
   - UX/UI hợp lý
   - Thông báo lỗi rõ ràng

3. **Security Check**
   - Kiểm tra injection
   - Verify phân quyền
   - Check session handling

## Tổng Kết
- Tuân thủ quy trình từng bước
- Kiểm tra kỹ trước khi commit
- Document đầy đủ các thay đổi
- Backup database thường xuyên