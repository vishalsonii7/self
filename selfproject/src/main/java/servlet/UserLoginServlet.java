package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import utility.JwtUtil;

import java.io.IOException;
import java.util.List;

import dao.UserDao;
import entity.User;

@WebServlet("/login")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UserLoginServlet() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();
        User user = userDao.loginUser(username, password);

        if (user != null) {
            
            String token = JwtUtil.generateToken(username);
            Cookie cookie = new Cookie("authToken", token);

            response.setHeader("Authorization", "Bearer " + token);
            cookie.setHttpOnly(true);  // Make sure the cookie is not accessible via JavaScript (security measure)
            //cookie.setSecure(true);    // Use this if you're using HTTPS
            cookie.setPath("/"); 
            response.addCookie(cookie);
            
         // Add token and user info as request attributes
            List<User> activeUsers = userDao.getActiveUsers();
            String username1 = JwtUtil.extractUsername(token);
            System.out.println("This shows the active users in database :- "+activeUsers+ 
            		" and this is the extracted username =  "+ username1 + "  \nand this is the Token =  "+ token);
//            request.setAttribute("authToken", token);
            //request.setAttribute("username", username);
           // request.setAttribute("activeUsers", activeUsers);
            

            
         // Forward to activeUsers.jsp
            response.sendRedirect("activeUsers");

        } else {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Invalid username or password\"}");
        }
    }

}
