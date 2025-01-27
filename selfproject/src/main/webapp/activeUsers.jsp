<%-- <%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
    // Read attributes from the servlet
    String username = (String) request.getAttribute("username");
    String authToken = (String) request.getAttribute("authToken");

    // Assume a list of active users is passed as an attribute for simplicity
    List<User> activeUsers = (List<User>) request.getAttribute("activeUsers");

    if (username == null || authToken == null) {
        response.sendRedirect("login.jsp"); // Redirect if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Active Users</title>
    <script>
        function sendMessage(receiverId) {
            const message = document.getElementById("message_" + receiverId).value;
            fetch('sendMessage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': sessionStorage.getItem('authToken')
                },
                body: `receiverId=${receiverId}&content=${encodeURIComponent(message)}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Message sent!');
                } else {
                    alert('Error sending message: ' + data.error);
                }
            });
        }
    </script>
</head>
<body>
    <h1>Welcome, ${username}!</h1>
    <h2>Active Users</h2>
    <ul>
        <c:forEach var="user" items="${activeUsers}">
            <li>
                ${user.username}
                <input type="text" id="message_${user.userId}" placeholder="Type your message">
                <button onclick="sendMessage(${user.userId})">Send</button>
            </li>
        </c:forEach>
    </ul>
</body>
</html>
 --%>
 
 
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
    // Read attributes from the servlet
    String username = (String) request.getAttribute("username");
    String authToken = (String) request.getAttribute("authToken");

    // Assume a list of active users is passed as an attribute for simplicity
    List<User> activeUsers = (List<User>) request.getAttribute("activeUsers");

    if (username == null || authToken == null) {
        response.sendRedirect("login.jsp"); // Redirect if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Active Users</title>
    <script>
        // Save the token in sessionStorage for future requests
        sessionStorage.setItem('authToken', '<%= authToken %>');

        function sendMessage(receiverId) {
            const message = document.getElementById("message_" + receiverId).value;
            fetch('sendMessage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Authorization': sessionStorage.getItem('authToken')
                },
                // Correct escaping for JavaScript template literals
                body: "receiverId=" + receiverId + "&content=" + encodeURIComponent(message)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Message sent!');
                } else {
                    alert('Error sending message: ' + data.error);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An unexpected error occurred.');
            });
        }
    </script>
</head>
<body>
    <h1>Welcome, <%= username %>!</h1>
    <h2>Active Users</h2>
    <ul>
        <% for (User user : activeUsers) { %>
            <li>
                <%= user.getUsername() %>
                <input type="text" id="message_<%= user.getUserId() %>" placeholder="Type your message">
                <button onclick="sendMessage(<%= user.getUserId() %>)">Send</button>
            </li>
        <% } %>
    </ul>
</body>
</html>
 --%>
 
 
 
 
 <!-- The Following is for using authtoken by setting in the request.setAttribute()  -->
 
 
 
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
    // Read attributes from the servlet
    String username = (String) request.getAttribute("username");
    String authToken = (String) request.getAttribute("authToken");

    // Assume a list of active users is passed as an attribute for simplicity
    List<User> activeUsers = (List<User>) request.getAttribute("activeUsers");

    if (username == null || authToken == null) {
        response.sendRedirect("login.jsp"); // Redirect if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Active Users</title>
    <script>
        // Function to submit the form with the JWT token in the request header
       	function sendMessage(event, form) {
		    event.preventDefault();
		
		    const token = "<%= authToken %>";
		    const formData = new FormData(form);
		
		    // Convert FormData to URL-encoded format
		    const params = new URLSearchParams();
		    for (const [key, value] of formData.entries()) {
		        params.append(key, value);
		    }
		
		    fetch(form.action, {
		        method: 'POST',
		        headers: {
		            'Authorization': 'Bearer ' + token,
		            'Content-Type': 'application/x-www-form-urlencoded', // Set appropriate content type
		        },
		        body: params.toString() // Send the URL-encoded data
		    })
		    .then(response => response.json())
		    .then(data => {
		        if (data.success) {
		            alert('Message sent successfully');
		        } else {
		            alert('Failed to send message: ' + (data.error || 'Unknown error'));
		        }
		    })
		    .catch(error => {
		        console.error('Error:', error);
		        alert('An error occurred while sending the message');
		    });
		}

    </script>
</head>
<body>
    <h1>Welcome, <%= username %>!</h1>
    <h2>Active Users</h2>
    <ul>
        <% for (User user : activeUsers) { %>
            <li>
                <form action="sendMessage" method="post" onsubmit="sendMessage(event, this)">
		            <p><%= user.getUsername() %></p> 
				    <input type="hidden" name="receiverId" value="<%= user.getUserId() %>">
				    <input type="text" name="content" placeholder="Type your message">
				    <button type="submit">Send</button>
				</form>				
            </li>
        <% } %>
    </ul>
</body>
</html> --%>
 
  
  
  
  
  <!-- And the following is by setting it into the response.setHeader() -->
  
<%--   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
    // Read attributes from the servlet
    String username = (String) request.getAttribute("username");

    // Assume a list of active users is passed as an attribute
    List<User> activeUsers = (List<User>) request.getAttribute("activeUsers");

    if (username == null) {
        response.sendRedirect("login.jsp"); // Redirect if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Active Users</title>
    <script>
        /* // JavaScript to get the Authorization token from the response header
        window.onload = function() {
            var token = localStorage.getItem("authToken");
            if (token) {
                console.log("Token from localStorage: ", token);
            } else {
                var authHeader = document.cookie.replace(/(?:(?:^|.*;\s*)Authorization\s*\=\s*([^;]*).*$)|^.*$/, "$1");
                if (authHeader) {
                    // Saving the token into localStorage for further use
                    localStorage.setItem("authToken", authHeader);
                    console.log("Token from header: ", authHeader);
                }
            }
        }; */
        
        // JavaScript to handle the form submission and include the Authorization header
        window.onload = function() {
            var token = '<%= request.getAttribute("authToken") %>';  // Get the token set by the servlet

            // Attach token to the form's request headers on submission
            const forms = document.querySelectorAll('form');
            forms.forEach(function(form) {
                form.onsubmit = function(event) {
                    event.preventDefault();  // Prevent the form from submitting normally
                    var formData = new FormData(form);
                    var xhr = new XMLHttpRequest();
                    xhr.open(form.method, form.action, true);
                    xhr.setRequestHeader('Authorization', 'Bearer ' + token);  // Set Authorization header
                    xhr.onload = function() {
                        if (xhr.status === 200) {
                            alert("Message sent successfully!");
                        } else {
                            alert("Failed to send message.");
                        }
                    };
                    xhr.send(formData);  // Send the form data via AJAX
                };
            });
        };
    </script>
</head>
<body>
    <h1>Welcome, <%= username %>!</h1>
    <h2>Active Users</h2>
    <ul>
        <% for (User user : activeUsers) { %>
            <li>
                <form action="sendMessage" method="post">
                    <p><%= user.getUsername() %></p>
                    <input type="hidden" name="receiverId" value="<%= user.getUserId() %>">
                    <input type="text" name="content" placeholder="Type your message">
                    <button type="submit">Send</button>
                </form>
            </li>
        <% } %>
    </ul>
</body>
</html>
   --%>
   
   
   
   
   
   
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
    // Read attributes from the servlet
    String username = (String) request.getAttribute("username");

    // Assume a list of active users is passed as an attribute for simplicity
    List<User> activeUsers = (List<User>) request.getAttribute("activeUsers");

    if (username == null ) {
        response.sendRedirect("login.jsp"); // Redirect if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Active Users</title>
    <script>
    window.onload = function() {
    	   var token = localStorage.getItem("authToken");
    	   
    	   if (token) {
    	       console.log("Token from localStorage: ", token);
    	   } else {
    	       // If not found in localStorage, attempt to retrieve from cookie
    	       var authHeader = document.cookie.replace(/(?:(?:^|.*;\s*)authToken\s*\=\s*([^;]*).*$)|^.*$/, "$1");
    	       if (authHeader) {
    	           // Save the token in localStorage for future use
    	           localStorage.setItem("authToken", authHeader);
    	           console.log("Token from cookie: ", authHeader);
    	       }
    	   }
    	};

        // Function to submit the form with the JWT token in the request header
        function sendMessage(event, form) {
		    event.preventDefault();
		
		    // Retrieve token from localStorage
		    const token = localStorage.getItem("authToken");
		    if (!token) {
		        alert("Unauthorized: No token available");
		        return;
		    }
		
		    const formData = new FormData(form);
		
		    // Convert FormData to URL-encoded format
		    const params = new URLSearchParams();
		    for (const [key, value] of formData.entries()) {
		        params.append(key, value);
		    }
		
		    fetch(form.action, {
		        method: 'POST',
		        headers: {
		            'Authorization': 'Bearer ' + token,  // Pass the token as an Authorization header
		            'Content-Type': 'application/x-www-form-urlencoded',  // Set appropriate content type
		        },
		        body: params.toString()  // Send the URL-encoded data
		    })
		    .then(response => response.json())
		    .then(data => {
		        if (data.success) {
		            alert('Message sent successfully');
		        } else {
		            alert('Failed to send message: ' + (data.error || 'Unknown error'));
		        }
		    })
		    .catch(error => {
		        console.error('Error:', error);
		        alert('An error occurred while sending the message');
		    });
		}

    </script>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
	<div class="container">
	    <h1>Welcome, <%= username %>!</h1>
	    <h2>Active Users</h2>
	    <ul>
	        <% for (User user : activeUsers) { %>
	            <li>
	                <form action="sendMessage" method="post" onsubmit="sendMessage(event, this)">
	                    <p><%= user.getUsername() %></p>
	                    <input type="hidden" name="receiverId" value="<%= user.getUserId() %>">
	                    <input type="text" name="content" placeholder="Type your message">
	                    <button type="submit">Send</button>
	                </form>              
	            </li>
	        <% } %>
	    </ul>
	</div>
</body>
</html>

