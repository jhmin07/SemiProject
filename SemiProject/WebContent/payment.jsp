<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	div#divPayments_1{
		/* margin: 50px 100px; */
	}
	div#divPayments_2{
		margin: 50px 100px 50px 100px;
	}
	div#divPayments_1 > table.payment{
		/* text-align: center; */
	}
	div#divPayments_1 > table#table1{
		/* width: 1500px; */
	}
	div#divPayments_2 > table.payment{
		/* text-align: right; */
		background-color: #f2f2f2;
		width: 700px;
	}
	div#divPayments_1  th.payment_table1{
		/* padding: 20px 130px; */
		font-size: 12pt;
		text-align: center;
		color: #a6a6a6;
		background-color: #f2f2f2;
	}
	
	div#divPayments_1  td.payment_table1{
		/* padding: 20px 130px; */
		font-size: 15pt;
		text-align: center;
		color: #a6a6a6;
		font-weight: bold;
	}
	/* tr.payment{
		border: solid 1px gray;
	} */
	div#divPayments_1  td.payment_table2{
		padding: 20px 60px;
		font-size: 12pt;
		text-align: center;
		color: #a6a6a6;
	}
	div#divPayments_1  td.left{
		background-color: #f2f2f2;
		color: #a6a6a6;
	}
	div#divPayments_1  td.right{
		color: #a6a6a6;
	}
	div#divPayments_2  td{
		padding: 20px 20px;
		font-size: 12pt;
		color: #a6a6a6;
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
	
</style>
	

<script type="text/javascript">

</script>

<form>
	<div id="divPayments_1">
		<h2 style="font-size: 13pt; color: #a6a6a6;">결제 예정 금액</h2>
		<table class="table odr_info"  class="payment">
			<thead>
				<tr>
					<th class="payment_table1">총 주문 금액&nbsp&nbsp<button class="payment_button">내역보기</button></th>
					<th class="payment_table1">총 할인 + 부가결제 금액</th>
					<th class="payment_table1">총 결제예정 금액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="payment_table1">원</td>
					<td class="payment_table1">- 원</td>
					<td class="payment_table1">= 원</td>
				</tr>
			</tbody>
		</table>
		<table class="table odr_info" class="payment">
			<tbody>
				<tr>
					<td class="payment_table2 left">총 할인금액</td>
					<td class="payment_table2 right"> 원</td>
				</tr>
				<tr>
					<td class="payment_table2 left">추가할인금액</td>
					<td class="payment_table2 right"> 원&nbsp&nbsp<button class="payment_button">내역보기</button></td>
				</tr>
				<tr>
					<td class="payment_table2 left">총 부가결제금액</td>
					<td class="payment_table2 right"> 원</td>
				</tr>
			</tbody>
		</table>	
	</div>
	
	<div id="divPayments_2" align="right">
	<table id="table3"  class="payment">
		<tbody>
			<tr>
				<td class="payment_table3">최종결제 금액</td>
			</tr>
			<tr>
				<td class="payment_table3"> 원</td>
			</tr>
			<tr>
				<td class="payment_table3"><label for="agree"></label><input type="checkbox" id="agree" />결제정보를 확인하였으며, 구매진행에 동의합니다.</td>
			</tr>
			<tr>
				<td class="payment_table3"><button id="paymentGo">결제하기</button></td>
			</tr>
		</tbody>
	</table>
	</div>	
</form>