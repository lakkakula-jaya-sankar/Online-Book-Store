<%@ page import="java.sql.*,java.util.*" %>
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
    <title>Your Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Your Cart</h2>
    <table class="table">
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <%
                double total = 0;
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "js0596");
                PreparedStatement pst = conn.prepareStatement("SELECT b.title, b.author, b.price, c.quantity, b.image FROM cart c JOIN books b ON c.book_id = b.id WHERE c.user_id = ?");
                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
                    double subtotal = rs.getDouble("price") * rs.getInt("quantity");
                    total += subtotal;
            %>
            <tr>
        		<td><img src="<%= rs.getString("image") %>" width="60"></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td>&#8377; <%= rs.getDouble("price") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td>&#8377; <%= subtotal %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <h4>Total: &#8377; <%= total %></h4>
    <a href="billing.jsp" class="btn btn-primary">Proceed to Bill</a>
</div>
</body>
</html>