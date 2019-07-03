<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>申请新版块/申请成为板块管理员</title>
<link rel="stylesheet" href="style_home.css" type="text/css" />
</head>
<body>
 <div class="nav">
 	  <a href="accountCenter">返回个人中心</a>
 	
 </div>
 <div class="post">
     <h3 class="post a reply">申请板块</h3>
     <form action="applyNewboard" name="applyBoard">
        <input type="text" name="boardname" value="板块名">
        <textarea name="boardreason" style="width:200px;height:50px;">申请理由</textarea>
        <input type="submit">提交申请</input>
    </form>
    
 
 </div>
 <h3 class="post a reply">申请成为板块管理员</h3>
 <form action="applyforAdmin" name="applyBoard">
 	<select name="boardname">
 	 	<c:forEach items="${AllBoard}" var="AllBoard">
 	 		<option value="${AllBoard.boardname }">${AllBoard.boardname }</option>
		</c:forEach>
	</select>
    <textarea name="applyreason" style="width:200px;height:50px;">申请理由</textarea>
    <input type="submit">提交申请</input>
</form>
<h3 class="post a reply">已提交申请的审核状态</h3>
<table border="1">
        <th>申请类别</th>
        <th>申请时间</th>
        <th>审核状态</th>
        <c:forEach items="${admined}" var="admin" varStatus="loop">
        	<tr>
 	 			<td>申请成为${boardnames.get(loop.count-1) }板块管理员</td>
            	<td>${admin.applytime }</td>
            	<c:if test="${admin.ishandle == 0}">
            		<td>待处理</td>
            	</c:if>
            	<c:if test="${admin.ishandle == 1}">
            		<td>通过</td>
            	</c:if>
            	<c:if test="${admin.ishandle == 2}">
            		<td>驳回</td>
            	</c:if>
 	 		</tr>
		</c:forEach>
        <c:forEach items="${boarded}" var="board">
        	<tr>
 	 			<td>申请${board.boardname }板块</td>
            	<td>${board.applytime }</td>
            	<c:if test="${board.ishandle == 0}">
            		<td>待处理</td>
            	</c:if>
            	<c:if test="${board.ishandle == 1}">
            		<td>通过</td>
            	</c:if>
            	<c:if test="${board.ishandle == 2}">
            		<td>驳回</td>
            	</c:if>
 	 		</tr>
		</c:forEach>
    </table>

</body>
</html>