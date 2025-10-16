package controller.docgia;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.DocGiaDAO;
import model.DocGia;

public class DocgiaController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        System.out.println("==========================================");
        System.out.println("[DocGiaController] Nhận yêu cầu GET");
        
        // Thiết lập UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        // Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("maTK") == null) {
            System.err.println("[DocGiaController] ❌ Chưa đăng nhập!");
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }
        
        Integer maTK = (Integer) session.getAttribute("maTK");
        String vaiTro = (String) session.getAttribute("vaiTro");
        
        System.out.println("[DocGiaController] Mã TK: " + maTK + ", Vai trò: " + vaiTro);
        
        // Lấy action từ parameter
        String action = req.getParameter("action");
        if (action == null) {
            action = "view";
        }
        
        DocGiaDAO dao = new DocGiaDAO();
        
        switch (action) {
            case "view":
                // Hiển thị thông tin độc giả
                if ("DOCGIA".equals(vaiTro)) {
                    // Độc giả chỉ xem thông tin của chính mình
                    DocGia docGia = dao.getDocGiaByMaTK(maTK);
                    if (docGia != null) {
                        req.setAttribute("docGia", docGia);
                        req.setAttribute("readOnly", false);
                    } else {
                        req.setAttribute("message", "Chưa có thông tin độc giả. Vui lòng cập nhật!");
                        req.setAttribute("readOnly", false);
                    }
                } else {
                    // Admin/Nhân viên có thể xem tất cả
                    req.setAttribute("docGiaList", dao.getAllDocGia());
                    req.setAttribute("readOnly", true);
                }
                break;
                
            case "edit":
                // Chỉ độc giả mới có thể sửa thông tin của mình
                if ("DOCGIA".equals(vaiTro)) {
                    DocGia docGia = dao.getDocGiaByMaTK(maTK);
                    req.setAttribute("docGia", docGia);
                    req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                    return;
                }
                break;
                
            default:
                break;
        }
        
        req.getRequestDispatcher("/jsp/docgia/docgia.jsp").forward(req, resp);
        System.out.println("==========================================\n");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        System.out.println("==========================================");
        System.out.println("[DocGiaController] Nhận yêu cầu POST");
        
        // Thiết lập UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        
        // Kiểm tra đăng nhập
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("maTK") == null) {
            System.err.println("[DocGiaController] ❌ Chưa đăng nhập!");
            resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
            return;
        }
        
        Integer maTK = (Integer) session.getAttribute("maTK");
        String vaiTro = (String) session.getAttribute("vaiTro");
        
        // Chỉ độc giả mới được cập nhật thông tin
        if (!"DOCGIA".equals(vaiTro)) {
            req.setAttribute("error", "Bạn không có quyền thực hiện thao tác này!");
            req.getRequestDispatcher("/jsp/docgia/docgia.jsp").forward(req, resp);
            return;
        }
        
        String action = req.getParameter("action");
        DocGiaDAO dao = new DocGiaDAO();
        
        if ("update".equals(action)) {
            try {
                // Lấy thông tin từ form
                String hoTen = req.getParameter("hoTen");
                String ngaySinhStr = req.getParameter("ngaySinh");
                String diaChi = req.getParameter("diaChi");
                String dienThoai = req.getParameter("dienThoai");
                String email = req.getParameter("email");
                String ngayCapTheStr = req.getParameter("ngayCapThe");
                String ngayHetHanTheStr = req.getParameter("ngayHetHanThe");
                
                System.out.println("[DocGiaController] Họ tên: " + hoTen);
                System.out.println("[DocGiaController] Email: " + email);
                
                // Kiểm tra độc giả hiện tại
                DocGia existingDocGia = dao.getDocGiaByMaTK(maTK);
                
                // Validate dữ liệu
                if (hoTen == null || hoTen.trim().isEmpty()) {
                    req.setAttribute("error", "Họ tên không được để trống!");
                    req.setAttribute("docGia", existingDocGia != null ? existingDocGia : new DocGia());
                    req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                    return;
                }
                
                if (email == null || email.trim().isEmpty()) {
                    req.setAttribute("error", "Email không được để trống!");
                    req.setAttribute("docGia", existingDocGia != null ? existingDocGia : new DocGia());
                    req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                    return;
                }
                
                if (existingDocGia != null) {
                    // Cập nhật thông tin
                    existingDocGia.setHoTen(hoTen.trim());
                    
                    if (ngaySinhStr != null && !ngaySinhStr.isEmpty()) {
                        existingDocGia.setNgaySinh(Date.valueOf(ngaySinhStr));
                    }
                    
                    existingDocGia.setDiaChi(diaChi != null ? diaChi.trim() : "");
                    existingDocGia.setDienThoai(dienThoai != null ? dienThoai.trim() : "");
                    existingDocGia.setEmail(email.trim());
                    
                    // Kiểm tra email trùng
                    if (dao.emailExists(email.trim(), existingDocGia.getMaDocGia())) {
                        req.setAttribute("error", "Email đã được sử dụng bởi độc giả khác!");
                        req.setAttribute("docGia", existingDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                    
                    // Kiểm tra điện thoại trùng
                    if (dienThoai != null && !dienThoai.trim().isEmpty() 
                        && dao.phoneExists(dienThoai.trim(), existingDocGia.getMaDocGia())) {
                        req.setAttribute("error", "Số điện thoại đã được sử dụng bởi độc giả khác!");
                        req.setAttribute("docGia", existingDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                    
                    if (dao.updateDocGia(existingDocGia)) {
                        System.out.println("[DocGiaController] ✅ Cập nhật thành công!");
                        req.setAttribute("message", "Cập nhật thông tin thành công!");
                        req.setAttribute("docGia", existingDocGia);
                        req.getRequestDispatcher("/jsp/docgia/docgia.jsp").forward(req, resp);
                        return;
                    } else {
                        req.setAttribute("error", "Cập nhật thông tin thất bại!");
                        req.setAttribute("docGia", existingDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                } else {
                    // Tạo mới thông tin độc giả
                    DocGia newDocGia = new DocGia();
                    newDocGia.setHoTen(hoTen.trim());
                    
                    if (ngaySinhStr != null && !ngaySinhStr.isEmpty()) {
                        newDocGia.setNgaySinh(Date.valueOf(ngaySinhStr));
                    }
                    
                    newDocGia.setDiaChi(diaChi != null ? diaChi.trim() : "");
                    newDocGia.setDienThoai(dienThoai != null ? dienThoai.trim() : "");
                    newDocGia.setEmail(email.trim());
                    newDocGia.setMaTK(maTK);
                    
                    // Thiết lập ngày cấp thẻ và hết hạn
                    if (ngayCapTheStr != null && !ngayCapTheStr.isEmpty()) {
                        newDocGia.setNgayCapThe(Date.valueOf(ngayCapTheStr));
                    } else {
                        newDocGia.setNgayCapThe(new Date(System.currentTimeMillis()));
                    }
                    
                    if (ngayHetHanTheStr != null && !ngayHetHanTheStr.isEmpty()) {
                        newDocGia.setNgayHetHanThe(Date.valueOf(ngayHetHanTheStr));
                    } else {
                        // Mặc định hết hạn sau 1 năm
                        newDocGia.setNgayHetHanThe(new Date(System.currentTimeMillis() + 365L * 24 * 60 * 60 * 1000));
                    }
                    
                    // Kiểm tra email trùng
                    if (dao.emailExists(email.trim(), 0)) {
                        req.setAttribute("error", "Email đã được sử dụng!");
                        req.setAttribute("docGia", newDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                    
                    // Kiểm tra điện thoại trùng
                    if (dienThoai != null && !dienThoai.trim().isEmpty() 
                        && dao.phoneExists(dienThoai.trim(), 0)) {
                        req.setAttribute("error", "Số điện thoại đã được sử dụng!");
                        req.setAttribute("docGia", newDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                    
                    if (dao.createDocGia(newDocGia)) {
                        System.out.println("[DocGiaController] ✅ Tạo mới thành công!");
                        req.setAttribute("message", "Tạo thông tin độc giả thành công!");
                        req.setAttribute("docGia", newDocGia);
                        req.getRequestDispatcher("/jsp/docgia/docgia.jsp").forward(req, resp);
                        return;
                    } else {
                        req.setAttribute("error", "Tạo thông tin độc giả thất bại!");
                        req.setAttribute("docGia", newDocGia);
                        req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                        return;
                    }
                }
                
            } catch (Exception e) {
                System.err.println("[DocGiaController] ❌ Lỗi: " + e.getMessage());
                e.printStackTrace();
                req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
                req.getRequestDispatcher("/jsp/docgia/suadocgia.jsp").forward(req, resp);
                return;
            }
        }
        
        // Mặc định quay về trang docgia.jsp
        req.getRequestDispatcher("/jsp/docgia/docgia.jsp").forward(req, resp);
        System.out.println("==========================================\n");
    }
}
