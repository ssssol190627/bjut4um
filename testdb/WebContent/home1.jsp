<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<a class="navbar-brand mr-auto mr-lg-0" href="/testdb/home1">Bjut4um</a>		
      		<div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        		<ul class="navbar-nav">
        			<li class="nav-item">
	            		<a class="nav-link" href="#">💗</a>
	          		</li> 
	          		<c:if test="${CurrentUser!=null }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="boardAdmin">个人中心</a>
	          				</li> 			          			
	          		</c:if>
	          		<li class="nav-item">
	            		<a class="nav-link" href="quit" style="position:fixed;right:50px;">退出登录</a>
	          		</li>   
	          		<c:if test ="${CurrentUser.isBoardAdmin !=0 }">	   
	          			<c:if test ="${CurrentUser.isForumAdmin !=1 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="boardAdmin">板块管理员入口</a>
	          				</li> 
	          			</c:if>       			          			
	          		</c:if>
	          		<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
	          			<li class="nav-item">
	            			<a class="nav-link" href="superAdmin.jsp">超级管理员入口</a>
	          			</li> 
	          		</c:if> 	
        		</ul>
      		</div>
	</nav>
	<h1 class="header">欢迎来到主页</h1>
	
	<div class="list-group">
		<c:forEach items="${AllBoard}" var="AllBoard">
			<a class="list-group-item" id="title${AllBoard.boardname }" href="  /testdb/board/${AllBoard.boardid}">${AllBoard.boardname }</a>
			</tr>
		</c:forEach>
	</div>


	<h3 class="footer">Copyright bjut4um.cn</h3>
</body>

</html>