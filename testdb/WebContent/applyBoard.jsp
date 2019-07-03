<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>申请新版块/申请成为板块管理员</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
</head>
<body>

	<nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark" style="position:fixed;top:0px;">
		<a class="navbar-brand mr-auto mr-lg-0" href="index.jsp">Bjut4um</a>		
      		<div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        		<ul class="navbar-nav"> 
        			<li class="nav-item">
	            		<a class="nav-link" href="#">💗</a>
	          		</li> 	
	          		<li class="nav-item">
	            		<a class="nav-link" href="accountCenter.jsp">个人中心</a>
	          		</li> 
        		</ul>
      		</div>
	</nav>
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<font size="6">
					申请板块
				</font>
			</h3>
		</div>
	</div>
	<main role="main" class="container"> 
	 	<div class="panel panel-success">
	    <div class="panel-heading">
	    	用户名：${CurrentUser.username}
	    </div>
	    <div class="panel-body">
		      <form action="applyNewboard" name="applyBoard">
					<label>板块名</label> <br> 
					<input class="form-control" type="text" name="boardname" placeholder="板块名，必填项目" style="width: 100%; height: 50px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">
					<br> 
					<label>申请理由</label> 
					<br>
					<textarea class="form-control" name="boardreason" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;"></textarea>
					<br>
					<input type="submit" value="提交申请"/>
			</form>
	    </div>
		</div>
	</main>
	
 <h3 class="post a reply">申请成为板块管理员</h3>
 <form action="userPreference.jsp" name="applyBoard">
 	<select name="boardname">
		<option value="情感天地">情感天地</option>
		<option value="荒野求生">荒野求生</option>
		<option value="工大学习">工大学习</option>
		<option value="工大生活">工大生活</option>
	</select>
    <textarea name="a" style="width:200px;height:50px;">申请理由</textarea>
    <input type="submit">提交申请</input>
</form>
<h3 class="post a reply">已提交申请的审核状态</h3>
<table border="1">
        <th>申请类别</th>
        <th>申请时间</th>
        <th>审核状态</th>
        <tr>
            <td>申请身为娱乐板块管理员</td>
            <td>2019-06-30</td>
            <td>通过</td>
        </tr>
        <tr>
            <td>申请读书板块</td>
            <td>2019-06-30</td>
            <td>请等待</td>
        </tr>
    </table>

</body>
</html>