package order.model;

import myshop.model.ProductVO;

public class OrderDetailVO {
	
	private int odNo;				// 주문상세일련번호
	private String fk_orderCode;	// 주문코드
	private int fk_pnum;			// 제품번호
	private int odAmount;			// 주문량
	private int odPrice;			// 주문가격
	private String optionContents;	// 옵션내역
	private String deliveryCon;		// 배송상태
	private String deliveryDone;	// 배송완료일자
	
	private ProductVO prod;			// 상품정보객체
	private OrderVO ord;			// 주문정보객체
	
	public int getOdNo() {
		return odNo;
	}
	
	public void setOdNo(int odNo) {
		this.odNo = odNo;
	}
	
	public String getFk_orderCode() {
		return fk_orderCode;
	}
	
	public void setFk_orderCode(String fk_orderCode) {
		this.fk_orderCode = fk_orderCode;
	}
	
	public int getFk_pnum() {
		return fk_pnum;
	}
	
	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}
	
	public int getOdAmount() {
		return odAmount;
	}
	
	public void setOdAmount(int odAmount) {
		this.odAmount = odAmount;
	}
	
	public int getOdPrice() {
		return odPrice;
	}
	
	public void setOdPrice(int odPrice) {
		this.odPrice = odPrice;
	}
	
	public String getOptionContents() {
		return optionContents;
	}

	public void setOptionContents(String optionContents) {
		this.optionContents = optionContents;
	}

	public String getDeliveryCon() {
		return deliveryCon;
	}
	
	public void setDeliveryCon(String deliveryCon) {
		this.deliveryCon = deliveryCon;
	}
	
	public String getDeliveryDone() {
		return deliveryDone;
	}
	
	public void setDeliveryDone(String deliveryDone) {
		this.deliveryDone = deliveryDone;
	}
	
	public OrderVO getOrd() {
		return ord;
	}

	public void setOrd(OrderVO ord) {
		this.ord = ord;
	}
	
	public ProductVO getProd() {
		return prod;
	}

	public void setProd(ProductVO prod) {
		this.prod = prod;
	}

}
