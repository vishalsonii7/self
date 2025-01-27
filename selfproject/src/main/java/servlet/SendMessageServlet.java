package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utility.JwtUtil;

import java.io.IOException;

import dao.MessageDao;
import dao.UserDao;
import entity.User;

@WebServlet("/sendMessage")
public class SendMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public SendMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    System.out.println("Hiie ! 1 ");
	    System.out.println("Request parameters:");
	    request.getParameterMap().forEach((key, values) -> 
	        System.out.println(key + ": " + String.join(", ", values))
	    );
	    
	    // Get the Authorization header
	    String authHeader = request.getHeader("Authorization");
	    if (authHeader == null || !authHeader.startsWith("Bearer ")) {
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        response.getWriter().write("{\"error\":\"Missing or invalid token\"}");
	        return;
	    }
	    System.out.println("Hiie ! 2 ");
	    
	    // Extract the token and validate it
	    String token = authHeader.substring(7); // Extract the token after "Bearer "
	    String username = JwtUtil.extractUsername(token);
	    if (username == null || !JwtUtil.validateToken(token, username)) {
	    	System.out.println("Username = "+ username + "  Token = "+token);
	        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
	        response.getWriter().write("{\"error\":\"Invalid or expired token\"}");
	        return;
	    }
	    System.out.println("Hiie ! 3 ");
	    
	    // Get parameters from the form
	    String receiverIdParam = request.getParameter("receiverId");
	    String content = request.getParameter("content");
	    
	    // Debugging: Check if receiverId and content are being passed correctly
	    System.out.println("Received receiverId: " + receiverIdParam);  // Debugging line
	    System.out.println("Received content: " + content);  // Debugging line

	    // Check if receiverId is valid
	    if (receiverIdParam == null || receiverIdParam.isEmpty()) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"error\":\"Missing receiverId\"}");
	        return;
	    }

	    // Parse the receiverId (if valid)
	    int receiverId = 0;
	    try {
	        receiverId = Integer.parseInt(receiverIdParam);  // Parse receiverId
	    } catch (NumberFormatException e) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"error\":\"Invalid receiverId\"}");
	        return;
	    }

	    // Ensure content is not empty
	    if (content == null || content.isEmpty()) {
	        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	        response.getWriter().write("{\"error\":\"Message content cannot be empty\"}");
	        return;
	    }

	    // Debugging: Check parsed receiverId and content
	    System.out.println("Parsed receiverId: " + receiverId);
	    System.out.println("Message content: " + content);
	    
	    System.out.println("Content-Type: " + request.getContentType());


	    // Proceed with sending the message
	    UserDao userDao = new UserDao();
	    User sender = userDao.getUserByUsername(username);  // Get the sender from the database

	    MessageDao messageDao = new MessageDao();
	    boolean isSuccess = messageDao.saveMessage(sender.getUserId(), receiverId, content);
	    
	    response.setContentType("application/json");
	    if (isSuccess) {
	        response.getWriter().write("{\"success\":true}");
	    } else {
	        response.getWriter().write("{\"success\":false, \"error\":\"Failed to send message\"}");
	    }
	}

}
