<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="utf-8">
	<title>login</title>
	<link rel="icon" href="../../favicon.ico">
	
	<!-- Bootstrap core CSS -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>
	<div class="login-container">
    	<form class="form-signin" action="login">
        	<h2 class="form-signin-heading">欢迎来到登录页面</h2>
        	<label for="inputUsername" class="sr-only">用户名</label>
        	<input type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus>
        	<label for="inputPassword" class="sr-only">密码</label>
        	<input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
        	<br>
        	<button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    	</form>
    </div> <!-- /container -->    
</body>
</html>