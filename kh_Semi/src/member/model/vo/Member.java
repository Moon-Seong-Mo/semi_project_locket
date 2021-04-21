package member.model.vo;

import java.sql.Date;

public class Member {
	private String id;
	private String pw;
	private String pwHint;
	private String pwAns;
	private String gender;
	private String email;
	private String phone;
	private String nickName;
	private int rankCode;
	private String rankName;
	private Date joinDate;
	private String inCheck;
	private String mCheck;
	private String pImage;
	private Date mDate;
	private String sCheck;

	public Member() {
	}

	public Member(String id, String pw) {
		super();
		this.id = id;
		this.pw = pw;
	}

	public Member(String pwHint, String pwAns, String email, String phone, String nickName) {
		super();
		this.pwHint = pwHint;
		this.pwAns = pwAns;
		this.email = email;
		this.phone = phone;
		this.nickName = nickName;
	}

	public Member(String id, String nickName, String rankName, Date joinDate, String inCheck, String sCheck) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.rankName = rankName;
		this.joinDate = joinDate;
		this.inCheck = inCheck;
		this.sCheck = sCheck;
	}

	public Member(String id, String nickName, int rankCode, String rankName, String pImage, String sCheck, Date mDate) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.rankCode = rankCode;
		this.rankName = rankName;
		this.pImage = pImage;
		this.sCheck = sCheck;
		this.mDate = mDate;
	}

	public Member(String pwHint, String pwAns, String email, String phone, String nickName, String rankName) {
		super();
		this.pwHint = pwHint;
		this.pwAns = pwAns;
		this.email = email;
		this.phone = phone;
		this.nickName = nickName;
		this.rankName = rankName;
	}

	public Member(String id, String pw, String pwHint, String pwAns, String gender, String email, String phone,
			String nickName, String mCheck) {
		super();
		this.id = id;
		this.pw = pw;
		this.pwHint = pwHint;
		this.pwAns = pwAns;
		this.gender = gender;
		this.email = email;
		this.phone = phone;
		this.nickName = nickName;
		this.mCheck = mCheck;
	}

	public Member(String id, String nickName, String accountNum, String rankName, Date joinDate, String inCheck,
			String sCheck) {
		this.id = id;
		this.nickName = nickName;
		this.rankName = rankName;
		this.joinDate = joinDate;
		this.inCheck = inCheck;
		this.sCheck = sCheck;
	}

	public Member(String id, String pw, String pwHint, String pwAns, String gender, String email, String phone,
			String nickName, int rankCode, Date joinDate, String inCheck, String mCheck, String pImage) {
		super();
		this.id = id;
		this.pw = pw;
		this.pwHint = pwHint;
		this.pwAns = pwAns;
		this.gender = gender;
		this.email = email;
		this.phone = phone;
		this.nickName = nickName;
		this.rankCode = rankCode;
		this.joinDate = joinDate;
		this.inCheck = inCheck;
		this.mCheck = mCheck;
		this.pImage = pImage;
	}

	public Member(String id, String nickName, String email, String phone) {
		super();
		this.id = id;
		this.nickName = nickName;
		this.email = email;
		this.phone = phone;

	}

	public Member(String id) {
		super();
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getPwHint() {
		return pwHint;
	}

	public void setPwHint(String pwHint) {
		this.pwHint = pwHint;
	}

	public String getPwAns() {
		return pwAns;
	}

	public void setPwAns(String pwAns) {
		this.pwAns = pwAns;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getRankCode() {
		return rankCode;
	}

	public void setRankCode(int rankCode) {
		this.rankCode = rankCode;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getInCheck() {
		return inCheck;
	}

	public void setInCheck(String inCheck) {
		this.inCheck = inCheck;
	}

	public String getmCheck() {
		return mCheck;
	}

	public void setmCheck(String mCheck) {
		this.mCheck = mCheck;
	}

	public String getpImage() {
		return pImage;
	}

	public void setpImage(String pImage) {
		this.pImage = pImage;
	}

	public Date getmDate() {
		return mDate;
	}

	public void setmDate(Date mDate) {
		this.mDate = mDate;
	}

	public String getsCheck() {
		return sCheck;
	}

	public void setsCheck(String sCheck) {
		this.sCheck = sCheck;
	}

	@Override
	public String toString() {
		return "Member [id=" + id + ", pw=" + pw + ", pwHint=" + pwHint + ", pwAns=" + pwAns + ", gender=" + gender
				+ ", email=" + email + ", phone=" + phone + ", nickName=" + nickName + ", rankCode=" + rankCode
				+ ", rankName=" + rankName + ", joinDate=" + joinDate + ", inCheck=" + inCheck + ", mCheck=" + mCheck
				+ ", pImage=" + pImage + ", mDate=" + mDate + ", sCheck=" + sCheck + "]";
	}

	
}
