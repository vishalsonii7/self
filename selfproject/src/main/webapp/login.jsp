<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
	<div class="container">
	    <h2>Login</h2>
	    <form action="login" method="post">
	        <input type="text" name="username" placeholder="Username" required>
	        <input type="password" name="password" placeholder="Password" required>
	        <button type="submit">Login</button>
	    </form>
	    <p><a href="register.jsp">Don't have an account? Register here</a></p>
	
	    <c:if test="${param.error == 'invalidcredentials'}">
	        <p class="error">Invalid username or password!</p>
	    </c:if>
    </div>
</body>
</html>
