<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contents2</title> 
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">

	div.carousel{
		/* border: solid 1px red; */
		display: inline-block;
		margin: 50px 10px;
	}
	div.container{
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
	img{
		width: 480px;
		height: 540px;
	}
	div.item{
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

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

</script>

</head>
<body>
<div id=contents2>
	<div id="newItem">NEW ITEM</div>
	
<div class="container mycontainer">


<div id="myCarousel1" class="carousel slide" data-ride="carousel">
 
    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="imagesContents2/sakura(1).jpg" alt="벚꽃1" style="width:100%;">
      </div>

      <div class="item">
        <img src="imagesContents2/sakura(2).jpg" alt="벚꽃2" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="imagesContents2/sakura(3).jpg" alt="벚꽃3" style="width:100%;">
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





  <div id="myCarousel2" class="carousel slide" data-ride="carousel">

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="imagesContents2/shinchan(1).jpg" alt="신짱1" style="width:100%;">
      </div>

      <div class="item">
        <img src="imagesContents2/shinchan(2).jpg" alt="신짱2" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="imagesContents2/shinchan(3).jpg" alt="신짱3" style="width:100%;">
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
  
  




  <div id="myCarousel3" class="carousel slide" data-ride="carousel">

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <div class="item active">
        <img src="imagesContents2/sky(1).jpg" alt="하늘1" style="width:100%;">
      </div>

      <div class="item">
        <img src="imagesContents2/sky(2).jpg" alt="하늘2" style="width:100%;">
      </div>
    
      <div class="item">
        <img src="imagesContents2/sky(3).jpg" alt="하늘3" style="width:100%;">
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


</body>
</html>