package myshop.model;

public class DetailCategoryVO {

	private int    fk_cnum;   // 세부 카테고리 분류 번호
	private String decode;   // 세부 카테고리 코드
	private String dename;  // 세부 카테고리명
	
	private CategoryVO categvo;	// 대분류 카테고리 번호
	
	public DetailCategoryVO() { }
	
	public DetailCategoryVO(int fk_cnum, String decode, String dename) {
		this.fk_cnum = fk_cnum;
		this.decode = decode;
		this.dename = dename;
	}
	
	public int getFk_cnum() {
		return fk_cnum;
	}

	public void setFk_cnum(int fk_cnum) {
		this.fk_cnum = fk_cnum;
	}

	public String getDecode() {
		return decode;
	}

	public void setDecode(String decode) {
		this.decode = decode;
	}

	public String getDename() {
		return dename;
	}

	public void setDename(String dename) {
		this.dename = dename;
	}

	public CategoryVO getCategvo() {
		return categvo;
	}

	public void setCategvo(CategoryVO categvo) {
		this.categvo = categvo;
	}

	
}
