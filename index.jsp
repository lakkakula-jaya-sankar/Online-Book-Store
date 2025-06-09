<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
	<h1 class="text-center my-5 heading-5">Welcome To Online Book Store!</h1>
    <div class="container mt-5">
        <div class="col-md-6 offset-md-3 border rounded p-4 bg-white">
            <h3 class="mb-4 text-center">Login</h3>
            <form action="login" method="post">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="text" class="form-control" name="email" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <button class="btn btn-primary w-100">Login</button>
                <p class="mt-3 text-center">Don't have an account? <a href="register.jsp">Register</a></p>
                
            </form>
            
            <% if (request.getParameter("error") != null) { %>
			        <p style="color:red;">Invalid email or password</p>
			    <% } %>
        </div>
    </div>
</body>
</html>
