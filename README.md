# 📚 Hệ thống Quản lý Thư viện

Ứng dụng web Java để quản lý thư viện, xây dựng với Servlet/JSP và MySQL.

## 🛠️ Công nghệ sử dụng

- **Java 17** - Ngôn ngữ lập trình chính
- **Maven** - Quản lý dependencies và build project
- **Servlet/JSP** - Framework web
- **MySQL** - Cơ sở dữ liệu
- **BCrypt** - Mã hóa mật khẩu
- **Tomcat** - Web server

## 📁 Cấu trúc dự án

```
📦 Quanlythuvien/
├── 📂 src/main/
│   ├── 📂 java/
│   │   ├── 📂 controller/     # Xử lý logic controller
│   │   ├── 📂 dao/           # Truy xuất dữ liệu
│   │   ├── 📂 model/         # Class model
│   │   └── 📂 utils/         # Tiện ích (kết nối DB)
│   └── 📂 webapp/
│       ├── 📂 jsp/           # Giao diện JSP
│       ├── 📄 index.jsp      # Trang chủ
│       └── 📂 WEB-INF/       # Cấu hình web
├── 📄 pom.xml               # Cấu hình Maven
└── 📄 README.md             # File hướng dẫn này
```

## 🚀 Hướng dẫn chạy project (CHO NGƯỜI MỚI)

### ✅ Yêu cầu hệ thống
- **Java 17+** (quan trọng!)
- **Maven 3.6+**
- **MySQL Server** (hoặc XAMPP/Laragon)
- **VS Code** với Java Extension Pack

### 📋 Các bước thực hiện

#### **Bước 1: Clone project về máy**
```bash
git clone https://github.com/Nguyen15idhue/Quanlythuvien.git
cd Quanlythuvien
```

#### **Bước 2: Mở project trong VS Code**
```bash
code .
```
Hoặc mở VS Code → File → Open Folder → chọn thư mục `Quanlythuvien`

#### **Bước 3: Cấu hình database MySQL**
1. **Tạo database:**
   ```sql
   CREATE DATABASE quanlythuvien;
   USE quanlythuvien;
   ```

2. **Cập nhật thông tin kết nối:**
   - Mở file: `src/main/java/utils/DBConnection.java`
   - Sửa thông tin database theo máy của bạn:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/quanlythuvien";
   private static final String USERNAME = "root";  // Username MySQL của bạn
   private static final String PASSWORD = "";      // Password MySQL của bạn
   ```

#### **Bước 4: Chạy ứng dụng**
**⚡ CÁCH NHANH NHẤT (1 lệnh duy nhất):**
```bash
mvn tomcat7:run
```

> 💡 **Lưu ý:** Lệnh này sẽ TỰ ĐỘNG:
> - Tải dependencies cần thiết
> - Biên dịch toàn bộ source code  
> - Khởi động Tomcat server
> - Deploy ứng dụng
>
> **➡️ Bạn KHÔNG cần chạy `mvn clean install` trước!**

#### **Bước 5: Truy cập ứng dụng**
- 🌐 Mở trình duyệt: **http://localhost:8080/quanlythuvien**

## 🎯 **Tóm tắt: Chỉ cần 3 bước!**
1. **Clone repo** 
2. **Cấu hình database** (sửa DBConnection.java)
3. **Chạy:** `mvn tomcat7:run`

> 🚀 **Chỉ vậy thôi!** Maven sẽ tự động lo phần còn lại.

## 🔧 Sử dụng VS Code Tasks (Tùy chọn)

Nếu bạn thích dùng VS Code Tasks, bấm **Ctrl+Shift+P** → gõ "Tasks: Run Task":

- **Maven: Clean** - Dọn dẹp build files
- **Maven: Compile** - Biên dịch source code
- **Maven: Package** - Tạo file WAR để deploy
- **Tomcat: Run** - Chạy server (giống `mvn tomcat7:run`)

## ⚠️ Xử lý lỗi thường gặp

### ❌ Lỗi port 8080 đã được sử dụng
```
Address already in use: bind <null>:8080
```
**Giải pháp:**
1. Dừng Apache/Laragon đang chạy port 8080
2. Hoặc kill process Java: `taskkill /f /im java.exe`
3. Chạy lại: `mvn tomcat7:run`

### ❌ Lỗi kết nối database
```
SQLException: Access denied for user
```
**Giải pháp:**
1. Kiểm tra MySQL đang chạy
2. Kiểm tra username/password trong `DBConnection.java`
3. Tạo database `quanlythuvien` nếu chưa có

### ❌ Lỗi Java version
```
Unsupported major.minor version
```
**Giải pháp:**
1. Kiểm tra Java version: `java -version`
2. Cần Java 17+
3. Cập nhật JAVA_HOME nếu cần

## 🎯 Chức năng chính

- 👤 **Đăng ký/Đăng nhập** người dùng
- 📖 **Quản lý sách** (thêm, sửa, xóa)
- 👥 **Quản lý người dùng**
- 🔐 **Bảo mật** với BCrypt

## 🚀 Deployment lên server

### Tạo file WAR:
```bash
mvn clean package
```

### Deploy:
1. Copy file `target/quanlythuvien.war`
2. Paste vào thư mục `webapps/` của Tomcat server
3. Restart Tomcat

## 🐛 Debug trong VS Code

1. **Chạy debug mode:**
   ```bash
   mvn tomcat7:run -Dmaven.tomcat.debug=8000
   ```

2. **Trong VS Code:**
   - Vào **Run and Debug** (Ctrl+Shift+D)
   - Tạo launch configuration cho Remote Java Debug
   - Port: 8000

## 📞 Hỗ trợ

- 📧 **Issues:** Tạo issue trên GitHub
- 💬 **Documentation:** Đọc code comments
- 🔗 **Pull Request:** Welcome!

## 📝 Lưu ý quan trọng

1. **`mvn tomcat7:run` đã bao gồm build - KHÔNG cần chạy `mvn clean install` trước**
2. **Đảm bảo MySQL đang chạy trước khi start app**
3. **Port 8080 phải trống (không có Apache/Laragon)**
4. **Java 17+ là bắt buộc**
5. **Chỉ cần sửa DBConnection.java cho đúng thông tin database của bạn**

---
✨ **Happy Coding!** 🎉
4. Push to the branch
5. Open a Pull Request