package myshop.model;

import member.model.MemberVO;
import order.model.OrderVO;

public class ReviewVO {
	
	
	private int reviewNo;// 리뷰작성번호
	private String reviewSubject;//리뷰내용
	private int fk_pnum; // 제품번호
	private String fk_userid;       
	private int review_like;  //-- 제품 별표용
	private String reviewRegisterday;
	
	private MemberVO mvo;
	private ProductVO pvo;
	private OrderVO ovo;

	
	public ReviewVO() { }
	
	public ReviewVO(int reviewNo, String reviewSubject, int fk_pnum, String fk_userid, int review_like, String reviewRegisterday ) {
		this.reviewNo = reviewNo;
		this.reviewSubject = reviewSubject;
		this.fk_pnum = fk_pnum;
		this.fk_userid = fk_userid;
		this.review_like = review_like;
		this.reviewRegisterday = reviewRegisterday;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReviewSubject() {
		return reviewSubject;
	}

	public void setReviewSubject(String reviewSubject) {
		this.reviewSubject = reviewSubject;
	}

	public int getFk_pnum() {
		return fk_pnum;
	}

	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public int getReview_like() {
		return review_like;
	}

	public void setReview_like(int review_like) {
		this.review_like = review_like;
	}

	public String getReviewRegisterday() {
		return reviewRegisterday;
	}

	public void setReviewRegisterday(String reviewRegisterday) {
		this.reviewRegisterday = reviewRegisterday;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}

	public OrderVO getOvo() {
		return ovo;
	}

	public void setOvo(OrderVO ovo) {
		this.ovo = ovo;
	}

	
}
