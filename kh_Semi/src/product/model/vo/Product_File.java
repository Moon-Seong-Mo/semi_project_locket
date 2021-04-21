package product.model.vo;

import java.sql.Date;

public class Product_File {
	private int pfId;
	private int p_num;
	private String originName;
	private String changeName;
	private String filePath;
	private int fileLevel;
	private String status;
	
	public Product_File() {}

	public Product_File(int p_num, String changeName) {
		super();
		this.p_num = p_num;
		this.changeName = changeName;
	}

	public Product_File(int pfId, int p_num, String originName, String changeName, String filePath, int fileLevel, String status) {
		super();
		this.pfId = pfId;
		this.p_num = p_num;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.fileLevel = fileLevel;
		this.status = status;
	}

	public int getPfId() {
		return pfId;
	}

	public void setPfId(int pfId) {
		this.pfId = pfId;
	}

	public int getP_num() {
		return p_num;
	}

	public void setP_num(int p_num) {
		this.p_num = p_num;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public int getFileLevel() {
		return fileLevel;
	}

	public void setFileLevel(int fileLevel) {
		this.fileLevel = fileLevel;
	}
	

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Product_File [pfId=" + pfId + ", p_num=" + p_num + ", originName=" + originName + ", changeName="
				+ changeName + ", filePath=" + filePath + ", fileLevel=" + fileLevel + ", status=" + status + "]";
	}
}
