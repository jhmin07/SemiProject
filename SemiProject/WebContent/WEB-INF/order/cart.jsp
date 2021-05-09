<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	String ctxPath = request.getContextPath();
    
%>   

<jsp:include page="../header4.jsp" /> 


<style type="text/css">

div.container{
	
	margin-left: 150px;
	margin-right: 100px;
}

 div#cart_content {
   /* border: solid 1px red; */
   display: inline-block;
   float: left;
 }


table.table{
	width: 800px;
}

table.odr_list, table.odr_info {
	border-bottom: solid 1px #ddd !important;
	/* border: solid 1px red; */
}

table.odr_list > thead {
	background-color: #f2f2f2;
}



tr.odr_tr > td {
	/* border: solid 1px red; */
	vertical-align: middle !important;
}

tr.odr_total_price > td {
	text-align: right;
	
}

img#delete_cart{
	margin-left:9px;
	cursor: pointer;
	filter:contrast(30%);
}
img#delete_cart:hover{
	cursor: pointer;
	filter:contrast(200%);
}

 th#cart_th_3{
 	font-size:15pt; 
 	text-align:center;
 	width: 350px; 
 	padding-bottom: 30px;
 }


div#cart_side{
	float: left;
	display: inline-block;
	width: 300px; 
	left: 67%;
	position: fixed;
	
	/* box-shadow: 0 4px 4px gray;
	background-color: #f2f2f2;
	padding: 15px; */
	/* border: solid 1px red; */
}
div.cart{
	margin-bottom:200px;
}


 tr.side_cart {
 	width: 100%; 
	height: 20px;
	/* line-height:40px; */
	

 }
 tr.side_cart > td:nth-child(2){
 	text-align:right;
 }
 tr#total_price_in_cart > td{
 	font-size:12pt;
 	font-weight: bold;
 	padding-bottom: 30px;
 }
 tr#discount_price_in_cart > td{
 	font-weight: bold;
 	color: red;
 
 }
 tr#side_cart_totalPrice > td{
 	vertical-align: middle !important;
 	font-size:14pt;
 	font-weight: bold;
 	padding-top: 20px;
 	
 }

  tr#side_hr > td{
  	padding-bottom:10px;
 	border-bottom: solid 1px #ddd !important;
 	width: 350px; 
 }
 div#order_button_cart{
 	line-height:40px;
 	background-color:black; 
 	color:white; 
 	text-align:center;
 	height: 40px;
 	weight:100%;
 	
 }

 div#cart_promo{
 	background-color:#FCF8E3; 
 	color:#A38C60; 
 	text-align:center; 
 	font-size:10pt;
 	padding:5px;
 }
 span.cart_pname{
	font-size:11pt;
	color:#3A464D;
	
 }
 td#productPrice_cart{
	font-weight: bold; 
	text-align:right;
	padding-top:20px;
 }

 td#td_plusminus> img{
	width:15px;
	height:15px;
	cursor: pointer;
 	
 }
 span#productName_cart{
 	font-weight: bold;
 	font-size: 12pt;
 }



button.del{
	width:120px;
	height: 30px;
	color: #f8585b;
	background: #fff;
	font-size: 10pt;
	border: solid 1px #f8585b;
	border-radius: 20px;
	transition:0.3s;
	position: absolute;
	left:59%;
	top: 20%;
	transform: translate(-50%,-50%);
}
button.del:focus {
	outline:0;
}
button.del:hover{
	background: #f8585b;
	cursor: pointer;
	color: #fff;
	box-shadow: 0 2px 4px #f8585b;
}

.card-1 {
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: all 0.3s cubic-bezier(.25,.8,.25,1);
  filter:contrast(50%);
  color: white;
  
}

.card-1:hover {
 /*  box-shadow: 0 10px 5px rgba(0,0,0,0.25), 0 8px 6px rgba(0,0,0,0.22);  */
 box-shadow:200px 0 0 0 rgba(0,0,0,0.5) inset; 
  filter:contrast(100%);
  cursor:pointer;
}

