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
<!-- <title>이불커버</title> -->
<style type="text/css">

/* #detailContents{
	/* margin-top: 50px; 
	margin-left: 10%;
}
.productImg{
	width: 300px;
	height: 350px;

}
.product{
	text-align: center;
	/* margin-bottom: 30px; 
}
.name{
	margin-top: 10px;
} */
.demanu{
	width: 505px;
	height: 550px;
	border: 1px solid #eee9dd;
}
div#detailMain{
	/* padding-left: 5%; */
	margin-top: 45px;
	/* border: solid 5px blue; */
}
div#dename{
	border: 4px solid white;
	border-radius: 10%;
	color: white;
	font-size: 50px;
	position: absolute;
	top: 50%;
  	left: 50%;
  	transform: translate(-50%, -50%);
}

</style>
</head>
<body>

<!-- <h5 style="text-align: center; border: solid 1px gray;">상세페이지 메인 </h5> -->

<div id="detailMain">
 <c:set var="i" value="0" />
	<c:set var="j" value="3" />
	<table>
	  <c:forEach items="${detailList}" var="devo">
	    <c:if test="${i%j == 0}">
	    <tr>
	    </c:if>
	      <td style="position: relative;">
			<a href="<%=ctxPath%>/detailMenu/menu.up?cnum=${cnum}&decode=${devo.decode}">
				<img src="<%=ctxPath%>/image/menu${devo.decode}.jpg" class="demanu"/>
				<div id="dename">${devo.dename}</div>
			</a>			
		  </td>
	    <c:if test="${i%j == j-1}">
	    </tr>
	    </c:if>
	    <c:set var="i" value="${i+1}" />
	  </c:forEach>
	</table>
</div> 	
<%--<div id= "detailContents">
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/blueCover.up">
				<img src="<%=ctxPath%>/image/blueCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/detailMenu/blueCover.up">	
					<span>모슬린 이불커버(블랙)</span>
				</a>
				<span>119,000 원 - 179,000 원</span>
			</div>
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/blackCover.up">
				<img src="<%=ctxPath%>/image/blackCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>퍼케일 코튼 이불커버(블루)</span>
				</a>
				<span>45,000 원 - 99,000 원</span>
			</div>
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/whiteCover.up">
				<img src="<%=ctxPath%>/image/whiteCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>워시드 린넨 이불커버(화이트)</span>
				</a>
				<span>139,000원</span>
			</div>	
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/naturalCover.up">
				<img src="<%=ctxPath%>/image/naturalCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>워시드 린넨 이불커버(네추럴)</span>
				</a>
				<span>169,000 원 - 199,000 원</span>
			</div>
		</article>	
	</div>
	<br>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/floralCover.up">
				<img src="<%=ctxPath%>/image/floralCover.PNG" class="productImg"/>
			</a>
			<<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>플로랄 프린트 이불커버</span>
				</a>
				<span>99,000 원 - 119,000 원</span>
			</div>
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/white_floralCover.up">
				<img src="<%=ctxPath%>/image/white_floralCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>퍼케일 코튼 이불커버(블루)</span>
				</a>
				<span>45,000 원 - 99,000 원</span>
			</div>
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/dotCover.up">
				<img src="<%=ctxPath%>/image/dotCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>도트 프린트 이불 커버</span>
				</a>
				<span>69,000 원 - 119,000 원</span>
			</div>
		</article>	
	</div>
	<div class="product">
		<article>
			<a href="<%=ctxPath%>/WEB-INF/detailMenu/checkCover.up">
				<img src="<%=ctxPath%>/image/checkCover.PNG" class="productImg"/>
			</a>
			<div class="name">
				<a href="<%=ctxPath%>/WEB-INF/menu01.jsp">	
					<span>다이트 얀 체크 이불커버</span>
				</a>
				<span>99,000 원 - 139,000 원</span>
			</div>
		</article>	
	</div>
</div>	 --%>

</body>
</html>

<jsp:include page="../footer.jsp"/>  