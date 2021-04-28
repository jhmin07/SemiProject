<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String ctxPath = request.getContextPath();
%>
<script type="text/javascript">

	window.onload = function(){		
		var frm = document.loginFrm;
		frm.action = "<%= ctxPath%>/member/memberRegisterSuccess.up";
		frm.method = "post";
		frm.submit();		
	}// end of window.onload = function(){}--------------------
	
</script>

<form name="loginFrm">
	<input type="hidden" name="userid" value="${requestScope.userid}"/>
	<input type="hidden" name="pwd" value="${requestScope.pwd}"/>
</form>



