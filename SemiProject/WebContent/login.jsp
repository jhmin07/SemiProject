<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
    
<%
    String ctxPath = request.getContextPath();
%>       
<jsp:include page="header.jsp" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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


#content{
	/* border: solid 2px blue; */
	min-width: 1000px;
	min-width: 650px; 
}
#content > div {
    position: relative;
    width: 1000px;
    padding-bottom: 150px;
    margin: 0 auto;
}
h2{
/* 	border: solid 2px blue; */
	clear: right;
	padding: 77px 0 14px 0;
	color: #000;
	font-size: 50px;
	text-align: center;
}
p{
	/* border: solid 2px blue; */
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
legend, label {
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
.menuBtn{
	background: url("image/threeline_small.png");
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
</style>

<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
</head>
<body>
<%-- *** 로그인을 하기 위한 폼을 생성 *** --%>
<!-- 로그인 정보 입력  -->
<form id="frm_login">
	<div id="content">
		<h2>로그인</h2>
		<p>RHOM을 방문해 주셔서 감사합니다</p>
		<fieldset class="login">
		<legend>로그인 정보 입력</legend>
		<input type="text" id="user_id" maxlength="20" placeholder="아이디를 입력해주세요.">
		<label for="user_id">아이디 입력</label>
		<input type="password" id="user_pwd" maxlength="20" placeholder="비밀번호를 입력해주세요." onkeypress="if(event.keyCode == 13) { login_submit(); event.returnValue = false }">
		<label for="user_pwd"> 입력</label>
		<a href="javascript:login_submit();" >로그인</a>
		<ul>
			<li> <a href="javascript:gofind_id();" >아이디 찾기 &nbsp; &nbsp;</a> </li>
			<li> <a href="javascript:gofind_pwd();" >비밀번호 찾기</a> </li>
			<li> <a href="javascript:go_Register();" > &nbsp; &nbsp; 회원가입</a> </li>
		</ul>
		</fieldset>
	</div>
</form>

</body>
</html>
<jsp:include page="footer.jsp" />  