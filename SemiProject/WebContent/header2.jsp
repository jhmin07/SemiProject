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

<style type="text/css">

li.menulist {
	font-size: 13pt;
	margin: 20px 0 40px 0;
    font-weight: bold;
    cursor: pointer;
}

span.mainheaderbtn {
	margin-right: 40px; 
	font-size: 10pt;
	cursor: pointer;
	font-weight: bold;
	font-family: Dotum;
}

span.submenubtn {
	font-family: Dotum;
	font-size: 10pt;
	font-weight: bold;
	margin: 10px 5px 0 5px;
	cursor: pointer;
}

</style>

<script type="text/javascript">

	function menuon(){	
		document.getElement
		$("div#sideinfo").css({"display":"block"});
		$("img#mainheadermenu").hide();	
	}	

	function menuclose(){	
		$("div#sideinfo").css({"display":"none"});
		$("img#mainheadermenu").show();
	}
</script>

</head>
<body>


<div id="maincontainer">

	<div id="sideinfo" style="display:none; height: 550px; position: absolute; width: 300px;">
		<div class="row">
			<div style="text-align: right; margin: 20px 30px 0 0; "><img src="<%= ctxPath %>/ProjectImg/menuclose.png" style="width:20px; cursor: pointer;" onclick="menuclose()"/></div>
			<div class="col-md-12" style="text-align: left; padding: 20px; ">
				<ul style="list-style-type: none; margin-top: 30px;">
					<li class="menulist"> -&nbsp;&nbsp;침실 가구</li>
					<li class="menulist"> -&nbsp;&nbsp;거실 가구</li>
					<li class="menulist"> -&nbsp;&nbsp;주방 가구</li>
					<li class="menulist"> -&nbsp;&nbsp;드레스 룸</li>			
				</ul>	
			</div>
			<hr style="border: solid 1px #CDCDCD; width: 230px;">
			<br>
			<div align="center">
				<span class="submenubtn" >로그인</span>|
				<span class="submenubtn" >주문내역</span>|
				<span class="submenubtn" >고객센터</span>
			</div>
		</div>
	</div>

	<div id="mainheader" style="min-height: 70px; margin-top: 5px; ">
		<div class="row">
		    <div class="col-sm-4" style="padding-top: 10px;"><img id="mainheadermenu" src="<%= ctxPath %>/ProjectImg/menu.png" style="width: 50px; cursor: pointer;" onclick="menuon()"/></div>
		    <div class="col-sm-4" align="center" style="padding-top: 10px;"><img id="mainheaderlogo"  src="<%= ctxPath %>/ProjectImg/logo.png" style="width:120px; height:50px; cursor: pointer;"/></div>
		    <div class="col-sm-4" style="text-align: right; padding-top: 20px;">
		    	<span id="mainheaderlogin" class="mainheaderbtn" >로그인</span>
		    	<span id="mainheadershoppingbag" class="mainheaderbtn" >장바구니</span>
		    </div>
		</div>
	</div>

</div>

</body>
</html>