<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <title>${nowBoard.boardname}</title>
    <!-- Bootstrap core CSS -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  	
  	<link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>

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

	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">
				<font size="10">
					${nowBoard.boardname}
				</font>
			</h3>
		</div>
	<div class="panel-body">		
<form method="post" action="/testdb/addPost">
			<c:if test ="${CurrentUser == null }">			
				<input type="submit" value="发布新帖，请先登录" name="发布新帖，请先登录" disabled="disabled"/>
			</c:if>
			<c:if test ="${CurrentUser != null }">			
				<input type="submit" value="发布新帖" name="发布新帖"/>
			</c:if>
		</form>
	</div>
	<table class="table">
		<tr>
			<th>帖子标题</th>
			<th>发帖人</th>
			<th>发帖时间</th>
			<th>更新时间</th>
			<th>回复数</th>
		</tr>
		<c:forEach items="${CurrentPost }" var="CurrentPost" varStatus="loop">
			<tr>
				<td id="title${CurrentPost.title }"><a
					href="/testdb/post/${CurrentPost.postid}">${CurrentPost.title }</a></td>
				<td id="username${postuser.get(loop.count-1) }">${postuser.get(loop.count-1) }</td>
				<td id="posttime${CurrentPost.posttime}">${CurrentPost.posttime }</td>
				<td id="newtime${CurrentPost.newtime }">${CurrentPost.newtime }</td>
				<td id="numpost${CurrentPost.numpost}">${CurrentPost.numpost }</td>
			</tr>
		</c:forEach>
	</table>
	

	<%-- 构建分页导航 --%>
	<c:if test="${page.totalPage > 1}">
        	<a href="/testdb/board/${nowBoard.boardid}/?page=1">首页&nbsp;</a>
    </c:if>	
	<%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
	<c:if test="${page.totalPage > 1}">
		<c:if test="${page.pageNum ==1}">
			<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
				<c:if test="${page.pageNum == i}">
        			${i}&nbsp;
                </c:if>
				<c:if test="${page.pageNum != i}">
					<a href="/testdb/board/${nowBoard.boardid}/?page=${i}">${i}&nbsp;</a>
				</c:if>
			</c:forEach>
			<a href="/testdb/board/${nowBoard.boardid}/?page=${page.pageNum+1}">下一页&nbsp;</a>
		</c:if>
	</c:if>	
	<%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
	<c:if test="${page.pageNum > 1 && page.pageNum < page.totalPage}">
		<a href="/testdb/board/${nowBoard.boardid}/?page=${page.pageNum-1}">上一页&nbsp;</a>
		<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
            	${i}&nbsp;
            </c:if>
			<c:if test="${page.pageNum != i}">
				<a href="/testdb/board/${nowBoard.boardid}/?page=${i}">${i}&nbsp;</a>
			</c:if>
		</c:forEach>
		<a href="/testdb/board/${nowBoard.boardid}/?page=${page.pageNum+1}">下一页&nbsp;</a>
	</c:if>
	<%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
	<c:if test="${page.totalPage > 1}">
		<c:if test="${page.pageNum == page.totalPage}">
			<a href="/testdb/board/${nowBoard.boardid}/?page=${page.pageNum-1}">上一页&nbsp;</a>
			<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
				<c:if test="${page.pageNum == i}">
	            	${i}&nbsp;
	            </c:if>
				<c:if test="${page.pageNum != i}">
					<a href="/testdb/board/${nowBoard.boardid}/?page=${i}">${i}&nbsp;</a>
				</c:if>
			</c:forEach>
		</c:if>
	</c:if>
	<%--尾页 --%>
	<c:if test="${page.totalPage > 1}">
		<a href="/testdb/board/${nowBoard.boardid}/?page=${page.totalPage}">尾页&nbsp;</a>
	</c:if>
	共${page.totalPage }页，${page.totalRecord}帖子
	<h6 class="footer">© www.bjut4um.cn</h6>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>