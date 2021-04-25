<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="contents1.jsp" />   

<style type="text/css">

	div.subcarousel{
		/* border: solid 1px red; */
		display: inline-block;
		 margin: 50px 15px;
	}
	div.subcontainer{
		text-align: center;
		/* border: solid 1px blue; */
		background-color: white;	
		width: 90%;
	}
	div#contents2{
		
		width: auto;
		background-color: #d9d9d9;
		padding-bottom: 40px;
	}
	
	div.contents2_item {
		width: 480px;
		height: 540px;
	}
	
	div.contents2_item > img{
		width: 480px;
		height: 540px;
	}
	
	div#newItem{
		font-weight: bold;
		text-align: center;
		margin-top: 50px;
		font-size: 18pt;
		padding: 40px 0px;
		background-color: #d9d9d9;
	}
</style>




<div id=contents2>
	<div id="newItem">NEW ITEM</div>
	
<div class="container subcontainer">


<div id="myCarousel1" class="subcarousel carousel slide" data-ride="carousel">
 
    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="contents2_item item active">
        <img src="imagesContents2/sofa01.jpeg" alt="소파1" style="width:100%;">
      </div>

      <div class="contents2_item item">
        <img src="imagesContents2/sofa02.jpeg" alt="소파2" style="width:100%;">
      </div>
    
      <div class="contents2_item item">
        <img src="imagesContents2/sofa03.jpg" alt="소파3" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel1" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel1" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>





  <div id="myCarousel2" class="subcarousel carousel slide" data-ride="carousel">

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="contents2_item item active">
        <img src="imagesContents2/table01.jpg" alt="테이블1" style="width:100%;">
      </div>

      <div class="contents2_item item">
        <img src="imagesContents2/table02.jpg" alt="테이블2" style="width:100%;">
      </div>
    
      <div class="contents2_item item">
        <img src="imagesContents2/table03.JPG" alt="테이블3" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel2" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel2" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  
  




  <div id="myCarousel3" class="subcarousel carousel slide" data-ride="carousel">

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="contents2_item item active">
        <img src="imagesContents2/closet01.JPG" alt="옷장1" style="width:100%;">
      </div>

      <div class="contents2_item item">
        <img src="imagesContents2/closet02.JPG" alt="옷장2" style="width:100%;">
      </div>
    
      <div class="contents2_item item">
        <img src="imagesContents2/closet03.JPG" alt="옷장3" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel3" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel3" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>  
</div>
</div>


<jsp:include page="footer.jsp" />  