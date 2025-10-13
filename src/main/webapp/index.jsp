<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utils.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
  <title>LibraryJSP - Test</title>
</head>
<body>
  <h2>Hello JSP is working!</h2>
  <%
      out.println("Server time: " + new java.util.Date());
  %>
  
  <%
    java.sql.Connection conn = DBConnection.getConnection();
    if (conn != null)
        out.println("<p style='color:green'>✅ Kết nối thành công!</p>");
    else
        out.println("<p style='color:red'>❌ Kết nối thất bại!</p>");
%>
  

</body>
</html>
