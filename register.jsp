<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<h1 class="text-center my-5 heading-5">Welcome To Online Book Store!</h1>
<div class="container mt-5 w-50 border rounded">
    <h2 class="my-4 text-center">Register</h2>
    <form method="post" action="register">
        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Registration failed. Try again.</div>
        <% } %>
        <div class="text-center"><button type="submit" class="btn btn-success">Register</button>
        <p class="mt-3">Already have an account? <a href="index.jsp">Login</a></p></div>
    </form>
</div>
</body>
</html>
