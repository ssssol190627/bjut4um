<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<title>管理举报信息</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script> 
  	<style> 
		.accountCentercontainer{ font-size:14px} 
	</style>
</head>
<body>

	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  		<ul class="navbar-nav">
    		<li class="nav-item active">
				<a class="nav-link" href="superAdmin.jsp">返回</a>
    		</li>
  		</ul>
	</nav>

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
   		</tr>
    </c:forEach>
	</table>

</body>
</html>