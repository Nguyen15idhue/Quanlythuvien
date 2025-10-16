<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DocGia" %>
<%
    // Kiểm tra đăng nhập
    if (session == null || session.getAttribute("tenDangNhap") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    Integer maTK = (Integer) session.getAttribute("maTK");
    String tenDangNhap = (String) session.getAttribute("tenDangNhap");
    String vaiTro = (String) session.getAttribute("vaiTro");
    
    // Chỉ độc giả mới được vào trang này
    if (!"DOCGIA".equals(vaiTro)) {
        response.sendRedirect(request.getContextPath() + "/jsp/home.jsp");
        return;
    }
    
    DocGia docGia = (DocGia) request.getAttribute("docGia");
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa thông tin - Thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 30px 0;
        }
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,.2);
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border: none;
        }
        .card-header h4 {
            margin: 0;
            font-weight: 600;
        }
        .card-body {
            padding: 30px;
            background: white;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn {
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-secondary {
            background: #6c757d;
            border: none;
        }
        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }
        .alert {
            border-radius: 10px;
            border: none;
            padding: 15px 20px;
        }
        .required {
            color: #dc3545;
            font-weight: bold;
        }
        .form-text {
            color: #6c757d;
            font-size: 0.875rem;
        }
        .info-badge {
            display: inline-block;
            padding: 8px 15px;
            background: #e7f1ff;
            border-radius: 10px;
            color: #0052cc;
            font-size: 0.9rem;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <!-- Thông báo -->
                <% if (error != null && !error.isEmpty()) { %>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> <strong>Lỗi!</strong> <%= error %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>
                
                <% if (message != null && !message.isEmpty()) { %>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> <strong>Thành công!</strong> <%= message %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <!-- Card chính -->
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>
                                <i class="fas fa-user-edit"></i> 
                                <%= docGia == null ? "Tạo hồ sơ độc giả" : "Chỉnh sửa thông tin" %>
                            </h4>
                            <a href="<%= request.getContextPath() %>/DocgiaController" class="btn btn-light btn-sm">
                                <i class="fas fa-arrow-left"></i> Quay lại
                            </a>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <% if (docGia == null) { %>
                            <div class="info-badge">
                                <i class="fas fa-info-circle"></i> 
                                Bạn chưa có hồ sơ độc giả. Vui lòng điền đầy đủ thông tin bên dưới.
                            </div>
                        <% } %>

                        <form method="post" action="<%= request.getContextPath() %>/DocgiaController" id="docgiaForm">
                            <input type="hidden" name="action" value="update">
                            
                            <!-- Thông tin cá nhân -->
                            <h5 class="mb-3 text-primary">
                                <i class="fas fa-id-card"></i> Thông tin cá nhân
                            </h5>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        Họ và tên <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" name="hoTen" 
                                           value="<%= docGia != null && docGia.getHoTen() != null ? docGia.getHoTen() : "" %>" 
                                           placeholder="Nhập họ và tên đầy đủ"
                                           required
                                           maxlength="100">
                                    <div class="form-text">Họ và tên đầy đủ của bạn</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" name="ngaySinh" 
                                           value="<%= docGia != null && docGia.getNgaySinh() != null ? docGia.getNgaySinh().toString() : "" %>"
                                           max="<%= new java.sql.Date(new java.util.Date().getTime()) %>">
                                    <div class="form-text">Ngày sinh của bạn</div>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" name="diaChi" 
                                       value="<%= docGia != null && docGia.getDiaChi() != null ? docGia.getDiaChi() : "" %>"
                                       placeholder="Số nhà, đường, quận/huyện, tỉnh/thành phố"
                                       maxlength="255">
                                <div class="form-text">Địa chỉ liên hệ của bạn</div>
                            </div>
                            
                            <!-- Thông tin liên hệ -->
                            <h5 class="mb-3 mt-4 text-primary">
                                <i class="fas fa-phone"></i> Thông tin liên hệ
                            </h5>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="tel" class="form-control" name="dienThoai" 
                                           value="<%= docGia != null && docGia.getDienThoai() != null ? docGia.getDienThoai() : "" %>"
                                           pattern="[0-9]{10,11}" 
                                           placeholder="Ví dụ: 0912345678"
                                           maxlength="15">
                                    <div class="form-text">Số điện thoại di động (10-11 số)</div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">
                                        Email <span class="required">*</span>
                                    </label>
                                    <input type="email" class="form-control" name="email" 
                                           value="<%= docGia != null && docGia.getEmail() != null ? docGia.getEmail() : "" %>"
                                           placeholder="example@email.com"
                                           required
                                           maxlength="100">
                                    <div class="form-text">Email để liên hệ và nhận thông báo</div>
                                </div>
                            </div>
                            
                            <!-- Thông tin thẻ thư viện -->
                            <% if (docGia != null) { %>
                            <h5 class="mb-3 mt-4 text-primary">
                                <i class="fas fa-id-badge"></i> Thông tin thẻ thư viện
                            </h5>
                            
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Mã độc giả</label>
                                    <input type="text" class="form-control" 
                                           value="<%= String.format("DG%05d", docGia.getMaDocGia()) %>" 
                                           readonly>
                                </div>
                                
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Ngày cấp thẻ</label>
                                    <input type="date" class="form-control" name="ngayCapThe" 
                                           value="<%= docGia.getNgayCapThe() %>" 
                                           readonly>
                                </div>
                                
                                <div class="col-md-4 mb-3">
                                    <label class="form-label">Ngày hết hạn</label>
                                    <input type="date" class="form-control" name="ngayHetHanThe" 
                                           value="<%= docGia.getNgayHetHanThe() %>" 
                                           readonly>
                                </div>
                            </div>
                            
                            <div class="alert alert-info mt-3">
                                <i class="fas fa-info-circle"></i>
                                <strong>Lưu ý:</strong> Thông tin thẻ thư viện không thể chỉnh sửa. 
                                Vui lòng liên hệ thư viện nếu cần gia hạn hoặc thay đổi.
                            </div>
                            <% } %>
                            
                            <!-- Nút hành động -->
                            <div class="d-flex gap-3 mt-4 pt-3 border-top">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Lưu thông tin
                                </button>
                                <a href="<%= request.getContextPath() %>/DocgiaController" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy bỏ
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Thông tin tài khoản -->
                <div class="card mt-3" style="background: rgba(255,255,255,0.95);">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <i class="fas fa-user-circle text-primary"></i>
                                <strong>Tài khoản:</strong> <%= tenDangNhap %>
                            </div>
                            <a href="<%= request.getContextPath() %>/jsp/home.jsp" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-home"></i> Trang chủ
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validation form
        document.getElementById('docgiaForm').addEventListener('submit', function(e) {
            const hoTen = document.querySelector('input[name="hoTen"]').value.trim();
            const email = document.querySelector('input[name="email"]').value.trim();
            
            if (!hoTen) {
                e.preventDefault();
                alert('Vui lòng nhập họ tên!');
                return false;
            }
            
            if (!email) {
                e.preventDefault();
                alert('Vui lòng nhập email!');
                return false;
            }
            
            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ!');
                return false;
            }
            
            // Validate phone if provided
            const phone = document.querySelector('input[name="dienThoai"]').value.trim();
            if (phone) {
                const phoneRegex = /^[0-9]{10,11}$/;
                if (!phoneRegex.test(phone)) {
                    e.preventDefault();
                    alert('Số điện thoại phải có 10-11 chữ số!');
                    return false;
                }
            }
            
            return true;
        });
        
        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>
