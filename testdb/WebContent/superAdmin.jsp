<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>超级管理员管理页面</title>
  	
  	<link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
	<style type="text/css">
		.selftemp{
			padding:30px 30px 30px 30px;
		}

		.col-sm-6{
			padding:23px 23px 23px 23px;
		}
	</style>
</head>
<body>
	
	<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
		<a class="navbar-brand mr-auto mr-lg-0" href="home1">Bjut4um</a>		
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
<h1 class="header">超级管理员管理页面</h1>

<div class="selftemp">
	<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">管理举报信息</h5>
        <p class="card-text">管理举报信息</p>
        <a href="reportAdmin" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">管理板块信息</h5>
        <p class="card-text">管理板块信息</p>
        <a href="boardApplyAdmin" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
</div>
	<div class="row">
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">加精</h5>
        <p class="card-text">加精帖子</p>
        <a href="/testdb/good" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
  <div class="col-sm-6">
    <div class="card">
      <div class="card-body">
        <h5 class="card-title">封禁和删除</h5>
        <p class="card-text">封禁帖子和删除帖子</p>
        <a href="banAndDelete.jsp" class="btn btn-primary">管理</a>
      </div>
    </div>
  </div>
</div>

</div>
</body>
</html>