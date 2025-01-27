package dao;

import java.sql.*;
import java.util.*;

import entity.Message;
import utility.DatabaseConnection;  // Import the DatabaseConnection class

public class MessageDao {

    // Use the utility DatabaseConnection class to get a connection
    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    // Save a message to the database
    public boolean saveMessage(int senderId, int receiverId, String content) {
        String query = "INSERT INTO messages (sender_id, receiver_id, content, timestamp) VALUES (?, ?, ?, NOW())";
        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setString(3, content);
            int result = stmt.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Retrieve chat history for a user
    public List<Message> getChatHistory(String username) {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT m.message_id, m.sender_id, m.receiver_id, m.content, m.timestamp " +
                       "FROM messages m " +
                       "JOIN users u ON m.sender_id = u.user_id " +
                       "WHERE u.username = ? " +
                       "ORDER BY m.timestamp DESC";
        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("message_id"));
                message.setSenderId(rs.getInt("sender_id"));
                message.setReceiverId(rs.getInt("receiver_id"));
                message.setContent(rs.getString("content"));
                message.setTimestamp(rs.getString("timestamp"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    // Get all messages between two users (for private chat)
    public List<Message> getMessagesBetweenUsers(int userId1, int userId2) {
        List<Message> messages = new ArrayList<>();
        String query = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp ASC";
        try (Connection con = getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, userId1);
            stmt.setInt(2, userId2);
            stmt.setInt(3, userId2);
            stmt.setInt(4, userId1);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setMessageId(rs.getInt("message_id"));
                message.setSenderId(rs.getInt("sender_id"));
                message.setReceiverId(rs.getInt("receiver_id"));
                message.setContent(rs.getString("content"));
                message.setTimestamp(rs.getString("timestamp"));
                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }
}
