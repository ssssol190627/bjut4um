<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>个人中心</title>
<link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>
	<div class="nav">
<<<<<<< HEAD
		<a href="userPreferences">改密码</a>
		<a href="home1.jsp">回主页</a>
	</div>
	<h3 class="footer">我的贴子</h3>
	<div class="single_content">
		<c:forEach items="${posted}" var="post" >
        	<tr>
        	<a href="detailedpost">${post.title }${post.posttime }</a>
        	</tr>
        </c:forEach> 
	</div>
	<h3 class="footer">我的回复</h3>
		<div class="single_content">
		<c:forEach items="${floored}" var="floor" >
        	<tr>
        	<a href="detailedfloor">${floor.floorcontent }${floor.floortime }</a>
        	</tr>
        </c:forEach> 
	</div>
=======
		<a href="userPreferences.jsp">改密码</a>
		<a href="home1.jsp">回主页</a>
	</div>
	<h3 class="footer">我的贴子</h3>
	<div class="single_content">
		<c:forEach items="${posted}" var="post" >
        	<tr>
        	<a href="detailedpost">${post.title }</a>
        	</tr>
        </c:forEach> 
	</div>
	<h3 class="footer">我的回复</h3>

>>>>>>> branch 'master' of https://github.com/ssssol190627/bjut4um.git
</body>
</html>