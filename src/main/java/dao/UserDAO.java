package dao;

import java.sql.*;
import model.User;
import utils.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // Tạo tài khoản mới (hash password trước khi lưu)
    public boolean createUser(String tenDangNhap, String matKhau, String vaiTro) {
        System.out.println("[UserDAO] createUser() - Bắt đầu tạo user: " + tenDangNhap);
        String sql = "INSERT INTO taikhoan (TenDangNhap, MatKhau, VaiTro) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[UserDAO] ❌ Connection null!");
                return false;
            }
            
            System.out.println("[UserDAO] Đang hash mật khẩu...");
            String hashedPassword = BCrypt.hashpw(matKhau, BCrypt.gensalt(12));
            System.out.println("[UserDAO] ✅ Hash thành công!");
            
            ps.setString(1, tenDangNhap);
            ps.setString(2, hashedPassword);
            ps.setString(3, vaiTro.toUpperCase());
            
            System.out.println("[UserDAO] Đang thực thi INSERT...");
            ps.executeUpdate();
            System.out.println("[UserDAO] ✅ Tạo user thành công: " + tenDangNhap);
            return true;
        } catch (SQLException e) {
            System.err.println("[UserDAO] ❌ Lỗi SQL khi tạo user: " + e.getMessage());
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            System.err.println("[UserDAO] ❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra đăng nhập (trả về User nếu đúng)
    public User checkLogin(String tenDangNhap, String matKhau) {
        System.out.println("[UserDAO] checkLogin() - Đăng nhập với user: " + tenDangNhap);
        String sql = "SELECT MaTK, TenDangNhap, MatKhau, VaiTro FROM taikhoan WHERE TenDangNhap = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[UserDAO] ❌ Connection null!");
                return null;
            }
            
            ps.setString(1, tenDangNhap);
            System.out.println("[UserDAO] Đang query database...");
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("[UserDAO] ✅ Tìm thấy user trong DB");
                    String hashedPassword = rs.getString("MatKhau");
                    System.out.println("[UserDAO] Hash từ DB: " + hashedPassword.substring(0, 20) + "...");
                    
                    // Kiểm tra password với BCrypt
                    System.out.println("[UserDAO] Đang kiểm tra mật khẩu...");
                    if (BCrypt.checkpw(matKhau, hashedPassword)) {
                        System.out.println("[UserDAO] ✅ Mật khẩu đúng!");
                        User u = new User();
                        u.setMaTK(rs.getInt("MaTK"));
                        u.setTenDangNhap(rs.getString("TenDangNhap"));
                        u.setMatKhau(hashedPassword);
                        u.setVaiTro(rs.getString("VaiTro"));
                        return u;
                    } else {
                        System.err.println("[UserDAO] ❌ Mật khẩu sai!");
                    }
                } else {
                    System.err.println("[UserDAO] ❌ Không tìm thấy user: " + tenDangNhap);
                }
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] ❌ Lỗi SQL khi login: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("[UserDAO] ❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
    
    // Kiểm tra tên đăng nhập đã tồn tại chưa
    public boolean usernameExists(String tenDangNhap) {
        System.out.println("[UserDAO] usernameExists() - Kiểm tra user: " + tenDangNhap);
        String sql = "SELECT TenDangNhap FROM taikhoan WHERE TenDangNhap = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, tenDangNhap);
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            System.out.println("[UserDAO] User tồn tại: " + exists);
            return exists;
        } catch (SQLException e) {
            System.err.println("[UserDAO] ❌ Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Tạo tài khoản mặc định nếu chưa có
    public void ensureDefaultUsers() {
        System.out.println("[UserDAO] ensureDefaultUsers() - Kiểm tra tài khoản mặc định...");
        String check = "SELECT COUNT(*) FROM taikhoan";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(check);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt(1);
                System.out.println("[UserDAO] Số tài khoản hiện có: " + count);
                if (count == 0) {
                    System.out.println("[UserDAO] Đang tạo tài khoản mặc định...");
                    createUser("admin", "admin123", "ADMIN");
                    createUser("nhanvien1", "nhanvien123", "NHANVIEN");
                    System.out.println("[UserDAO] ✅ Đã tạo tài khoản mặc định");
                } else {
                    System.out.println("[UserDAO] ✅ Đã có tài khoản, bỏ qua tạo mặc định");
                }
            }
        } catch (SQLException e) {
            System.err.println("[UserDAO] ❌ Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
