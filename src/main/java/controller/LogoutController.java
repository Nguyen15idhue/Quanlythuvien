package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); // ✅ Hủy toàn bộ session
        }

        // Xóa cookie JSESSIONID (nếu có)
        Cookie cookie = new Cookie("JSESSIONID", "");
        cookie.setMaxAge(0);
        cookie.setPath(req.getContextPath());
        res.addCookie(cookie);

        // ✅ Chuyển về trang đăng nhập
        res.sendRedirect(req.getContextPath() + "/jsp/login.jsp");
    }
}
