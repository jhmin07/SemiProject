<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../header4.jsp"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.11.4.custom/jquery-ui.min.js"></script>

<title>상품등록</title>
<style type="text/css">

	div.container {		
		margin: 80px auto;
	}
	
	table#tblMemberRegister {		
		width: 98%;          
		margin: 10px;	
	}  
	
	th#th {				
		text-align: center;		
		font-size: 30pt; 
		font-family: 'Papyrus', Fantasy; 
		font-weight: bold;
	}	
	
	td {
		line-height: 30px;
		padding-top: 8px;
		padding-bottom: 8px;
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
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("span.error").hide();
		
		/* $("select[name=fk_decode]").change(function(){
			console.log($(this).val());
		}); */
		
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
			
			$(".infoData").each(function(index, item){
				var val = $(item).val().trim();
				if (val == "") {
					$(item).next().show();
					flag = true;
					return false;
				}
			});
			
			if (!flag) {
				var frm = document.prodInputFrm;
				frm.submit();
			}
		});
	});

</script>

<div class="container" align="center">
	<form name="prodInputFrm"
			action="<%=request.getContextPath()%>/admin/productRegister.up"
			method="POST"
			enctype="multipart/form-data" >

		<table id="tblProductRegister">
			<thead>
				<tr>
					<th colspan="2" id="th" style="padding: 30px;">상품등록</th>
				</tr>
			</thead>

			<tbody>
				<tr>
					<td width="25%" class="prodInputName" style="padding-top: 10px;">카테고리</td>
					<td width="75%" align="left" style="padding-top: 10px;">
						<select name="fk_decode" class="infoData">
							<option value="0">::: 선택하세요 :::</option>
							
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
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="pname" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제조사</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="text" style="width: 300px;" name="pcompany" class="box infoData" /> 
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품이미지</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="file" name="pimage1" class="infoData" />
						<span class="error">필수입력</span>
						<input type="file" name="pimage2" class="infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="25%" class="prodInputName">제품수량</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input id="spinnerPqty" name="pqty" value="1" style="width: 30px; height: 20px;"> 개
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
							<option>::: 선택하세요 :::</option>
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
						<input type="text" style="width: 100px;" name="point"
						class="box infoData" /> POINT <span class="error">필수입력</span>
					</td>
				</tr>
				
				<%-- ==== 첨부파일 타입 추가하기 ==== --%>
				<tr>
					<td width="25%" class="prodInputName" style="padding-bottom: 10px;">추가이미지파일(선택)</td>
					<td>
						<label for="spinnerImgQty">파일갯수 : </label> 
						<input id="spinnerImgQty" value="0" style="width: 30px; height: 20px;">
						<div id="divfileattach"></div>
						<input type="hidden" name="attachCount" id="attachCount" />
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