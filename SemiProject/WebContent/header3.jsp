<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();
%>       
    
<!DOCTYPE html>
<html>
<head>
<title>HOME PAGE START</title>
<meta charset="UTF-8">
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
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidenav a {
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
  /* background-color: #333; */
  /* position: fixed; */  /* fixed 를 하면 navbar 자체가 다 안보이게 되서 주석문 처리해뒀습니다. */
  top: 0;
  width: 100%;
  min-height: 70px;
  border-bottom: 1px solid #dedede;
}

.navbar > span {
  
  display:inline-block;
  
}

a.sub2 {
	margin-top: 15px;
}

</style>

<script type="text/javascript">

function openNav() {
	  document.getElementById("mySidenav").style.width = "250px";
	}

	function closeNav() {
	  document.getElementById("mySidenav").style.width = "0";
	}

</script>

</head>
<body>


	<div id="mySidenav" class="sidenav">
	  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	  <a class="sub2" href="#">침실 가구</a>
	  <a class="sub2" href="#">거실 가구</a>
	  <a class="sub2" href="#">주방 가구</a>
	  <a class="sub2" href="#">드레스 룸</a>
	  <hr style="border: solid 1px #CDCDCD; width: 190px; margin-top: 30px;">
	  <br>
	  <div align="center" style="color: white;">
		 <span class="submenubtn" >로그인</span>|
		 <span class="submenubtn" >주문내역</span>|
		 <span class="submenubtn" >고객센터</span>
	  </div>
	</div>

<div class="navbar">
  <span style="font-size:30px;cursor:pointer; width:15%; vertical-align: middle;" onclick="openNav()"><img id="mainheadermenu" src="<%= ctxPath %>/ProjectImg/menu.png" style="width: 50px;" align="middle"/></span>
  <span class="hsub1" style="width:60%; text-align: center; "><img id="headerlogo" src="<%= ctxPath %>/image/logo.png" style="width:120px; height:50px; cursor: pointer;" align="middle"/></span>
  <span class="hsub1" style="width:10%; text-align: right;"><img id="headerlogo"  src="<%= ctxPath %>/image/login_small.png" style="width:28px; height:23px; cursor: pointer; " align="middle" /></span>
  <span class="hsub1" style="width:10%; text-align: right;"><img id="headerlogo"  src="<%= ctxPath %>/image/cart_small.png" style="width:28px; height:23px; cursor: pointer;" align="middle" /></span>
</div>

 
</body>
</html> 
