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

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.checkLogin(email, password);

        if (user != null) {
            // Prevent session fixation: invalidate old session and create new one
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }
            HttpSession newSession = req.getSession(true);
            newSession.setMaxInactiveInterval(SESSION_TIMEOUT_SECONDS);

            // Store only safe user info (not password)
            newSession.setAttribute("userId", user.getId());
            newSession.setAttribute("userEmail", user.getEmail());
            newSession.setAttribute("userRole", user.getRole());
            newSession.setAttribute("username", user.getUsername());

            // Optionally force HttpOnly on session cookie (may duplicate container cookie)
            Cookie sessionCookie = new Cookie("JSESSIONID", newSession.getId());
            sessionCookie.setHttpOnly(true);
            sessionCookie.setPath(req.getContextPath());
            // If using https in production:
            // sessionCookie.setSecure(true);
            resp.addCookie(sessionCookie);

            // Redirect based on role
            if ("admin".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/jsp/home.jsp");
            }
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng.");
            RequestDispatcher rd = req.getRequestDispatcher("/jsp/login.jsp");
            rd.forward(req, resp);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Chạy form login
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }
}
