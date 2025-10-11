package dao;

import java.sql.*;
import model.User;
import utils.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // Tạo user mới (hash password)
    public boolean createUser(String email, String username, String plainPassword, String role) {
        String hashed = BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
        String sql = "INSERT INTO users (email, username, password_hash, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, username);
            ps.setString(3, hashed);
            ps.setString(4, role);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra login bằng email + password (trả về User nếu đúng)
    public User checkLogin(String email, String plainPassword) {
        String sql = "SELECT id, email, username, password_hash, role FROM users WHERE email = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashed = rs.getString("password_hash");
                    if (BCrypt.checkpw(plainPassword, hashed)) {
                        User u = new User();
                        u.setId(rs.getInt("id"));
                        u.setEmail(rs.getString("email"));
                        u.setUsername(rs.getString("username"));
                        u.setRole(rs.getString("role"));
                        return u;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Tùy chọn: tạo user mặc định nếu chưa có (dùng ở servlet init)
    public void ensureDefaultUsers() {
        String check = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(check);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next() && rs.getInt(1) == 0) {
                createUser("admin@library.local", "admin", "12345678", "admin");
                createUser("reader1@library.local", "reader1", "12345678", "reader");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
