package order.model;

import myshop.model.ProductVO;

public class CartVO {
	
	 private int cartNo;       //장바구니번호
	 private String fk_userid;   //회원아이디
	 private int fk_pnum;    //제품번호
	 private int odAmount;   //주문량
	 private String cartDate;  // 입력일자
	 
	 private ProductVO prod;  //  제품정보객체 (오라클로 말하면 부모테이블)
	 
	 private String optionNo_es; // 옵션번호들
	 
	 public CartVO() { }
	   
	 public CartVO(int cartNo, String fk_userid, int fk_pnum, int odAmount, ProductVO prod, String optionNo_es) {
	      this.cartNo = cartNo;
	      this.fk_userid = fk_userid;
	      this.fk_pnum = fk_pnum;
	      this.odAmount = odAmount;
	      this.prod = prod;
	      this.optionNo_es = optionNo_es;
	   }
	 
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

	public ProductVO getProd() {
		return prod;
	}

	public void setProd(ProductVO prod) {
		this.prod = prod;
	}

	public String getOptionNo_es() {
		return optionNo_es;
	}

	public void setOptionNo_es(String optionNo_es) {
		this.optionNo_es = optionNo_es;
	}


	
	
	
}
