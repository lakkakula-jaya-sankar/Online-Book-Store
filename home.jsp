<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Store - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
	<div>
    	<h2 class="float-start">Welcome, <%= session.getAttribute("username") %>!</h2>
    	<a href="cart.jsp" class="btn btn-warning d-block float-end">View Cart</a>
    	<div class="clearfix"></div>
    </div>
    <div class="row mt-5">
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "js0596");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM books");

            while (rs.next()) {
        %>
        <div class="col-md-4 mb-4">
            <div class="card h-100">
    			<img src="<%= rs.getString("image") %>" class="card-img-top" alt="Book Image" style="height: 200px; object-fit: cover;">
    			<div class="card-body">
        			<h5 class="card-title"><%= rs.getString("title") %></h5>
        			<p class="card-text">Author: <%= rs.getString("author") %></p>
        			<p class="card-text">Price: &#8377; <%= rs.getDouble("price") %></p>
        			<form action="addToCart" method="post">
            			<input type="hidden" name="bookId" value="<%= rs.getInt("id") %>">
            			<input type="number" name="quantity" value="1" min="1" class="form-control mb-2">
            			<button type="submit" class="btn btn-primary">Add to Cart</button>
        			</form>
    			</div>
			</div>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
