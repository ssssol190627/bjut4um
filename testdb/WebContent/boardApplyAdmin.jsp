<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>管理板块信息</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  	
  	<link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
  	<style> 
		.accountCentercontainer{ font-size:14px} 
	</style>
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
		      			<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
		          			<li class="nav-item">
		            			<a class="nav-link" href="/testdb/superAdmin">返回管理论坛</a>
		          			</li>
	          			</c:if>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/home1">主页</a>
	     				</li>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
	     				</li>
	     				<c:if test ="${CurrentUser.isBoardAdmin !=0 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="/testdb/boardAdmin">管理板块</a>
	          				</li> 
	          			</c:if>

	          			<li class="nav-item">
	            			<a class="nav-link" href="/testdb/quit">退出登录</a>
	          			</li>
	          		</c:if>
				    <c:if test="${CurrentUser==null }">
				    	<li class="nav-item">
							<span class="nav-link disabled">未登录</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/testdb/loginpage">登录</a>
						</li>
						<li class="nav-item">
	            			<a class="nav-link" href="/testdb/registerpage">注册</a>
	          			</li> 
			   		</c:if>
        		</ul>
      		</div>
	</nav>
 <c:if test="${CurrentUser.isForumAdmin == 1 }">
	<h3 class="footer">板块申请信息</h3>
	<table class="table table-hover">
		<thead>
   			<tr>
		       	 <th>板块名</th>
				<th>申请人</th>
				<th>申请理由</th>
				<th>申请时间</th>
				<th>是否通过</th>
   			</tr>
		</thead>
		<tbody>
		<c:forEach items="${applyboards}" var="applyboard" varStatus="loop">
		<tr>
		    <td>${applyboard.boardname }</td>
		    <td>${username.get(loop.count-1) }</td>
		    <td>${applyboard.applyingreason }</td>
		    <td>${applyboard.applytime }</td>
		    <c:if test = "${applyboard.ishandle == 0 }">
		    	<td>
					<form action="manageApplyboard">
						<input type="radio" name="newBoard" value="allow">通过<br>
						<input type="radio" name="newBoard" value="refuse">驳回<br>
						<input type="hidden" name="applyid" value="${applyboard.applyingid }" />   
						<input type="submit" name="submit" value="确定">
					<br>
					</form>
				</td>
			</c:if>
			<c:if test = "${applyboard.ishandle == 1 }">
				<td>已通过</td>
			</c:if>
			<c:if test = "${applyboard.ishandle == 2 }">
				<td>已驳回</td>
			</c:if>
   		</tr>
    </c:forEach>
	</table>


	<h3 class="footer">板块管理员申请信息</h3>
	<table class="table table-hover">
		<thead>
   			<tr>
		      <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
	</tr>
	<c:forEach items="${applyadmins}" var="applyadmin" varStatus="loop">
		<tr>
		    <td>${boardname.get(loop.count-1) }</td>
		    <td>${username2.get(loop.count-1) }</td>
		    <td>${applyadmin.applyingreason }</td>
		    <td>${applyadmin.applytime }</td>
		    <c:if test = "${applyadmin.ishandle == 0 }">
		    	<td>
					<form action="manageApplyAdmin">
						<input type="radio" name="newAdmin" value="allow">通过<br>
						<input type="radio" name="newAdmin" value="refuse">驳回<br>
						<input type="hidden" name="applyid" value="${applyadmin.applyingid }" />   
						<input type="submit" name="submit" value="确定">
						<br>
					</form>
				</td>
			</c:if>
			<c:if test = "${applyadmin.ishandle == 1 }">
				<td>已通过</td>
			</c:if>
			<c:if test = "${applyadmin.ishandle == 2 }">
				<td>已驳回</td>
			</c:if>
   		</tr>
    </c:forEach>
	</table>
	</c:if>
 <c:if test="${CurrentUser.isForumAdmin == 0 }">
 	<font color="red">您没有权限访问此页面，</font>
	<a href="/testdb/home1">返回主页</a>
 </c:if>
	<h6 class="footer">© www.bjut4um.cn</h6>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>