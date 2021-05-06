package order.model;

import myshop.model.ProductVO;

public class OrderVO {
	
	private String orderCode;	// 주문코드
	private String fk_userid;	// 회원아이디
	private int totalPrice;		// 주문총액
	private int totalPoint;		// 주문총포인트
	private String orderDate;	// 주문일자
	
	private ProductVO prod;		// 제품정보객체(오라클로 말하면 부모테이블)
	
	public OrderVO() { }
	
	public String getOrderCode() {
		return orderCode;
	}
	
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	
	public String getFk_userid() {
		return fk_userid;
	}
	
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}
	
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	public int getTotalPoint() {
		return totalPoint;
	}
	
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}
	
	public String getOrderDate() {
		return orderDate;
	}
	
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public ProductVO getProd() {
		return prod;
	}

	public void setProd(ProductVO prod) {
		this.prod = prod;
	}
	

}
