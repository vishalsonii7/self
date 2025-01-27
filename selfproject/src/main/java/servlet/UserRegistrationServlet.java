package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.UserDao;

@WebServlet("/register")
public class UserRegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UserRegistrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // Validate the user input (basic validation)
        if (username.isEmpty() || password.isEmpty() || email.isEmpty()) {
            response.sendRedirect("register.jsp?error=emptyfields");
            return;
        }

        // Store user in the database
        UserDao userDao = new UserDao();
        if (userDao.registerUser(username, password, email)) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("register.jsp?error=userexists");
        }
    }

}
