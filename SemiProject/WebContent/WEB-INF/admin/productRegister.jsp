<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header4.jsp" />     
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>

<title>상품등록</title>
<style type="text/css">
div.container {
	margin: 80px auto;
	width: 1000px !important;
}

table#tblMemberRegister {
	
	
}

h2#prodRegh2 {
	clear: right;
	padding-top: 30px;
	padding-bottom: 10px;
	color: #000;
	font-size: 30px;
	text-align: center;
	font-family: 'Papyrus', Fantasy; 
}

p#prodRegP{
	padding-bottom: 20px;
    color: #a7a7a7;
    font-size: 16px;
    text-align: center;	
}
/* 
th#prodRegth {
	text-align: center;
	font-size: 30pt;
	font-family: Georgia;
	font-weight: bold;
}
 */
/* td.prodInputName {
	background-color: #333;
	color: white;
} */
 
td {
	line-height: 30px;
	padding-top: 8px;
	padding-bottom: 8px;
	padding-left: 10px;
}

span.star {
	color: red;
	font-weight: bold;
	font-size: 13pt;
}

span.info {
	color: gray;
	font-size: 9.5pt;
}

span.error {
	color: red;
	margin-left: 10px;
	font-size: 9.5pt;
	font-weight: bold;
}

select {
	padding: 7px 0;
}

input.optInput {
	width: 110px;
	line-height: 20px;
	padding: 4px; 
	margin-left: 5px;
}

button.optDelBtn {
	margin-left: 5px;
}

div.optDiv {
	padding: 10px;
}
</style>

