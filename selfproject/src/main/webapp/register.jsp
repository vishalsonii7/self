<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Create an Account</h2>
    <form action="register" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="email" name="email" placeholder="Email" required>
        <button type="submit">Register</button>
    </form>
    <p><a href="login.jsp">Already have an account? Login here</a></p>

    <c:if test="${param.error == 'emptyfields'}">
        <p class="error">Please fill all fields!</p>
    </c:if>
    <c:if test="${param.error == 'userexists'}">
        <p class="error">Username already exists!</p>
    </c:if>
</body>
</html>
    