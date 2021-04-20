<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
		div.contents1 {
			padding: 0;
			width: 100%;
		}
		
		div.contents1 ol.carousel-indicators {
			text-align: right;
			width: 75%;
		}
</style>


<jsp:include page="header3.jsp" />

<div class="container contents1" style="width: 100%; padding: 0;"> 
  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="image/banner1.jpg" alt="banner1" style="width:100%;">
      </div>

      <div class="item">
        <img src="image/banner2.jpg" alt="banner2" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="image/banner3.jpg" alt="banner3" style="width:100%;">
      </div>
    </div>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
</div>

