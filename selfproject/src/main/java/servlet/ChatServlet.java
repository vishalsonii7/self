package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utility.JwtUtil;

import java.io.IOException;
import java.util.List;

import dao.MessageDao;
import entity.Message;


public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ChatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authHeader = request.getHeader("Authorization");

        // Check if the Authorization header exists and contains the Bearer token
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Missing or invalid token\"}");
            return;
        }

        // Extract the token from the header
        String token = authHeader.substring(7);
        String username = JwtUtil.extractUsername(token);

        // Validate the token
        if (username != null && JwtUtil.validateToken(token, username)) {
            // Token is valid, proceed with fetching chat history
            MessageDao messageDao = new MessageDao();
            List<Message> messages = messageDao.getChatHistory(username);

            request.setAttribute("messages", messages);
            request.getRequestDispatcher("chat.jsp").forward(request, response);
        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Invalid or expired token\"}");
        }
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
