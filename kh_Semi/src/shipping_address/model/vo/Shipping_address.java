package shipping_address.model.vo;

public class Shipping_address {
	private int address_num;
	private String address_name;
	private String adderss;
	private String phone;
	private String receiver;
	private String status;
	
	public Shipping_address() {}
	

	public Shipping_address(String address_name, String adderss, String phone, String receiver) {
		this.address_name = address_name;
		this.adderss = adderss;
		this.phone = phone;
		this.receiver = receiver;
	}



	public Shipping_address(int address_num, String address_name, String adderss, String phone, String receiver,
			String status) {
		super();
		this.address_num = address_num;
		this.address_name = address_name;
		this.adderss = adderss;
		this.phone = phone;
		this.receiver = receiver;
		this.status = status;
	}

	public Shipping_address(int address_num, String address_name, String adderss, String phone, String receiver) {
		super();
		this.address_num = address_num;
		this.address_name = address_name;
		this.adderss = adderss;
		this.phone = phone;
		this.receiver = receiver;
	}

	public int getAddress_num() {
		return address_num;
	}

	public void setAddress_num(int address_num) {
		this.address_num = address_num;
	}

	public String getAddress_name() {
		return address_name;
	}

	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}

	public String getAdderss() {
		return adderss;
	}

	public void setAdderss(String adderss) {
		this.adderss = adderss;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Shipping_address [address_num=" + address_num + ", address_name=" + address_name + ", adderss="
				+ adderss + ", phone=" + phone + ", receiver=" + receiver + ", status=" + status + "]";
	}

}
