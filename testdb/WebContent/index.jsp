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
</head>
<body>

	 <nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
		<a class="navbar-brand mr-auto mr-lg-0" href="index.jsp">Bjut4um</a>		
      		<div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        		<ul class="navbar-nav">
					<li class="nav-item" style="position:fixed;right:100px;">
	            		<a class="nav-link" href="loginpage">登录</a>
	          		</li>   
	          		<li class="nav-item" style="position:fixed;right:50px;">
	            		<a class="nav-link" href="registerpage">注册</a>
	          		</li> 
	          		<li class="nav-item">
	            		<a class="nav-link" href="#">💗</a>
	          		</li>   	
        		</ul>
      		</div>
	</nav>
	
	
	<h1 class="header">欢迎来到主页</h1>   
    <div class="list-group">
  		<a href="board\1" class="list-group-item">情感天地</a>
  		<a href="board\2" class="list-group-item">荒野求生</a>
  		<a href="board\3" class="list-group-item">娱乐明星</a>
  		<a href="board\4" class="list-group-item">追剧狂</a>
  		<a href="board\5" class="list-group-item">爱小说</a>
  		<a href="board\6" class="list-group-item">工大生活</a>
  		<a href="board\7" class="list-group-item">工大学习</a>
	</div>

	<h3 class="footer">
		Copyright bjut4um.cn
	</h3>
</body>

</html>