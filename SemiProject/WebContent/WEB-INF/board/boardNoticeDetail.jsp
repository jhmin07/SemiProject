<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<jsp:include page="../header4.jsp" />

<style type="text/css">
	
   table.NoticeDetail tr{
      border: solid 2px #999999;
      border-left: none;
      border-right: none;
   }
   table.NoticeDetail th{
   		height: 40px;
   }
   table.NoticeDetail td{
      padding-left: 10px;
   }
   td.NoticeDate{
   
   		height: 100px;
   }
    table.NoticeDetail{
    	width: 100%;
    	text-align: center;
    }
   div.NoticeDetailDiv{
   		margin-top: 200px;
   		margin-bottom: 100px;
   }
    div#tableContainer{
    	width: 100%;
    	border: solid 1px hidden;
    	text-align: center;
    }
   td.NoticeContent{
   
   		height: 300px;
   }
    button#noticeList{
   	width: 150px; 
   	height: 40px; 
	color: white; 
	background-color: #bfbfbf;
   	font-size: 22px; 
   	font-weight: bold; 
   	border: none;
   }
    button#noticeList:hover{
   	font-size: 22px; 
   	font-weight: bold; 
   	color: #bfbfbf; 
	background-color: white;
   	border: solid 2px #bfbfbf;
   }
   button.NoticemodiDel{
   		display: inline-block;
   		text-align: center;
   		font-size: 15pt;
   		border: solid 1px #bfbfbf;
   }
</style>

<script type="text/javascript">

	var goBackURL = "";
	
	$(document).ready(function(){
		
		     
	      
	      
		
		

		goBackURL = "${requestScope.goBackURL}";
		// 자바스크립트에서는  replaceall 이 없고 replace 밖에 없다.
	    // !!! 자바스크립트에서 replace를 replaceall 처럼 사용하기 !!! //
	      
	    // "korea kena" ==> "korea kena".replace("k","y") ==> "yorea kena"
	    // "korea kena".replace(/k/gi, "y") ==> "yorea yena"
	      
	    // 변수 goBackURL 에 공백 " " 을 모두 "&" 로 변경하도록 한다.
	    
	    goBackURL = goBackURL.replace(/ /gi, "&");	// 앞에서 &를 공백으로 바꿨으므로 다시 &로 바꿔준다. / / 안에는 쌍따옴표 같은거 안넣는다.
		
	}); // end of $(document).ready(function(){})----------------------------------------------

	
	// Function Declaration
	function goNoticeList(){
		location.href = "<%=request.getContextPath()%>/board/board.up";
	}
	function goNoticeDel(){
		location.href = "<%=request.getContextPath()%>/board/NoticeDel.up?ctNo="+${requestScope.nvo.ctNo};
			   
	}
	function goNoticeModi(){
		location.href = "<%=request.getContextPath()%>/board/NoticeModi.up?ctNo="+${requestScope.nvo.ctNo};
			   
	}
	
</script>
<div class="container NoticeDetailDiv" style="">
	<c:if test="${empty requestScope.nvo}">
		존재하지 않는 글입니다.
	</c:if>
	<c:if test="${not empty requestScope.nvo}">
		<div id="tableContainer">
		<table class="NoticeDetail" >
			<thead>
				<tr>
					<th style="text-align: center; color:#737373; font-size: 18px; font-weight: bold;">${requestScope.nvo.ctTitle}</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="NoticeDate" style="text-align: left; color:#737373; font-size: 15px;">Date : ${requestScope.nvo.ctRegisterday}
						<br>
						Name : ${requestScope.nvo.fk_adId}
					</td>
				</tr>
			</tbody>   
			
			<tbody>
				<tr>
					<td class="NoticeContent" style="text-align: left; font-size: 15px;"><br><br>${requestScope.nvo.ctContent}<br><br><br><br></td>
				</tr>
			</tbody> 
		</table>
		</div>
		
		
	</c:if>    
	 <c:if test="${requestScope.nvo.fk_adId eq sessionScope.loginadmin.adId}">   
	   <div style="text-align: center;">	
	   	<br>
	 	<button class="NoticemodiDel" onClick="goNoticeModi()">수정하기</button>
	 	<a>&nbsp;&nbsp;&nbsp;</a>
	 	<button class="NoticemodiDel" onClick="goNoticeDel()">삭제하기</button>
	   </div>
	 </c:if> 
	<div>
		<button id="noticeList" style="margin-top: 50px;" type="button" onclick="goNoticeList()">공지사항목록</button>
	   &nbsp;&nbsp;
	</div>

</div>


<jsp:include page="../footer.jsp" />