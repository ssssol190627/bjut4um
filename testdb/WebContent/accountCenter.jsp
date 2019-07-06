<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  	
  	<link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>个人中心</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
  	
  	
  	<style> 
		.accountCentercontainer{ font-size:14px} 
	</style>
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
		      				<span class="nav-link disabled">${CurrentUser.username} 的个人用户中心</span>
		      			</li>
		      			<li class="nav-item">
      						<a class="nav-link" href="/testdb/applyBoard">申请板块/管理员</a>
    					</li>
	          			<li class="nav-item">
			     			 <a class="nav-link" href="/testdb/adminMessage">站内信息</a>
			    		</li>
			    		<li class="nav-item">
      						<a class="nav-link" href="/testdb/userPreferences">修改密码</a>
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
							<a class="nav-link active" href="/testdb/loginpage">登录</a>
						</li>
						<li class="nav-item">
	            			<a class="nav-link active" href="/testdb/registerpage">注册</a>
	          			</li> 
			   		</c:if>
        		</ul>
      		</div>
	</nav>
	<!--
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  		<ul class="navbar-nav">
    		<li class="nav-item active">
      		<a class="nav-link" href="applyBoard">申请板块/成为板块管理员</a>
    		</li>
    		<li class="nav-item">
     		 <a class="nav-link" href="adminMessage">站内信息</a>
    		</li>
    		<li class="nav-item">
      		<a class="nav-link" href="userPreferences">改密码</a>
    		</li>
    		<li class="nav-item">
      		<a class="nav-link" href="home1">回主页</a>
    		</li>
    		<c:if test="${CurrentUser!=null}">
    		<li><span> </span>
    			<a class="nav-link disabled" href="#">您好，${CurrentUser.username}</a>
    			</li>
    		</c:if>
    		<c:if test="${CurrentUser==null}">
    		<li><span> </span>
    			<a class="nav-link disabled" href="#">未登录</a>
    			<li>
    		</c:if>
  		</ul>
	</nav>
	-->
	<div class="accountCentercontainer">
	<h3 class="footer">我的贴子</h3>
	<table class="table table-hover">
		<thead>
   			<tr>
		       <td>序号</td>
		       <td>帖子名</td>
		       <td>发帖时间</td>
   			</tr>
		</thead>
		<tbody>
			<c:forEach items="${posted}" var="post" varStatus="postStatus">
				<tr>
			       <td>${postStatus.index }</td>
			       <td><a href="/testdb/post/${post.postid}" target="_blank">${post.title }</a></td>
			       <td>${post.posttime }</td>
   				</tr>
       		</c:forEach>
		</tbody> 
	</table>
	<h3 class="footer">我的回复</h3>
		<table class="table table-hover">
			<thead>
	   			<tr>
			       <td>回复内容</td>
			       <td>回复时间</td>
	   			</tr>
			</thead>
			<tbody>
				<c:forEach items="${floored}" var="floor" varStatus="postStatus" >
					<tr>
						<td><a href="/testdb/post/${floor.postid }">${floor.floorcontent }</a></td>
				       	<td>${floor.floortime }</td>
			       	</tr>
        		</c:forEach>	
			</tbody>
        </table> 
	</div>
	<h6 class="footer">© www.bjut4um.cn</h6>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>