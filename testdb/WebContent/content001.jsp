<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>-->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>为客户的产品量身制作合格的包装箱</title>
	<style> 
        .black_overlay{ 
            display: none; 
            position: absolute; 
            top: 0%; 
            left: 0%; 
            width: 100%; 
            height: 100%; 
            background-color: black; 
            z-index:1001; 
            -moz-opacity: 0.8; 
            opacity:.80; 
            filter: alpha(opacity=88); 
        } 
        .white_content { 
            display: none; 
            position: absolute; 
            top: 25%; 
            left: 25%; 
            width: 55%; 
            height: 55%; 
            padding: 20px; 
            border: 10px solid orange; 
            background-color: white; 
            z-index:1002; 
            overflow: auto; 
        } 
    </style>
<link rel="stylesheet" href="style_home.css" type="text/css"/>
<SCRIPT language=javascript>
</SCRIPT> 
</head>
<body>
 <div class="nav">
 	<a href="/testdb/home1">返回</a>
 </div>

    <div class="post">
 	<h3 class="postTitle">${post.title }</h3>
 	<div class="avatar">
 		<img alt="" src="images/tu1.jpg" height="50" width="50">
 		<p class="username">${postuser.username }</p>
 		<p class="postingDate">${post.posttime }</p>
 		<p class="reply" onclick = "">回复</p>
			<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">举报</a>
 		</p> 
        <div id="light" class="white_content">
        	<form action="report">
				<br>举报类型：<br>
				<input type="radio" name="reportType" value="淫秽色情" /> 淫秽色情<br />
				<input type="radio" name="reportType" value="人身攻击" /> 人身攻击<br />
				<input type="radio" name="reportType" value="有害信息" /> 有害信息<br />
				<input type="radio" name="reportType" value="垃圾营销" /> 垃圾营销<br />
				<input type="radio" name="reportType" value="不实信息" /> 不实信息<br />
				<input type="radio" name="reportType" value="内容抄袭" /> 内容抄袭
				<input type="hidden" name="postId" value="${post.getPostid() }" /> 
				<input type="hidden" name="floorId" value="${floor.getFloorId() }" /> 
				<br>举报原因：<br>
				<input type="text" name="reportReason" value="">
				<input type="submit" name="submit" value="确定" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
				<br>
			</form>
		</div> 
        <div id="fade" class="black_overlay"></div> 
 	</div>
 	<p class="footer">${post.postcontent }</p>
 	
 	<%
		//判断cookie的id 与贴子id是否一样，一样out.println("修改");
	%>
 </div>
 <div class="reply">
  	<div class="avatar">
 		<img alt="" src="images/tu1.jpg" height="50" width="50">
 		<c:forEach items="${floors }" var="floor" >
 			<br>
        	<tr>
        	<td id="us">${floor.getUserId() }</td>
        	<td id="replyingDate">${floor.floortime }</td>
        	<td id="content">${floor.floorcontent }</td>
        	<td ><a onclick="reply_con(${floor.getFloorId()})">回复</a></td>|
 			<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">举报</a>
        	<div id="light" class="white_content">
        	<form action="report">
				<br>举报类型：<br>
				<input type="radio" name="reportType" value="淫秽色情" /> 淫秽色情<br />
				<input type="radio" name="reportType" value="人身攻击" /> 人身攻击<br />
				<input type="radio" name="reportType" value="有害信息" /> 有害信息<br />
				<input type="radio" name="reportType" value="垃圾营销" /> 垃圾营销<br />
				<input type="radio" name="reportType" value="不实信息" /> 不实信息<br />
				<input type="radio" name="reportType" value="内容抄袭" /> 内容抄袭
				<input type="hidden" name="postId" value="${post.getPostid() }" /> 
				<input type="hidden" name="floorId" value="${floor.getFloorId() }" /> 
				<br>举报原因：<br>
				<input type="text" name="reportReason" value="">
				<input type="submit" name="submit" value="确定" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
				<br>
			</form>
			</div> 
        	<div id="fade" class="black_overlay"></div> 
        	</tr>
        	<br>
        </c:forEach>
 	</div>
 	
 
 </div>
 <div class="post a reply">
 	<form action="content001.jsp" name="postAReply">
 		<textarea name="replyContent" style="width:200px;height:50px;">这里写内容</textarea>
 		<input type="submit" name="回复"/>
 		<input type="hidden" name="postId" value="${Temp}" /> 
		<input type="hidden" name="floorId" value="${Temp}" /> 
 	</form>
 </div> 
 
	<%
	
	%>

</body>
</html>