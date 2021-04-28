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

	$("button#btnOK").click(function(){
		
	});

	
</script>

<form name="pwdUpdateEndFrm" style="margin-top: 80px;">
	<div id="div_findResult" align="center">
   	  회원님의 아이디 : <span style="color: red; font-size: 16pt; font-weight: bold;">${requestScope.userid}</span> 
   </div>
   <br>
<!--    <div id="div_btnUpdate" align="center">
   	  <button type="button" id="btnOK" style="background-color: black; color: white; width: 150px; font-weight:bold;">확인</button>
   	  
   </div>  -->

    
   
</form>
