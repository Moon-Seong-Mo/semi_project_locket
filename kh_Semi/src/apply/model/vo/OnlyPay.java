package apply.model.vo;

public class OnlyPay {

	private int price;
	private String name;
	private String buyer_name;
	private String buyer_phone;
	private String buyer_email;
	
	public OnlyPay() {
		
	}

	public OnlyPay(int price, String name, String buyer_name, String buyer_phone, String buyer_email) {
		super();
		this.price = price;
		this.name = name;
		this.buyer_name = buyer_name;
		this.buyer_phone = buyer_phone;
		this.buyer_email = buyer_email;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBuyer_name() {
		return buyer_name;
	}

	public void setBuyer_name(String buyer_name) {
		this.buyer_name = buyer_name;
	}

	public String getBuyer_phone() {
		return buyer_phone;
	}

	public void setBuyer_phone(String buyer_phone) {
		this.buyer_phone = buyer_phone;
	}

	public String getBuyer_email() {
		return buyer_email;
	}

	public void setBuyer_email(String buyer_email) {
		this.buyer_email = buyer_email;
	}

	@Override
	public String toString() {
		return "OnlyPay [price=" + price + ", name=" + name + ", buyer_name=" + buyer_name + ", buyer_phone="
				+ buyer_phone + ", buyer_email=" + buyer_email + "]";
	}
	
	
}
