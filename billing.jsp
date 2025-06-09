<%@ page import="java.sql.*,java.util.*" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Billing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
    function sendCityToServer(city) {
        fetch('storeLocation.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: "city=" + encodeURIComponent(city)
        }).then(response => {
            if (response.ok) {
                location.reload();
            } else {
                console.error("Failed to send city.");
            }
        });
    }


    function getCityName(lat, lon) {
        const apiKey = 'YOUR_API_KEY'; // Replace with your OpenCage API key
        const url = `https://api.opencagedata.com/geocode/v1/json?q=${lat}+${lon}&key=${apiKey}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                const components = data.results[0].components;
                const city = components.city || components.town || components.village || components.state;
                if (city) {
                    sendCityToServer(city);
                } else {
                    console.error("City not found in response");
                }
            })
            .catch(error => {
                console.error("Error in reverse geocoding:", error);
            });
    }

    function getLocationAndSend() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
                (position) => {
                    getCityName(position.coords.latitude, position.coords.longitude);
                },
                (error) => {
                    console.error("Error getting location: ", error.message);
                }
            );
        } else {
            console.error("Geolocation is not supported by this browser.");
        }
    }

    window.onload = getLocationAndSend;
    </script>
</head>
<body>
<div class="container mt-5">
    <h2>Billing Receipt</h2>

    <% 
        String city = (String) session.getAttribute("city");
        if (city != null) {
    %>
        <p><strong>Your City:</strong> <%= city %></p>
    <%
        }
    %>

    <table class="table">
        <thead>
            <tr>
                <th>Book</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <%
                double total = 0;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "js0596");
                    PreparedStatement pst = conn.prepareStatement("SELECT b.title, b.author, b.price, b.image, c.quantity FROM cart c JOIN books b ON c.book_id = b.id WHERE c.user_id = ?");
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
                <td>&#8377;<%= rs.getDouble("price") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td>&#8377;<%= subtotal %></td>
            </tr>
            <%
                    }
                    rs.close();
                    pst.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr><td colspan="6">Error fetching cart data.</td></tr>
            <%
                }
            %>
        </tbody>
    </table>
    <h4>Grand Total: &#8377; <%= total %></h4>
    <p class="mt-3">Thank you for shopping with us!</p>
    <form action="logout" method="post">
        <button type="submit" class="btn btn-danger">Logout</button>
    </form>
</div>
</body>
</html>
