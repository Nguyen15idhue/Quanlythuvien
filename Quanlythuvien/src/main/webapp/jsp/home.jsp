<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if (session == null || session.getAttribute("userEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("userRole");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Trang chủ thư viện</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">📚 Library System</a>
      <div class="d-flex">
        <span class="navbar-text text-white me-3">
          Xin chào, <b><%= username %></b> (<%= role %>)
        </span>
        <a href="<%= request.getContextPath() %>/LogoutController" class="btn btn-outline-light btn-sm">
          Đăng xuất
        </a>
      </div>
    </div>
  </nav>

  <div class="container mt-5 text-center">
    <h2>🎉 Chào mừng bạn đến với Hệ thống Quản lý Thư viện</h2>
    <p>Email của bạn: <b><%= email %></b></p>
    <p>Vai trò: <b><%= role %></b></p>

    <hr>
    <div class="mt-4">
      <a href="#" class="btn btn-success">📖 Quản lý Sách</a>
      <a href="#" class="btn btn-info">👥 Quản lý Độc Giả</a>
      <a href="#" class="btn btn-secondary">🔍 Tìm kiếm</a>
    </div>
  </div>
</body>
</html>
