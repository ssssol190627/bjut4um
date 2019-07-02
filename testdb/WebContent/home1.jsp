<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>this is home</title>
<link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>

	<h1 class="header">欢迎来到主页</h1>
	<div class="nav">
		<a href="accountCenter">个人中心</a> <a href="boardAdmin.jsp">板块管理员入口</a>
		<a href="superAdmin.jsp">超级管理员入口</a> <a href="quit">退出登录</a>
	</div>
	<div class="board">
		<span> </span>
		<table border="1">
			<c:forEach items="${AllBoard}" var="AllBoard">
				<tr>
					<td id="title${AllBoard.boardname }"><a
						href="  /testdb/board/${AllBoard.boardid}">${AllBoard.boardname }</a></td>
				</tr>
			</c:forEach>

		</table>
	</div>
	<div class="latest_content">
		<div class="single_content">
			<%
				//int i=100;
				String title1 = "为客户的产品量身制作合格的包装箱";
				String href1 = "content001.jsp";
				out.println("<a href=" + href1 + " target=\"_blank\">" + title1 + "</a>");
			%>
		</div>
		<div class="single_content">
			<%
				//int i=100;
				String title2 = "为客户的产品量身制作合格的包装箱2";
				String href2 = "content001.jsp";
				out.println("<a href=" + href2 + " target=\"_blank\">" + title2 + "</a>");
			%>
		</div>
		<div class="single_content">
			<%
				//int i=100;
				String title3 = "为客户的产品量身制作合格的包装箱3";
				String href3 = "content001.jsp";
				out.println("<a href=" + href3 + " target=\"_blank\">" + title3 + "</a>");
			%>
		</div>
	</div>
	<h3 class="footer">Copyright bjut4um.cn</h3>
</body>

</html>