<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<div class="nav">
		<a href="superAdmin.jsp">返回</a>
	</div>
	<table border="1">
	<caption align="top">板块申请信息列表</caption>
	<tr>
	    <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>工大小锤</td>
		<td>分享生活点滴</td>
		<th>2019/06/20 23:05:07</th>
		<th>
		<form action="superAdmin.jsp">
			<input type="radio" name="newBoard" value="newBoard">
			通过<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
	<table border="1">
	<caption align="top">板块管理员申请信息列表</caption>
	<tr>
	    <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>好有趣最好吃</td>
		<td>工大学生自媒体运营者</td>
		<th>2019/06/20 23:05:07</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="newBoardAdministrator" value="newBoardAdministrator">
			通过<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
</body>
</html>