<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath();
%>       

<!DOCTYPE html>
<html>
<head>
<title>HOME PAGE START</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
body {
  font-family: "Lato", sans-serif;
}
.sidenav {
  height: 100%;
  width: 0;
  position: fixed;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  z-index: 2;
  transition: 0.5s;
  padding-top: 60px;
}
.sidenav a {
  clear: both;
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}
.sidenav a:hover {
  color: #f1f1f1;
}
.sidenav .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}
@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
.navbar {
  overflow: hidden;
  background-color: white;
  position: fixed;
  top: 0;
  transition: 0.5s;
  z-index: 1;
  width: 100%;
  min-height: 70px;
  border-bottom: 1px solid #dedede;
}
.navbar > span {
  clear: both;
  display:inline-block;
  
}
a.sub2 {
	margin-top: 15px;
}

 span.submenubtn:hover{
       cursor: pointer;
    }

span.submenubtn {
	cursor: pointer;
	margin: 0 10px 0 2px;
}
span.hsub1{
	cursor: pointer;	 
	font-weight: bold;
	margin-right: 5px;
	font-size: 10pt;
}

</style>

<script type="text/javascript">
function openNav() {
	document.getElementById("mySidenav").style.width = "250px";
}	
function closeNav() {

	  document.getElementById("mySidenav").style.width = "0";
	}

	function goNotice(){
		location.href = "<%=request.getContextPath()%>/detailMenu/board.up";
	}

function goHome(){
	location.href = "<%=request.getContextPath()%>/home.up";
}

function LogIn() {
	location.href="<%= request.getContextPath()%>/admin/adminLogin.up";
}	
function LogOut() {
	location.href="<%= request.getContextPath()%>/admin/adminLogout.up";
}
function myPage() {
	var userid = "${sessionScope.loginadmin.adId}";
	location.href="<%= request.getContextPath()%>/admin/adminMyPage.up?adId="+adId;	
}
	
</script>

</head>
<body>

<c:set var="menu_session"  value="first" scope="session" /> 

	<div id="mySidenav" class="sidenav">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	  <a class="sub2" href="<%= ctxPath%>/shop/mallByCategory.up?cnum=${requestScope.tbl_category.cnum}">침실 가구</a>
	  <a class="sub2" href="#">거실 가구</a>
	  <a class="sub2" href="#">주방 가구</a>
	  <a class="sub2" href="#">드레스 룸</a>
	  <hr style="border: solid 1px #CDCDCD; width: 190px; margin-top: 30px;">
	  <br>
	  <div align="center" style="color: white;">
	  	<c:if test="${empty sessionScope.loginadmin}">
		 	<span class="submenubtn" onclick="LogIn()">로그인</span>|
		 </c:if>	
	  	<c:if test="${not empty sessionScope.loginadmin}">
		 	<span class="submenubtn" onclick="LogOut()" >로그아웃</span>|
		 </c:if>			 
		 <span class="submenubtn" >주문내역</span>|
		 <span class="submenubtn" id="Notice" onClick="goNotice();" >고객센터</span>
	  </div>
	</div>

<div class="navbar">
  <span style="font-size:30px;cursor:pointer; width:15%; vertical-align: middle;" onclick="openNav()"><img id="mainheadermenu" src="<%= ctxPath %>/image/ProjectImg/menu.png" style="width: 50px;" align="middle"/></span>
  <span class="hsub1" style="width:60%; text-align: center; padding-left: 185px;" onclick="goHome()"><img class="headerlogo" src="<%= ctxPath %>/image/ProjectImg/logo2.png" style="width:120px; height:50px; cursor: pointer;" align="middle"/></span>
  
  	<c:if test="${empty sessionScope.loginadmin}">
  	  <span class="hsub1" style="margin-left: 200px;" onclick="LogIn()"><img class="headerlogo"  src="<%= ctxPath%>/image/ProjectImg/login.png" style="width:28px; height:23px; cursor: pointer;" align="middle" />로그인</span>
    </c:if>
    <c:if test="${not empty sessionScope.loginadmin}">
  	  <span class="hsub1" style="margin-left: 100px;" onclick="myPage()"><img class="headerlogo"  src="<%= ctxPath%>/image/ProjectImg/login.png" style="width:28px; height:23px; cursor: pointer;" align="middle" />관리자페이지</span>
  	  <span class="hsub1" onclick="LogOut()"><img class="headerlogo"  src="<%= ctxPath%>/image/logout.png" style="width:28px; height:23px; cursor: pointer;" align="middle" />로그아웃</span>
    </c:if>  
    
  
</div>



</body>
</html>  