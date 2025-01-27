package utility;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.util.Date;

public class JwtUtil {

    // Secret key for signing the JWT (this can be moved to a config file for better security)
    private static final SecretKey SECRET_KEY = Keys.hmacShaKeyFor("your_secret_key_your_secret_key_your_secret_key".getBytes());

    // Generate a JWT token
    public static String generateToken(String username) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + 3600000)) // 1 hour expiration
                .signWith(SECRET_KEY)
                .compact();
    }

    // Parse and validate the JWT token, and extract the claims
    public static String parseToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (Exception e) {
            return null; // Invalid token
        }
    }

    // Method to check if the JWT token is valid
    public static boolean isValidToken(String token) {
        return parseToken(token) != null; // If the token parses successfully, it is valid
    }

    // Method to extract the username (subject) from the JWT token
    public static String extractUsername(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return claims.getSubject(); // Return the username (subject) from the token
        } catch (Exception e) {
        	System.out.println("Can't extract the token ! ");
            return null; // If token is invalid or cannot extract the username
        }
    }

    // Check if the token is expired
    public static boolean isTokenExpired(String token) {
        try {
            Claims claims = Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
            return claims.getExpiration().before(new Date()); // Compare expiration with current time
        } catch (Exception e) {
            return true; // If there's an error (invalid token), consider it expired
        }
    }

    // Validate the JWT token
    public static boolean validateToken(String token, String username) {
        return (username.equals(extractUsername(token)) && !isTokenExpired(token));
    }
}
