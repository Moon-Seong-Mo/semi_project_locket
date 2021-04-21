package product.model.vo;

import java.sql.Date;

public class Deal {
	private String member; //거래 신청하는 사람
	private int productId;
	private String productTitle;
	private String receiver;  //신청 받는 사람
	private Date send_date;
	private String status;
	
	public Deal() {}

	public Deal(String member, int productId, String productTitle, String receiver, Date send_date, String status) {
		super();
		this.member = member;
		this.productId = productId;
		this.productTitle = productTitle;
		this.receiver = receiver;
		this.send_date = send_date;
		this.status = status;
	}
	
	public Deal(String member, int productId, String productTitle, String receiver, Date send_date) {
		super();
		this.member = member;
		this.productId = productId;
		this.productTitle = productTitle;
		this.receiver = receiver;
		this.send_date = send_date;
	}

	public String getMember() {
		return member;
	}

	public void setMember(String member) {
		this.member = member;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public Date getSend_date() {
		return send_date;
	}

	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Deal [member=" + member + ", productId=" + productId + ", productTitle=" + productTitle + ", receiver="
				+ receiver + ", send_date=" + send_date + ", status=" + status + "]";
	}
}
