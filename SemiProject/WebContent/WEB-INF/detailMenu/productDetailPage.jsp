<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<%
    String ctxPath = request.getContextPath();
%>           

<jsp:include page="/WEB-INF/header4.jsp" />

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

table tbody tr {
  height: 15px;
}

td.pdt_main {
	font-weight: bold;
	width: 100px;
}

a {
	/* background-color: black; */
	color: white;
	font-weight: bold;
}

ul {
	list-style: none;
}

li.lifont {
	margin : 30px 0 30px 0;
	font-size: 15pt;
	font-weight: bold;
}

li {
	margin: 7px 0 7px 0;
}

</style>

<script type="text/javascript">
	$( function() {
	
		 goloop(); 
	
	var spinner = $( "#spinner" ).spinner();
	
	$("input#spinner").spinner({
		spin: function(event, ui) {
            if(ui.value > 10) {
               $(this).spinner("value", 10);
               return false;
            }
            else if(ui.value < 1) {
               $(this).spinner("value", 1);
               return false;
            }
         }
	});	     
	
	}); // end of $(function(){});
	
	// Function Declaration	
	
	function goCart() {
		
		   // pnum 은 장바구니에 담을 제품번호 이다.
		   // === 주문량에 대한 유효성 검사하기 === //
		   var frm = document.pdtFrm;
		   frm.method = "post";
		   frm.action = "<%= request.getContextPath()%>/order/goCart.up";
		   frm.submit();
   
	   } // end of function goCart(pnum) {}------------------------------------	
	   
	function goOrder(){
		var oqty = $("input[name=odAmount]").val();
		var totalPrice = Number(oqty) * ${requestScope.pvo.saleprice};
		var totalPoint = Number(oqty) * ${requestScope.pvo.point};
		
		//console.log(totalPrice);
		//console.log(typeof(totalPrice));
		
		$("input[name=pnum_es]").val("${requestScope.pvo.pnum}");
		$("input[name=oqty_es]").val(oqty);
		$("input[name=totalPrice_es]").val(totalPrice);
		$("input[name=sumtotalPrice]").val(totalPrice);
		$("input[name=sumtotalPoint]").val(totalPoint);
		
		var frm = document.goOrderFrm;
		frm.method = "post";
		frm.action = "<%= request.getContextPath()%>/order/order.up";
		frm.submit();
		   
    } // end of function goOrder(){}
    
    function goloop() { 
        
        var oname="";
        $("td.listoname").each(function(index,item){
           var $this = $(this);
           oname = $(this).text();
              $.ajax({
                 url:"<%= request.getContextPath()%>/detailMenu/productDetailOption.up",
                 type:"get",
                 data:{"pnum":"${pvo.pnum}"
                     ,"oname":oname}, 
                 dataType:"json",
                 success:function(json){
                    
                    var html = "";      
                       
                        $.each(json, function(index, item){
                           if(index == 1){
                           html += " <option value='"+item.optionNo+"' selected>"+item.ocontents+"</option>";
                           }
                           else{
                           html += " <option value='"+item.optionNo+"'>"+item.ocontents+"</option>";
                           }
                        });
                
                    $this.next().children().html(html);
                  
                 },
                 error: function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                 }
              }); 
              });
        
      
      } // end of function goloop() {}  
      
      function option(item) {
          
	          var option = "";
	          $("select.listocontents").each(function(index,item){
		       	  if(option != ""){
		           option += ",";
		       	  }
		           option += $(this).children("option:selected").val();       	 	 
          		});
          	console.log(option);
       		$("input#optionNo").val(option);
  }
      
	   
</script>

