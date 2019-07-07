<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>Bjut4um</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
	<style>

	</style>
</head>
<body>
		<h1 class="header">欢迎来到Bjut4um网站</h1>
		<br>
		<br>
		<br>
		<br>  
    <!-- <div class="list-group">
  		<a href="board\1" class="list-group-item">荒野求生</a>
  		<a href="board\2" class="list-group-item">娱乐明星</a>
  		<a href="board\3" class="list-group-item">追剧狂</a>
  		<a href="board\4" class="list-group-item">爱小说</a>
  		<a href="board\5" class="list-group-item">工大生活</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
	</div> -->
		<% 		
		response.setHeader("Refresh", "0;URL=/testdb/home1"); 
		%>
	

	 <nav class="navbar navbar-dark bg-dark fixed-top" style="width:100%;" >
		<a class="navbar-brand" href="home1">Bjut4um</a>
		<!-- <a class="nav-link" href="#">💗</a>	 -->	
      	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample01" aria-controls="navbarsExample01" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>
      		
      		<div class="collapse navbar-collapse" id="navbarsExample01">
        		<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
	            		<a class="nav-link" href="loginpage">登录</a>
	          		</li>   
	          		<li class="nav-item">
	            		<a class="nav-link" href="registerpage">注册</a>
	          		</li> 
        		</ul>
      		</div>
	</nav>
	
	<!--  
	<h1 class="header">欢迎来到主页</h1>   
    <div class="list-group">
  		<a href="board\1" class="list-group-item">荒野求生</a>
  		<a href="board\2" class="list-group-item">娱乐明星</a>
  		<a href="board\3" class="list-group-item">追剧狂</a>
  		<a href="board\4" class="list-group-item">爱小说</a>
  		<a href="board\5" class="list-group-item">工大生活</a>
  		<a href="board\6" class="list-group-item">工大学习</a>
	</div>-->

	
		<h2>正在为您自动跳转，同样欢迎您使用手机访问手机页面</h2>
	<div class="footer">
	<h5 >© www.bjut4um.cn</h5>
	我们同样为移动端进行了适配，欢迎使用手机访问<br>
	<a href="https://github.com/ssssol190627/bjut4um">联系我们·Github主页</a>
	</div>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>

</body>

</html>