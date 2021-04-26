<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="header4.jsp" />
<jsp:include page="order.jsp" />

<style type="text/css">
	table.payment_table tr {
		height: 50px;
	}
	
	table.payment_table td,
	table.payment_table th {
		border: none !important;
	}
	
	tr.payment_thead > th {
		/* padding: 20px 130px; */
		/* font-size: 12pt; */
		/* color: #a6a6a6; */
		
		text-align: center;
		background-color: #f2f2f2;
	}
	
	tr.payment_thead_result > td {
		text-align: right;
		background-color: white !important;
	}

	tr.payment_tbody > td {
		/* padding: 20px 130px; */
		/* font-size: 15pt; */
		/* color: #a6a6a6; */
		/* font-weight: bold; */

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
		/* text-align: right; */
		list-style-type: none;
		background-color: #f2f2f2;
		padding: 10px 10px;
		width: 600px;
	}
	
	ul.payment_last > li {
		margin-bottom: 20px;
	}
	
</style>
<script type="text/javascript">
</script>

<form>
	<div id="divPayments_1">
		<br><hr color="#a6a6a6;"><br>
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
					<td> - 원</td>
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
	</div>
	<br>
	
	<div id="divPayments_2" align="right">
		<ul class="payment_last">
			<li>최종결제 금액</li>
			<li>원</li>
			<li><label for="agree"></label><input type="checkbox" id="agree" />결제정보를 확인하였으며, 구매진행에 동의합니다.</li>
			<li><button id="paymentGo">결제하기</button></li>
		</ul>
	</div>	
</form>	
</div><%-- order.jsp의 첫번째 div 태그닫는 부분 --%>	

<jsp:include page="footer.jsp" />	
