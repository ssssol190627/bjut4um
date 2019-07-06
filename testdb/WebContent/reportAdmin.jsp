<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>管理举报信息</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
  	<style> 
		.accountCentercontainer{ font-size:14px} 
	</style>

	<script type="text/javascript">
		function alertAdminMessage(loopCount){
			var adminResult = document.getElementById ("mR"+loopCount).manage.value;
			if(adminResult=="ban")	alert("已封禁");
			else if(adminResult=="delete")	alert("已删除");
			else if(adminResult=="refuse")	alert("已驳回");
		}
	</script>
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
		      				<span class="nav-link disabled">您好，${CurrentUser.username}</span>
		      			</li>
		      			<c:if test ="${CurrentUser.isBoardAdmin !=0 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="boardAdmin">返回管理板块</a>
	          				</li> 
	          			</c:if>
	          			<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
		          			<li class="nav-item">
		            			<a class="nav-link" href="superAdmin.jsp">返回管理论坛</a>
		          			</li>
	          			</c:if>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/home1">主页</a>
	     				</li>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
	     				</li>

	          			<li class="nav-item">
	            			<a class="nav-link" href="quit">退出登录</a>
	          			</li>
	          		</c:if>
				    <c:if test="${CurrentUser==null }">
				    	<li class="nav-item">
							<span class="nav-link disabled">未登录</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="loginpage">登录</a>
						</li>
						<li class="nav-item">
	            			<a class="nav-link" href="registerpage">注册</a>
	          			</li> 
			   		</c:if>
        		</ul>
      		</div>
	</nav>
	<h1 class="footer">管理员管理页面-举报信息</h1>
	<table class="table table-hover">
		<thead>
   			<tr>
		       	<td>举报类型</td>
				<td>所属帖子</td>
				<td>所属楼层</td>
				<td>举报原因</td>
				<td>举报人</td>
				<td>处理结果</td>
   			</tr>
		</thead>
		<tbody>
				<c:forEach items="${reported }" var="report" varStatus="loop">
		<tr>
			<c:if test ="${report.ishandle == 0 }">
			<td id="reportbrief${report.reportbrief }">${report.reportbrief }</td>
			<td id="postid${report.postid }">${report.postid }</td>
			<td id="floorid${report.floorid }">${report.floorid }</td>
			<td id="reportcontent${report.reportcontent }">${report.reportcontent }</td>
			<td id="username${usernames.get(loop.count-1) }">${usernames.get(loop.count-1)  }</td>
			<td>
				<form action="manageReport" id="mR${loop.count-1 }">
					<input type="radio" name="manage" value="ban">
						封禁<br>
					<input type="radio" name="manage" value="delete">
						删除<br>
					<input type="radio" name="manage" value="refuse">
						驳回<br>					
					<input type="hidden" name="reportid" value="${report.reportid }" />  					
					<input type="submit" name="submit" value="确定" onclick="javascript:alertAdminMessage(${loop.count-1 })"><br>
				</form>
			</td>
			</c:if>
		</tr>
	</c:forEach>
		</tbody> 
	</table>
	<h6 class="footer">© www.bjut4um.cn</h6>
	    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>