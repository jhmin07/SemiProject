package QA.model;

public class QACommentVO {
	public int addno;
	public String addSubject; 
	public int fk_qaNo; 
	public String writer;     
	public String addRegisterday;
	public int getAddno() {
		return addno;
	}
	public void setAddno(int addno) {
		this.addno = addno;
	}
	public String getAddSubject() {
		return addSubject;
	}
	public void setAddSubject(String addSubject) {
		this.addSubject = addSubject;
	}
	public int getFk_qaNo() {
		return fk_qaNo;
	}
	public void setFk_qaNo(int fk_qaNo) {
		this.fk_qaNo = fk_qaNo;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getAddRegisterday() {
		return addRegisterday;
	}
	public void setAddRegisterday(String addRegisterday) {
		this.addRegisterday = addRegisterday;
	} 
	
	
}
