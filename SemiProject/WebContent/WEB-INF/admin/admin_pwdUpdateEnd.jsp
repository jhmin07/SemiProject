<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /SemiProject
%>    
    
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>

#btnOk{

}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("button#btnUpdate").click(function(){
			
			var pwd = $("input#pwd").val();
			var pwd2 = $("input#pwd2").val();
			
			// var regExp = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
			// 또는
			var regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			var bool = regExp.test(pwd);
			
			if(!bool) {
				alert("암호는 8글자 이상 15글자 이하에 영문자,숫자,특수기호가 혼합되어야만 합니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return;   // 종료
			}
			else if(bool && pwd != pwd2) {
				alert("암호가 일치하지 않습니다.");
				$("input#pwd").val("");
				$("input#pwd2").val("");
				return;   // 종료
			}
			else {
			 	var frm = document.pwdUpdateEndFrm;
			 	frm.action = "<%= ctxPath%>/member/pwdUpdateEnd.up";
			 	frm.method = "POST";
			 	frm.submit();
			}
		});
		
		
	});// end of $(document).ready(function(){})--------------------------

	
</script>

<form name="pwdUpdateEndFrm" style="margin-top: 20px;">
   <div id="div_pwd" align="center">
      <span style="font-size: 12pt; font-weight:bold;">새암호</span><br/> 
      <input type="password" name="pwd" id="pwd" size="30" style="margin-top: 5px; margin-bottom: 10px;" placeholder="새 암호 입력" required />
   </div>
   
   <div id="div_pwd2" align="center">
   	  <span style="color: blue; font-size: 12pt;">새암호확인</span><br/>
      <input type="password" id="pwd2" size="30" style="margin-top: 5px; margin-bottom: 10px;" placeholder="새 암호 확인" required />
   </div>
   
   <input type="hidden" name="userid" value="${requestScope.userid}" />
   
   <c:if test="${requestScope.method eq 'POST' && requestScope.n == 1}">
   	   <div id="div_updateResult" align="center">
   	   	   사용자 ID가 ${requestScope.userid}님의 암호가 새로이 변경되었습니다.<br><br>
   	   </div> 
   </c:if>
   
   <c:if test="${requestScope.method eq 'GET'}">
	   <div id="div_btnUpdate" align="center">
	   	  <button type="button" class="btn btn-success" id="btnUpdate" style="background-color: black; color: white; width: 150px; font-weight:bold;">암호변경하기</button>
	   </div> 
   </c:if> 
    
   
</form>