<script type="text/javascript">
	
	var optCnt = 0;
	
	$(document).ready(function(event){
		$("span.error").hide();
		
		$("input#optCnt").val(optCnt);
		
		$("input#spinnerPqty").spinner({
			spin:function(event,ui){
				if (ui.value > 100) {
					$(this).spinner("value", 100);
					return false;
				}
				else if (ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
		});
		
		
		$("input#spinnerImgQty").spinner({
			spin:function(event,ui){
				if (ui.value > 100) {
					$(this).spinner("value", 100);
					return false;
				}
				else if (ui.value < 1) {
					$(this).spinner("value", 1);
					return false;
				}
			}
		});
		
		$("input#spinnerImgQty").bind("spinstop", function(){
			var html = "";
			var cnt = $(this).val();
			// console.log("확인용 cnt : "+ cnt);
			// console.log("확인용 typeof cnt : "+ typeof(cnt));
			
			for (var i=0; i<parseInt(cnt); i++) {
				html += "<br>";
				html += "<input type='file' name='attach"+i+"' class='btn btn-default' />";
			}
			$("div#divfileattach").html(html);
			
			$("input#attachCount").val(cnt);
		});
		
		$("input#btnRegister").click(function(){
			var flag = false;
			
			<%-- 상품 정보 입력 검사 --%>
			$(".infoData").each(function(index, item){
				var val = $(item).val().trim();
				if (val == "") {
					$(item).focus();
					$(item).next().show();
					flag = true;
					
					$(item).blur(function(){
						val = $(item).val().trim();
						if (val != "") {
							$(item).next().hide();
						}
					});
					return false;
				}
			});
				
			
			<%-- 추가 옵션 부분 검사 --%>
			$("div.optDiv").each(function(index, item){
				var $onum = $(item).find("select");
				if ($onum.val().trim() == "") {
					alert("옵션분류를 선택하세요.");
					$onum.focus();
					return false;
				}
				
				var $ocontents = $onum.next().next();
				if ($ocontents.val().trim() == "") {
					alert("옵션내용을 입력하세요.");
					$ocontents.focus();
					return false;
				}
				
				var $addprice = $onum.next().next().next();
				var regExp = /^[0-9]+$/;
				var bool = regExp.test($addprice.val());
				
				if (!bool) {
					alert("추가금액을 올바르게 입력하세요.");
					$addprice.focus();
					return false;
				}
			});
			
			
			if (!flag) {
				var frm = document.prodInputFrm;
				frm.submit();
			}
		});
		
		
	});

	
	// == Function Declaration == // 
	
	// == 옵션 추가 버튼 클릭 시 실행되는 함수 == // 
	function optAdd() {
		var html = "";
		html += '<div class="optDiv">'+
					'<select name="onum'+ optCnt +'" class="optionData" onchange="setoname(this);">' +
						'<option value="">:::선택하세요:::</option>'+
						'<option value="0">색상</option>' +
						'<option value="1">크기</option>'+
						'<option value="2">조립유무</option>'+
					'</select>'+
					'<input type="hidden" name="oname'+optCnt+'" />'+
					'<input type="text" name="ocontents'+ optCnt +'" class="optInput" placeholder="옵션내용"/>'+
					'<input type="text" name="addprice'+optCnt+'" class="optInput" placeholder="추가금액"/>';
		html += '<button type="button" class="optDelBtn btn btn-danger" onclick="optDel(this);">삭제</button></div>';
		$("div#divoptattach").append(html);
		
		optCnt++;
		// console.log(optCnt);
		$("input#optCnt").val(optCnt);
	}
	
	// == 옵션 삭제 버튼 클릭 시 실행되는 함수 == //
	function optDel(item) {
		$(item).parent().remove();
	}
	 
	// == 선택된 옵션번호에 해당하는 옵션이름 input 태그에 값 설정하기 == //
	function setoname(item) {
		var onum = $(item).val();
		var oname = "";
		$("select.optionData > option").each(function(index, option){
			if (option.value == onum) {
				oname = option.text;
				return false;
			}
		});
		
		//console.log("onum => "+onum);
		//console.log("oname => "+oname);
		
		$(item).next().val(oname);
	} 
	
	
</script>

<div class="container" align="center">
	<form name="prodInputFrm"
			action="<%=request.getContextPath()%>/admin/productRegister.up"
			method="POST"
			enctype="multipart/form-data" >
		
		<h2 id="prodRegh2">PRODUCT REGISTER</h2>
		<p id="prodRegP">[관리자모드] 제품등록 페이지입니다. 아래 형식에 맞게 제품정보를 등록해주세요.</p>
		<table id="tblProductRegister" >
		<%--
			<thead>
				<tr>
					<th colspan="2" id="prodRegth" >PRODUCT REGISTER</th>
				</tr>
			</thead>
		--%>
			<tbody>
				<tr>
					<td width="25%" class="prodInputName" style="padding-top: 10px;">카테고리</td>
					<td width="75%" align="left" style="padding-top: 10px;">
						<select name="fk_decode" class="infoData">
							<option value="">::: 선택하세요 :::</option>
							
							<c:forEach var="map" items="${requestScope.categoryList}">
								<optgroup label="${map.cname}">									
									<c:forEach var="dcvo" items="${requestScope.detailCategoryList}">
										<c:if test="${dcvo.fk_cnum eq map.cnum}">
											<option value="${dcvo.decode}">${dcvo.dename}</option>
										</c:if>
									</c:forEach>
								</optgroup>
							</c:forEach>
							
						</select>
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품명</td>
					<td width="75%" align="left" >
						<input type="text" style="width: 300px;" name="pname" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제조사</td>
					<td width="75%" align="left" >
						<input type="text" style="width: 300px;" name="pcompany" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품이미지</td>
					<td width="75%" align="left" >
						<input type="file" name="pimage1" class="infoData" />
						<span class="error">필수입력</span>
						<input type="file" name="pimage2" class="infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품수량</td>
					<td width="75%" align="left" >
						<input id="spinnerPqty" name="pqty" value="1" style="width: 30px; height: 20px;" class="spinner"> 개
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품정가</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="price" class="box infoData" /> 원
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품판매가</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 100px;" name="saleprice" class="box infoData" /> 원
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품스펙</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<select name="fk_snum" class="infoData">
							<option value="">::: 선택하세요 :::</option>
							<c:forEach var="spvo" items="${specList}">
							<option value="${spvo.snum}">${spvo.sname}</option>
							</c:forEach>
						</select>
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품설명</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<textarea name="pcontent" rows="5" cols="60"></textarea>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName" style="padding-bottom: 10px;">제품포인트</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden; padding-bottom: 10px;">
						<input type="text" style="width: 100px;" name="point" class="box infoData" /> POINT <span class="error">필수입력</span>
					</td>
				</tr>
				
				<%-- ==== 첨부파일 타입 추가하기 ==== --%>
				<tr>
					<td width="25%" class="prodInputName" style="padding-bottom: 10px; vertical-align: top;">추가이미지파일(선택)</td>
					<td>
						<label for="spinnerImgQty">파일갯수 : </label> 
						<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
						<div id="divfileattach"></div>
						<input type="hidden" name="attachCount" id="attachCount" />
					</td>
				</tr>
				
				<tr style="background-color: #f2f2f2;">
					<td width="25%" class="prodInputName" style="padding-bottom: 10px; vertical-align: top;">추가옵션(선택)<br>
						<button type="button" onclick="optAdd();" class="btn btn-primary">추가</button>
					</td>
					<td>
						<div id="divoptattach"></div>
						<input type="hidden" name="optCnt" id="optCnt" />
					</td>
				</tr>
				

				<tr style="height: 70px;">
					<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
						<input type="button" value="제품등록" id="btnRegister" style="width: 80px;" /> &nbsp; 
						<input type="reset" value="취소" style="width: 80px;" />
					</td>
				</tr>
			</tbody>
		</table>
		
	</form>
</div>

<jsp:include page="../footer.jsp"/>