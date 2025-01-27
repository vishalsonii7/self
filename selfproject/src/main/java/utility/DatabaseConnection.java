package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public static final String URL = "jdbc:mysql://localhost:3306/self";
    public static final String USERNAME = "root";
    public static final String PASSWORD = "root"; 

    public static Connection getConnection() throws SQLException {
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver"); 
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found!", e);
        }
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
