<%@ page language="java" contentType="text/html; charset=utf-8"
        pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="author" content="">
<title>${post.title }</title>
<!-- Bootstrap core CSS -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  	
  	<link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
<style>
.black_overlay {
        display: none;
        position: absolute;
        top: 0%;
        left: 0%;
        width: 100%;
        height: 100%;
        background-color: black;
        z-index: 1001;
        -moz-opacity: 0.8;
        opacity: .80;
        filter: alpha(opacity = 88);
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
        z-index: 1002;
        overflow: auto;
}
</style>
<link rel="stylesheet" href="style_home.css" type="text/css" />
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
                function replyFloor(loopCount,ansFloor,floorUser,floorContent){
                    var s="<%=session.getAttribute("CurrentUser")%>";
	                if (s == "null") {
	                        alert("请先登录");
	                        document.getElementById("replyContent").readOnly = true;
	                } else {
	                        document.getElementById("showReplyContent").textContent = "回复："
	                                        + floorUser + ":" + floorContent;
	                        document.getElementById("ansfloorId").value = ansFloor;
	                }
                }
                function clickReport1(){
                	var s="<%=session.getAttribute("CurrentUser")%>";
	                if (s == "null") 
	                        alert("请先登录");
	                else{
	                	document.getElementById("light0").style.display="block";
	                	document.getElementById("fade0").style.display="block";
	                }               	
                }
                function clickReport2(){
                	var s="<%=session.getAttribute("CurrentUser")%>";
	                if (s == "null") 
	                        alert("请先登录");
	                else{
	                	document.getElementById("light").style.display="block";
	                	document.getElementById("fade").style.display="block";
	                }               	
                }
