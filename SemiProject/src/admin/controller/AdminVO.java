package admin.controller;

public class AdminVO {
	
	private String adId;             // 회원아이디
	private String adPwd;                // 비밀번호 (SHA-256 암호화 대상)
	private String adName;               // 회원명
	private String adEmail;              // 이메일 (AES-256 암호화/복호화 대상)
	private String adMobile;             // 연락처 (AES-256 암호화/복호화 대상) 
	
	public AdminVO() {	}
	
	public AdminVO(String adId, String adPwd, String adName, String adEmail, String adMobile) { 
		
		this.adId = adId;
		this.adPwd = adPwd;
		this.adName = adName;
		this.adEmail = adEmail;
		this.adMobile = adMobile;
		
	}
	
	public String getAdId() {
		return adId;
	}
	public void setAdId(String adId) {
		this.adId = adId;
	}
	public String getAdPwd() {
		return adPwd;
	}
	public void setAdPwd(String adPwd) {
		this.adPwd = adPwd;
	}
	public String getAdName() {
		return adName;
	}
	public void setAdName(String adName) {
		this.adName = adName;
	}
	public String getAdEmail() {
		return adEmail;
	}
	public void setAdEmail(String adEmail) {
		this.adEmail = adEmail;
	}
	public String getAdMobile() {
		return adMobile;
	}
	public void setAdMobile(String adMobile) {
		this.adMobile = adMobile;
	}
	
	
	
	
	
	
	

}
