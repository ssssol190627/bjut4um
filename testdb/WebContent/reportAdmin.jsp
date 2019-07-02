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
	<table border="1">
	<tr>
		<th>举报类型</th>
		<th>所属帖子</th>
		<th>所属楼层</th>
		<th>举报原因</th>
		<th>举报人</th>
		<th>处理结果</th>
	</tr>
	<tr>
		<td>不实信息</td>
		<td>我从北区食堂吃出苍蝇了</td>
		<td>我也迟到了！</td>
		<th>说谎！北区食堂苍蝇都让我打死了！</th>
		<th>王xx</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="ban" value="ban">
			封禁<br>
			<input type="radio" name="delete" value="delete">
			删除<br>
			<input type="submit" name="submit" value="确定">
			<br>
			</form>
		</th>
	</tr>
	</table>
</body>
</html>