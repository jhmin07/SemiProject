<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    
    
<%
	String ctxPath = request.getContextPath();
%>    
<jsp:include page="../header4.jsp" />  
<title>RHOM 공식 홈페이지[관리자모드]</title>
<style type="text/css">
div, h2, p{
	margin: 0;
	padding: 0;
}
div{
	display: block;
}
ul{
	list-style: none;
}
h1{
	width: 55px;
	padding-top: 12px;
    margin: 0 auto;
}
#content > div {
    position: relative;
    padding-bottom: 150px;
    margin: 0 auto;
}
h2{
	clear: right;
	padding: 77px 0 14px 0;
	color: #000;
	font-size: 50px;
	text-align: center;
}
p{
	padding-bottom: 66px;
    color: #a7a7a7;
    font-size: 16px;
    text-align: center;	
}
.login{
	width: 450px;
    margin: -20px auto 0 auto;
    padding: 75px 0 85px 0;
    border-top: 1px solid #dedede;
    border-bottom: 1px solid #dedede;
    text-align: center;  
}
fieldset{
	border: 0;
}
label {
    position: absolute;
    overflow: hidden;
    visibility: hidden;
}
.login input[type=text] {
    display: block;
    width: 450px;
    height: 45px;
    margin: 0 auto 10px auto;
    line-height: 43px;
}
.login input[type=password] {
    display: block;
    width: 450px;
    height: 45px;
    margin: 0 auto 10px auto;
    line-height: 43px;
}
a{ 
	text-decoration:none
}
.login > a {
	display: block;
    width: 450px;
    height: 45px;
    margin: 30px auto 0 auto;
    background: #000;
    color: #fff;
    font-size: 16px;
    text-align: center;
    line-height: 45px;
}
.login > ul{
	margin: 10px;
	display: inline-block;
}
.login > ul > li:first-child {
	float: left;
    padding-right: 10px;
    border-right: 2px solid #dedede;
}  
.login > ul > li:last-child {
  	float: left;
    padding-left: 10px;
    margin-right: 30px;
}  
.login > ul > li > a {
    color: #999;
    font-size: 13px;
}
form{
	border-top: solid 1px #dedede;
}
button#gologin{
	 color: #999;
    font-size: 13px;
    display: block;
    width: 450px;
    height: 45px;
    margin: 30px auto 0 auto;
    background: #000;
    color: #fff;
    font-size: 16px;
    text-align: center;
    line-height: 45px;
    cursor: pointer;
}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$("button.myclose").click(function(){
			javascript:history.go(0);
	       
		});
		
		$("button#gologin").click(function(){
			goLogin(); // 로그인 시도한다.
		});
		
		
		$("input#user_pwd").keyup(function(event){
			if(event.keyCode == 13) {  // 암호입력란에 엔터를 했을 경우 
				goLogin(); // 로그인 시도한다.
			}	
		});
		
	});
	
	function goLogin() {
		// alert("로그인 시도함");
		var loginUserid = $("input#user_id").val().trim();
		var loginPwd = $("input#user_pwd").val().trim();
		
		if(loginUserid == "") {
			alert("아이디를 입력하세요!!");
			$("input#user_id").val("");
			$("input#user_id").focus();
			return;  // goLogin() 함수 종료
		}
		
		if(loginPwd == "") {
			alert("암호를 입력하세요!!");
			$("input#user_pwd").val("");
			$("input#user_pwd").focus();
			return;  // goLogin() 함수 종료
		}
		
		
		var frm = document.frm_login;
	    frm.action = "<%= request.getContextPath()%>/member/adminLogin.up";
	    frm.method = "post";
		frm.submit();
		
	}// end of function goLogin()-----------------------------------------
</script>

</head>
<body>
<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<!-- 로그인 정보 입력  -->
<form id="frm_login">
	<div id="content">
	<br><br>
		<h2>로그인</h2>
		<p><span style="background-color:navy; color: #fff;">[관리자모드]</span><br>RHOM 관리자모드 페이지 입니다. 회원께서는 뒤로가기를 눌러주세요.</p>
		<fieldset class="login">
		<input type="text" id="user_id" maxlength="20" placeholder="아이디를 입력해주세요.">
		<input type="text" id="user_id" name="adId" maxlength="20" placeholder="아이디를 입력해주세요.">
		<label for="user_id">아이디 입력</label>
		<input type="password" id="user_pwd" maxlength="20" placeholder="비밀번호를 입력해주세요." onkeypress="if(event.keyCode == 13) { login_submit(); event.returnValue = false }">
		<input type="password" id="user_pwd" name="adPwd" maxlength="20" placeholder="비밀번호를 입력해주세요." >
		<label for="user_pwd"> 입력</label>
		<a href="javascript:login_submit();" >로그인</a>
		<button id="gologin" >로그인</button>
		<ul>
			<li> <a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal" data-backdrop="static"> [관리자모드] 아이디 찾기</a></li>
			<li> <a style="cursor: pointer;" data-toggle="modal" data-target="#userpwdfind" data-dismiss="modal" data-backdrop="static"> [관리자모드] 비밀번호 찾기</a> </li>
		</ul>
		</fieldset>
	</div>
</form>
<%-- ****** 아이디 찾기 Modal 시작****** --%>
  <div class="modal fade" id="userIdfind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
	      
	        <div class="modal-header">
		          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title" align="center" style="font-weight:bold; font-size: 25pt;">아이디 찾기</h4>
		          <br>
		          <div align="center" >회원님의 아이디를 잊으셨나요?</div>
		          <div align="center" >이름과 가입 시 기제한 이메일 주소를 입력하시면 고객님의 정보를 알려드립니다.</div>
	        </div>
	        
	        <div class="modal-body" style="height: 250px; width: 100%;">        
		          <div id="idFind" >
		          	<iframe style="border: none; width: 100%; height: 230px; " src="<%=ctxPath%>/admin/idFind.up">
		          	</iframe>
		          </div>	          
	        </div>
	         <div class="modal-footer">
	          	<button type="button" class="btn btn-default myclose" data-dismiss="modal">close</button>
	         </div>
        
      </div>
      
    </div>
  </div>
<%-- ****** 아이디 찾기 Modal 끝****** --%>
<%-- ****** 비밀번호 찾기 Modal 시작****** --%>
  <div class="modal fade" id="userpwdfind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
	      
	        <div class="modal-header">
		          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title" align="center" style="font-weight:bold; font-size: 25pt;">비밀번호 찾기</h4>
		          <br>
		          <div align="center" >회원님의 비밀번호를 잊으셨나요?</div>
		          <div align="center" >아이디와 가입 시 기제한 이메일 주소를 입력하시면 인증 후 고객님의 정보를 알려드립니다.</div>
	        </div>
	        
	        <div class="modal-body" style="height: 250px; width: 100%;">
	        
		          <div id="idFind" >
		          	<iframe style="border: none; width: 100%; height: 230px; " src="<%=ctxPath%>/admin/pwdFind.up">
		          	</iframe>
		          </div>
	          
	        </div>
        	<div class="modal-footer">
	          	<button type="button" class="btn btn-default myclose" data-dismiss="modal">close</button>
	         </div>
      </div>
      
    </div>
  </div>
<%-- ****** 비밀번호 찾기 Modal 끝****** --%>
</body>
<jsp:include page="../footer.jsp" />  