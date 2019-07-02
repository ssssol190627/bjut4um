<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>加/去精</title>
</head>
<body>
	<div class="nav">
		<a href="boardAdmin.jsp">返回</a>
	</div>
	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br> <input type="text" name="searchPostByKeyWord"
			value="searchPostByKeyWord"> <input type="submit"
			name="submit" value="搜索"> <br>
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
				<form action="/testdb/good">
					<input type="hidden" name="isGoodNow" value="$goodPost.postid}">
						<input type="submit" name="submit" value="去精"> <br>
				</form>
			</th>
		</tr>
	</table>
<br>

	<table border="1">
		<caption align="top">已加精列表</caption>
		<tr>
			<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否去精</th>
		</tr>
		<c:forEach items="${goodPost}" var="goodPost" varStatus="loop">
			<tr>
				<td id="board${boardNameList.get(loop.count-1) }">${boardNameList.get(loop.count-1) }</td>
				<td id="title${goodPost.title }"><a href="  /testdb/post/${goodPost.postid}">${goodPost.title }</a></td>
				<td id="content${goodPost.postcontent }">${goodPost.postcontent }</td>
				<td id="user${userNameList.get(loop.count-1) }">${userNameList.get(loop.count-1) }</td>
				<td>
					<form action="/testdb/good" method="post">
						<input type="hidden" name="isNotGoodAnymore" value="${goodPost.postid}">
						<input type="submit" name="submit" value="去精"> <br>
					</form>
				</td>
		</c:forEach>


	</table>
</body>
</html>