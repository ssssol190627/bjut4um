<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<title>个人中心</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script> 
  	<style> 
		.accountCentercontainer{ font-size:14px} 
	</style>
</head>
<body>
	<div class="accountCentercontainer">
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
      		<a class="nav-link disabled" href="home1">回主页</a>
    		</li>
  		</ul>
	</nav>
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
					<td><a href="/testdb/post/${floor.postid }">${floor.floorcontent }</a></td>
			       	<td>${floor.floortime }</td>
        		</c:forEach>	
			</tbody>
        </table> 
	</div>
		<!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
	<script src="https://code.jquery.com/jquery.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>