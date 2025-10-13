<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Đăng ký tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container vh-100 d-flex justify-content-center align-items-center">
    <div class="card p-4 shadow" style="width:400px;">
      <h4 class="text-center mb-3">Đăng ký tài khoản</h4>
      <form method="post" action="${pageContext.request.contextPath}/RegisterController">
        <div class="mb-2">
          <label>Email</label>
          <input type="email" class="form-control" name="email" required>
        </div>
        <div class="mb-2">
          <label>Tên hiển thị</label>
          <input type="text" class="form-control" name="username" required>
        </div>
        <div class="mb-2">
          <label>Mật khẩu</label>
          <input type="password" class="form-control" name="password" required>
        </div>
        <div class="mb-3">
          <label>Nhập lại mật khẩu</label>
          <input type="password" class="form-control" name="confirmPassword" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Đăng ký</button>
      </form>
      <div class="text-danger mt-2">${error}</div>
      <div class="text-success mt-2">${message}</div>
      <div class="mt-3 text-center">
        <a href="${pageContext.request.contextPath}/jsp/login.jsp">Đã có tài khoản? Đăng nhập</a>
      </div>
    </div>
  </div>
</body>
</html>
