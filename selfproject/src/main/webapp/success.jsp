<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="utility.DatabaseConnection" %>
<%@ page import="utility.JwtUtil" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // Get the JWT token from the cookies
    Cookie[] cookies = request.getCookies();
    String token = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwt".equals(cookie.getName())) {
                token = cookie.getValue();
                System.out.println("Your token is = "+token);
                break;
            }
        }
    }

    if (token == null || !JwtUtil.isValidToken(token)) {
        // If no valid JWT token, redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }

    // Decode the token to extract the username (or any other information)
    String username = JwtUtil.extractUsername(token);
    System.out.println("Username = "+username);
%>
<%-- <%
    // Retrieve the username from the session, because it's being stored in the session in LoginServlet
    String username = (String) session.getAttribute("username");
    if (username == null) {
    	System.out.println("username is null");
        response.sendRedirect("login.jsp");
        return;
    }
%> --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Success</title>
    <style>
        /* General body styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* Container for content */
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 900px;
            text-align: center;
        }

        /* Header styling */
        h2 {
            color: #333;
            font-size: 28px;
            margin-bottom: 20px;
        }

        h3 {
            color: #007bff;
            font-size: 20px;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        /* Style for paragraphs */
        p {
            color: #555;
            font-size: 16px;
            margin-bottom: 15px;
        }

        /* Styling the JWT token textarea */
        textarea {
            width: 100%;
            height: 150px;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
            resize: none;
            margin-bottom: 20px;
            box-sizing: border-box;
            font-family: 'Courier New', monospace;
        }

        /* Form styling */
        form {
            margin-bottom: 30px;
            text-align: left;
        }

        label {
            font-size: 14px;
            margin-bottom: 8px;
            display: block;
            color: #555;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        button[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="button"]:hover {
            background-color: #0056b3;
        }

		button[type="button"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #0056b3;
        }

        /* Table styling */
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            font-size: 16px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        tr:nth-child(even) td {
            background-color: #f1f1f1;
        }

        tr:hover td {
            background-color: #e1e1e1;
        }

        /* Styling the logout button */
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #0056b3;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                width: 100%;
                padding: 15px;
            }

            h2 {
                font-size: 24px;
            }

            h3 {
                font-size: 18px;
            }

            table {
                font-size: 14px;
            }

            input[type="text"], button[type="submit"] {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
    Hii there !
        <h2>Welcome, <%= username %></h2>  <!-- Displaying the username directly from session -->
        <h3>Your JWT Token:</h3>
        <textarea readonly><%= token %></textarea>  <!-- Accessing token attribute -->

        <h3>Add Employee</h3>
        <form action="addemployeeservlet" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required><br>
            <label for="salary">Salary:</label>
            <input type="text" id="salary" name="salary" required><br>
            <label for="experience">Experience:</label>
            <input type="text" id="experience" name="experience" required><br>
            <label for="company">Company:</label>
            <input type="text" id="company" name="company" required><br>
            <button type="submit">Add Employee</button>
<!--             <button type="button" onclick="location.href='showall.jsp'" >Show All Employees</button>
 -->        </form>
        
       

    <h3>Employee List</h3>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Salary</th>
            <th>Experience</th>
            <th>Company</th>
        </tr>
        <%
            try (Connection conn = DatabaseConnection.getConnection()) {
                String sql = "SELECT * FROM token_employees WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getDouble("salary") %></td>
            <td><%= rs.getInt("experience") %></td>
            <td><%= rs.getString("company") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <a href="logoutservlet">Logout</a>
    </div>
</body>
</html>

