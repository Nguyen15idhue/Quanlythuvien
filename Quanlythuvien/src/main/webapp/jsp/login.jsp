<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Đăng nhập - Thư viện</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container vh-100 d-flex justify-content-center align-items-center">
    <div class="card p-4" style="width:380px;">
      <h4 class="card-title text-center mb-3">Đăng nhập</h4>
      <form method="post" action="${pageContext.request.contextPath}/LoginController">
        <div class="mb-2">
          <label class="form-label">Email</label>
          <input type="email" name="email" required class="form-control" placeholder="email@domain">
        </div>
        <div class="mb-3">
          <label class="form-label">Mật khẩu</label>
          <input type="password" name="password" required class="form-control" placeholder="Mật khẩu">
        </div>
        <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
      </form>
      <div class="mt-2 text-danger">${error}</div>
     
      <div class="mt-3 text-center">
	  <a href="${pageContext.request.contextPath}/jsp/register.jsp">Chưa có tài khoản? Đăng ký ngay</a>
	</div>
    </div>
    
  </div>
</body>
</html>
