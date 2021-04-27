package QA.model;

public class QAVO {
	private int qaNo;
	private String qaTitle;
	private String qaContent;;
	private String qaPwd;
	private String fk_userid;
	private String qaRegisterday;
	private int qaViewcount;
	
	 public QAVO() {
			
		}

	public int getQaNo() {
		return qaNo;
	}

	public void setQaNo(int qaNo) {
		this.qaNo = qaNo;
	}

	public String getQaTitle() {
		return qaTitle;
	}

	public void setQaTitle(String qaTitle) {
		this.qaTitle = qaTitle;
	}

	public String getQaContent() {
		return qaContent;
	}

	public void setQaContent(String qaContent) {
		this.qaContent = qaContent;
	}

	public String getQaPwd() {
		return qaPwd;
	}

	public void setQaPwd(String qaPwd) {
		this.qaPwd = qaPwd;
	}

	public String getFk_userid() {
		return fk_userid;
	}

	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}

	public String getQaRegisterday() {
		return qaRegisterday;
	}

	public void setQaRegisterday(String qaRegisterday) {
		this.qaRegisterday = qaRegisterday;
	}

	public int getQaViewcount() {
		return qaViewcount;
	}

	public void setQaViewcount(int qaViewcount) {
		this.qaViewcount = qaViewcount;
	}
	

}
