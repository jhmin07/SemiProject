package myshop.model;

public class OptionVO {
	private int optionNo;		// 옵션번호 (Primary Key)
	private int onum;			// 옵션분류번호
	private String oname;		// 옵션분류명
	private int fk_pnum;		// 제품번호
	private int addprice;		// 추가금액
	private String ocontents;	// 옵션내용
	
	private ProductVO pvo;		// 부모 테이블(tbl_product)의 객체

	public int getOptionNo() {
		return optionNo;
	}

	public void setOptionNo(int optionNo) {
		this.optionNo = optionNo;
	}

	public int getOnum() {
		return onum;
	}

	public void setOnum(int onum) {
		this.onum = onum;
	}

	public String getOname() {
		return oname;
	}

	public void setOname(String oname) {
		this.oname = oname;
	}

	public int getFk_pnum() {
		return fk_pnum;
	}

	public void setFk_pnum(int fk_pnum) {
		this.fk_pnum = fk_pnum;
	}

	public int getAddprice() {
		return addprice;
	}

	public void setAddprice(int addprice) {
		this.addprice = addprice;
	}

	public String getOcontents() {
		return ocontents;
	}

	public void setOcontents(String ocontents) {
		this.ocontents = ocontents;
	}

	public ProductVO getPvo() {
		return pvo;
	}

	public void setPvo(ProductVO pvo) {
		this.pvo = pvo;
	}
	
	
}
