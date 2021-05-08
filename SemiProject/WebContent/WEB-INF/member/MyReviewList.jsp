<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
	
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();

	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy+'-'+mm+'-'+dd;
	//console.log(today);
	
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
		
		if($('input#hiddendate').val() == today || $('input#hiddendate').val() == ""){
			// From의 초기값을 3개월 전으로 설정
			$('input#fromDate').datepicker('setDate', '-3M'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
			// To의 초기값을 오늘로 설정
			$('input#toDate').datepicker('setDate', 'today'); // (-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)		
			}
		else{
			// From의 초기값을 3개월 전으로 설정
			$('input#fromDate').datepicker('setDate', $('input#hiddendate').val()); 
			// To의 초기값을 오늘로 설정
			$('input#toDate').datepicker('setDate', $('input#hiddendate2').val()); 
		}
		
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

	
	// 날짜별, 배송상태별 주문조회하기
	function showOrderListByDate(){
		var frm = document.orderListFrm;
		frm.action = "<%= ctxPath%>/order/orderList.up";
		frm.method = "GET";
		frm.submit();		

	}
</script>

<div class="container">	
	<h2 align="center">My Review List</h2>
	<%-- 주문 내역조회 날짜 보여주기 --%>
	<div class="stateSelect">
		<span style="font-weight: bold;">내가 작성한 리뷰 조회</span>
		<%-- 조회기간 --%>
		<form name="orderListFrm">			
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
			<input type="hidden" value="${fromDate}" id="hiddendate"/>
			<input type="hidden" value="${toDate}" id="hiddendate2"/>
			<input type="text" class="datepicker" id="fromDate" name="fromDate" autocomplete="off" > - <input type="text" class="datepicker" id="toDate" name="toDate" autocomplete="off">
			<span id="showOrderList" onclick="showOrderListByDate()">조회</span>
		</form>
	</div>
	
	<div style="margin: 5px 0;">
	&nbsp;&nbsp;· 기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 리뷰들을 조회하실 수 있습니다.<br>
	&nbsp;&nbsp;· 작성하신 리뷰를 클릭하시면 해당 상품에 대한 상세페이지를 확인하실 수 있습니다.
	</div>
	
	<%-- 주문 내역 보여주기 --%>
	<table class="table odr_list">
		<thead>
			<tr>
				<th>구매날짜</th>
				<th>상품정보</th>
				<th>상품구매금액</th>
				<th>리뷰작성날짜</th>
				<th>별점</th>
				<th>리뷰내용</th>
				<th>리뷰삭제</th>				
			</tr>
		</thead>
		
		<tbody>		
			<c:if test="${empty requestScope.orderList}">
				<tr>
					<td colspan="7" align="center" class="ordertext">
						주문한 상품이 없습니다.
					</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty requestScope.orderList}">
			
				<c:forEach var="ordervo" items="${requestScope.orderList}" varStatus="status">
				<tr>
					<td> <%-- 구매날짜 --%>
						
						<span>${ordervo.ord.orderDate}</span>
					</td>
					<td> <%-- 상품정보 --%>
					<a href="<%= ctxPath%>/detailMenu/productDetailPage.up?pnum=${ordervo.fk_pnum}">
						<img src="<%= ctxPath%>/image/product/${ordervo.prod.fk_decode}/${ordervo.prod.pimage1}" width="130px"/>
					</a>
					<span>${ordervo.prod.pname}</span>	
					</td>
					<td> <%-- 상품구매금액 --%>
						<span id="totalprice">
							<fmt:formatNumber value="${ordervo.ord.totalPrice}" pattern="###,###" />
							<input class="totalPrice" type="hidden" value="${ordervo.ord.totalPrice}" />
						</span> 원
					</td>
					<td> <%-- 리뷰작성날짜 --%>
						<span>${review.reviewRegisterday}</span>
					</td>
					<td> <%-- 별점 --%>
						<span>${review.review_like}</span>
					</td>
					<td> <%-- 리뷰내용 --%>
						<span>${review.reviewSubject}</span>
					</td>
					<td> <%-- 리뷰삭제 --%>
						
					</td>
				</tr>				
				</c:forEach>
							
			</c:if>
		</tbody>
	</table>
	
	
</div>

<jsp:include page="../footer.jsp"/>