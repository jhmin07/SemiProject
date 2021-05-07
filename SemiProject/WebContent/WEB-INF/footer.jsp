<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>
<style type="text/css">
footer{
 	background-color: #3e505e;
 	/* margin-top: 10px; */
 	
}
div.footer{
	margin: 0px 100px 0 100px ;
}
div.footerClick{
	display: inline;
	
}
div#footer_1_1 > img{
	/* border: solid 1px red;   */
	width: 100px;
	height: 30px;
	margin-top: 30px;
	margin-left: 30px;
	cursor: pointer;
	
}
div#footer_1_2 {
	/* border: solid 1px red;  */
	position: absolute;
	left: 45%;
	color: #CDCDCD;
	margin-top: 35px;
	cursor: pointer;
	
}

div#footer_1_3 {
	/* border: solid 1px red;  */
	position: absolute;
	left: 83%;
	margin-top: 20px;
}
div#footer_1_3 > img {
	width: 25px;
	height: 25px;
	margin-top: 10px;
	cursor: pointer;
}
div#footer_2{
	text-align: center;
	font-size: 10pt;
}
div#footer_2 > span{
	display: block;
	color: #CDCDCD;
}
span#contact{
	color: #EAEAEA; 
}
span#service{
	color: white;
	font-weight: bold;
}


.modal-dialog.modal-fullsize {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}

.modal-content.modal-fullsize {
  height: auto;
   min-height: 100%;
  
}

</style>

<script type="text/javascript">



function goHome(){
	location.href = "<%=request.getContextPath()%>/home.up";
}


function gokakao(){
	location.href = "https://www.kakaocorp.com/";
}
function gonaver(){
	location.href = "https://www.naver.com/";
}
function goinstagram(){
	location.href = "https://www.instagram.com/";
}
function gofacebook(){
	location.href = "https:///www.facebook.com/";
}

function goBoard(){
	location.href = "<%=request.getContextPath()%>/board/board.up";
}
</script>


<footer>
<div class="footer">
	<div id="footer_1">
		<div class="footerClick" id="footer_1_1">
			<img src="<%= ctxPath%>/image/logo_footer.png" onclick="goHome()" />
		</div>
		<div class="footerClick" id="footer_1_2" >
			<a style="color: #CDCDCD;" data-toggle="modal" data-target="#userCondition" data-dismiss="modal">이용약관 </a>&nbsp;|&nbsp;&nbsp;<a style="color: #CDCDCD;" data-toggle="modal" data-target="#personalPolicy" data-dismiss="modal">개인정보처리방침</a>
		</div>
		<div class="footerClick" id="footer_1_3">
			<img src="<%= ctxPath%>/image/kakao.png" onclick="gokakao()" />
			<img src="<%= ctxPath%>/image/naver.png" onclick="gonaver()" />
			<img src="<%= ctxPath%>/image/instagram.png" onclick="goinstagram()" />
			<img src="<%= ctxPath%>/image/facebook.png" onclick="gofacebook()" />
		</div>
	</div>
	<hr style="border: solid 1px #CDCDCD;">
	<br>
	<div id="footer_2">
		<span>(주)RHOME&nbsp;&nbsp;주소:서울 마포구 월드컵북로 21 (서교동) 풍성빌딩 2층 c강의실 &nbsp;&nbsp; 대표:이조&nbsp;&nbsp;<span onclick="goBoard()">고객센터 </span>: 1588-1588</span>
		<span>사업자등록번호: 126-81-24080&nbsp;&nbsp;사업자정보 확인&nbsp;&nbsp;통신판매업신고:제2021-서울마포-0123호</span>
		<span>개인정보관리책임자: 장혜민&nbsp;&nbsp;호스팅 서비스 사업자 : 이조</span>
		<br>
		<span id="contact">Contact to : jhmin07@nate.com</span>
		<br>
		<span>고객님은 안전거래를 위해 현금 등으로 결제시 모든 금액에 대하여 본 쇼핑몰에서 가입한 <span id="service">구매안전서비스</span> 소비자피해보상보험 서비스를 이용하실 수 있습니다.</span>
		<br>
		<span>Copyright&copy; by RHOME-K. Co. Ltd All Rights Reserved</span>
		<br>
		<a href="<%= ctxPath%>/admin/adminLogin.up" style="color: white;">[관리자모드]</a>
		<br><br>
	</div>
</div>
</footer>

<%-- ****** userCondition Modal 시작****** --%>
  <div class="modal fade" id="userCondition" role="dialog">
    <div class="modal-dialog modal-fullsize">
    
      <!-- Modal content-->
      <div class="modal-content modal-fullsize">
	      
	        <div class="modal-header">
		          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title" align="center" style="font-weight:bold; font-size: 25pt;">이용약관</h4>
		          <br>
		          <div align="center" >RHOME의 서비스 이용약관은 다음과 같은 내용을 담고 있습니다. </div>
		          <div align="center" >회원으로 가입하시면 RHOME 서비스를 보다 편리하게 이용할 수 있습니다.</div>
	        </div>
	        
	        <div class="modal-body" style="height: 250px; width: 100%;">        
		          <div id="idFind" >
		          	<iframe src="/SemiProject/iframeAgree/agree2.html" width="100%" height="500px" class="box" style="border: solid 1px #ccc;"></iframe>
		          </div>	          
	        </div>
	         <div class="modal-footer" style="margin-top: 300px;">
	          	<button type="button" class="btn btn-default myclose" data-dismiss="modal">close</button>
	         </div>
        
      </div>
      
    </div>
  </div>
<%-- ****** userCondition Modal 끝****** --%>
<%-- ****** personalPolicy Modal 시작****** --%>
  <div class="modal fade" id="personalPolicy" role="dialog">
    <div class="modal-dialog modal-fullsize">
    
      <!-- Modal content-->
      <div class="modal-content modal-fullsize">
	      
	        <div class="modal-header">
		          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
		          <h4 class="modal-title" align="center" style="font-weight:bold; font-size: 25pt;">개인정보처리방침</h4>
		          <br>
		          <div align="center" >RHOME의 개인정보처리방침은 다음과 같은 내용을 담고 있습니다. </div>
		          <div align="center" >회원으로 가입하시면 RHOME 서비스를 보다 편리하게 이용할 수 있습니다.</div>
	        </div>
	        
	        <div class="modal-body" style="height: 250px; width: 100%;">        
		          <div id="idFind" >
		          	<iframe src="/SemiProject/iframeAgree/agree2.html" width="100%" height="500px" class="box" style="border: solid 1px #ccc;"></iframe>
		          </div>	          
	        </div>
	         <div class="modal-footer" style="margin-top: 300px;">
	          	<button type="button" class="btn btn-default myclose" data-dismiss="modal">close</button>
	         </div>
        
      </div>
      
    </div>
  </div>
<%-- ****** personalPolicy Modal 끝****** --%>


</body>
</html>