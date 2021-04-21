package apply.model.vo;

import java.sql.Date;

public class Apply {

	private int gNum;
	private String title;
	private String memberId;
	private String membername;
	private String address;
	private int amount;
	private Date apply_date;
	private String merchant_uid;
	private int amountNum;
	private String recipient;
	
	public Apply() {}
	
	public Apply(int gNum, String memberId, int amount, Date apply_date) {
		super();
		this.gNum = gNum;
		this.memberId = memberId;
		this.amount = amount;
		this.apply_date = apply_date;
	}	// 아임포트로 넘길 데이터
	
	
	
	public Apply(int gNum, int amount, String membername, Date apply_date, String merchant_uid) {
		super();
		this.gNum = gNum;
		this.membername = membername;
		this.amount = amount;
		this.apply_date = apply_date;
		this.merchant_uid = merchant_uid;
	}	// buy_list_a
	
	public Apply(int gNum, String memberId, String address, int amount, String merchant_uid) {
		super();
		this.gNum = gNum;
		this.memberId = memberId;
		this.address = address;
		this.amount = amount;
		this.merchant_uid = merchant_uid;
	}	// ApplySuccess

	public Apply(int gNum, String memberId, int amount, Date apply_date, String merchant_uid) {	// buy_list_a
		super();
		this.gNum = gNum;
		this.memberId = memberId;
		this.amount = amount;
		this.apply_date = apply_date;
		this.merchant_uid = merchant_uid;
	}	// 이미 구매했을 경우 재구매 못하게.

	public Apply(int gNum, String title, String membername, String address, int amount, Date apply_date, String merchant_uid, int amountNum) {	// buy_list_c
		super();
		this.gNum = gNum;
		this.title = title;
		this.membername = membername;
		this.address = address;
		this.amount = amount;
		this.apply_date = apply_date;
		this.merchant_uid = merchant_uid;
		this.amountNum = amountNum;
	}	// buy_list_c

	public int getgNum() {
		return gNum;
	}

	public void setgNum(int gNum) {
		this.gNum = gNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public String getMembername() {
		return membername;
	}

	public void setMembername(String membername) {
		this.membername = membername;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public int getAmountNum() {
		return amountNum;
	}

	public void setAmountNum(int amountNum) {
		this.amountNum = amountNum;
	}

	public String getRecipient() {
		return recipient;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	@Override
	public String toString() {
		return "Apply [gNum=" + gNum + ", title=" + title + ", memberId=" + memberId + ", membername=" + membername
				+ ", address=" + address + ", amount=" + amount + ", apply_date=" + apply_date + ", merchant_uid="
				+ merchant_uid + ", amountNum=" + amountNum + ", recipient=" + recipient + "]";
	}

	
}
