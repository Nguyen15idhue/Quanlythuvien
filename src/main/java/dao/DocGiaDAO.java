package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.DocGia;
import utils.DBConnection;

public class DocGiaDAO {

    // Tạo độc giả mới
    public boolean createDocGia(DocGia docGia) {
        System.out.println("[DocGiaDAO] createDocGia() - Bắt đầu tạo độc giả: " + docGia.getHoTen());
        String sql = "INSERT INTO doc_gia (ho_ten, ngay_sinh, dia_chi, dien_thoai, email, ma_tk, ngay_cap_the, ngay_het_han_the) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return false;
            }
            
            ps.setString(1, docGia.getHoTen());
            ps.setDate(2, docGia.getNgaySinh());
            ps.setString(3, docGia.getDiaChi());
            ps.setString(4, docGia.getDienThoai());
            ps.setString(5, docGia.getEmail());
            
            // ma_tk có thể null
            if (docGia.getMaTK() != null) {
                ps.setInt(6, docGia.getMaTK());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            
            ps.setDate(7, docGia.getNgayCapThe());
            ps.setDate(8, docGia.getNgayHetHanThe());
            
            System.out.println("[DocGiaDAO] Đang thực thi INSERT...");
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                // Lấy ID vừa tạo
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        docGia.setMaDocGia(generatedKeys.getInt(1));
                    }
                }
                System.out.println("[DocGiaDAO] ✅ Tạo độc giả thành công: " + docGia.getHoTen());
                return true;
            }
            
            return false;
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi tạo độc giả: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Cập nhật thông tin độc giả
    public boolean updateDocGia(DocGia docGia) {
        System.out.println("[DocGiaDAO] updateDocGia() - Cập nhật độc giả ID: " + docGia.getMaDocGia());
        String sql = "UPDATE doc_gia SET ho_ten = ?, ngay_sinh = ?, dia_chi = ?, " +
                     "dien_thoai = ?, email = ?, ma_tk = ?, ngay_cap_the = ?, ngay_het_han_the = ? " +
                     "WHERE ma_doc_gia = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return false;
            }
            
            ps.setString(1, docGia.getHoTen());
            ps.setDate(2, docGia.getNgaySinh());
            ps.setString(3, docGia.getDiaChi());
            ps.setString(4, docGia.getDienThoai());
            ps.setString(5, docGia.getEmail());
            
            if (docGia.getMaTK() != null) {
                ps.setInt(6, docGia.getMaTK());
            } else {
                ps.setNull(6, Types.INTEGER);
            }
            
            ps.setDate(7, docGia.getNgayCapThe());
            ps.setDate(8, docGia.getNgayHetHanThe());
            ps.setInt(9, docGia.getMaDocGia());
            
            System.out.println("[DocGiaDAO] Đang thực thi UPDATE...");
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                System.out.println("[DocGiaDAO] ✅ Cập nhật độc giả thành công");
                return true;
            } else {
                System.err.println("[DocGiaDAO] ❌ Không tìm thấy độc giả để cập nhật");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi cập nhật độc giả: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Xóa độc giả
    public boolean deleteDocGia(int maDocGia) {
        System.out.println("[DocGiaDAO] deleteDocGia() - Xóa độc giả ID: " + maDocGia);
        String sql = "DELETE FROM doc_gia WHERE ma_doc_gia = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return false;
            }
            
            ps.setInt(1, maDocGia);
            
            System.out.println("[DocGiaDAO] Đang thực thi DELETE...");
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                System.out.println("[DocGiaDAO] ✅ Xóa độc giả thành công");
                return true;
            } else {
                System.err.println("[DocGiaDAO] ❌ Không tìm thấy độc giả để xóa");
                return false;
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi xóa độc giả: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // Lấy độc giả theo ID
    public DocGia getDocGiaById(int maDocGia) {
        System.out.println("[DocGiaDAO] getDocGiaById() - Lấy độc giả ID: " + maDocGia);
        String sql = "SELECT * FROM doc_gia WHERE ma_doc_gia = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return null;
            }
            
            ps.setInt(1, maDocGia);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DocGia docGia = new DocGia();
                    docGia.setMaDocGia(rs.getInt("ma_doc_gia"));
                    docGia.setHoTen(rs.getString("ho_ten"));
                    docGia.setNgaySinh(rs.getDate("ngay_sinh"));
                    docGia.setDiaChi(rs.getString("dia_chi"));
                    docGia.setDienThoai(rs.getString("dien_thoai"));
                    docGia.setEmail(rs.getString("email"));
                    
                    // ma_tk có thể null
                    int maTK = rs.getInt("ma_tk");
                    if (!rs.wasNull()) {
                        docGia.setMaTK(maTK);
                    }
                    
                    docGia.setNgayCapThe(rs.getDate("ngay_cap_the"));
                    docGia.setNgayHetHanThe(rs.getDate("ngay_het_han_the"));
                    
                    System.out.println("[DocGiaDAO] ✅ Tìm thấy độc giả: " + docGia.getHoTen());
                    return docGia;
                }
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi lấy độc giả: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.err.println("[DocGiaDAO] ❌ Không tìm thấy độc giả ID: " + maDocGia);
        return null;
    }

    // Lấy độc giả theo mã tài khoản
    public DocGia getDocGiaByMaTK(int maTK) {
        System.out.println("[DocGiaDAO] getDocGiaByMaTK() - Lấy độc giả theo mã TK: " + maTK);
        String sql = "SELECT * FROM doc_gia WHERE ma_tk = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return null;
            }
            
            ps.setInt(1, maTK);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DocGia docGia = new DocGia();
                    docGia.setMaDocGia(rs.getInt("ma_doc_gia"));
                    docGia.setHoTen(rs.getString("ho_ten"));
                    docGia.setNgaySinh(rs.getDate("ngay_sinh"));
                    docGia.setDiaChi(rs.getString("dia_chi"));
                    docGia.setDienThoai(rs.getString("dien_thoai"));
                    docGia.setEmail(rs.getString("email"));
                    docGia.setMaTK(rs.getInt("ma_tk"));
                    docGia.setNgayCapThe(rs.getDate("ngay_cap_the"));
                    docGia.setNgayHetHanThe(rs.getDate("ngay_het_han_the"));
                    
                    System.out.println("[DocGiaDAO] ✅ Tìm thấy độc giả: " + docGia.getHoTen());
                    return docGia;
                }
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi lấy độc giả theo mã TK: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.err.println("[DocGiaDAO] ❌ Không tìm thấy độc giả với mã TK: " + maTK);
        return null;
    }

    // Lấy tất cả độc giả
    public List<DocGia> getAllDocGia() {
        System.out.println("[DocGiaDAO] getAllDocGia() - Lấy tất cả độc giả");
        List<DocGia> list = new ArrayList<>();
        String sql = "SELECT * FROM doc_gia ORDER BY ma_doc_gia DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (conn == null) {
                System.err.println("[DocGiaDAO] ❌ Connection null!");
                return list;
            }
            
            while (rs.next()) {
                DocGia docGia = new DocGia();
                docGia.setMaDocGia(rs.getInt("ma_doc_gia"));
                docGia.setHoTen(rs.getString("ho_ten"));
                docGia.setNgaySinh(rs.getDate("ngay_sinh"));
                docGia.setDiaChi(rs.getString("dia_chi"));
                docGia.setDienThoai(rs.getString("dien_thoai"));
                docGia.setEmail(rs.getString("email"));
                
                int maTK = rs.getInt("ma_tk");
                if (!rs.wasNull()) {
                    docGia.setMaTK(maTK);
                }
                
                docGia.setNgayCapThe(rs.getDate("ngay_cap_the"));
                docGia.setNgayHetHanThe(rs.getDate("ngay_het_han_the"));
                
                list.add(docGia);
            }
            
            System.out.println("[DocGiaDAO] ✅ Lấy được " + list.size() + " độc giả");
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL khi lấy danh sách độc giả: " + e.getMessage());
            e.printStackTrace();
        }
        
        return list;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean emailExists(String email, int excludeId) {
        System.out.println("[DocGiaDAO] emailExists() - Kiểm tra email: " + email);
        String sql = "SELECT ma_doc_gia FROM doc_gia WHERE email = ? AND ma_doc_gia != ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setInt(2, excludeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                boolean exists = rs.next();
                System.out.println("[DocGiaDAO] Email tồn tại: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }

    // Kiểm tra số điện thoại đã tồn tại chưa
    public boolean phoneExists(String dienThoai, int excludeId) {
        System.out.println("[DocGiaDAO] phoneExists() - Kiểm tra điện thoại: " + dienThoai);
        String sql = "SELECT ma_doc_gia FROM doc_gia WHERE dien_thoai = ? AND ma_doc_gia != ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, dienThoai);
            ps.setInt(2, excludeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                boolean exists = rs.next();
                System.out.println("[DocGiaDAO] Điện thoại tồn tại: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.err.println("[DocGiaDAO] ❌ Lỗi SQL: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}
