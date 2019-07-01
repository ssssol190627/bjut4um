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
		<a href="boardAdmin.jsp">返回</a>
	</div>
	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br>
		<input type="text" name="searchPostByKeyWord" value="searchPostByKeyWord">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<table border="1">
	<tr>
	    <th>所属板块</th>
		<th>帖子标题</th>
		<th>帖子内容</th>
		<th>发帖人</th>
		<th>是否加精</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>工大小锤</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="isGood" value="isGood">
			是<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br>
		<input type="text" name="searchGoodPostByKeyWord" value="searchGoodPostByKeyWord">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<table border="1">
	<caption align="top">已加精列表</caption>
	<tr>
	    <th>所属板块</th>
		<th>帖子标题</th>
		<th>帖子内容</th>
		<th>发帖人</th>
		<th>加精时间</th>
		<th>是否去精</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>工大小锤</th>
		<th>2019/06/20 23:05:07</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="isNotGoodAnymore" value="isNotGoodAnymore">
			去精<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
</body>
</html>