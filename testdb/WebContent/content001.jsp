<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <title>${post.title }</title>
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
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
		function replyFloor(floorUser,floorContent){
			var s="<%=session.getAttribute("CurrentUser")%>";
			if(s=="null"){
				alert("请先登录");
				document.getElementById("replyContent").readOnly=true;
			}
			else{
				document.getElementById("showReplyContent").textContent ="回复："+floorUser+":"+floorContent;
				document.getElementById("replyContent").readOnly=false;
			}
		}
	</script>
</head>
<body class="bg-light">
 
 <nav class="navbar navbar-expand-lg fixed-top navbar-dark bg-dark">
	<c:if test ="${CurrentUser!=null }">
		<a class="navbar-brand mr-auto mr-lg-0" href="/testdb/home1">Bjut4um</a>		
	</c:if> 
    <c:if test ="${CurrentUser==null }">
		<a class="navbar-brand mr-auto mr-lg-0" href="#">Bjut4um</a>		
	</c:if>  
      <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav">
        	<c:if test ="${CurrentUser!=null }">
				<li class="nav-item">
            		<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
          		</li>
			</c:if>        	
        </ul>
      </div>
</nav>
    
<main role="main" class="container">    
    <div class="my-3 p-3 bg-white rounded shadow-sm">
        <h6 class="border-bottom border-gray pb-2 mb-0">${post.title }</h6>
        <div class="media text-muted pt-3">
          <!--  <img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">-->
          <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
            <strong class="d-block text-gray-dark">${postuser.username }</strong>
            ${post.postcontent }<br>
            ${post.posttime }
          </p>
        </div>
        <small class="d-block text-right mt-3">
        	<a id="clickToReplyPost" href = "javascript:void(0)" onclick="replyPost('${postuser.username }','${post.postcontent }')">回复</a>|
			<a href = "javascript:void(0)" onclick = "document.getElementById('light0').style.display='block';document.getElementById('fade0').style.display='block'">举报</a>
        </small>
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
    </div>
    
	<div class="my-3 p-3 bg-white rounded shadow-sm">
        <h6 class="border-bottom border-gray pb-2 mb-0">回复</h6>
          <!--  <img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">-->
          <c:forEach items="${floor }" var="floor" varStatus="loop">
          	<div class="media text-muted pt-3">
 				<div class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
            		<div class="d-flex justify-content-between align-items-center w-100">
              			<strong class="text-gray-dark" id="us">${flooruser.get(loop.count-1)}</strong>
            		</div>
            		<span class="d-block" id="content">${floor.floorcontent }</span><br>
            		${floor.floortime }
          		</div>
	        	<small class="d-block text-right mt-3">
	        		<a id="clickToReplyFloor" href = "javascript:void(0)" onclick="replyFloor('${loop.count}','${floor.floorid }','${flooruser.get(loop.count-1)}','${floor.floorcontent }')">回复</a>|
        			<a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">举报</a>
	        	</small>
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
        	</div> 	
        </c:forEach>
        <div class="media text-muted pt-3">
        <%-- 构建分页导航 --%>
        <c:if test="${page.totalPage > 1}">
        	<a href="/testdb/post/${post.postid}/?page=1">首页&nbsp;</a>
        </c:if>		
		<%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
		<c:if test="${page.totalPage > 1}">
			<c:if test="${page.pageNum ==1}">
				<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
					<c:if test="${page.pageNum == i}">
                        ${i}&nbsp;
                	</c:if>
					<c:if test="${page.pageNum != i}">
						<a href="/testdb/post/${post.postid}/?page=${i}">${i}&nbsp;</a>
					</c:if>
				</c:forEach>
			</c:if>			
			<a href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页&nbsp;</a>
		</c:if>
		<%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
		<c:if test="${page.pageNum > 1 && page.pageNum < page.totalPage}">
			<a href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页&nbsp;</a>
			<c:forEach begin="${page.start}"
				end="${page.end}" step="1" var="i">
				<c:if test="${page.pageNum == i}">
                        ${i}&nbsp;
                </c:if>
				<c:if test="${page.pageNum != i}">
				<a href="/testdb/post/${post.postid}/?page=${i}">${i}&nbsp;</a>
				</c:if>
			</c:forEach>
			<a href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页&nbsp;</a>
		</c:if>
		<%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
		<c:if test="${page.totalPage > 1}">
			<c:if test="${page.pageNum == page.totalPage}">
				<a href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页&nbsp;</a>
				<c:forEach begin="${page.start}"
					end="${page.end}" step="1" var="i">
					<c:if test="${page.pageNum == i}">
                        ${i}&nbsp;
                	</c:if>
					<c:if test="${page.pageNum != i}">
						<a href="/testdb/post/${post.postid}/?page=${i}">${i}&nbsp;</a>
					</c:if>
				</c:forEach>
			</c:if>
		</c:if>		
		<%--尾页 --%>
		<c:if test="${page.totalPage > 1}">
			<a href="/testdb/post/${post.postid}/?page=${page.totalPage}">尾页&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
		</c:if>			
		${page.totalRecord}回复帖，共${page.totalPage }页
		</div>
	</div>      
 
	<div class="my-3 p-3 bg-white rounded shadow-sm">
		<form action="postReply" name="postAReply">
 			<p id="showReplyContent"></p>
 			<textarea name="replyContent" style="width:200px;height:50px;" placeholder="这里写内容"></textarea>
 			<input type="submit" name="回复"/>
 			<input type="hidden" name="postId" value="${post.postid }" /> 
 		</form>
	</div> 	
 </main>
 
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.1/assets/js/vendor/holder.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.js"></script>
</body>
</html>