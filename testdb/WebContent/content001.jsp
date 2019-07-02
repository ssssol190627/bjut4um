<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>${post.title }</title>
	<link rel="stylesheet" href="style_home.css" type="text/css"/>
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
	<script type="text/javascript">
		function replyPost(postUser,postContent){			
			var s="<%=session.getAttribute("CurrentUser")%>";
			if(s=="null"){
				alert("请先登录");
				document.getElementById("replyContent").readOnly=true;
			}
			else{
				document.getElementById("showReplyContent").textContent ="回复："+postUser+":"+postContent;
				document.getElementById("replyContent").readOnly=false;
			}
		}
		function replyFloor(loopCount,floorId,floorUser,floorContent){
			var s="<%=session.getAttribute("CurrentUser")%>";
			if(s=="null"){
				alert("请先登录");
				document.getElementById("replyContent").readOnly=true;
			}
			else{
				document.getElementById("showReplyContent").textContent ="回复："+floorUser+":"+floorContent;
				document.getElementById("floorId+"+loopCount).value =""+floorId;
				document.getElementById("replyContent").readOnly=false;
			}
		}
	</script>
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
 		<p class="footer">${post.postcontent }</p>
 		<p>
 		    <a id="clickToReplyPost" href = "javascript:void(0)" onclick="replyPost('${postuser.username }','${post.postcontent }')">回复</a>|
			<a href = "javascript:void(0)" onclick = "document.getElementById('light0').style.display='block';document.getElementById('fade0').style.display='block'">举报</a>
 		</p> 
        <div id="light0" class="white_content">
        	<form action="report">
				<br>举报类型：<br>
				<input type="radio" name="reportType" value="淫秽色情" /> 淫秽色情<br />
				<input type="radio" name="reportType" value="人身攻击" /> 人身攻击<br />
				<input type="radio" name="reportType" value="有害信息" /> 有害信息<br />
				<input type="radio" name="reportType" value="垃圾营销" /> 垃圾营销<br />
				<input type="radio" name="reportType" value="不实信息" /> 不实信息<br />
				<input type="radio" name="reportType" value="内容抄袭" /> 内容抄袭
				<input type="hidden" name="postId" value="${post.postid}" /> 
				<input type="hidden" name="floorId" value="0" /> 
				<br>举报原因：<br>
				<input type="text" name="reportReason" value="">
				<input type="submit" name="submit" value="确定" onclick ="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
				<br>
			</form>
		</div> 
        <div id="fade0" class="black_overlay"></div>
 	
 	<%
		//判断cookie的id 与贴子id是否一样，一样out.println("修改");
	%>
 </div>
 <div class="reply">
  	<div class="avatar">
 		<img alt="" src="images/tu1.jpg" height="50" width="50">
 		<c:forEach items="${floor }" var="floor" varStatus="loop">
 			<br>
        	<tr>
        	<td id="us">${flooruser.get(loop.count-1)}</td>
        	<td id="replyingDate">${floor.floortime }</td>
        	<td id="content">${floor.floorcontent }</td>
            <td >
        		<a id="clickToReplyFloor" href = "javascript:void(0)" onclick="replyFloor('${loop.count}','${floor.floorid }','${flooruser.get(loop.count-1)}','${floor.floorcontent }')">回复</a>|
        		<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">举报</a>
        	</td>
        	<div id="light" class="white_content">
        	<form action="report">
				<br>举报类型：<br>
				<input type="radio" name="reportType" value="淫秽色情" /> 淫秽色情<br />
				<input type="radio" name="reportType" value="人身攻击" /> 人身攻击<br />
				<input type="radio" name="reportType" value="有害信息" /> 有害信息<br />
				<input type="radio" name="reportType" value="垃圾营销" /> 垃圾营销<br />
				<input type="radio" name="reportType" value="不实信息" /> 不实信息<br />
				<input type="radio" name="reportType" value="内容抄袭" /> 内容抄袭
				<input type="hidden" name="postId" value="${post.postid}" /> 
				<input type="hidden" name="floorId" id="floorId+${loop.count}"/> 
				<br>举报原因：<br>
				<input type="text" name="reportReason" value="">
				<input type="submit" name="submit" value="确定" onclick ="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
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
 		<p id="showReplyContent" name="showReplyContent" ></p>
 		<textarea name="replyContent" style="width:200px;height:50px;" placeholder="这里写内容"></textarea>
 		<input type="submit" name="回复"/>
 		<input type="hidden" name="postId" value="${Temp}" /> 
		<input type="hidden" name="floorId" value="${Temp}" /> 
 	</form>
 </div> 
 
	<%
	
	%>
<%-- 构建分页导航 --%>
	共有${page.totalRecord}个回复，共${page.totalPage }页，当前为${page.pageNum}页
	<a href="/testdb/post/${post.postid}/?page=1">首页</a>
	<%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
	<c:if test="${page.pageNum ==1}">
		<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/post/${post.postid}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
		<a
			href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页</a>
	</c:if>
	<%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
	<c:if
		test="${page.pageNum > 1 && page.pageNum < page.totalPage}">
		<a
			href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页</a>
		<c:forEach begin="${page.start}"
			end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/post/${post.postid}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
		<a
			href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页</a>
	</c:if>
	<%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
	<c:if
		test="${page.pageNum == page.totalPage}">
		<a
			href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页</a>
		<c:forEach begin="${page.start}"
			end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/post/${post.postid}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
	</c:if>
	<%--尾页 --%>
	<a
		href="/testdb/post/${post.postid}/?page=${page.totalPage}">尾页</a>
</body>
</html>