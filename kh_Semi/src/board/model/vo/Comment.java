package board.model.vo;

import java.sql.Timestamp;

public class Comment {
	private int commentNum;
	private int boardNum;
	private int commentLevel;
	private String memberId;
	private String memberName;
	private String comment;
	private Timestamp wrDate;
	private Timestamp modifyDate;
	private String status;
	private String pImage;
	
	public Comment() {
	}
	
	

	public Comment(int boardNum, String memberId, String comment) {
		this.boardNum = boardNum;
		this.memberId = memberId;
		this.comment = comment;
	}

	public Comment(int commentNum, int boardNum, int commentLevel, String memberId, String memberName, String comment,
			Timestamp wrDate, Timestamp modifyDate, String status, String pImage) {
		this.commentNum = commentNum;
		this.boardNum = boardNum;
		this.commentLevel = commentLevel;
		this.memberId = memberId;
		this.memberName = memberName;
		this.comment = comment;
		this.wrDate = wrDate;
		this.modifyDate = modifyDate;
		this.status = status;
		this.pImage = pImage;
	}



	public int getCommentNum() {
		return commentNum;
	}



	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}



	public int getBoardNum() {
		return boardNum;
	}



	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}



	public int getCommentLevel() {
		return commentLevel;
	}



	public void setCommentLevel(int commentLevel) {
		this.commentLevel = commentLevel;
	}



	public String getMemberId() {
		return memberId;
	}



	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}



	public String getMemberName() {
		return memberName;
	}



	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}



	public Timestamp getWrDate() {
		return wrDate;
	}



	public void setWrDate(Timestamp wrDate) {
		this.wrDate = wrDate;
	}



	public Timestamp getModifyDate() {
		return modifyDate;
	}



	public void setModifyDate(Timestamp modifyDate) {
		this.modifyDate = modifyDate;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getpImage() {
		return pImage;
	}



	public void setpImage(String pImage) {
		this.pImage = pImage;
	}



	@Override
	public String toString() {
		return "Comment [commentNum=" + commentNum + ", boardNum=" + boardNum + ", commentLevel=" + commentLevel
				+ ", memberId=" + memberId + ", memberName=" + memberName + ", comment=" + comment + ", wrDate="
				+ wrDate + ", modifyDate=" + modifyDate + ", status=" + status + ", pImage=" + pImage + "]";
	}


	


}
