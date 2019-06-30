<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
		<a href="accountCenter">个人中心</a>
		<a href="home.jsp">退出登录</a>
	</div>
	<div class="board">
		<span>
		
		</span>
		<%
			int boardSize=7;
			String boardTitle[]={"情感天地","荒野求生","娱乐明星","追剧狂","爱小说","工大生活","工大学习"};
			out.println("<nav>");
			//String boardHref[]={"board1","board1","board1","board1","board1","board1","board1"};
			for(int i=0;i<boardSize;i++){
				//out.println("<span>");
				//out.println("<nav>");
				out.println("<a href=board\\"+i+" target=\"_blank\">"+boardTitle[i]+"</a>");
				out.println("<br>");
				//out.println("/<span>");
			}
			out.println("</nav>");
		%>
	</div>
	<div class="latest_content">
			<div class="single_content">
				<% 
					//int i=100;
					String title1="为客户的产品量身制作合格的包装箱";
					String href1="content001.jsp";
						out.println("<a href="+href1+" target=\"_blank\">"+title1+"</a>");
				%>
			</div>
			<div class="single_content">
				<% 
					//int i=100;
					String title2="为客户的产品量身制作合格的包装箱2";
					String href2="content001.jsp";
						out.println("<a href="+href2+" target=\"_blank\">"+title2+"</a>");
				%>
			</div>
			<div class="single_content">
				<% 
					//int i=100;
					String title3="为客户的产品量身制作合格的包装箱3";
					String href3="content001.jsp";
						out.println("<a href="+href3+" target=\"_blank\">"+title3+"</a>");
				%>
			</div>
	</div>
	<h3 class="footer">
		Copyright bjut4um.cn
	</h3>
</body>

</html>