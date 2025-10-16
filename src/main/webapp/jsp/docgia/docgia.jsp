<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.DocGia" %>
<%@ page import="java.util.List" %>
<%
    // Kiểm tra đăng nhập
    if (session == null || session.getAttribute("tenDangNhap") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }

    Integer maTK = (Integer) session.getAttribute("maTK");
    String tenDangNhap = (String) session.getAttribute("tenDangNhap");
    String vaiTro = (String) session.getAttribute("vaiTro");
    
    DocGia docGia = (DocGia) request.getAttribute("docGia");
    List<DocGia> docGiaList = (List<DocGia>) request.getAttribute("docGiaList");
    Boolean editMode = (Boolean) request.getAttribute("editMode");
    Boolean readOnly = (Boolean) request.getAttribute("readOnly");
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    
    if (editMode == null) editMode = false;
    if (readOnly == null) readOnly = false;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý độc giả - Thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,.1);
            margin-bottom: 20px;
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .form-label {
            font-weight: 600;
            color: #495057;
        }
        .info-row {
            padding: 12px;
            border-bottom: 1px solid #e9ecef;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            font-weight: 600;
            color: #6c757d;
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/jsp/home.jsp">
                <i class="fas fa-book-reader"></i> Quản lý thư viện
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text text-white me-3">
                    <i class="fas fa-user"></i> <%= tenDangNhap %> (<%= vaiTro %>)
                </span>
                <a href="<%= request.getContextPath() %>/jsp/home.jsp" class="btn btn-outline-light btn-sm me-2">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a href="<%= request.getContextPath() %>/LogoutController" class="btn btn-outline-light btn-sm">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Thông báo -->
        <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <% if (message != null && !message.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if ("DOCGIA".equals(vaiTro)) { %>
            <!-- Giao diện cho độc giả -->
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">
                        <i class="fas fa-id-card"></i> Thông tin cá nhân
                    </h4>
                </div>
                <div class="card-body">
                    <% if (docGia == null && !editMode) { %>
                        <!-- Chưa có thông tin -->
                        <div class="text-center py-5">
                            <i class="fas fa-user-plus fa-4x text-muted mb-3"></i>
                            <h5>Chưa có thông tin độc giả</h5>
                            <p class="text-muted">Vui lòng cập nhật thông tin cá nhân của bạn</p>
                            <a href="?action=edit" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Cập nhật thông tin
                            </a>
                        </div>
                    <% } else if (editMode || docGia == null) { %>
                        <!-- Form chỉnh sửa -->
                        <form method="post" action="<%= request.getContextPath() %>/DocgiaController">
                            <input type="hidden" name="action" value="update">
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Họ và tên <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="hoTen" 
                                           value="<%= docGia != null ? docGia.getHoTen() : "" %>" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày sinh</label>
                                    <input type="date" class="form-control" name="ngaySinh" 
                                           value="<%= docGia != null && docGia.getNgaySinh() != null ? docGia.getNgaySinh() : "" %>">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Địa chỉ</label>
                                <input type="text" class="form-control" name="diaChi" 
                                       value="<%= docGia != null && docGia.getDiaChi() != null ? docGia.getDiaChi() : "" %>">
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Điện thoại</label>
                                    <input type="tel" class="form-control" name="dienThoai" 
                                           value="<%= docGia != null && docGia.getDienThoai() != null ? docGia.getDienThoai() : "" %>"
                                           pattern="[0-9]{10,11}" placeholder="Ví dụ: 0912345678">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" name="email" 
                                           value="<%= docGia != null && docGia.getEmail() != null ? docGia.getEmail() : "" %>" required>
                                </div>
                            </div>
                            
                            <% if (docGia != null) { %>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày cấp thẻ</label>
                                    <input type="date" class="form-control" name="ngayCapThe" 
                                           value="<%= docGia.getNgayCapThe() %>" readonly>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Ngày hết hạn thẻ</label>
                                    <input type="date" class="form-control" name="ngayHetHanThe" 
                                           value="<%= docGia.getNgayHetHanThe() %>" readonly>
                                </div>
                            </div>
                            <% } %>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Lưu thông tin
                                </button>
                                <% if (docGia != null) { %>
                                <a href="<%= request.getContextPath() %>/DocgiaController" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                                <% } %>
                            </div>
                        </form>
                    <% } else { %>
                        <!-- Hiển thị thông tin -->
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Mã độc giả:</div>
                                <div class="col-md-9"><%= docGia.getMaDocGia() %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Họ và tên:</div>
                                <div class="col-md-9"><%= docGia.getHoTen() %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Ngày sinh:</div>
                                <div class="col-md-9"><%= docGia.getNgaySinh() != null ? docGia.getNgaySinh() : "Chưa cập nhật" %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Địa chỉ:</div>
                                <div class="col-md-9"><%= docGia.getDiaChi() != null && !docGia.getDiaChi().isEmpty() ? docGia.getDiaChi() : "Chưa cập nhật" %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Điện thoại:</div>
                                <div class="col-md-9"><%= docGia.getDienThoai() != null && !docGia.getDienThoai().isEmpty() ? docGia.getDienThoai() : "Chưa cập nhật" %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Email:</div>
                                <div class="col-md-9"><%= docGia.getEmail() %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Ngày cấp thẻ:</div>
                                <div class="col-md-9"><%= docGia.getNgayCapThe() %></div>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="row">
                                <div class="col-md-3 info-label">Ngày hết hạn:</div>
                                <div class="col-md-9"><%= docGia.getNgayHetHanThe() %></div>
                            </div>
                        </div>
                        
                        <div class="mt-4">
                            <a href="?action=edit" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Chỉnh sửa thông tin
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } else { %>
            <!-- Giao diện cho Admin/Nhân viên - Xem danh sách -->
            <div class="card">
                <div class="card-header">
                    <h4 class="mb-0">
                        <i class="fas fa-users"></i> Danh sách độc giả
                    </h4>
                </div>
                <div class="card-body">
                    <% if (docGiaList != null && !docGiaList.isEmpty()) { %>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Mã</th>
                                        <th>Họ tên</th>
                                        <th>Ngày sinh</th>
                                        <th>Điện thoại</th>
                                        <th>Email</th>
                                        <th>Ngày cấp thẻ</th>
                                        <th>Hết hạn</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (DocGia dg : docGiaList) { %>
                                    <tr>
                                        <td><%= dg.getMaDocGia() %></td>
                                        <td><%= dg.getHoTen() %></td>
                                        <td><%= dg.getNgaySinh() != null ? dg.getNgaySinh() : "" %></td>
                                        <td><%= dg.getDienThoai() != null ? dg.getDienThoai() : "" %></td>
                                        <td><%= dg.getEmail() %></td>
                                        <td><%= dg.getNgayCapThe() %></td>
                                        <td><%= dg.getNgayHetHanThe() %></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <div class="text-center py-5">
                            <i class="fas fa-users-slash fa-4x text-muted mb-3"></i>
                            <h5>Chưa có độc giả nào</h5>
                        </div>
                    <% } %>
                </div>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>