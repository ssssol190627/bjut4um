<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>申请解封</title>
</head>
<body>
	<div class="nav">
 	  <a href="accountCenter.jsp">返回个人中心</a>	
 	</div>
	<h3 class="post a reply">申请解封</h3>
	<table border="1">
	<caption align="top">详细信息</caption>
	<tr>
	    <th>所属板块</th>
		<th>所属帖子</th>
		<th>所属楼层</th>
		<th>封禁原因</th>
		<th>封禁时间</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>不实信息</th>
		<th>2019/06/20 23:05:07</th>
	</tr>
	</table>
    <form action="accountCenter.jsp" name="askNotBan">
        <textarea name="askNotBanReason" style="width:200px;height:50px;">申请理由</textarea>
        <input type="submit" value="确定"></input>
    </form>
</body>
</html>