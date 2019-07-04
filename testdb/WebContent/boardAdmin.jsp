<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap 
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">-->
	<title>板块管理员管理页面</title>
	<!-- <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>  -->
  	
  	<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
  	<style> 
  		.black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 100%; 
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 25%; 
            width: 55%; 
            height: 55%; 
            padding: 20px; 
            border: 10px solid orange; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        }
		.accountCentercontainer{ font-size:14px} 
		.selftemp{
			padding:40px 40px 40px 40px;
		}

		.col-sm-6{
			padding:40px 40px 40px 40px;
		}
		
	</style>
</head>
<body >
	<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
		<a class="navbar-brand mr-auto mr-lg-0" href="index.jsp">Bjut4um</a>		
      		<div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        		<ul class="navbar-nav">
        			<li class="nav-item">
	            		<a class="nav-link" href="#">💗</a>
	          		</li>  
					<li class="nav-item">
	            		<a class="nav-link" href="accountCenter">个人中心</a>
	          		</li> 
	          		<li class="nav-item">
	            		<a class="nav-link" href="quit" style="position:fixed;right:50px;">退出登录</a>
	          		</li>
        		</ul>
      		</div>
	</nav>
<h1 class="header">板块管理员管理页面</h1>
	<!--  <div class="accountCentercontainer">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  		<ul class="navbar-nav">
	<h1 class="header">板块管理员管理页面</h1>
	<div class="nav">
		<a href="reportAdmin">管理举报信息</a>
		<a href="/testdb/good">加精</a>
		<a href="banAndDelete.jsp">封禁和删除</a>
		<a href="home1">回主页</a>-->
	</div>

	<div class="selftemp">
	<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">管理举报信息</h5>
        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
        <a href="reportAdmin" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">加精</h5>
        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
        <a href="/testdb/good" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
</div>
	<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">封禁和删除</h5>
        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
        <a href="banAndDelete.jsp" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">回主页</h5>
        <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
        <a href="home1" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
</div>
</div>
</body>
</html>