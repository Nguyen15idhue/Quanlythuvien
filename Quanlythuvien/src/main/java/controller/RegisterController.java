package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;

public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L; // ✅ để loại bỏ cảnh báo

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // ✅ Thiết lập mã hóa UTF-8 để tránh lỗi tiếng Việt
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email") != null ? req.getParameter("email").trim() : "";
        String username = req.getParameter("username") != null ? req.getParameter("username").trim() : "";
        String password = req.getParameter("password") != null ? req.getParameter("password").trim() : "";
        String confirmPassword = req.getParameter("confirmPassword") != null ? req.getParameter("confirmPassword").trim() : "";

        // ✅ Kiểm tra dữ liệu trống
        if (email.isEmpty() || username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // ✅ Kiểm tra định dạng email
        if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            req.setAttribute("error", "Email không hợp lệ.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // ✅ Kiểm tra mật khẩu trùng khớp
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();

        // ✅ Kiểm tra email đã tồn tại
        if (dao.emailExists(email)) {
            req.setAttribute("error", "Email đã được đăng ký, vui lòng đăng nhập.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
            return;
        }

        // ✅ Tạo tài khoản mới với role mặc định "reader"
        boolean success = dao.createUser(email, username, password, "reader");

        if (success) {
            req.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Đăng ký thất bại, thử lại sau.");
            req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // ✅ Khi người dùng mở trực tiếp link /RegisterController → hiển thị form
        req.getRequestDispatcher("/jsp/register.jsp").forward(req, res);
    }
}
