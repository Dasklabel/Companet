package message;

public class Message {
	private int ID;
	private String Title;
	private String userID;
	private String Date;
	private String Content;
	private String ReceiveID;
	private int Available;
	
	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public int getAvailable() {
		return Available;
	}
	public void setAvailable(int available) {
		Available = available;
	}
	public String getReceiveID() {
		return ReceiveID;
	}
	public void setReceiveID(String receiveID) {
		ReceiveID = receiveID;
	}
}
