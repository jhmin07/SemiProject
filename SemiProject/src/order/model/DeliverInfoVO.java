package order.model;

public class DeliverInfoVO {
	private String fk_orderCode; 		//주문코드
	private String recName;
	private String recMobile;			//연락처 (AES-256 암호화/복호화 대상) 
	private String recPostcode;			//우편번호
	private String recAddress;			//주소
	private String recDetailaddress;	//상세주소
	private String recExtraaddress;		//참고항목
	private String dvMessage;			//배송메세지
	
	
	public String getRecName() {
		return recName;
	}
	public void setRecName(String recName) {
		this.recName = recName;
	}
	public String getFk_orderCode() {
		return fk_orderCode;
	}
	public void setFk_orderCode(String fk_orderCode) {
		this.fk_orderCode = fk_orderCode;
	}
	public String getRecMobile() {
		return recMobile;
	}
	public void setRecMobile(String recMobile) {
		this.recMobile = recMobile;
	}
	public String getRecPostcode() {
		return recPostcode;
	}
	public void setRecPostcode(String recPostcode) {
		this.recPostcode = recPostcode;
	}
	public String getRecAddress() {
		return recAddress;
	}
	public void setRecAddress(String recAddress) {
		this.recAddress = recAddress;
	}
	public String getRecDetailaddress() {
		return recDetailaddress;
	}
	public void setRecDetailaddress(String recDetailaddress) {
		this.recDetailaddress = recDetailaddress;
	}
	public String getRecExtraaddress() {
		return recExtraaddress;
	}
	public void setRecExtraaddress(String recExtraaddress) {
		this.recExtraaddress = recExtraaddress;
	}
	public String getDvMessage() {
		return dvMessage;
	}
	public void setDvMessage(String dvMessage) {
		this.dvMessage = dvMessage;
	}
	
	
	
}
