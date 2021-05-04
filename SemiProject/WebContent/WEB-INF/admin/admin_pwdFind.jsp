<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject
%> 

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#btnConfirmCode{
	background-color: black; 
	color: white; 
	width: 150px; 
	font-weight:bold;
}
#btnConfirmCodeR{
	background-color: black; 
	color: white; 
	width: 150px; 
	font-weight:bold;
}
#sendEmail{
	margin-top: 80px;
}
</style>

<script type="text/javascript">

	var start = 0; 
	var cnt = 0;
	var clock;

	$(document).ready(function(){		
		
		// 찾기
		$("button#btnFind").click(function(){			
			var useridVal = $("input#userid").val().trim();
			var emailVal = $("input#email").val().trim();
			
			if(useridVal != "" && emailVal != ""){
				var frm = document.pwdFindFrm;
				frm.action = "<%=ctxPath%>/member/pwdFind.up";
				frm.method = "POST";
				frm.submit();				
				
			}
			else{
				alert("아이디와 이메일을 입력하세요!!")
				return;
			}
		}); // end of $("button#btnFind").click(function(){}
		
		
	 	var method = "${requestScope.method}";
		
		if(method == "POST"){
			$("input#userid").val("${requestScope.userid}");
			$("input#email").val("${requestScope.email}");
			$("div#div_userid").hide();
			$("div#div_email").hide();
			$("div#div_findResult").show();
			
			if(${requestScope.sendMailSuccess == true}){
				$("div#div_btnFind").hide();
			}
		}
		else{
			$("div#div_findResult").hide();
		}
		
		// 인증하기
		$("button#btnConfirmCode").click(function(){
			
			var frm = document.verifyCertificationFrm;
			
		    frm.userid.value = $("input#userid").val();
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			
			frm.action = "<%= ctxPath%>/admin/ad_verifyCertification.up";
			frm.method = "POST";
			frm.submit();
		});	 
		
		// 인증번호 재발송 
		$("button#btnConfirmCodeR").click(function(){
			
			var useridVal = $("input#userid").val().trim();
			var emailVal = $("input#email").val().trim();
			
			if(useridVal != "" && emailVal != ""){
				var frm = document.pwdFindFrm;
				frm.action = "<%=ctxPath%>/admin/admin_pwdFind.up";
				frm.method = "POST";
				frm.submit();				
				
			}
			else{
				alert("아이디와 이메일을 입력하세요!!")
				return;
			}
		});
		
		// 타이머		
		func_loopTimer();
		
	});// end of $(document).ready(function(){}
	
	function func_timer(i){
		start = 3*60-i; // 3분
		
		if(start >= 0) {
			var minute = "";
			
			if(start < 600) { // 10분 미만인 경우
				minute = "0";
				// 05:00   04:59   04:58   04:57
			}
			
			minute += parseInt(start/60); // 05  04  04  04 
			
			var second = start%60;
			second = (second < 10)?"0"+second:second;
			
			var timer = document.getElementById("timer");
			timer.innerHTML = minute+" : "+second;
		}		
		else {
			func_finish(); 
			alert("인증시간이 만료되었습니다.");
			$("button#btnConfirmCode").hide();
			return;
		}
	}// end of function func_timer(i){}
	
	function func_loopTimer() {
		
		func_timer(cnt++);
		
		if(start >= 0) {
			clock = setTimeout('func_loopTimer()', 1000);
		}	
	}// end of function func_loopTimer() {}
	
	function func_finish(){
		clearTimeout(clock);
	};
</script>

</head>
<body>

<form name="pwdFindFrm" style="margin-top: 20px;">
   <div id="div_userid" align="center">
      <span style="font-size: 12pt; font-weight:bold;">아이디</span><br/> 
      <input type="text" name="userid" id="userid" size="30" style="margin-top: 5px; margin-bottom: 10px;" placeholder="아이디를 입력해주세요" autocomplete="off" required />
   </div>
   
   <div id="div_email" align="center">
   	  <span style="font-size: 12pt; font-weight:bold;">이메일</span><br/>
      <input type="text" name="email" id="email" size="30" style="margin-top: 5px; " placeholder="이메일 주소를 입력해주세요" autocomplete="off" required />
   </div>
   
	 <div id="div_findResult" align="center">
		<c:if test="${requestScope.isUserExist == false}">
			<span style="color:red;">사용자 정보가 없습니다.</span>
		</c:if>	 
		<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true}">
			<span style="font-size: 10pt;">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br><br>
			<span style="font-size: 10pt;">인증코드를 입력해주세요.</span><br><br>
			<input type="text" name="input_confirmCode" id="input_confirmCode" required /><span id="timer">&nbsp;</span>
			<br><br>
			<button type="button" class="btn btn-info" id="btnConfirmCode">인증하기&nbsp;</button>
			<button type="button" class="btn btn-info" id="btnConfirmCodeR">인증번호 재전송</button>		
		</c:if>	 
		<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false}">
			<span style="color:red;">메일 발송이 실패했습니다.</span>
		</c:if>	 	 	
	 </div>
   
   <div id="div_btnFind" align="center" style="margin-top: 25px;">
   		<button type="button" style="background-color: black; color: white; width: 150px; font-weight:bold;" id="btnFind">비밀번호 찾기</button>
   </div>
   
</form>

<form name="verifyCertificationFrm">
   <input type="hidden" name="userid" />
   <input type="hidden" name="userCertificationCode" />
</form>
