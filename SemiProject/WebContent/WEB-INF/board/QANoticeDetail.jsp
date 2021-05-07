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
   div.NoticeDetailDiv{
   		margin-top: 200px;
   		margin-bottom: 200px;
   }
    table.NoticeDetail{
    	width: 100%;
    	text-align: center;
    }s
    div#tableContainer{
    	width: 100%;
    	border: solid 1px hidden;
    	text-align: center;
    }
   td.NoticeContent{
   
   		height: 300px;
   }
   button#comment{
   	width: 150px; 
   	height: 100px; 
	color: white; 
	background-color: #bfbfbf;
   	font-size: 22px; 
   	font-weight: bold; 
   	border: none;
   }
    button#comment:hover{
   	font-size: 22px; 
   	font-weight: bold; 
   	color: #bfbfbf; 
	background-color: white;
   	border: solid 2px #bfbfbf;
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
   table#QACommentTable th{
   	background-color: #bfbfbf;
   	color : black;
   	font-size: 15px;
   	font-weight: bold;
   	text-align: center;
   }
   table#QACommentTable td{
   	background-color: #e6e6e6;
   	color : black;
   	font-size: 13px;
   	text-align: center;
   }
   table#QACommentTable tr{
   	height: 50px;
   }
</style>

<script type="text/javascript">

	var goBackURL = "";
	
	$(document).ready(function(){
		
		CommentView();
		
		goBackURL = "${requestScope.goBackURL}";
		// 자바스크립트에서는  replaceall 이 없고 replace 밖에 없다.
	    // !!! 자바스크립트에서 replace를 replaceall 처럼 사용하기 !!! //
	      
	    // "korea kena" ==> "korea kena".replace("k","y") ==> "yorea kena"
	    // "korea kena".replace(/k/gi, "y") ==> "yorea yena"
	      
	    // 변수 goBackURL 에 공백 " " 을 모두 "&" 로 변경하도록 한다.
	    
	    goBackURL = goBackURL.replace(/ /gi, "&");	// 앞에서 &를 공백으로 바꿨으므로 다시 &로 바꿔준다. / / 안에는 쌍따옴표 같은거 안넣는다.
		
	}); // end of $(document).ready(function(){})----------------------------------------------

	
	// Function Declaration
	function goQAList(){
		location.href = "/SemiProject/"+goBackURL;
	}
	function goQAComment(){
		var frm = document.QACommentFrm;
		frm.action = "QAComment.up?"; 
		frm.method = "GET";	// 숨길필요 없이 빨리빨리 이동해야해서 get 사용
		frm.submit();
	}
	function CommentView(){
		$.ajax({	// 화면의 변화는 없고 DB만 바꿔줄거라서 ajax를 사용
			   url:"<%=request.getContextPath()%>/board/commentView.up",
			   type:"post",
			   data:{"qaNo":"${requestScope.qvo.qaNo}"},
			   dataType:"json",
			   success:function(json){
				   var html = "";
				   if(json.length != 0) {
					   html += '<table id="QACommentTable"><thead><tr>'+
			   		   		   '<th style="width: 50px;">NO.</th>'+
					   		   '<th style="width: 500px;">댓글</th>'+
					   		   '<th style="width: 100px;">관리자</th>'+
					   		   '<th style="width: 300px;">작성일자</th>'+
					   		   '</tr></thead>'+
									'<tbody>';
					   $.each(json, function(index,item){
						   var addno = item.addno;
						   var addSubject = item.addSubject;
						   var fk_qaNo = item.fk_qaNo;
						   var writer = item.writer;
						   var addRegisterday = item.addRegisterday;
							html += '<tr>'+
								   '<td>'+addno+'</td>'+
								   '<td>'+addSubject+'</td>'+
								   '<td>'+writer+'</td>'+
								   '<td>'+addRegisterday+'</td>';
						});
					   
						html +=	 '</tbody>'+
									'</table>';
						$("div#commentList").html(html);
				   } else{
		                 // 처음부터 데이터가 존재하지 않는 경우
		                // !!! 주의 !!!
		                // if(json == null) 이 아님!!!
		                // if(json.length == 0) 으로 해야함!!
		                html += "등록된 댓글이 없습니다.....";
		                
						$("div#commentList").html(html);;
		              } 
				   
			   },
			   error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		         }
		   });
	}
</script>
<div class="container NoticeDetailDiv">
	<c:if test="${empty requestScope.qvo}">
		존재하지 않는 글입니다.
	</c:if>
	<c:if test="${not empty requestScope.qvo}">
	<div id="tableContainer">
		<table class="NoticeDetail">
			<thead>
				<tr>
					<th style="text-align: center; color:#737373; font-size: 25px; font-weight: bold;">${requestScope.qvo.qaTitle}</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="NoticeDate" style="text-align: left; color:#737373; font-size: 17px;">Date : ${requestScope.qvo.qaRegisterday}
						<br>
						Name : ${requestScope.qvo.fk_userid}
					</td>
				</tr>
			</tbody>   
			
			<tbody>
				<tr>
					<td class="NoticeContent" style="text-align: left; font-size: 22px;"><br><br>${requestScope.qvo.qaContent}<br><br><br><br></td>
				</tr>
			</tbody> 
		</table>
		</div>
		<br><br>
		<div id="commentList">
			
		</div>
		<c:if test="${sessionScope.loginadmin.adId != null}">
			<br><br><br>
			<form name="QACommentFrm">
				<a><input name="QAComment" style="width: 700px; height: 200px; border: solid 2px #bfbfbf" type="text"/>&nbsp;&nbsp;<button id="comment" onclick="goQAComment()">댓글달기</button></a>
				<input name="qaNo" type="hidden" value="${requestScope.qvo.qaNo}"/>
			</form>
		</c:if>    
		    
		<div>
			<button id="noticeList" style="margin-top: 50px;" type="button" onclick="goQAList()">Q&A목록</button>
		   &nbsp;&nbsp;
		</div>
	</c:if>    
	

</div>


<jsp:include page="../footer.jsp" />