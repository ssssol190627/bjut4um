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
	<link rel="stylesheet" type="text/css" href="assets/css/demo.css" />
	<script src="js/jquery-1.11.0.min.js" type="text/javascript"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.2/TweenMax.min.js"></script>
	<script src="https://unpkg.com/imagesloaded@4.1.4/imagesloaded.pkgd.min.js"></script>
	<script src="assets/js/demo.js"></script>  
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
	<ul id="board_tap" class="nav nav-tabs">
		<li class="active">
			<a href="#apply-board" data-toggle="tab">
			申请板块
			</a>
		</li>
		<li>
			<a href="#apply-boardAdmin" data-toggle="tab">
			申请成为板块管理员
			</a>
		</li>
		<li class="dropdown">
			<a href="#" id="myTabDrop1" class="dropdown-toggle" 
		   			data-toggle="dropdown">申请状态 
			<!--  <b class="caret"></b> -->
			</a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="myTabDrop1">
				<li><a href="#status" tabindex="-1" data-toggle="tab">板块申请状态</a></li>
				<li><a href="#ejb" tabindex="-1" data-toggle="tab">板块管理员申请状态</a></li>
			</ul>
		</li>
	
	
	</ul>
	<div id="myTabContent" class="tab-content">
	<div class="tab-pane fade in active" id="apply-board">
		<main role="main" class="container"> 
		 	<div class="panel panel-success">
			    <div class="panel-heading">
			    	申请板块
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
	</div>
	<div class="tab-pane fade" id="apply-boardAdmin">
		<main role="main" class="container"> 
		<div class="panel panel-success">
			<div class="panel-heading">
			    	申请板块管理员
			 </div>
			 <div class="panel-body">
				 <form action="userPreference.jsp" name="applyBoard">
				 <label>板块名</label> <br> 
				 	<select name="boardname" class="form-control" style="margin:10px 10px 20px 0px">
						<option value="情感天地" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">情感天地</option>
						<option value="荒野求生" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">荒野求生</option>
						<option value="工大学习" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">工大学习</option>
						<option value="工大生活" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">工大生活</option>
					</select>
					<br> <label>申请理由</label> <br> 
						<textarea class="form-control" name="a" style="width: 100%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;"></textarea>
					    <!-- <textarea name="a" style="width:200px;height:50px;">申请理由</textarea> -->
					    <br>
					    <input type="submit" value="提交申请"></input>
				</form>
			</div>
			</div>
		</main>
	</div>
	<div class="tab-pane fade" id="status">
		<main role="main" class="container"> 
		<div class="panel panel-success">
		<div class="panel-heading">
		    	申请板块状态
		 </div>
		 <div class="panel-body">
			<table border="1" class="table table-bordered table-striped table-hover">
	        <th style="width: 70%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">申请类别</th>
	        <th>申请时间</th>
	        <th>审核状态</th>
	        <tr class="success">
	            <td>申请读书板块</td>
	            <td>2019-06-30</td>
	            <td>成功</td>
	        </tr>
	        <tr>
	            <td>申请留学板块</td>
	            <td>2019-06-30</td>
	            <td>请等待</td>
	        </tr>
	        	<tr class="error">
	            <td>申请免费电影板块</td>
	            <td>2019-06-30</td>
	            <td>拒绝</td>
	        </tr>
	        </table>
	    </div>
	    </div>
		</main>
	</div>
	<div class="tab-pane fade" id="ejb">
	    <main role="main" class="container"> 
	    <div class="panel panel-success">
		<div class="panel-heading">
		  	申请板块管理员状态
		 </div>
		 <div class="panel-body">
			<table border="1" class="table table-bordered table-striped table-hover">
			<th style="width: 70%; height: 150px ;overflow: auto;word-break: break-all; resize: none;margin-bottom:5px;">申请类别</th>
		        <th>申请时间</th>
		        <th>审核状态</th>
		        <tr class="success">
		            <td>申请身为娱乐板块管理员</td>
		            <td>2019-06-30</td>
		            <td>通过</td>
		        </tr>
		        <tr class="error">
		            <td>申请身为校园生活板块管理员</td>
		            <td>2019-06-30</td>
		            <td>通过</td>
		        </tr>
	        </table>
	      </div>
	      </div>
	      </main>
	</div>
</div>
	

	<!--  
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
    -->

</body>
</html>