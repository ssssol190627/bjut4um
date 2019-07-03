<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>	
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>用户设定</title>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
</head>
<body>
	<script src="http://mymaplist.com/js/vendor/TweenLite.min.js"></script>
		<div class="login-body">
		<div class="container">
    		<div class="vertical-offset-100">
    			<div class="col-md-4 col-md-offset-4">
    				<div class="panel panel-default">
			  			<div class="panel-heading">
			    			<h3 class="panel-title">修改密码</h3>
			 			</div>
			  		<div class="panel-body">
			    	<form accept-charset="UTF-8" action="updatePassword" method="POST">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="原密码" name="passwordOld" type="password">
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="新密码" name="passwordNew" type="password">
			    		</div>
			    		<input class="btn btn-lg btn-success btn-block" type="submit" value="确定">
			    		<input class="btn btn-lg btn-success btn-block" type="button" value="返回" onClick="javascript :history.back(-1);">
			    	</fieldset>
			   	 	</form>
			    	</div>
				</div>
			</div>
		</div>
	</div>   
	</div>
</body>
</html>