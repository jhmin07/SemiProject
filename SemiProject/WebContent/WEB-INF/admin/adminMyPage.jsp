<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
    
<%
    String ctxPath = request.getContextPath();

%>
<jsp:include page="../header4_forAdmin.jsp" />     
    
<style type="text/css">
 
 
h2{
	
	clear: right;
	padding: 200px 40px 0 0;
	color: #000;
	font-size: 30px;
	text-align: center;
	font-family: Georgia;
}
p{
	padding: 0 40px 70px 0;
    color: #a7a7a7;
    font-size: 16px;
    text-align: center;	
}

.button_base {
	margin-right: 13px;
    border: 0;
    font-size: 18px;
    position: relative;
    width: 200px;
    height: 45px;
    text-align: center;
    box-sizing: border-box;
    display: inline-block;
    left: 21%;
    margin-bottom: 100px;
}

.button_base:hover {
    cursor: pointer;
}

/* ### ### ### 01 */
.b01 {
    color: #9FA7B6;
    border: #CBCBCB solid 2px;
    padding: 8px;
    background-color: #ffffff;
}

.b01:hover {
    color: #ffffff;
    background-color: #CBCBCB;
}

div.personalInfo{
	
	width: 500px;
	position: relative;
    left: 28%;
	margin-top: 50px;
	
}

span.input{
	
	font-weight: bold;
}


 
 </style>   
 
 <script type="text/javascript">
 
 $(document).ready(function(){
	 
	 $("div#manageMember").bind("click", function(){
		 location.href= "<%= ctxPath%>/admin/";
	 });
	 $("div#adminRegister").bind("click", function(){
		 location.href= "<%= ctxPath%>/admin/adminRegister.up";
	 });
	 $("div#productRegister").bind("click", function(){
		 location.href= "<%= ctxPath%>/product/";
	 });
	 
 });

 
 
 </script>
 


<div class="container">
	<h2>ADMINISTRATOR PAGE</h2>
	<p>안녕하세요 <span style="font-weight: bold; color: black;">${(sessionScope.loginadmin).adName}</span>님 [관리자 모드입니다.]</p>
	<div class="buttons">
	 	<div class="button_base b01" id="manageMember">
	     	MANAGE MEMBER
	     </div>
	     <div class="button_base b01" id="adminRegister">
	     	ADMIN REGISTER
	     </div>
	     <div class="button_base b01" id="productRegister">
	     	PRODUCT REGISTER
	     </div>
	</div>
	    
	     
	     
<!-- 	     <div class="personalInfo">
	     	<div><span class="input" id="userName">장혜민</span>님은 [관리자회원]이십니다.</div>
	     	<br>
	     	<div>POINT : <span class="input" id="point">4000</span></div>
	     </div> -->
		       
		
</div>
<jsp:include page="../footer.jsp" />  