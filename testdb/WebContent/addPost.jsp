<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>发布新帖</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
</head>
<body>

	<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark" style="position:fixed;top:0px;">
		<a class="navbar-brand mr-auto mr-lg-0" href="index.jsp">Bjut4um</a>		
      		<div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        		<ul class="navbar-nav"> 
        			<li class="nav-item">
	            		<a class="nav-link" href="#">💗</a>
	          		</li> 	
	          		<li class="nav-item">
	            		<a class="nav-link" href="/testdb/board/${nowBoard.boardid}">回到板块- ${nowBoard.boardname}</a>
	          		</li> 
        		</ul>
      		</div>
	</nav>
	
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<font size="6">
					发布新帖
				</font>
			</h3>
		</div>
	</div>
	
	<main role="main" class="container"> 
	 	<div class="panel panel-success">
	    <div class="panel-heading">
	    	用户名：${CurrentUser.username}
	    </div>
	    <div class="panel-body">
		      <form method="post" action="/testdb/board/${nowBoard.boardid}">
					<label>标题</label> <br> 
					<input class="form-control" type="text" name="title" placeholder="标题，必填项目" style="width: 100%; height: 50px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">
					<br> 
					<label>内容</label> 
					<br>
					<textarea class="form-control" id="wenbenkuang" name="content" placeholder="主题帖内容" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;"></textarea>
					<br>
					<input type="submit" value="发布新帖" name="发布新帖"/>
			</form>
	    </div>
		</div>
	</main>
			





</body>
</html>