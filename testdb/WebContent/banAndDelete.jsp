<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
				<a class="nav-link" href="boardAdmin.jsp">返回</a>
    		</li>
  		</ul>
	</nav>

	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br>
		<input type="text" name="searchToBanByKeyWord" value="searchToBanByKeyWord">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	
	
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
		    <input type="text" name="bdReason" value="bdReason">
			<br>
			<input type="submit" name="submit" value="确定">
			<br>
			</form>
		</th>
	</tr>
	</table>
	<table border="1">
	<caption align="top">申请解封列表</caption>
	<tr>
	    <th>所属板块</th>
		<th>所属帖子</th>
		<th>所属楼层</th>
		<th>封禁原因</th>
		<th>封禁时间</th>
		<th>申请解封理由</th>
		<th>是否恢复，不通过理由</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>不实信息</th>
		<th>2019/06/20 23:05:07</th>
		<th>经查实，并非不实信息</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="notBanAnymore" value="notBanAnymore">
			恢复<br>
			<input type="text" name="stillBanReason" value="stillBanReason">
			<br>不通过原因<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
</body>
</html>