<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>发布新帖</title>
</head>
<body>
<a href="/testdb/board/${nowBoard.boardid}"> 回到板块- ${nowBoard.boardname}</a>
	<h2>发布新帖</h2>
	<form method="post" action="/testdb/board/${nowBoard.boardid}">
		<label>标题</label> <br> 
		<input type="text" name="title" placeholder="标题，必填项目">
		<br> 
		用户名：${CurrentUser.username}
		<br> 
		<label>内容</label> 
		<br>
		<textarea rows="14" id="wenbenkuang" name="content" placeholder="主题帖内容，最多请勿超出30000字"></textarea>
		<br>
		<input type="submit" value="发布新帖" name="发布新帖"/>
	</form>


</body>
</html>