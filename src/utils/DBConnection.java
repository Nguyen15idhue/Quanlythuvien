package utils;
import java.sql.*;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quanlythuvien?useUnicode=true&characterEncoding=UTF-8", "root", "");
        } catch (Exception e) {
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
