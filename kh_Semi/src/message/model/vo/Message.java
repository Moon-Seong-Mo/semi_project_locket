package message.model.vo;

import java.sql.Date;

public class Message {
	private int message_Num;
	private String memberId;
	private String nickname;
	private String sendId;
	private String MContent;
	private Date sendDate;
	
	public Message() {}

	public Message(int message_Num, String memberId, String sendId, String mContent, Date sendDate) {
		super();
		this.message_Num = message_Num;
		this.memberId = memberId;
		this.sendId = sendId;
		MContent = mContent;
		this.sendDate = sendDate;
	}
	
	public Message(int message_Num, String memberId, String nickname, String sendId, String mContent, Date sendDate) {
		super();
		this.message_Num = message_Num;
		this.memberId = memberId;
		this.nickname = nickname;
		this.sendId = sendId;
		MContent = mContent;
		this.sendDate = sendDate;
	}

	public int getMessage_Num() {
		return message_Num;
	}

	public void setMessage_Num(int message_Num) {
		this.message_Num = message_Num;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getSendId() {
		return sendId;
	}

	public void setSendId(String sendId) {
		this.sendId = sendId;
	}

	public String getMContent() {
		return MContent;
	}

	public void setMContent(String mContent) {
		MContent = mContent;
	}

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Override
	public String toString() {
		return "Message [message_Num=" + message_Num + ", memberId=" + memberId + ", nickname=" + nickname + ", sendId="
				+ sendId + ", MContent=" + MContent + ", sendDate=" + sendDate + "]";
	}

	
	
	
}
