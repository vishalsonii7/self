<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/socket.io/4.0.1/socket.io.min.js"></script>
    <script>
        const socket = new WebSocket("ws://localhost:8080/yourproject/chat/" + "${sessionScope.username}");
        socket.onmessage = function(event) {
            const message = event.data;
            document.getElementById("chat-box").innerHTML += "<p>" + message + "</p>";
        };

        function sendMessage() {
            const message = document.getElementById("message-input").value;
            socket.send(message);
            document.getElementById("message-input").value = "";
        }
    </script>
</head>
<body>
    <h2>Welcome, ${sessionScope.username}</h2>
    <button onclick="window.location.href='logout'">Logout</button>
    <div id="chat-box">
        <c:forEach var="message" items="${messages}">
            <p>${message.sender}: ${message.content}</p>
        </c:forEach>
    </div>
    <input type="text" id="message-input" placeholder="Type your message...">
    <button onclick="sendMessage()">Send</button>
</body>
</html>
