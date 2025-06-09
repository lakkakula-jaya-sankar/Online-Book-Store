<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
    String city = request.getParameter("city");
    if (city != null) {
        session.setAttribute("city", city);
    }
%>
	
</body>
</html>