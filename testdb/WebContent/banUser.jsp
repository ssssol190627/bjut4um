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
	<form action="boardAdmin.jsp">
		<br>用户名模糊搜索：<br>
		<input type="text" name="searchToBanByName" value="searchToBanByName">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<table border="1">
	<tr>
	    <th>用户名</th>
		<th>处理</th>
	</tr>
	<tr>
		<td>abcd是abcd噢</td>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="toBanUserByName1Hour" value="toBanUserByName1Hour">
			封禁1小时<br>
			<input type="radio" name="toBanUserByName1Day" value="toBanUserByName1Day">
			封禁1天<br>
			<input type="radio" name="toBanUserByName1Month" value="toBanUserByName1Month">
			封禁1月<br>
			<input type="submit" name="submit" value="确定">
			<br>
			</form>
		</th>
	</tr>
	</table>
	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br>
		<input type="text" name="searchToBanByPostName" value="searchToBanByPostName">
		<br>回帖关键词：<br>
		<input type="text" name="searchToBanByReply" value="searchToBanByReply">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<table border="1">
	<tr>
		<th>所属帖子</th>		
		<th>所属楼层</th>
		<th>发言人</th>
		<th>处理结果</th>
	</tr>
	<tr>
		<td>我从北区食堂吃出苍蝇了</td>
		<td>我也迟到了！</td>
		<th>王xx</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="toBanUserByReply1Hour" value="toBanUserByReply1Hour">
			封禁1小时<br>
			<input type="radio" name="toBanUserByReply1Day" value="toBanUserByReply1Day">
			封禁1天<br>
			<input type="radio" name="toBanUserByReply1Month" value="toBanUserByReply1Month">
			封禁1月<br>
			<input type="submit" name="submit" value="确定">
			<br>
			</form>
		</th>
	</tr>
	</table>
</body>
</html>