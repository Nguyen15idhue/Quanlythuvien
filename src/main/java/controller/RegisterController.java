package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;

public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        System.out.println("==========================================");
        System.out.println("[RegisterController] Nhận yêu cầu đăng ký");
        
        // Thiết lập mã hóa UTF-8
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String tenDangNhap = req.getParameter("tenDangNhap") != null ? req.getParameter("tenDangNhap").trim() : "";
        String matKhau = req.getParameter("matKhau") != null ? req.getParameter("matKhau").trim() : "";
        String confirmPassword = req.getParameter("confirmPassword") != null ? req.getParameter("confirmPassword").trim() : "";
        String vaiTro = req.getParameter("vaiTro") != null ? req.getParameter("vaiTro").trim() : "NHANVIEN";

        System.out.println("[RegisterController] Username: " + tenDangNhap);
        System.out.println("[RegisterController] Password length: " + matKhau.length());
        System.out.println("[RegisterController] Vai trò: " + vaiTro);
        
        // Kiểm tra dữ liệu trống
        if (tenDangNhap.isEmpty() || matKhau.isEmpty() || confirmPassword.isEmpty()) {
            System.err.println("[RegisterController] ❌ Dữ liệu trống!");
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // Kiểm tra mật khẩu trùng khớp
        if (!matKhau.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // Kiểm tra độ dài mật khẩu
        if (matKhau.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();

        // Kiểm tra tên đăng nhập đã tồn tại
        if (dao.usernameExists(tenDangNhap)) {
            req.setAttribute("error", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // Validate vai trò (chỉ cho phép ADMIN hoặc NHANVIEN)
        if (!vaiTro.equals("ADMIN") && !vaiTro.equals("NHANVIEN")) {
            vaiTro = "NHANVIEN"; // Mặc định là NHANVIEN
        }

        // Tạo tài khoản mới
        System.out.println("[RegisterController] Đang tạo tài khoản...");
        boolean success = dao.createUser(tenDangNhap, matKhau, vaiTro);

        if (success) {
            System.out.println("[RegisterController] ✅ Đăng ký thành công!");
            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, res);
        } else {
            System.err.println("[RegisterController] ❌ Đăng ký thất bại!");
            req.setAttribute("error", "Đăng ký thất bại, thử lại sau.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
        }
        System.out.println("==========================================\n");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Hiển thị form đăng ký
        req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
    }
}
