package product.model.vo;

import java.sql.Timestamp;

public class PComment {
	private int commentNum;
	private int o_Num;
	private int commentLevel;
	private String memberId;
	private String comment;
	private Timestamp wrDate;
	private Timestamp modifyDate;
	private String status;
	private String memberName;
	private String pImage;
	
	public PComment() {}
	
	public PComment(int o_Num, String memberId, String comment) {
		super();
		this.o_Num = o_Num;
		this.memberId = memberId;
		this.comment = comment;
	}

	
	

	public PComment(int commentNum, int o_Num, String memberId, String comment, Timestamp wrDate, String memberName, String pImage) {
		super();
		this.commentNum = commentNum;
		this.o_Num = o_Num;
		this.memberId = memberId;
		this.comment = comment;
		this.wrDate = wrDate;
		this.memberName = memberName;
		this.pImage = pImage;
	}

	public PComment(int commentNum, int o_Num, int commentLevel, String memberId, String comment, Timestamp wrDate,
			Timestamp modifyDate, String status, String pImage) {
		super();
		this.commentNum = commentNum;
		this.o_Num = o_Num;
		this.commentLevel = commentLevel;
		this.memberId = memberId;
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

	public int getO_Num() {
		return o_Num;
	}

	public void setO_Num(int o_Num) {
		this.o_Num = o_Num;
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

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	@Override
	public String toString() {
		return "PComment [commentNum=" + commentNum + ", o_Num=" + o_Num + ", commentLevel=" + commentLevel
				+ ", memberId=" + memberId + ", comment=" + comment + ", wrDate=" + wrDate + ", modifyDate="
				+ modifyDate + ", status=" + status + ", memberName=" + memberName + ", pImage=" + pImage + "]";
	}

	
	
	
	
	
}
