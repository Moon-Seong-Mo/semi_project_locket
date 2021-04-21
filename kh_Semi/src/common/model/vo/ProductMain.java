package common.model.vo;

public class ProductMain {
	private int productNum;
	private String category;
	private String productTitle;
	private int productPrice;
	private String productImage;
	
	public ProductMain() {
	}

	public ProductMain(int productNum, String category, String productTitle, int productPrice, String productImage) {
		this.productNum = productNum;
		this.category = category;
		this.productTitle = productTitle;
		this.productPrice = productPrice;
		this.productImage = productImage;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getProductTitle() {
		return productTitle;
	}

	public void setProductTitle(String productTitle) {
		this.productTitle = productTitle;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	@Override
	public String toString() {
		return "ProductMain [productNum=" + productNum + ", category=" + category + ", productTitle=" + productTitle
				+ ", productPrice=" + productPrice + ", productImage=" + productImage + "]";
	}

	
}
