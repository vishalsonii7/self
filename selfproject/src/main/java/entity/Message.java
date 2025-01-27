package entity;

public class Message {
    private int messageId;
    private int senderId;
    private int receiverId;
    private String content;
    private String timestamp;

    public Message() {super();}
    
    
    // Getters and Setters
    public int getMessageId() {
        return messageId;
    }

    public Message(int messageId, int senderId, int receiverId, String content, String timestamp) {
		super();
		this.messageId = messageId;
		this.senderId = senderId;
		this.receiverId = receiverId;
		this.content = content;
		this.timestamp = timestamp;
	}

	public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
    }

    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
