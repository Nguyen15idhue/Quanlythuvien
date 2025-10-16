package utils;
import java.sql.*;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            System.out.println("[DBConnection] Đang kết nối đến MySQL...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quanlythuvien?useUnicode=true&characterEncoding=UTF-8", "root", "");
            System.out.println("[DBConnection] ✅ Kết nối thành công!");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBConnection] ❌ Không tìm thấy MySQL Driver: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("[DBConnection] ❌ Lỗi kết nối database: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("[DBConnection] ❌ Lỗi không xác định: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    // Test main
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            if (conn != null)
                System.out.println("✅ Kết nối MySQL thành công!");
            else
                System.out.println("❌ Kết nối thất bại!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
