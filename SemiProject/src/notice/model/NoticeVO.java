package notice.model;

public class NoticeVO {
	private int ctNo;
	private String ctTitle;
	private String ctContent;
	private String fk_adId;
	private String ctRegisterday;
	private int ctViewcount;

	 public NoticeVO() {
			
		}
	
	public int getCtNo() {
		return ctNo;
	}
	public void setCtNo(int ctNo) {
		this.ctNo = ctNo;
	}
	public String getCtTitle() {
		return ctTitle;
	}
	public void setCtTitle(String ctTitle) {
		this.ctTitle = ctTitle;
	}
	public String getCtContent() {
		return ctContent;
	}
	public void setCtContent(String ctContent) {
		this.ctContent = ctContent;
	}
	public String getFk_adId() {
		return fk_adId;
	}
	public void setFk_adId(String fk_adId) {
		this.fk_adId = fk_adId;
	}
	public String getCtRegisterday() {
		return ctRegisterday;
	}
	public void setCtRegisterday(String ctRegisterday) {
		this.ctRegisterday = ctRegisterday;
	}
	public int getCtViewcount() {
		return ctViewcount;
	}
	public void setCtViewcount(int ctViewcount) {
		this.ctViewcount = ctViewcount;
	}     
}
