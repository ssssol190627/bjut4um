<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>管理举报信息</title>
</head>
<body>
	<div class="nav">
		<a href="boardAdmin">返回</a>
	</div>
	<table border="1">
	<tr>
		<th>举报类型</th>
		<th>所属帖子</th>
		<th>所属楼层</th>
		<th>举报原因</th>
		<th>举报人</th>
		<th>处理结果</th>
	</tr>
	<c:forEach items="${reported }" var="report" varStatus="loop">
		<tr>
			<td id="reportbrief${report.reportbrief }">${report.reportbrief }</td>
			<td id="postid${report.postid }">${report.postid }</td>
			<td id="floorid${report.floorid }">${report.floorid }</td>
			<td id="reportcontent${report.reportcontent }">${report.reportcontent }</td>
			<td id="username${usernames.get(loop.count-1) }">${usernames.get(loop.count-1)  }</td>
			<td>
			<c:if test ="${report.ishandle == 0 }">
				<form action="manageReport">
					<input type="radio" name="manage" value="ban">
						封禁<br>
					<input type="radio" name="manage" value="delete">
						删除<br>
					<input type="radio" name="manage" value="refuse">
						驳回<br>
					
					<input type="hidden" name="reportid" value="${report.reportid }" />  
					<input type="submit" name="submit" value="确定"><br>
				</form>
			</c:if>
			<c:if test = "${report.ishandle == 1 }">已封禁</c:if>
			<c:if test = "${report.ishandle == 2 }">已删除</c:if>
			<c:if test = "${report.ishandle == 3 }">已驳回</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>