input#price:focus { outline: none; }

</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="<%= ctxPath %>/js/jquery.number.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("span#totalPrice_1").text(0);
    $("span#totalPrice_2").text(0);
    $("span#discount").text(0);
	// 스피너
	$("input.spinner").spinner({
		
		spin: function(event, ui) {
			if(ui.value > 100) {
				$(this).spinner("value", 100);
				return false;
			}
			else if(ui.value < 0) {
				$(this).spinner("value", 0);
				return false;
			}
		} 
	
	});// end of $(".spinner").spinner({});-----------------
	
	$("input.spinner").bind("spinstop", function(){
		
		goOqtyEdit(this);
	});
	
	//== 체크박스 전체선택/전체해제 == //
	$("input:checkbox[name=checkall]").click(function(){
		var bool = $(this).prop("checked");
		// 체크되어있으면 true, 해제되어있으면 false
		
		$("input:checkbox[name=product]").prop("checked", bool);
		if(bool){
			total(this);
		}
		else{
			$("span#totalPrice_1").text(0);
		    $("span#totalPrice_2").text(0);
		    $("span#discount").text(0);
		}
		
		// product 의 체크박스 상태를 checkall 의 체크상태와 동일하게 적용
	});

	// == 상품의 체크박스 클릭시 == //
	$("input:checkbox[name=product]").click(function(){
		var bool = $(this).prop("checked");
		
		if (bool) { // 현재 상품의 체크박스에 체크했을 때
			var bFlag = false;
			
			$("input:checkbox[name=product]").each(function(index, item){ // 다른 모든 상품의 체크박스 상태 확인
				var bChecked = $(item).prop("checked");
				if (!bChecked) {	// 체크표시가 안되어있는 상품일 경우 반복문 종료
					bFlag = true;
					return false;
				}
			});
			
			if(!bFlag) {	// 모든 체크박스가 체크되어있을 경우
				$("input:checkbox[name=checkall]").prop("checked", true);	
				
			}
		}
		else {	// 현재 상품의 체크박스에 체크 해제했을 때
			$("input:checkbox[name=checkall]").prop("checked", false);
			
		}
		
	});
	
	$("input:checkbox[name=product]").click(function(){
		total(this);
	});
	
});

