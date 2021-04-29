<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
	//	/Semiproject
%>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">

</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		var method = "${requestScope.method}";
		
		if(method=="GET"){
			$("div#div_findResult").hide();
		}
		else{
			$("input#name").val("${requestScope.name}");
			$("input#email").val("${requestScope.email}")
		}
		
		$("button#btnFind").click(function(){
			
			var frm = document.idFindFrm;
			frm.action = "<%=ctxPath%>/member/idFindResult.up";
			frm.method = "post";
			frm.submit();
		});
	});
	

</script>

</head>
<body>

<form name="idFindFrm" style="margin-top: 20px;">
   <div id="div_name" align="center">
      <span style="font-size: 12pt; font-weight:bold;">성명</span><br/> 
      <input type="text" name="name" id="name" size="30" style="margin-top: 5px; margin-bottom: 10px;" placeholder="이름을 입력해주세요" autocomplete="off" required />
   </div>
   
   <div id="div_email" align="center">
   	  <span style="font-size: 12pt; font-weight:bold;">이메일</span><br/>	
      <input type="text" name="email" id="email" size="30" style="margin-top: 5px; " placeholder="이메일 주소를 입력해주세요" autocomplete="off" required />
   </div>
   
   <%--  <div id="div_findResult" align="center">
   	  ID : <span style="color: red; font-size: 16pt; font-weight: bold;">${requestScope.userid}</span> 
   </div>  --%>
      
   <div id="div_btnFind" align="center" style="margin-top: 25px;">
   		<button type="button" style="background-color: black; color: white; width: 150px; font-weight:bold;" id="btnFind">아이디 찾기</button>
   </div>
   
</form>

</body>
</html>