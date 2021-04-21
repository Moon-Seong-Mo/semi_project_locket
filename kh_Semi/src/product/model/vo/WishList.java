package product.model.vo;

public class WishList {
	private String memberId;
	private int productId;
	
	public WishList() {}
	
	public WishList(String memberId, int productId) {
		super();
		this.memberId = memberId;
		this.productId = productId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	@Override
	public String toString() {
		return "WishList [memberId=" + memberId + ", productId=" + productId + "]";
	}
}