<div id="detailcontainer" style="width:100%; margin-top: 100px; background-color: #f2f2f2; display: table; height: 500px;" align="center">
	
	<div style="display:table-cell; width: 50%; vertical-align: middle;" >
	<c:if test="${requestScope.pvo.fk_decode eq 10001}"><img src="<%= ctxPath %>/image/product/10001/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10002}"><img src="<%= ctxPath %>/image/product/10002/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10003}"><img src="<%= ctxPath %>/image/product/10003/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10004}"><img src="<%= ctxPath %>/image/product/10004/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20001}"><img src="<%= ctxPath %>/image/product/20001/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20002}"><img src="<%= ctxPath %>/image/product/20002/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20003}"><img src="<%= ctxPath %>/image/product/20003/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20004}"><img src="<%= ctxPath %>/image/product/20004/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30001}"><img src="<%= ctxPath %>/image/product/30001/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30002}"><img src="<%= ctxPath %>/image/product/30002/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30003}"><img src="<%= ctxPath %>/image/product/30003/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40001}"><img src="<%= ctxPath %>/image/product/40001/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40002}"><img src="<%= ctxPath %>/image/product/40002/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40003}"><img src="<%= ctxPath %>/image/product/40003/${requestScope.pvo.pimage1}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	</div>

	<div style="display:table-cell; width: 50%; text-align: left; padding-left: 160px; vertical-align: middle; ">	

		<h3 style="font-weight: bold;">${requestScope.pvo.pname}</h3>
		<br>
		<form name="goOrderFrm">
			<input hidden name="pnum_es" />
			<input hidden name="oqty_es" />
			<input hidden name="totalPrice_es" />
			<input hidden name="sumtotalPrice" />
			<input hidden name="sumtotalPoint" />
		</form>
		
		<form name="pdtFrm">
		<table style="vertical-align: middle;">
				<tbody>
					<tr>
						<td class="pdt_main">NAME</td>
						<td class="pdt_sub" >
							<span > ${requestScope.pvo.pname}</span>
						</td>
					<tr>
					<tr>
						<td class="pdt_main">PRICE</td>
						<td class="pdt_sub"><fmt:formatNumber value="${requestScope.pvo.saleprice}" pattern="###,###" />&nbsp;원</td>
					<tr>
					<tr>
						<td class="pdt_main">POINT</td>
						<td class="pdt_sub" >${requestScope.pvo.point}&nbsp;<span >&nbsp;POINT</span></td>
					<tr>					
					<tr>
						<td class="pdt_main">QUANTITY</td>
						<td class="pdt_sub" >
							<label for="spinner"></label>
	 						<input id="spinner" name="odAmount" size="3pt" value="1" style="height: 20px;">						
						</td>
					<tr>

					<c:forEach var="option" items="${onameList}" varStatus="status" >            
                  <tr>                              
                     <td class="listoname pdt_main">${option.oname}</td>
                     <td>
                          <select class ="listocontents" name="optocontents" id="${status.index}" onchange="option(this);" style="width: 150px;">                                                           
                           </select>
                       </td>
                  </tr>   
               </c:forEach>   								
					
				</tbody>
			</table>
			<button type="button"  onclick="goCart();" style="background-color: black; color: white;  width: 350px; margin-top: 10px; height: 30px;">장바구니에 담기</button>
			<div id="datasubmit">
			<input type="hidden" name="pnum" value="${requestScope.pvo.pnum}" />
			<input type="hidden" id="optionNo"  name="optionNo" value="" />
			</div>
			<br>
			<button type="button"  onclick="goOrder();" style="background-color: black; color: white;  width: 350px; margin-top: 10px; height: 30px;">주문하러 가기</button>
			</form>
			</div>


</div>

<div align="center" style="margin-top: 100px;">
<div id="description_content">
	<c:if test="${requestScope.pvo.fk_decode eq 10001}"><img src="<%= ctxPath %>/image/product/10001/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10002}"><img src="<%= ctxPath %>/image/product/10002/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10003}"><img src="<%= ctxPath %>/image/product/10003/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 10004}"><img src="<%= ctxPath %>/image/product/10004/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20001}"><img src="<%= ctxPath %>/image/product/20001/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20002}"><img src="<%= ctxPath %>/image/product/20002/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20003}"><img src="<%= ctxPath %>/image/product/20003/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 20004}"><img src="<%= ctxPath %>/image/product/20004/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30001}"><img src="<%= ctxPath %>/image/product/30001/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30002}"><img src="<%= ctxPath %>/image/product/30002/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 30003}"><img src="<%= ctxPath %>/image/product/30003/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40001}"><img src="<%= ctxPath %>/image/product/40001/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40002}"><img src="<%= ctxPath %>/image/product/40002/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
	<c:if test="${requestScope.pvo.fk_decode eq 40003}"><img src="<%= ctxPath %>/image/product/40003/${requestScope.pvo.pimage2}" style="width:450px; height:400px; cursor: pointer; "></c:if>
