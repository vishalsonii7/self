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

@WebServlet("/activeUsers")
public class ActiveServletUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ActiveServletUsers() {
        super();
        // TODO Auto-generated constructor stub
    }

	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authHeader = request.getHeader("Authorization");
        System.out.println("SOUT from doget() method in ActiveuserServlet ");
        String token = null;

        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
        } else {
            // Check for the token in cookies
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if ("authToken".equals(cookie.getName())) {
                        token = cookie.getValue();
                        break;
                    }
                }
            }
        }

        if (token == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Missing or invalid token\"}");
            return;
        }
        
        System.out.println("Token in ActiveServlet =  "+ token);


//        String token = authHeader.substring(7);
        String username = JwtUtil.extractUsername(token);
        if (username == null || !JwtUtil.validateToken(token, username)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Invalid or expired token\"}");
            return;
        }

        UserDao userDao = new UserDao();
        User loggedInUser = userDao.getUserByUsername(username); // Get the logged-in user's details
        
        //Vaise to login hee ni hoyga but lets test 
        if (loggedInUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"User not found\"}");
            return;
        }
        response.setHeader("Authorization", "Bearer " + token);
        
        List<User> activeUsersfriends = userDao.getFriendsByUserId(loggedInUser.getUserId()); 
        System.out.println("The user id by which logged in =  "+loggedInUser.getUserId());
        request.setAttribute("username", username);
        request.setAttribute("activeUsers", activeUsersfriends);
        request.getRequestDispatcher("activeUsers.jsp").forward(request, response);
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
