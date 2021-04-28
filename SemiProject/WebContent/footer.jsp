<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
footer{
 	background-color: #3e505e;
 	
}
div.footer{
	margin: 100px 100px;
}
div.footerClick{
	display: inline;
	
}
div#footer_1_1 > img{
	/* border: solid 1px red;  */
	width: 150px;
	height: 60px;
	
}
div#footer_1_2 {
	/* border: solid 1px red;  */
	position: absolute;
	left: 45%;
	color: #CDCDCD;
	margin-top: 30px;
}
div#footer_1_3 {
	/* border: solid 1px red;  */
	position: absolute;
	left: 80%;
	margin-top: 20px;
}
div#footer_1_3 > img {
	width: 25px;
	height: 25px;
	margin-top: 10px;
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

</style>


<footer>
<div class="footer">
	<div id="footer_1">
		<div class="footerClick" id="footer_1_1">
			<img src="image/logo_footer.png"/>
		</div>
		<div class="footerClick" id="footer_1_2" >
			<span id="userCondition">이용약관 </span>|&nbsp;<span id="personalPolicy">개인정보처리방침</span>
		</div>
		<div class="footerClick" id="footer_1_3">
			<img src="image/kakao.png"/>
			<img src="image/naver.png"/>
			<img src="image/instagram.png"/>
			<img src="image/facebook.png"/>
		</div>
	</div>
	<hr style="border: solid 1px #CDCDCD;">
	<br>
	<div id="footer_2">
		<span>(주)RHOME&nbsp;&nbsp;주소:서울 마포구 월드컵북로 21 (서교동) 풍성빌딩 2층 c강의실 &nbsp;&nbsp; 대표:이조&nbsp;&nbsp;고객센터:1588-1588</span>
		<span>사업자등록번호: 126-81-24080&nbsp;&nbsp;사업자정보 확인&nbsp;&nbsp;통신판매업신고:제2021-서울마포-0123호</span>
		<span>개인정보관리책임자: 장혜민&nbsp;&nbsp;호스팅 서비스 사업자 : 이조</span>
		<br>
		<span id="contact">Contact to : jhmin07@nate.com</span>
		<br>
		<span>고객님은 안전거래를 위해 현금 등으로 결제시 모든 금액에 대하여 본 쇼핑몰에서 가입한 <span id="service">구매안전서비스</span> 소비자피해보상보험 서비스를 이용하실 수 있습니다.</span>
		<br>
		<span>Copyright&copy; by RHOME-K. Co. Ltd All Rights Reserved</span>
		<br><br>
	</div>
</div>
</footer>

</body>
</html>