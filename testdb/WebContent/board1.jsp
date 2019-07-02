<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${nowBoardName}</title>
</head>
<body>
	<h2>${nowBoardName}</h2>
	<table border="1">
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
	共有${page.totalRecord}个帖子，共${page.totalPage }页，当前为${page.pageNum}页
	<a href="/testdb/board/${nowBoardId}/?page=1">首页</a>
	<%--如果当前页为第一页时，就没有上一页这个超链接显示 --%>
	<c:if test="${page.pageNum ==1}">
		<c:forEach begin="${page.start}" end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/board/${nowBoardId}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
		<a
			href="/testdb/board/${nowBoardId}/?page=${page.pageNum+1}">下一页</a>
	</c:if>
	<%--如果当前页不是第一页也不是最后一页，则有上一页和下一页这个超链接显示 --%>
	<c:if
		test="${page.pageNum > 1 && page.pageNum < page.totalPage}">
		<a
			href="/testdb/board/${nowBoardId}/?page=${page.pageNum-1}">上一页</a>
		<c:forEach begin="${page.start}"
			end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/board/${nowBoardId}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
		<a
			href="/testdb/board/${nowBoardId}/?page=${page.pageNum+1}">下一页</a>
	</c:if>
	<%-- 如果当前页是最后一页，则只有上一页这个超链接显示，下一页没有 --%>
	<c:if
		test="${page.pageNum == page.totalPage}">
		<a
			href="/testdb/board/${nowBoardId}/?page=${page.pageNum-1}">上一页</a>
		<c:forEach begin="${page.start}"
			end="${page.end}" step="1" var="i">
			<c:if test="${page.pageNum == i}">
                        ${i}
                    </c:if>
			<c:if test="${page.pageNum != i}">
				<a
					href="/testdb/board/${nowBoardId}/?page=${i}">${i}</a>
			</c:if>
		</c:forEach>
	</c:if>
	<%--尾页 --%>
	<a
		href="/testdb/board/${nowBoardId}/?page=${page.totalPage}">尾页</a>
</body>
</html>