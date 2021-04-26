<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<%
    String ctxPath = request.getContextPath();
%>        
    
    
<jsp:include page="../../header4.jsp" />  

<title>RHOM 공식 홈페이지</title>
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
    margin: 0;
    padding: 0;
    border-right: 2px solid #dedede;
}  
.login > ul > li:last-child {
	margin-right: 50px;
	border-left: 2px solid #dedede;
}  
.login > ul > li {
	float: left;
    margin-left: 16px;
}
.login > ul > li > a {
    color: #999;
    font-size: 13px;
}
form{
	border-top: solid 1px #dedede;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	
	
});
</script>


</head>
<body>
<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<!-- 로그인 정보 입력  -->

	<div id="content">
		<h2>로그인</h2>
		<p>RHOM을 방문해 주셔서 감사합니다</p>
		<fieldset class="login">
		<form id="frm_login" method="POST" action="<%= request.getContextPath()%>/member/login.up">
		<input type="text" id="user_id"  name="userid" maxlength="20" placeholder="아이디를 입력해주세요." />	
		<input type="password" id="user_pwd" name="pwd" maxlength="20" placeholder="비밀번호를 입력해주세요." onkeypress="if(event.keyCode == 13) { login_submit(); event.returnValue = false }" />
		<input type="submit" id="submit" value="로그인" style="background-color: black; color: white;  width: 450px;" />
		</form>
		<ul>
			<li> <a style="cursor: pointer;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디 찾기</a></li>
			<li> <a style="cursor: pointer;" data-toggle="modal" data-target="#userpwdfind" data-dismiss="modal">비밀번호 찾기</a> </li>
			<li> <a href="javascript:go_Register();" > &nbsp; &nbsp; 회원가입</a> </li>
		</ul>
		</fieldset>
	</div>


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
		          	<iframe style="border: none; width: 100%; height: 230px; " src="http://localhost:9090/SemiProject/member/idfind.jsp">
		          	</iframe>
		          </div>
	          
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
		          	<iframe style="border: none; width: 100%; height: 230px; " src="http://localhost:9090/SemiProject/member/pwdfind.jsp">
		          	</iframe>
		          </div>
	          
	        </div>
        
      </div>
      
    </div>
  </div>
<%-- ****** 비밀번호 찾기 Modal 끝****** --%>

</body>

<jsp:include page="../../footer.jsp" />  