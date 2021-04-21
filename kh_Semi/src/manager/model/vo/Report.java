package manager.model.vo;

import java.sql.Date;

public class Report {
	private int reportNum;
	private String category;
	private String memberId;
	private String memberId2;
	private String reason;
	private Date date;
	private String path;
	
	public Report() {}

	public Report(int reportNum, String category, String memberId, String memberId2, String reason, Date date,
			String path) {
		super();
		this.reportNum = reportNum;
		this.category = category;
		this.memberId = memberId;
		this.memberId2 = memberId2;
		this.reason = reason;
		this.date = date;
		this.path = path;
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberId2() {
		return memberId2;
	}

	public void setMemberId2(String memberId2) {
		this.memberId2 = memberId2;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Override
	public String toString() {
		return "Report [reportNum=" + reportNum + ", category=" + category + ", memberId=" + memberId + ", memberId2="
				+ memberId2 + ", reason=" + reason + ", date=" + date + ", path=" + path + "]";
	}
	
	
}
