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
	<h1 class="header">欢迎来到主页</h1>
	
	<div class="list-group">
		<c:forEach items="${AllBoard}" var="AllBoard">
			<a class="list-group-item" id="title${AllBoard.boardname }" href="  /testdb/board/${AllBoard.boardid}">${AllBoard.boardname }</a>
			</tr>
		</c:forEach>
	</div>
	
	<nav class="narvbar navbar-dark bg-dark fixed-top" style="width:100%;">
		<a class="navbar-brand" href="/testdb/home1" style="float:left;">Bjut4um</a>
       		<c:if test="${CurrentUser!=null }">
				<ul class="navbar-nav mr-auto" style="float:left">
     				<li class="nav-item">
       				<a class="nav-link disabled" href="#">您好，${CurrentUser.username}</a>
     				</li>
     			</ul>	          			
     		</c:if>
   			<c:if test="${CurrentUser==null }">
   			    <li class="nav-item">
     				<a class="nav-link disabled" href="#">未登录</a>
   				</li>
   			</c:if>	
		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample01" aria-controls="navbarsExample01" aria-expanded="false" aria-label="Toggle navigation" style="float:right;">
        	<span class="navbar-toggler-icon"></span>
      	</button>
				
      		<div class="collapse navbar-collapse" id="navbarsExample01">
        		<ul class="navbar-nav">
				<c:if test="${CurrentUser!=null }">
					 <li class="nav-item">
       				<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
     				</li> 
	          	</c:if>  
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
	          		<c:if test="${CurrentUser!=null }">
	          			          		<li class="nav-item" >
	            		<a class="nav-link" href="quit" >退出登录</a>
	          		</li> 
	          		</c:if>  
        		</ul>
      		</div>
	</nav>

<h3 class="footer">Copyright bjut4um.cn</h3>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>

	
</body>

</html>