<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header4.jsp"/> 

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>메뉴헤드메뉴</title> -->
<style type="text/css">

/* div#headMenu{
	display: inline-block;
} */
div#headMenu{
	margin-top: 100px;
	margin-left: 20px;
}
/* #detailCategory{
	float: left;
} */
div#headMenu > a{
	cursor: pointer;
	display: block;
	color: black;
}
div#headMenu > a:hover{
	color: black;
}
img.demanu{
	width: 85px;
	height: 85px;
	margin-left: 20px;
	border-radius: 50%;
	float: left;
}
a.category{
	margin: 5px 0px 10px 20px;
	font-size: 11px;
	color: black;
	display:block;
	text-align: center;
}
</style>
</head>
<body>

<div id= "headMenu" class="container">
	
	<table id=detailCategory text-align: center;>
		<thead>
		<tr>			
			<c:forEach var="devo" items="${detailList}">
				
			<td><a href="<%=ctxPath%>/detailMenu/menu.up?cnum=${cnum}&decode=${devo.decode}">
					<img src="<%=ctxPath%>/image/menu${devo.decode}.jpg" class="demanu"/>
				</a></td>
			</c:forEach>	
		</tr>	
		<tr>	
			<c:forEach var="devo" items="${detailList}">
				<td><a href="<%=ctxPath%>/detailMenu/menu.up?cnum=${cnum}&decode=${devo.decode}" class="category" >
					${devo.dename}
				</a></td>
			</c:forEach>
		</tr>
		</thead>
	</table>  
	<%-- 	<article>
			<a href="<%=ctxPath%>/detailMenu/menu01.up">
				<img src="<%=ctxPath%>/image/menu01.PNG" />
			</a>
			<a href="<%=ctxPath%>/WEB-INF/menu01.jsp" class="category" style="text-align: center">	
				<span>${requestScope.categoryList}이불커버</span>
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
	</div> --%>
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
