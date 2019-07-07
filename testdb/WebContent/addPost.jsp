<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>添加新贴</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>

	<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top" style="width:100%;">
		<a class="navbar-brand" href="/testdb/home1">Bjut4um</a>
		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample01" aria-controls="navbarsExample01" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>
      		
      		<div class="collapse navbar-collapse" id="navbarsExample01">
        		<ul class="navbar-nav mr-auto">
					<c:if test="${CurrentUser!=null }">
						<li class="nav-item">
		      				<span class="nav-link disabled">您好，${CurrentUser.username}</span>
		      			</li>
		      			<li class="nav-item">
	            			<a class="nav-link" href="/testdb/board/${nowBoard.boardid}">回到板块- ${nowBoard.boardname}</a>
	          			</li> 
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
	     				</li>
	     				<c:if test ="${CurrentUser.isBoardAdmin !=0 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="/testdb/boardAdmin">管理板块</a>
	          				</li> 
	          			</c:if>
	          			<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
		          			<li class="nav-item">
		            			<a class="nav-link" href="/testdb/superAdmin">管理论坛</a>
		          			</li>
	          			</c:if>
	          			<li class="nav-item">
	            			<a class="nav-link" href="/testdb/quit">退出登录</a>
	          			</li>
	          		</c:if>
				    <c:if test="${CurrentUser==null }">
				    	<li class="nav-item">
							<span class="nav-link disabled">未登录</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/testdb/loginpage">登录</a>
						</li>
						<li class="nav-item">
	            			<a class="nav-link" href="/testdb/registerpage">注册</a>
	          			</li> 
			   		</c:if>
        		</ul>
      		</div>
	</nav>
	<h3 class="footer">发布新帖</h3>
	
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