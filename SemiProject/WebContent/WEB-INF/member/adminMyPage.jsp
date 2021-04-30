<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    String ctxPath = request.getContextPath();

%>
   
    
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Orelega+One&family=PT+Serif:wght@400;700&family=Titillium+Web:wght@700&display=swap" rel="stylesheet">
    
<style type="text/css">
 

 
h2{
	clear: right;
	padding: 200px 40px 0 0;
	color: #000;
	font-size: 30px;
	text-align: center;
	font-family: 'PT Serif', serif;
}
p{
	padding: 0 40px 10px 0;
    color: #a7a7a7;
    font-size: 16px;
    text-align: center;	
}
 
.button_base {
    margin: 0;
    border: 0;
    font-size: 18px;
    margin-left: 20px;
    position: relative;
    left: 27%;
    width: 200px;
    height: 40px;
    text-align: center;
    box-sizing: border-box;
    display: inline-block;
    font-family: 'PT Serif', serif;
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
 $(function(){
	 
	 $("div#manageMember").bind("click", function(){
		 location.href= "<%= ctxPath%>/member/";
	 });
	 $("div#adminRegister").bind("click", function(){
		 location.href= "<%= ctxPath%>/member/";
	 });
	 $("div#productRegister").bind("click", function(){
		 location.href= "<%= ctxPath%>/product/";
	 });
	 
 });

 
 
 </script>
 
<jsp:include page="../header4.jsp" />   

<div class="container">
	<h2>ADMIN PAGE</h2>
	<p>[관리자 모드입니다.]</p>
	     <div class="button_base b01" id="manageMember">
	     	MANAGE MEMBER
	     </div>
	     <div class="button_base b01" id="adminRegister">
	     	ADMIN REGISTER
	     </div>
	     <div class="button_base b01" id="productRegister">
	     	PRODUCT REGISTER
	     </div>
	     
	     
<!-- 	     <div class="personalInfo">
	     	<div><span class="input" id="userName">장혜민</span>님은 [관리자회원]이십니다.</div>
	     	<br>
	     	<div>POINT : <span class="input" id="point">4000</span></div>
	     </div> -->
		       
		
</div>
<jsp:include page="../footer.jsp" />  