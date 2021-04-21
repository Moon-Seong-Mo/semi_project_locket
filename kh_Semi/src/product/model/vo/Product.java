package product.model.vo;

import java.sql.Date;

public class Product {
	private int productId;
	private String productWriter;
	private String pImage;
	private String nickname;
	private String category;
	private String title;
	private int price;
	private String condition;
	private String delivery;
	private String explain;
	private Date create_date;
	private int productCount;
	private String status;   		//거래상태 (거래 완료인지, 거래전인지)
	private int rankCode;
	private String location1;
	private String location2;
	private String location3;
	private String rankName;
	private int dealCount;
	
	public Product() {}

	public Product(int productId, String productWriter, String pImage, String nickname, String category, String title,
			int price, String condition, String delivery, String explain, Date create_date, int productCount,
			String status) {
		super();
		this.productId = productId;
		this.productWriter = productWriter;
		this.pImage = pImage;
		this.nickname = nickname;
		this.category = category;
		this.title = title;
		this.price = price;
		this.condition = condition;
		this.delivery = delivery;
		this.explain = explain;
		this.create_date = create_date;
		this.productCount = productCount;
		this.status = status;
	}
	
	public Product(int productId, String category, String title, int price, String condition, String delivery, String explain) {
		super();
		this.productId = productId;
		this.category = category;
		this.title = title;
		this.price = price;
		this.condition = condition;
		this.delivery = delivery;
		this.explain = explain;
	}

	public Product(String category, String title, int price, String condition, String delivery, String explain) {
		super();
		this.category = category;
		this.title = title;
		this.price = price;
		this.condition = condition;
		this.delivery = delivery;
		this.explain = explain;
	}

	public Product(int productId, String productWriter, String pImage, String nickname, String category, String title,
			int price, String condition, String delivery, String explain, Date create_date, int productCount) {
		super();
		this.productId = productId;
		this.productWriter = productWriter;
		this.pImage = pImage;
		this.nickname = nickname;
		this.category = category;
		this.title = title;
		this.price = price;
		this.condition = condition;
		this.delivery = delivery;
		this.explain = explain;
		this.create_date = create_date;
		this.productCount = productCount;
	}

	public Product(int productId, String productWriter, String category, String title, int price, String condition,
			String delivery, String explain, Date create_date, int productCount) {
		super();
		this.productId = productId;
		this.productWriter = productWriter;
		this.category = category;
		this.title = title;
		this.price = price;
		this.condition = condition;
		this.delivery = delivery;
		this.explain = explain;
		this.create_date = create_date;
		this.productCount = productCount;
	}
	
	public Product(int productId, String title, int price, int productCount) {
		super();
		this.productId = productId;
		this.title = title;
		this.price = price;
		this.productCount = productCount;
	}

	
	public Product(int productId, String nickname, String title, int price, int productCount) {
		super();
		this.productId = productId;
		this.nickname = nickname;
		this.title = title;
		this.price = price;
		this.productCount = productCount;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductWriter() {
		return productWriter;
	}

	public void setProductWriter(String productWriter) {
		this.productWriter = productWriter;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getDelivery() {
		return delivery;
	}

	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}

	public String getExplain() {
		return explain;
	}

	public void setExplain(String explain) {
		this.explain = explain;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public int getProductCount() {
		return productCount;
	}

	public void setProductCount(int productCount) {
		this.productCount = productCount;
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

	public int getRankCode() {
		return rankCode;
	}

	public void setRankCode(int rankCode) {
		this.rankCode = rankCode;
	}

	public String getLocation1() {
		return location1;
	}

	public void setLocation1(String location1) {
		this.location1 = location1;
	}

	public String getLocation2() {
		return location2;
	}

	public void setLocation2(String location2) {
		this.location2 = location2;
	}

	public String getLocation3() {
		return location3;
	}

	public void setLocation3(String location3) {
		this.location3 = location3;
	}

	public String getRankName() {
		return rankName;
	}

	public void setRankName(String rankName) {
		this.rankName = rankName;
	}

	public int getDealCount() {
		return dealCount;
	}

	public void setDealCount(int dealCount) {
		this.dealCount = dealCount;
	}

	@Override
	public String toString() {
		return "Product [productId=" + productId + ", productWriter=" + productWriter + ", pImage=" + pImage
				+ ", nickname=" + nickname + ", category=" + category + ", title=" + title + ", price=" + price
				+ ", condition=" + condition + ", delivery=" + delivery + ", explain=" + explain + ", create_date="
				+ create_date + ", productCount=" + productCount + ", status=" + status + ", rankCode=" + rankCode
				+ ", location1=" + location1 + ", location2=" + location2 + ", location3=" + location3 + ", rankName="
				+ rankName + ", dealCount=" + dealCount + "]";
	}

	
}
