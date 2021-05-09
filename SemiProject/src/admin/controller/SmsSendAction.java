package admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import net.nurigo.java_sdk.api.Message;

public class SmsSendAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// >> SMS발송 <<
		// HashMap 에 받는사람번호, 보내는사람번호, 문자내용 등 을 저장한뒤 Coolsms 클래스의 send를 이용해 보냅니다.
		
		// String api_key = "발급받은 본인의 API Key";  // 발급받은 본인 API Key
		String api_key = ""; 
		
		// String api_secret = "발급받은 본인의 API Secret";  // 발급받은 본인 API Secret
		String api_secret = "0JIO4QUI4FTFJJLD3FSNJTPOEQITYNPI"; 
		
		Message coolsms = new Message(api_key, api_secret);
		
		String mobile = request.getParameter("mobile");
		String smsContent = request.getParameter("smsContent");
				
		// == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
		HashMap<String, String> paraMap = new HashMap<String, String>();
		paraMap.put("to", mobile); // 수신번호
		paraMap.put("from", "01021216775"); // 발신번호
		paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
		paraMap.put("text", smsContent); // 문자내용 
		
		String datetime = request.getParameter("datetime");
		if(datetime != null) {
			paraMap.put("datetime", datetime);
		}
		
		paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version
		
		JSONObject jsobj = (JSONObject) coolsms.send(paraMap);
		
		String json = jsobj.toString();
		
		request.setAttribute("json", json);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
