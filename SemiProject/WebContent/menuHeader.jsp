<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="header4.jsp"/> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>메뉴헤드메뉴</title> -->
<style type="text/css">

div{
	display: inline-block;
}
div#headMenu{
	margin-top: 100px;
	margin-left: 80px;

}
a{
	cursor: pointer;
	display: block;
	color: black;
}
a:hover{
	color: black;
}
img{
	width: 85px;
	height: 85px;
}
article{
	margin-left: 30px;
}
.category{
	margin-top: 5px;
	font-size: 11px;
}
</style>

</head>
<body>

<div id= "headMenu" class="container">
	<div>
		<article>
			<a href="<%=ctxPath%>/WEB-INF/DetailMenu/menu01.up">
				<img src="<%=ctxPath%>/image/menu01.PNG" />
			</a>
			<a href="<%=ctxPath%>/WEB-INF/menu01.jsp" class="category" style="text-align: center">	
				<span>이불커버</span>
			</a>
		</article>	
	</div>
	<div>
		<article>
			<a href="<%=ctxPath%>/WEB-INF/menu02.jsp">
				<img src="<%=ctxPath%>/image/menu02.PNG" />
			</a>
			<a href="<%=ctxPath%>/WEB-INF/menu02.jsp" class="category" style="text-align: center">	
				<span>플랫시트</span>
			</a>
		</article>	
	</div>
	<div>
		<article>
			<a href="<%=ctxPath%>/WEB-INF/menu03.jsp">
				<img src="<%=ctxPath%>/image/menu03.png" />
			</a>
			<a href="<%=ctxPath%>/WEB-INF/menu03.jsp" class="category" style="text-align: center">	
				<span>매트리스커버</span>
			</a>
		</article>	
	</div>
	<div>
		<article>
			<a href="<%=ctxPath%>/WEB-INF/menu04.jsp">
				<img src="<%=ctxPath%>/image/menu04.PNG" />
			</a>
			<a href="<%=ctxPath%>/WEB-INF/menu04.jsp" class="category" style="text-align: center">	
				<span>베개커버</span>
			</a>
		</article>	
	</div>
</div>	
	<br>
<!-- 	<div id="contents">
		<h2>이불커버 메뉴 클릭</h2>
		<h2>이불커버 메뉴 클릭</h2>
		<h2>이불커버 메뉴 클릭</h2>
		<h2>이불커버 메뉴 클릭</h2>
		<h2>이불커버 메뉴 클릭</h2>
		<h2>이불커버 메뉴 클릭</h2>
	</div> -->


</body>
</html>
