<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户设定</title>


</head>
<body>
	<form action="updatePassword" method="POST">

		<br>原密码：<br>
		<input type="password" name="passwordOld" value="">
		<br>密码：<br>
		<input type="password" name="passwordNew" value="">
		<br>
		<input type="submit" name="submit" value="提交">
		<br>
	</form>
</body>
</html>