</script>
</head>
<body class="bg-light">

	<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top" style="width:100%;">
		<a class="navbar-brand" href="/testdb/home1">Bjut4um</a>
		 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample01" aria-controls="navbarsExample01" aria-expanded="false" aria-label="Toggle navigation">
        	<span class="navbar-toggler-icon"></span>
      	</button>
      		
      		<div class="collapse navbar-collapse" id="navbarsExample01">
        		<ul class="navbar-nav mr-auto">
					<c:if test="${CurrentUser!=null }">
						<li class="nav-item">
		      				<span class="nav-link disabled">您好，${CurrentUser.username}</span>
		      			</li>
		      			<li class="nav-item">
	            			<a class="nav-link" href="/testdb/board/${nowBoard.boardid}">回到板块- ${nowBoard.boardname}</a>
	          			</li> 
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/home1">主页</a>		      			
		      			</li>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
	     				</li>
	     				<c:if test ="${CurrentUser.isBoardAdmin !=0 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="/testdb/boardAdmin">管理板块</a>
	          				</li> 
	          			</c:if>
	          			<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
		          			<li class="nav-item">
		            			<a class="nav-link" href="/testdb/superAdmin">管理论坛</a>
		          			</li>
	          			</c:if>
	          			<li class="nav-item">
	            			<a class="nav-link" href="/testdb/quit">退出登录</a>
	          			</li>
	          		</c:if>
				    <c:if test="${CurrentUser==null }">
				    	<li class="nav-item">
							<span class="nav-link disabled">未登录</span>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/testdb/loginpage">登录</a>
						</li>
						<li class="nav-item">
	            			<a class="nav-link" href="/testdb/registerpage">注册</a>
	          			</li> 
			   		</c:if>
        		</ul>
      		</div>
	</nav>
 <c:if test="${post.isBanned==0 && post.isExist==1 }">
        <main role="main" class="container">
        <div class="my-3 p-3 bg-white rounded shadow-sm">
                <h6 class="border-bottom border-gray pb-2 mb-0">${post.title }</h6>
                <div class="media text-muted pt-3">
                        <!--  <img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">-->
                        <p
                                class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                                <strong class="d-block text-gray-dark">${postuser.username }</strong>
                                ${post.postcontent }<br> ${post.posttime }
                        </p>
                </div>
                <small class="d-block text-right mt-3"> <a
                        id="clickToReplyPost" href="javascript:void(0)"
                        onclick="replyPost('${postuser.username }','${post.postcontent }')">回复</a>|
                        <a href="javascript:void(0)"
                        onclick="javascript:clickReport1();">举报</a>
                </small>
                <div id="light0" class="white_content">
                        <form action="/testdb/post/report">
                                <br>举报类型：<br> <input type="radio" name="reportType"
                                        value="淫秽色情" /> 淫秽色情<br /> <input type="radio" name="reportType"
                                        value="人身攻击" /> 人身攻击<br /> <input type="radio" name="reportType"
                                        value="有害信息" /> 有害信息<br /> <input type="radio" name="reportType"
                                        value="垃圾营销" /> 垃圾营销<br /> <input type="radio" name="reportType"
                                        value="不实信息" /> 不实信息<br /> <input type="radio" name="reportType"
                                        value="内容抄袭" /> 内容抄袭 <input type="hidden" name="postId"
                                        value="${post.postid}" /> <input type="hidden" name="floorId"
                                        value="0" /> <br>举报原因：<br> <input type="text"
                                        name="reportReason" value=""> <input type="submit"
                                        name="submit" value="确定"
                                        onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
                                		<button type="button" onclick="document.getElementById('light0').style.display='none';document.getElementById('fade0').style.display='none'">返回</button>
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
                                <div
                                        class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                                        <div
                                                class="d-flex justify-content-between align-items-center w-100">
                                                <strong class="text-gray-dark" id="us">${flooruser.get(loop.count-1)}</strong>
                                        </div>
                                        <span class="d-block" id="content">
                                        
                                         <c:if  test="${floor.ansfloorid !=0 }">
                        回复 ${floor.ansfloorid }层[${ansname.get(loop.count-1) }] : 
                        </c:if> 
                                        <c:if test="${floor.isBanned !=0 }">
                                                        <font color="red">此层违规，已被封禁</font>
                                        </c:if> 
                                        <c:if test="${floor.isBanned ==0 }">
                        ${floor.floorcontent }
                        </c:if>

                                        </span><br> ${floor.floorid }层 ${floor.floortime }
                                </div>
                                <small class="d-block text-right mt-3"> <a
                                        id="clickToReplyFloor" href="javascript:void(0)"
                                        onclick="replyFloor('${loop.count}','${floor.floorid }','${flooruser.get(loop.count-1)}','${floor.floorcontent }')">回复</a>|
                                        <a href="javascript:void(0)"
                                        onclick="javascript:clickReport2();">举报</a>
                                </small>
                                <div id="light" class="white_content">
                                        <form action="/testdb/post/report">
                                                <br>举报类型：<br> <input type="radio" name="reportType"
                                                        value="淫秽色情" /> 淫秽色情<br /> <input type="radio"
                                                        name="reportType" value="人身攻击" /> 人身攻击<br /> <input
                                                        type="radio" name="reportType" value="有害信息" /> 有害信息<br /> <input
                                                        type="radio" name="reportType" value="垃圾营销" /> 垃圾营销<br /> <input
                                                        type="radio" name="reportType" value="不实信息" /> 不实信息<br /> <input
                                                        type="radio" name="reportType" value="内容抄袭" /> 内容抄袭 <input
                                                        type="hidden" name="postId" value="${post.postid}" /> <input
                                                        type="hidden" name="floorId" value="${floor.floorid}"
                                                        id="floorId${loop.count+1}" /> <br>举报原因：<br> <input
                                                        type="text" name="reportReason" value=""> <input
                                                        type="submit" name="submit" value="确定"
                                                        onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
                                               			<button type="button" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">返回</button>
                                                <br>
                                        </form>
                                </div>
                                <div id="fade" class="black_overlay"></div>
                        </div>
                </c:forEach>
                <div class="media text-muted pt-3">
                        <%-- 构建分页导航 --%>
                        <c:if test="${page.totalPage > 1}">
                                <a href="/testdb/post/${post.postid}/?page=1">首页 </a>
                        </c:if>
                        <%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
                        <c:if test="${page.totalPage > 1}">
                                <c:if test="${page.pageNum ==1}">
                                        <c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
                                                <c:if test="${page.pageNum == i}">
                        ${i} 
                        </c:if>
                                                <c:if test="${page.pageNum != i}">
                                                        <a href="/testdb/post/${post.postid}/?page=${i}">${i} </a>
                                                </c:if>
                                        </c:forEach>
                                        <a href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页 </a>
                                </c:if>
                        </c:if>
                        <%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
                        <c:if test="${page.pageNum > 1 && page.pageNum < page.totalPage}">
                                <a href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页 </a>
                                <c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
                                        <c:if test="${page.pageNum == i}">
                        ${i} 
                </c:if>
                                        <c:if test="${page.pageNum != i}">
                                                <a href="/testdb/post/${post.postid}/?page=${i}">${i} </a>
                                        </c:if>
                                </c:forEach>
                                <a href="/testdb/post/${post.postid}/?page=${page.pageNum+1}">下一页 </a>
                        </c:if>
                        <%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
                        <c:if test="${page.totalPage > 1}">
                                <c:if test="${page.pageNum == page.totalPage}">
                                        <a href="/testdb/post/${post.postid}/?page=${page.pageNum-1}">上一页 </a>
                                        <c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
                                                <c:if test="${page.pageNum == i}">
                        ${i} 
                        </c:if>
                                                <c:if test="${page.pageNum != i}">
                                                        <a href="/testdb/post/${post.postid}/?page=${i}">${i} </a>
                                                </c:if>
                                        </c:forEach>
                                </c:if>
                        </c:if>
                        <%--尾页 --%>
                        <c:if test="${page.totalPage > 1}">
                                <a href="/testdb/post/${post.postid}/?page=${page.totalPage}">尾页     </a>
                        </c:if>
                        ${page.totalRecord}回复帖，共${page.totalPage }页
                </div>
        </div>

        <script>
                window.onload = function() {
                        var btn = document.getElementById('course');
                        btn.onmouseover = function() {
                                $("#course").addClass('btn-info');
                        };
                        btn.onmouseout = function() {
                                $("#course").removeClass('btn-info')
                        };
                };
        </script>

        <div class="panel panel-success">
                <div class="panel-heading">
                        <p class="panel-title" id="showReplyContent">回复：</p>
                </div>
                <div class="panel-body">
                        <form action="/testdb/post/${post.postid }/postReply"
                                name="postAReply">
								<c:if test="${CurrentUser!=null }">
									<textarea class="form-control" name="replyContent" id="log"
                                        placeholder="这里写内容"
                                        style="width: 100%; height: 150px; overflow: auto; word-break: break-all; resize: none; margin-bottom: 10px;"></textarea>
									<input type="submit" id="course" name="回复" class="btn btn-inverse"
                                        role="button" /> <input type="hidden" name="postId"
                                        value="${post.postid }" /> <input type="hidden" name="ansfloorId"
                                        id="ansfloorId" /> <input type="hidden" name="nowPage"
                                        value="${page.pageNum }" />
								</c:if>
                                <c:if test="${CurrentUser==null }">
                                	<textarea class="form-control" name="replyContent" id="log"
                                        placeholder="回复请先登录" readonly="readonly"
                                        style="width: 100%; height: 150px; overflow: auto; word-break: break-all; resize: none; margin-bottom: 10px;"></textarea>
                                </c:if>

                        </form>
                </div>
        </div>
        </main>
</c:if>
 <c:if test="${post.isBanned ==1 || post.isExist==0 }">
 	<font color="red">此帖违规，已被封禁或删除，有疑问请联系管理员15010398335@163.com</font>
 	<a href="/testdb/board/${post.boardid }">返回板块</a>
 </c:if>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
                crossorigin="anonymous"></script>
        <script>
                window.jQuery
                                || document
                                                .write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')
        </script>
        
		<div class="footer">
	<h5 >© www.bjut4um.cn</h5>
	我们同样为移动端进行了适配，欢迎使用手机访问<br>
	<a href="https://github.com/ssssol190627/bjut4um">联系我们·Github主页</a>
	</div>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>