// function declation

	// 체크박스에 체크 된 것만 total에 넣기
	function total(obj){
		var index = $("input:checkbox[name=product]").index(obj);
		var pnum = $("input:checkbox[name=product]").eq(index).val();
		//var total = $("input#total").eq(index).val(); // 갯수를 곱한 가격
		
		
	  ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. /// 
	   var allCnt = $("input:checkbox[name=product]").length;
	  
         
       var pnumArr = new Array();
       var odAmountArr = new Array();
       var cartNoArr = new Array();
       var totalPriceArr = new Array();
       var totalPointArr = new Array();
       var totalBeforeArr = new Array();

   
       
       for(var i=0; i<allCnt; i++){
     	  
     	  if($("input:checkbox[name=product]").eq(i).is(":checked")){
     		  pnumArr.push( $("input:checkbox[name=product]").eq(i).val() );
     		  odAmountArr.push($("input.odAmount").eq(i).val() );
     		  cartNoArr.push($("input.cartNo").eq(i).val() );
     		  totalPriceArr.push( $("input#totalPrice").eq(i).val() );
     		  totalPointArr.push( $("input#totalPoint").eq(i).val() );
     		  totalBeforeArr.push ( $("input#beforeSale").eq(i).val() * $("input.odAmount").eq(i).val() );

     	  }
     	  
       }// end of for-----------------------------
       
       var sumtotalBefore = 0;
       for(var i=0; i<totalBeforeArr.length; i++){
        	
    	   sumtotalBefore +=parseInt(totalBeforeArr[i]);
        	  
        }// end of for-----------------------
       
       var sumtotalPrice = 0;
       for(var i=0; i<totalPriceArr.length; i++){
     	
     	sumtotalPrice+=parseInt(totalPriceArr[i]);
     	  
       }// end of for-----------------------
       
       var str_pnum = pnumArr.join();
 	   var str_oqty = odAmountArr.join();
 	   var str_cartno= cartNoArr.join();
       var str_totalPrice= totalPriceArr.join();
       var sumtotalPoint = 0;
       
      for(var i=0; i<totalPointArr.length; i++){            	                	
       	sumtotalPoint+=parseInt(totalPointArr[i]);           	  
       }// end of for----------------------- 
       
       /// === java 단으로 보내야할 최종 데이터 확인용 === //
/*        console.log("제품번호들: "+str_pnum);
       console.log("주문량들: "+str_oqty);
       console.log("장바구니번호들: "+str_cartno);
       console.log("제품별금액들: "+str_totalPrice);
       console.log("제품별금액들의 총합계: "+sumtotalPrice);
       console.log("제품별포인트들의 총합계: "+sumtotalPoint); */
       
       var beforesale = $.number(sumtotalBefore);
       var aftersale = $.number(sumtotalPrice); // "12,345"
       var discount = $.number(sumtotalBefore-sumtotalPrice);
       
       $("span#totalPrice_1").text(beforesale);
       $("span#totalPrice_2").text(aftersale);
       $("span#discount").text(discount);
       
	}// end of 체크박스 토탈
	
	function goOrder(){
		
		var checkCnt = $("input:checkbox[name=product]:checked").length;
	       
	      if(checkCnt < 1) {
	          alert("주문하실 제품을 선택하세요!!");
	          return; //종료
	       }
	      else{
	    	
	    	  var allCnt = $("input:checkbox[name=product]").length;	  
	    	  
		   var pnumArr = new Array();
	       var odAmountArr = new Array();
	       var cartNoArr = new Array();
	       var totalPriceArr = new Array();
	       var totalPointArr = new Array();
	       var totalBeforeArr = new Array();
	       var optionstrArr = new Array();
	       
	       for(var i=0; i<allCnt; i++){
	     	  
	     	  if($("input:checkbox[name=product]").eq(i).is(":checked")){
	     		  pnumArr.push( $("input:checkbox[name=product]").eq(i).val() );
	     		  odAmountArr.push($("input.odAmount").eq(i).val() );
	     		  cartNoArr.push($("input.cartNo").eq(i).val() );
	     		  totalPriceArr.push( $("input#totalPrice").eq(i).val() );
	     		  totalPointArr.push( $("input#totalPoint").eq(i).val() );
	     		  totalBeforeArr.push ( $("input#beforeSale").eq(i).val() * $("input.odAmount").eq(i).val() );
	     		  optionstrArr.push( $("input#optionstr").eq(i).val() );
	     	  }
	     	  
	       }// end of for-----------------------------
	       
	       var sumtotalBefore = 0;
	       for(var i=0; i<totalBeforeArr.length; i++){
	        	
	    	   sumtotalBefore +=parseInt(totalBeforeArr[i])
	       }
	       
	       var sumtotalPrice = 0;
	       for(var i=0; i<totalPriceArr.length; i++){
	     	
	     	sumtotalPrice+=parseInt(totalPriceArr[i])
	     	  
	       }// end of for-----------------------
	       
	       var str_pnum = pnumArr.join();
	 	   var str_oqty = odAmountArr.join();
	 	   var str_cartno= cartNoArr.join();
	       var str_totalPrice= totalPriceArr.join();
	       var sumtotalPoint = 0;
	       var str_optionstr= optionstrArr.join();
	       
	       //console.log(str_optionstr);
	       
	      for(var i=0; i<totalPointArr.length; i++){            	                	
	       	sumtotalPoint+=parseInt(totalPointArr[i]);           	  
	       }// end of for----------------------- 
		
		/* console.log("제품번호들: "+str_pnum);
	       console.log("주문량들: "+str_oqty);
	       console.log("장바구니번호들: "+str_cartno);
	       console.log("제품별금액들: "+str_totalPrice);
	       console.log("제품별금액들의 총합계: "+sumtotalPrice);
	       console.log("제품별포인트들의 총합계: "+sumtotalPoint); */
			
	       // order.up 에서 페이지 이동을 해야하므로 form 으로 데이터 전송 
	       $("input[name=pnum_es]").val(str_pnum);
	       $("input[name=oqty_es]").val(str_oqty);
	       $("input[name=cartno_es]").val(str_cartno);
	       $("input[name=totalPrice_es]").val(str_totalPrice);
	       $("input[name=sumtotalPrice]").val(sumtotalPrice);
	       $("input[name=sumtotalPoint]").val(sumtotalPoint);
	       $("input[name=optionstr]").val(str_optionstr);
	       
	       submitOdrTransInfoFrm();
	       
		<%--  $.ajax({
	     	 url:"<%=request.getContextPath()%>/WEB-INF/order/order.up",
	     	 type:"post",
	     	 data:{"pnum_es":str_pnum,
	     		 "oqty_es":str_oqty,
	     		 "cartno_es":str_cartno,
	     		 "totalPrice_es":str_totalPrice,
	     		 "sumtotalPrice":sumtotalPrice,
	     		 "sumtotalPoint":sumtotalPoint},
	     	dataType:"json",
	     	success:function(json){
	     		alert("성공");
	     		location.href = "<%= request.getContextPath()%>/order/order.up";
	     	}, 
	     	error: function(request, status, error){
	             alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          } 
	     	 
	       }); --%> 
	      }
		
	}
	
	// === order.up 으로 데이터 전송 하기 === // 
	function submitOdrTransInfoFrm() {
		var frm = document.odrTransInfoFrm;
		
		frm.method = "post";
		frm.action = "<%=request.getContextPath()%>/order/order.up";
		frm.submit();
	}
	

	 // === 장바구니 수량 수정하기 === //
   function goOqtyEdit(obj) {
	
	   var index = $("input.spinner").index(obj);

       var cartNo = $("input.cartNo").eq(index).val(); 

       var odAmount = $(".odAmount").eq(index).val();
  
      
     if(odAmount<=0){
    	 alert("바꾸시려는 수량은 0개 이상이어야 합니다.");
         location.href="javascript:history.go(0);";
         return;
     }
  
   // alert("장바구니번호 : " + cartno + "\n주문량 : " + oqty);
      if(odAmount == "0") {
         goDel(cartNo);
      }
      else {
    	  $.ajax({
     		 url:"<%= request.getContextPath()%>/order/cartEdit.up",
     		 type:"post",
     		 data:{"cartNo":cartNo,
     			 "odAmount":odAmount},
     		 dataType:"json",
     		 success:function(json){
     			 if(json.n==1) {
     				 location.href="cartController.up";
     			 }     			
     		 },
     		 error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
     	  });
      }
      
    
   
   }// end of function goOqtyEdit(obj)-----------------
   
	// === 장바구니에서 특정 제품을 비우기 === //  
	function goDel(cartNo) {
		
		var $target = $(event.target);
		/* var pname = $target.parent().parent().find(".cart_pname").text(); */
		
			$.ajax({
				url:"<%= request.getContextPath()%>/order/cart_delete.up",
				type:"post",
				data:{"cartNo":cartNo},
				dataType:"json",
				success:function(json){
					location.href = "cartController.up";
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		
		
	}// end of function goDel(cartno)---------------------------
	
   //== 장바구니 물건 전체 삭제하기 ==//
	function goDelAll(cartNo) {
		
		var bool = confirm("장바구니를 전체 비우시겠습니까?");
		
		if(bool) {
			
			$.ajax({
				url:"<%= request.getContextPath()%>/order/cart_deleteAll.up",
				type:"post",
				data:{"cartNo":cartNo},
				dataType:"json",
				success:function(json){
					location.href = "cartController.up";
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}
		else {
	
			alert("장바구니비우기를 취소하셨습니다.");
		}
		
	}

</script>


<div class="container cart">

 <h2 style="width: 80%; margin-top: 100px; margin-bottom: 50px; color: gray;">- Cart</h2>
<form name="orderFrm">
<div id="cart_content">
	<button type="button" class="del" onclick="goDelAll('${cartvo.cartNo}')">장바구니 비우기</button>
	
	<table class="table odr_list table-hover">
	  
	  	<thead>
			<tr>
				<th><input type="checkbox" id = "check" name="checkall"/><label for="check"></label></th>
				<th>이미지</th>
				<th>상품정보</th>
				<th>판매가</th>
				<th>수량</th>
				<th>합계</th>
				<th>삭제</th>
				
			</tr>
		</thead>
		
		<tbody>
		
	 <c:if test="${empty requestScope.cartList}">
	   <tr>
	   	  <td colspan="6" align="center">
	   	    <span style="color: red; font-weight: bold;">
	   	    	<br><br><img src="../image/cart/cart_icon.png" style="width: 200px; height: 120px; filter:contrast(20%);"><br><br>
	   	    	장바구니에 담긴 상품이 없습니다.<br><br>
	   	    </span>
	   	  </td>	
	   </tr>
	   </c:if>
	   
	   <c:if test="${not empty requestScope.cartList}">
		
			<c:forEach var="cartvo" items="${requestScope.cartList}" varStatus="status"> 
				
				<tr class="odr_tr edit">
					<td ><input type="checkbox" name="product" class="chkboxpnum" id="pnum${status.index}" value="${cartvo.fk_pnum}" /></td>
					<td id="img" style="width:200px;"> <%-- 제품이미지 --%>
						<a href="/SemiProject/detailMenu/productDetailPage.up?pnum=${cartvo.fk_pnum}">
	                  
	                  	<c:if test="${cartvo.prod.fk_decode eq 10001}"><img src="<%= ctxPath %>/image/product/10001/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 10002}"><img src="<%= ctxPath %>/image/product/10002/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 10003}"><img src="<%= ctxPath %>/image/product/10003/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 10004}"><img src="<%= ctxPath %>/image/product/10004/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 20001}"><img src="<%= ctxPath %>/image/product/20001/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 20002}"><img src="<%= ctxPath %>/image/product/20002/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 20003}"><img src="<%= ctxPath %>/image/product/20003/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 20004}"><img src="<%= ctxPath %>/image/product/20004/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;" ></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 30001}"><img src="<%= ctxPath %>/image/product/30001/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;" ></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 30002}"><img src="<%= ctxPath %>/image/product/30002/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;" ></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 30003}"><img src="<%= ctxPath %>/image/product/30003/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 40001}"><img src="<%= ctxPath %>/image/product/40001/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 40002}"><img src="<%= ctxPath %>/image/product/40002/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;"></c:if>
						<c:if test="${cartvo.prod.fk_decode eq 40003}"><img src="<%= ctxPath %>/image/product/40003/${cartvo.prod.pimage1}"  style="width: 200px; height: 240px; cusor:pointer;" ></c:if>
 	
	                    </a> 
                    </td>
					<td style="width:220px; text-align: left;" >
						<span class="cart_pname">${cartvo.prod.pname}</span><br>
						<span id="cart_productOption"style="font-size: 11px;">${cartvo.optionstr}</span>
						<input type="hidden" id="optionstr"  value="${cartvo.optionstr}" />
					</td>
						
				   <td align="right" style="width:100px; text-align: left;"> <%-- 실제판매단가 및 포인트 --%> 
				      <c:if test="${cartvo.prod.price > cartvo.prod.saleprice }">
				         <input id="beforeSale" type="text" style="color: red; font-size: 13px; text-decoration: line-through; width:60px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" name="price"  value="${cartvo.prod.price+ cartvo.sumAddprice}" />
	                   </c:if>
	                   <c:if test="${cartvo.prod.price == cartvo.prod.saleprice }">
	                     <input id="beforeSale" type="hidden" style="font-size: 13px;width:60px; border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" name="price"  value="${cartvo.prod.price+ cartvo.sumAddprice}" />
	                   </c:if>
	                   
	                   <fmt:formatNumber value="${cartvo.prod.saleprice + cartvo.sumAddprice}" pattern="###,###" /> 원
	                   <input type="hidden" name="saleprice"  value="${cartvo.prod.saleprice + cartvo.sumAddprice}" /> <!-- SumAddprice -->
	                   <br/><span style="color: green; font-weight: bold; font-size: 11px;;"><fmt:formatNumber value="${cartvo.prod.point}" pattern="###,###" /> POINT</span>
               	   </td>
               	   
					<td id="td_plusminus">
					 <%-- 장바구니번호 --%>
	               	   <input class="cartNo" type="hidden" name="cartNo" value="${cartvo.cartNo}" />
					   <input class="spinner odAmount" name="odAmount" value="${cartvo.odAmount}" style="width: 20px; height: 20px;"><br>
					
				   </td>
					
               	   <td>
               	   	<fmt:formatNumber value="${(cartvo.prod.saleprice + cartvo.sumAddprice) * cartvo.odAmount}" pattern="###,###" /> 원 <!-- 총금액 -->
               	   	<input type="hidden" id="totalPrice"  value="${(cartvo.prod.saleprice + cartvo.sumAddprice) * cartvo.odAmount}">
               	   	<input type="hidden" id="totalPoint"  value="${cartvo.prod.point * cartvo.odAmount}">
               	   </td>
               	   
					<!-- 삭제 버튼을 누르면 delete.do로 장바구니 개별 id (삭제하길원하는 장바구니 id)를 보내서 삭제한다. -->
					<td>
						<span class="del" style="cursor: pointer;" onClick="goDel('${cartvo.cartNo}');"><img id="delete_cart" src="../image/cart/delete.png" style="width: 11px; height: 11px;"/></span>  
					</td> 
					

				</tr>
				
			</c:forEach>
		</c:if>	
		</tbody>
		
      </table>
      
</div>


<div id="cart_side">

	<table>

		<tr>
			<th class="side_cart" id="cart_th_3" colspan="2" >::: 주문요약 :::<br></th>
		</tr>

		<tr class="side_cart" id="total_price_in_cart">
            <td>총 제품 : </td>
            <td><span id="totalPrice_1" ></span> 원 <!-- style="text-decoration: line-through;" -->
         </tr>
         <tr class="side_cart" id="discount_price_in_cart" style="font-size:15px;">
         	<td > - 상품할인금액 : </td>
         	<td>- <span id="discount"></span>원</td>
         </tr>
         <!-- <tr class="side_cart" id="discount_price_in_cart" ></tr> -->
  

         <tr class="side_cart" id="side_cart_totalPrice">
            <td>합계 : </td>
            <td><span id="totalPrice_2"></span> 원</td>
         </tr>

	</table>
	<br><br>
	
	<div id="cart_promo">
		POINT를 합산하여 할인된 금액은 <br>
		주문페이지에서 확인 가능합니다.
	</div>
	<br>

	<div class="card-1" id="order_button_cart" onclick="goOrder()">
		주문하기 
	</div>
</div>
 </form> 
 
 <%-- order.up 으로 데이터 전송하기  --%>
 <form name="odrTransInfoFrm">
 	<input type="hidden" name="pnum_es" />
 	<input type="hidden" name="oqty_es" />
 	<input type="hidden" name="cartno_es" />
 	<input type="hidden" name="totalPrice_es" />
 	<input type="hidden" name="sumtotalPrice" />
 	<input type="hidden" name="sumtotalPoint" />
 	<input type="hidden" name="optionstr" />
 </form>
</div>



<jsp:include page="../footer.jsp" />  