<br>
<h2 style="text-align: center; margin :50px 0 20px 0;" align="center">DESCRIPTION</h2>
<span style="line-height: 2.0em"> ${requestScope.pvo.pcontent} </span>
</div>

<div id="deliveryreturn_content">
	<h2 style="text-align: center; margin :50px 0 50px 0;" align="center">DELIVERY / RETURN</h2>
	<ul style="text-align: center;">
		<li class="lifont">주의사항</li>
		<li>침대 프레임과 매트리스, 가구류를 제외한 나머지 제품은 연출된 이미지입니다</li>
		<li>제품 색상은 모니터 사양에 따라 실제 색상과 다를 수 있습니다</li>
		<li>함께 구매하신 케노샤 홈(침구) 및 사은품은 별도 택배 발송됩니다</li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">배송방법</li>
	<li>매트리스, 프레임, 룸세트 : 직접 설치배송</li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">배송안내</li>
	<li>전국 배송(일부 도서/산간지역은 배송이 불가능 합니다)<br></li>
	<li>결제완료 후 익일부터 1~3일내 해피콜 상담을 통하여 배송일 협의가 가능합니다</li>
	<li>(단, 배송시간 지정 불가, 지방의 경우 해피콜이 다소 지연될 수 있습니다)</li>
	<li>배송시간 9:30 ~ 18:00<br></li>	
	<li>사다리차 및 그 외 추가적으로 발생하는 비용은 해피콜 시 상담 바랍니다</li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">기존 침대 철거 안내</li>
	<li>기존 침대 '내림 서비스' 또는 다른 방 '이동 서비스' 중 1회 무상 제공</li>
	<li>(최초 1회만 무상으로 제공됩니다. 유·무상 관계없이 서비스 횟수 추가 불가)<br></li>
	<li>폐기물 스티커는 고객이 별도 준비해야 하며, 내림 서비스는 1층 폐기 장소까지만 가능합니다<br></li>
	<li>돌침대, 흙침대 등은 내림 서비스와 이동 서비스가 불가합니다<br></li>
	<li>침대, 매트리스 외에 제품 철거신청은 불가합니다</li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">배송일정
	<li>해피콜 이후부터 배송 전까지 배송일자 변경 및 취소 가능합니다<br></li>
	<li>제품 모델 변경은 불가능하며, 기존 주문 취소 후 재주문 가능합니다<br></li>
	<li>설치 전 취소를 희망하는 경우, RHOME Customer Care Center(1588-1588)에 연락 후 쇼핑몰에 함께 접수해야 원활한 처리가 가능합니다</li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">교환 및 반품 안내</li>
	<li>비닐 포장을 제거하거나, 조립 설치한 후에는 교환 및 반품이 불가합니다<br></li>
	<li>제품을 설치할 공간을 미리 확보해두지 않아 설치가 불가능할 경우 고객이 반품비용을 부담해야 합니다<br></li>
	<li>단순 변심으로 인해 교환 및 반품할 경우 고객이 반품비용을 부담해야 합니다<br></li>
	</ul>
	
	<ul style="text-align: center;">
	<li class="lifont">기타 문의</li>
	<li>RHOME 홈페이지 고객센터 메뉴<br></li>
	<li>RHOME Customer Care Center : 1588-1588</li>
	</ul>
	
	</div>
</div>

<jsp:include page="review.jsp" />
<jsp:include page="/WEB-INF/footer.jsp" />