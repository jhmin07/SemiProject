<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctxPath = request.getContextPath();
%>     

<style type="text/css">
/* 쇼핑몰 구매 동의 css */
table.payAgree_table td:nth-child(1) {
	width: 30%; 
}	

table.payAgree_table th {
	background-color: #f2f2f2;
}

table.payAgree_table td {
	background-color: #fff;
	border-bottom: solid 1px #f2f2f2;
}

/* 결제예정금액 css */
table.payment_table tr {
	height: 50px;
}

table.payment_table td,
table.payment_table th {
	border: none !important;
}

tr.payment_thead > th {
	text-align: center;
	background-color: #f2f2f2;
}

tr.payment_thead_result > td {
	text-align: right;
	background-color: white !important;
}

tr.payment_tbody > td {
	border: none;
	text-align: right;
}

tr.payment_tbody td:nth-child(1) {
	width: 30%; 
	font-weight: bold;
	background-color: #f2f2f2;
	text-align: center;
}

button#paymentGo{
	width: 100%;
	height: 50px;
	background-color: #cc6666;
	color: white;
	text-align: center;
	border: none;
	font-size: 17;
}

button.payment_button{
	border: solid 1px black;
	background-color:white;
	font-size: 15;
}

ul.payment_last {
	text-align: right;
	list-style-type: none;
	background-color: #f2f2f2;
	padding: 10px 10px;
	width: 600px;
}

ul.payment_last > li {
	margin: 10px 10px;
}
</style>

<script type="text/javascript">

	function payAgreeCheck() {
		$("input:checkbox[name=shoppingAgree]:checked").length
	}

</script>


	<%-- 쇼핑몰 구매 이용약관 --%>
	<br><hr color="#a6a6a6;"><br>
	<table class="table payAgree_table">
		<thead style="background-color: #f2f2f2;">
			<tr>
				<th colspan="2">
					<input type="checkbox" id="shoppingAllAgree" name="shoppingAllAgree"/>
					<label for="shoppingAllAgree">쇼핑몰 이용약관 비회원 구매시 개인정보수집이용 동의에 모두 동의합니다.</label>
				</th>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td>쇼핑몰 이용약관</td>
				<td>
					<iframe src="<%=ctxPath%>/iframeAgree/agree.html" width="100%" height="150px" class="box" style="border: solid 1px #ccc;"></iframe>
					<input type="checkbox" id="shoppingAgree1" name="shoppingAgree"/>
					<label for="shoppingAgree1">&nbsp;동의</label>
				</td>
			</tr>
			<tr>
				<td>비회원 구매시 개인정보 수집이용동의</td>
				<td>
					<iframe src="<%=ctxPath%>/iframeAgree/agree.html" width="100%" height="150px" class="box" style="border: solid 1px #ccc;"></iframe>
					<input type="checkbox" id="shoppingAgree2" name="shoppingAgree"/>
					<label for="shoppingAgree2">&nbsp;동의</label>
				</td>
			</tr>
		</tbody>
	</table>	
	
	<%-- 결제 예정 금액 --%>
	<h2 style="font-size: 13pt; color: #a6a6a6;">결제 예정 금액</h2>
	<table class="table payment_table">
		<thead>
			<tr class="payment_thead">
				<th>총 주문 금액&nbsp;&nbsp;<button class="payment_button">내역보기</button></th>
				<th>총 할인 + 부가결제 금액</th>
				<th>총 결제예정 금액</th>
			</tr>
		</thead>
		
		<tbody>
			<tr class="payment_thead_result">
				<td><fmt:formatNumber value="${total_price}" pattern="#,###" />원</td>
				<td> ${total_price} 원</td>
				<td> = 원</td>
			</tr>
			<tr class="payment_tbody">
				<td>총 할인금액</td>
				<td> 원</td>
			</tr>
			<tr class="payment_tbody">
				<td>추가할인금액</td>
				<td> 원</td>
				<td style="text-align: left;"><button class="payment_button">내역보기</button></td>
			</tr>
			<tr class="payment_tbody">
				<td>총 부가결제금액</td>
				<td> 원</td>
			</tr>
		</tbody>
	</table>
	
	<%-- 최종 결제 예정 금액 --%>
	<div align="right">
		<ul class="payment_last">
			<li>최종결제 금액</li>
			<li>원</li>
			<li>
				<input type="checkbox" id="paymentagree" />
				<label for="paymentagree">&nbsp;결제정보를 확인하였으며, 구매진행에 동의합니다.</label>
			</li>
			<li><button id="paymentGo" onclick="paymentGoFunc()">결제하기</button></li>
		</ul>
	</div>
