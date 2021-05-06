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

div.stateSelect{
	border: solid 2.5px #ddd;
	padding: 20px;
}

a.btnNormal {
	border: solid 1px #f2f2f2;
	color: black;
	font-size: 9pt;
}

span.period {
	margin-right: 10px;
}

span#showOrderList{
	border: solid 1px #336699;
	background-color: #336699;
	color: white;
	padding: 2px;
	margin-left: 5px;
	cursor: pointer;
}

span.chkbox {
	font-size: 9pt;
	border: solid 1px gray;
	color: gray;
	border-radius: 5px;
	margin-right: 2px;
	padding-left: 3px;	
}

input.dateType{
	display: none;
}

input.datepicker{
	width: 100px;
}

label{
	cursor: pointer;
	font-weight: normal;
}

table.odr_list {
	border-bottom: solid 1px #ddd !important;
}

table.odr_list > thead {
	background-color: #f2f2f2;
}

img.odr_img {
	width: 100px;
	height: 100px;
}

tr.odr_tr > td {
	vertical-align: middle !important;
}


</style>

<script type="text/javascript">
$(document).ready(function(){	
			
	// === 전체 datepicker 옵션 일괄 설정하기 ===  
    //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
	$(function() {
		// 모든 datepicker에 대한 공통 옵션 설정
		$.datepicker.setDefaults({
			dateFormat: 'yy-mm-dd'		// Input Display Format 변경
			,showOtherMonths: true		// 빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true	// 년도 먼저 나오고, 뒤에 월 표시
			,changeYear: true			// 콤보박스에서 년 선택 가능
			,changeMonth: true			// 콤보박스에서 월 선택 가능                
			,showOn: "both"				// button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
			,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로
			,buttonImageOnly: true		// 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		//	,buttonText: "선택"			// 버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
			,yearSuffix: "년"			// 달력의 년도 부분 뒤에 붙는 텍스트
			,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] // 달력의 월 부분 텍스트
			,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 달력의 월 부분 Tooltip 텍스트
			,dayNamesMin: ['일','월','화','수','목','금','토'] // 달력의 요일 부분 텍스트
			,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] // 달력의 요일 부분 Tooltip 텍스트
		//	,minDate: "-1M"				// 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		//	,maxDate: "+1M"				// 최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
		});

		// input을 datepicker로 선언
		$("input#fromDate").datepicker();                    
		$("input#toDate").datepicker();
		
		// From의 초기값을 3개월 전으로 설정
		$('input#fromDate').datepicker('setDate', '-3M'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
		// To의 초기값을 오늘로 설정
		$('input#toDate').datepicker('setDate', 'today'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	});
});
	
	// Function Declaration
	function setSearchDate(start){
		var num = start.substring(0,1);
		var str = start.substring(1,2);

		var today = new Date();

		var endDate = $.datepicker.formatDate('yy-mm-dd', today);
		$('#toDate').val(endDate);
		
		if(str == 'd'){
			today.setDate(today.getDate() - num);
		} else if (str == 'w'){
			today.setDate(today.getDate() - (num*7));
		} else if (str == 'm'){
			today.setMonth(today.getMonth() - num);
			today.setDate(today.getDate() + 1);
		}
		
		var startDate = $.datepicker.formatDate('yy-mm-dd', today);
		$('#fromDate').val(startDate);
		
		// 종료일은 시작일 이전 날짜 선택하지 못하도록 비활성화
		$("#toDate").datepicker( "option", "minDate", startDate );
		
		// 시작일은 종료일 이후 날짜 선택하지 못하도록 비활성화
		$("#fromDate").datepicker( "option", "maxDate", endDate );
	}

</script>

<div class="container">	
	<h2 align="center">ORDER LIST</h2>
	
	<%-- 주문 내역조회 날짜 보여주기 --%>
	<div class="stateSelect">
		<select style="height: 30px;">
			<option value="all">전체 주문처리상태</option>
			<option value="shipped_before">입금전</option>
			<option value="shippeed_standby">배송준비중</option>
			<option value="shipped_begin">배송중</option>
			<option value="shipped_complate">배송완료</option>
			<option value="order_cancel">취소</option>
			<option value="order_exchange">교환</option>
			<option value="order_return">반품</option>
		</select>
		
	<%-- 조회기간 --%>	
		<br>
		<span class="period">
			<span class="chkbox">
				<input type="radio" class="dateType" id="dateType1" onclick="setSearchDate('0d')"/>
				<label for="dateType1">오늘</label>
			</span>
			<span class="chkbox">
				<input type="radio" class="dateType" id="dateType2" onclick="setSearchDate('1w')"/>
				<label for="dateType2">1주일</label>
			</span>
			<span class="chkbox">
				<input type="radio" class="dateType" id="dateType3" onclick="setSearchDate('1m')"/>
				<label for="dateType3">1개월</label>
			</span>
			<span class="chkbox">
				<input type="radio" class="dateType" id="dateType4" onclick="setSearchDate('3m')"/>
				<label for="dateType4">3개월</label>
			</span>
			<span class="chkbox">
				<input type="radio" class="dateType" id="dateType5" onclick="setSearchDate('6m')"/>
				<label for="dateType5">6개월</label>
			</span>
		</span>
	
		<input type="text" class="datepicker" id="fromDate" autocomplete="off"> - <input type="text" class="datepicker" id="toDate" autocomplete="off">
		<span id="showOrderList" onclick="gosearch()">조회</span>
	</div>
	
	<div style="margin: 5px 0;">
	&nbsp;&nbsp;· 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.<br>
	&nbsp;&nbsp;· 주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.
	</div>
	
	<%-- 주문 내역 보여주기 --%>
	<table class="table odr_list">
		<thead>
			<tr>
				<th>주문일자</th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>수량</th>
				<th>상품구매금액</th>
				<th>포인트</th>
				<th>배송상태</th>				
			</tr>
		</thead>
		
		<tbody>
			<tr class="odr_tr">				
				<td>2021-05-04</td>
				<td><img class="odr_img" src="<%=ctxPath%>/image/product/kitchen/furniture/furniture_01_01.jpg"></td>
				<td></td>
				<td>1개</td>
				<td>10,000원</td>
				<td>100</td>				
				<td>배송준비중</td>
			</tr>
		</tbody>
	</table>
	
	
</div>

<jsp:include page="../footer.jsp"/>