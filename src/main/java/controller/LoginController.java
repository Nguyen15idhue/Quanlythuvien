package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import dao.UserDAO;
import model.User;

public class LoginController extends HttpServlet {
    private static final int SESSION_TIMEOUT_SECONDS = 30 * 60; // 30 phút

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        System.out.println("==========================================");
        System.out.println("[LoginController] Nhận yêu cầu đăng nhập");
        
        // Thiết lập UTF-8
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String tenDangNhap = req.getParameter("tenDangNhap");
        String matKhau = req.getParameter("matKhau");
        
        System.out.println("[LoginController] Username: " + tenDangNhap);
        System.out.println("[LoginController] Password length: " + (matKhau != null ? matKhau.length() : 0));

        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(tenDangNhap, matKhau);

        if (user != null) {
            System.out.println("[LoginController] ✅ Đăng nhập thành công!");
            System.out.println("[LoginController] MaTK: " + user.getMaTK());
            System.out.println("[LoginController] Vai trò: " + user.getVaiTro());
            // Prevent session fixation: invalidate old session and create new one
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = req.getSession(true);
            newSession.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);

            // Lưu thông tin user vào session
            newSession.setAttribute("maTK", user.getMaTK());
            newSession.setAttribute("tenDangNhap", user.getTenDangNhap());
            newSession.setAttribute("vaiTro", user.getVaiTro());

            // Optionally force HttpOnly on session cookie
            Cookie sessionCookie = new Cookie("JSESSIONID", newSession.getId());
            sessionCookie.setHttpOnly(true);
            sessionCookie.setPath(req.getContextPath());
            resp.addCookie(sessionCookie);

            // Redirect về trang chủ
            System.out.println("[LoginController] Redirect đến home.jsp");
            resp.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
        } else {
            System.err.println("[LoginController] ❌ Đăng nhập thất bại!");
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
            RequestDispatcher rd = req.getRequestDispatcher("/jsp/login.jsp");
            rd.forward(req, resp);
        }
        System.out.println("==========================================\n");
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Hiển thị form login
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }
}
