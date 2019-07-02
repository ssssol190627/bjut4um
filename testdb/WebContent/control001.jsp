<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>为客户的产品量身制作合格的包装箱</title>
<link rel="stylesheet" href="style_home.css" type="text/css" />
<SCRIPT language=javascript>
	function go()
	{
	window.history.go(-1);
	}
	setTimeout("go()",3000);
</SCRIPT>
</head>
<body>
 <div class="nav">
 	<!--  <a href="home1.jsp">返回</a>
 	
 	
 	<a href="javascript :;" onClick="javascript :history.back(-1);">返回上一页</a>
 	<a href="javascript :history.back(-1)">返回上一页</a>
 	<a href=”#” onClick=”javascript:history.back(-1);”>返回上一页</a>-->
 </div>
 <div class="post">
 	<h3 class="postTitle">为客户的产品量身制作合格的包装箱</h3>
 	<div class="avatar">
 		<img alt="" src="images/tu1.jpg" height="50" width="50">
 		<p class="username">wang77</p>
 		<p class="postingDate">2019/06/20 23:03:07</p>
 		<p class="reqport">举报</p>
 	</div>
 	<p class="footer">我有个问题，大家可以讲一讲如何为客户定制合格的包装箱吗？</p>
 	
 	<%
		//判断cookie的id 与贴子id是否一样，一样out.println("修改");
	%>
 </div>
 <div class="reply">
  	<div class="avatar">
 		<img alt="" src="images/tu1.jpg" height="50" width="50">
 		<p class="username">feifei</p>
 		<p class="replyingDate">2019/06/20 23:05:07</p>
 		<p class="reqport">举报</p>
 	</div>
 	<p class="replyContent">必须要做好的包装盒！！！</p>
 	
 
 </div>
 <div class="post a reply">
 	<form action="content001.jsp" name="postAReply">
 		<textarea name="a" style="width:200px;height:50px;">这里写内容</textarea>
 		<input type="submit">回复</input>
 	</form>
 </div>
 
	<%
	
	%>

</body>
</html>