package order.model;

public class CartVO {
	
	 private int cartNo;       //장바구니번호
	 private String fk_userid;   //회원아이디
	 private int fk_pnum;    //제품번호
	 private int odAmount;   //주문량
	 private String cartDate;  // 입력일자
	 
	public int getCartNo() {
		return cartNo;
	}
	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
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
	public String getCartDate() {
		return cartDate;
	}
	public void setCartDate(String cartDate) {
		this.cartDate = cartDate;
	}
	
}
