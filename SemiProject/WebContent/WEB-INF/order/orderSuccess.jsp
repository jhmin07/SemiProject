<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% 
	String ctxPath = request.getContextPath();
%>
<jsp:include page="../header4.jsp"/>
<style type="text/css">
div.container {
	margin: 100px auto;
}

div.odrscContainer {
	width: 80%;
}

div#odrSucesContent {
	text-align: center;
	margin: 50px auto;
	border: solid 1px gray;
	padding: 50px;
}

h2#odrthankyou {
	clear: right;
	padding-top: 30px;
	padding-bottom: 10px;
	color: #000;
	font-size: 30px;
	text-align: center;
	font-family: Georgia;
}

button.odrscBtn {
	border: none;
	background-color: black;
	color: white;
	width: 200px;
	height: 40px;
	margin: 20px 5px;
}

/* 주문정보 관련 css */
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

/* 배송정보 관련 css */
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

	$(document).ready(function(){
		// orderSuccessSendMsg();
		
		
	});
	
	// == 주문 성공 메세지 보내기 == //
	function orderSuccessSendMsg() {
        var dataObj;
        var mobile = "${sessionScope.loginuser.mobile}";
        var smsContent = "[RHOME] "+"${requestScope.odrmsg}";
        
        dataObj = {"mobile":mobile,
                  "smsContent":smsContent};
         
		$.ajax({
			url:"<%=request.getContextPath()%>/admin/smsSend.up",
			type:"POST",
			data:dataObj,
			dataType:"json",
			success:function(json){
				// json 은 {"group_id":"R2G2yDfncqLQd7GF","success_count":1,"error_count":0}
				if (json.success_count == 1) {
					console.log("문자전송 성공");
					// 문자 전송되는 것 확인 완료
					// mobile: 01085618498 smsContent[심플침대프레임]...외 2건 주문완료되었습니다
				}
				else if (json.error_count != 0) {
					console.log("문자전송 실패");
				}
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}
	
	// == 쇼핑계속하기 == //
	function goHome(){
		location.href = "<%=request.getContextPath()%>/home.up";
	}
	
	// == 주문내역확인하기 == //
	function goOrderListCheck() {
		location.href = "<%=request.getContextPath()%>/order/orderList.up"; 
	}
</script>

<div class="container odrscContainer">	
	<c:set var="odrList" value="심플침대프레임 심플침대매트리스"/>
	
	<div id="odrSucesContent">
		<h2 id="odrthankyou">THANK YOU</h2>
		<p>[주문번호] ${requestScope.delivo.fk_orderCode}<br>${requestScope.odrmsg}</p>
		
		<button type="button" class="odrscBtn" onclick="goHome();">쇼핑계속하기</button>
		<button type="button" class="odrscBtn" onclick="goOrderListCheck();" style="background-color: #80bfff;">주문내역확인하기</button>
	</div>
	
	<br>
	
	<%-- 결제 정보 보여주기 --%>
	<table class="table odr_info">
		<thead><tr><td colspan="2">결제 정보</td></tr></thead>
		<tbody>
			<tr>
				<td>결제방법</td>
				<td>카드</td>
				<td rowspan="2" style="width: 35%; background-color: #f2f2f2;">
					<span style="font-weight: bold;">총결제금액</span><br><br>
					<span style="font-size: 15pt; padding-left: 20px;">${requestScope.sumtotalPrice}</span>
				</td>
			</tr>
			<tr>
				<td>결제상태</td>
				<td>결제완료</td>
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
				<td>${requestScope.delivo.recName}</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					(${requestScope.delivo.recPostcode})&nbsp;
					${requestScope.delivo.recAddress}&nbsp;
					${requestScope.delivo.recDetailaddress}&nbsp;
					${requestScope.delivo.recExtraaddress}&nbsp;
				</td>
			</tr>
			<tr>
				<td>연락처</td>
				<c:set var="hp" value="${requestScope.delivo.recMobile}"/>
				<td>
					${fn:substring(hp, 0, 3)} -
					${fn:substring(hp, 3, 7)} - 
					${fn:substring(hp, 7, 12)}
				</td>
			</tr>
			<tr>
				<td>배송메시지</td>
				<td>${requestScope.delivo.dvMessage}</td>
			</tr>
		</tbody>
	</table>
</div>

<jsp:include page="../footer.jsp"/>