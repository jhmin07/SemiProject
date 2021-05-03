<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header4.jsp"/>
<style type="text/css">
div.container {
	margin: 80px auto;
}

div#odrSucesMsg {
	text-align: center;
	width: 70%;
	margin: 50px auto;
	border: solid 1px gray;
	padding: 20px;
}

span#sucesSpan {
	color: red;
	font-weight: bold;
}

<%-- 주문정보 관련 css --%>
table.odr_list, table.odr_info {
	border-bottom: solid 1px #ddd !important;
	/* border: solid 1px red; */
}

table.odr_list > thead {
	background-color: #f2f2f2;
}

img.odr_img {
	width: 100px;
	height: 100px;
}

tr.odr_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

<%-- 배송정보 관련 css --%>
table.odr_info tr {
	height: 50px;
}

table.odr_info>tbody td:nth-child(1) {
	width: 20%;
	font-weight: bold;
	background-color: #f2f2f2;
}

table.odr_info td:nth-child(2) {
	/* width: 80%; */
	text-align: left;
}

</style>

<script type="text/javascript">
function goHome(){
	location.href = "<%=request.getContextPath()%>/home.up";
}
</script>

<div class="container">	
	<div id="odrSucesMsg">
		<h3>감사합니다!&nbsp;<span id="sucesSpan">주문이 완료</span>되었습니다.</h3>
		<span>주문번호:</span>
	</div>
	
	<%-- 주문 완료된 상품 리스트 보여주기 --%>
	<table class="table odr_list">
		<thead>
			<tr>
				<th>이미지</th>
				<th>상품정보</th>
				<th>상품금액</th>
				<th>할인금액</th>
				<th>수량</th>
				<th rowspan="2">주문금액</th>
			</tr>
		</thead>
		
		<tbody>
			<tr class="odr_tr">
				<td><img class="odr_img" src="<%=ctxPath%>/imagesContents2/${prod.image}.jpg"></td>
				<td>의자</td>
				<td>10,000원</td>
				<td>2,000원</td>
				<td>1</td>
				<td style="background-color: #f2f2f2; text-align: center;">8,000원</td>
			</tr>
		</tbody>
	</table>
	
	<br>
	
	<%-- 결제 정보 보여주기 --%>
	<table class="table odr_info">
		<thead><tr><td colspan="2">결제 정보</td></tr></thead>
		<tbody>
			<tr>
				<td>결제방법</td>
				<td></td>
				<td rowspan="2" style="width: 35%; background-color: #f2f2f2;">총결제금액</td>
			</tr>
			<tr>
				<td>결제상태</td>
				<td></td>
			</tr>
		</tbody>
	</table>
	
	<br>
	
	<%-- 배송지 정보 보여주기 --%>
	<table class="table odr_info">
		<thead><tr><td colspan="2">배송지 정보</td></tr></thead>
		<tbody>
			<tr>
				<td>받으시는 분</td>
				<td></td>
			</tr>
			<tr>
				<td>주소</td>
				<td></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td></td>
			</tr>
			<tr>
				<td>배송메시지</td>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>

<jsp:include page="../footer.jsp"/>