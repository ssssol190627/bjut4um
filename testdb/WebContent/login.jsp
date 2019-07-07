<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>登录</title>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	 <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

		<h3 class="footer">登录</h3>
    <!-- Custom styles for this template -->
    <script>
    	$(document).ready(function(){
    		$(document).mousemove(function(e){
    	    	 TweenLite.to($('body'), 
    	        	.5, 
    	        		{ css: 
    	            		{
    	                		//backgroundPosition: ""+ parseInt(event.pageX/'8') + "px "+parseInt(event.pageY/'12')+"px, "+parseInt(event.pageX/'15')+"px "+parseInt(event.pageY/'15')+"px, "+parseInt(event.pageX/'30')+"px "+parseInt(event.pageY/'30')+"px";
    	            		}
    	        		});
    	  	});
    	});
    </script>
    <script>
    	$(document).ready(function(){
    		var s=document.getElementById("judgeType").value;
			if(s==1)	alert("用户名不存在");
			else if(s==2)	alert("登录失败");
    	});
    </script>
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
			    			<h3 class="panel-title">欢迎来到登录页面</h3>
			 			</div>
			  		<div class="panel-body">
			    	<form accept-charset="UTF-8" action="login" method="post">
                    <fieldset>
			    	  	<div class="form-group">
			    		    <input class="form-control" placeholder="用户名" name="username" type="text">
			    		</div>
			    		<div class="form-group">
			    			<input class="form-control" placeholder="密码" name="password" type="password">
			    		</div>
			    		<input class="btn btn-lg btn-success btn-block" type="submit" value="登录">
			    		<input class="btn btn-lg btn-success btn-block" type="button" value="随便逛逛" onClick="javascript:window.location.href='index.jsp';">
			    		<input id="judgeType" type="hidden" value="${logInWrongType }">
			    	</fieldset>
			   	 	</form>
			    	</div>
				</div>
			</div>
		</div>
	</div>   
	</div>
			<div class="footer">
	<h5 >© www.bjut4um.cn</h5>
	我们同样为移动端进行了适配，欢迎使用手机访问<br>
	<a href="https://github.com/ssssol190627/bjut4um">联系我们·Github主页</a>
	</div>
</body>
</html>