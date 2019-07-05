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
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  		<ul class="navbar-nav">
    		<li class="nav-item active">
    			<c:if test = "${CurrentUser.isForumAdmin == 1}">
					<a class="nav-link" href="superAdmin">返回</a>
				</c:if>
				<c:if test = "${CurrentUser.isForumAdmin != 1}">
					<a class="nav-link" href="boardAdmin">返回</a>
				</c:if>
    		</li>
  		</ul>
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
</body>
</html>