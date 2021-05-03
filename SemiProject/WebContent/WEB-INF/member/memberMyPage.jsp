<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
    
<%
    String ctxPath = request.getContextPath();

%>
   
   
<jsp:include page="../header4.jsp" />  
    

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
    margin-bottom: 40px;
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
	/* border: solid 1px red; */
	width: 650px;
	position: relative;
    left: 21%;
/*     background-color: #CBCBCB; */
    

	
}

span.input{
	font-weight: bold;
}


 
 </style>   
 <script type="text/javascript">
 $(function(){
	 
	 $("div#orderList").bind("click", function(){
		 location.href= "<%= ctxPath%>/member/";
	 });
	 $("div#myInfo").bind("click", function(){
		 location.href= "<%= ctxPath%>/member/memberEdit.up?userid=${sessionScope.loginuser.userid}";
	 });
	 $("div#coupon").bind("click", function(){
		 location.href= "<%= ctxPath%>/product/";
	 });
	 
 });

 
 
 </script>
 


<div class="container">
	<h2>MY PAGE</h2>
	<p>안녕하세요 <span style="font-weight: bold; color: black;">${(sessionScope.loginuser).name}</span>님 마이페이지입니다.</p>
	     <div class="button_base b01" id="orderList">
	     	ORDER LIST
	     </div>
	     <div class="button_base b01" id="myInfo">
	     	MY INFO
	     </div>
	     <div class="button_base b01" id="coupon">
	     	COUPON
	     </div>
	     
	     <div class="personalInfo">
	     	<div><span class="input">${(sessionScope.loginuser).name}</span>님은 <span class="input" >[일반회원]</span>이십니다.</div>
	     	<br>
	     	<div>POINT :&nbsp;&nbsp;&nbsp;&nbsp;<span class="input" id="point"><fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" /></span></div>
	     	<div>COUPON :&nbsp;<span class="input" id="point">${requestScope.coupon}</span></div>
	     </div> 
		       
		
</div>
<jsp:include page="../footer.jsp" />  