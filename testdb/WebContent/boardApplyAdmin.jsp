<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
	<div class="nav">
		<a href="superAdmin.jsp">返回</a>
	</div>
	<table border="1">
	<caption align="top">板块申请信息列表</caption>
	<tr>
	    <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
	</tr>
	<c:forEach items="${applyboards}" var="applyboard" varStatus="loop">
		<tr>
		    <td>${applyboard.boardname }</td>
		    <td>${username.get(loop.count-1) }</td>
		    <td>${applyboard.applyingreason }</td>
		    <td>${applyboard.applytime }</td>
		    <c:if test = "${applyboard.ishandle == 0 }">
		    	<td>
					<form action="manageApplyboard">
						<input type="radio" name="newBoard" value="allow">通过<br>
						<input type="radio" name="newBoard" value="refuse">驳回<br>
						<input type="hidden" name="applyid" value="${applyboard.applyingid }" />   
						<input type="submit" name="submit" value="确定">
					<br>
					</form>
				</td>
			</c:if>
			<c:if test = "${applyboard.ishandle == 1 }">
				<td>已通过</td>
			</c:if>
			<c:if test = "${applyboard.ishandle == 2 }">
				<td>已驳回</td>
			</c:if>
   		</tr>
    </c:forEach>
	</table>
	<table border="1">
	<caption align="top">板块管理员申请信息列表</caption>
	<tr>
	    <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
	</tr>
	<c:forEach items="${applyadmins}" var="applyadmin" varStatus="loop">
		<tr>
		    <td>${boardname.get(loop.count-1) }</td>
		    <td>${username2.get(loop.count-1) }</td>
		    <td>${applyadmin.applyingreason }</td>
		    <td>${applyadmin.applytime }</td>
		    <c:if test = "${applyadmin.ishandle == 0 }">
		    	<td>
					<form action="manageApplyAdmin">
						<input type="radio" name="newAdmin" value="allow">通过<br>
						<input type="radio" name="newAdmin" value="refuse">驳回<br>
						<input type="hidden" name="applyid" value="${applyadmin.applyingid }" />   
						<input type="submit" name="submit" value="确定">
						<br>
					</form>
				</td>
			</c:if>
			<c:if test = "${applyadmin.ishandle == 1 }">
				<td>已通过</td>
			</c:if>
   		</tr>
    </c:forEach>
	</table>
</body>
</html>