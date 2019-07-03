<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>站内信息</title>
</head>
<body>
	<div class="nav">
		<a href="accountCenter.jsp">个人中心</a>
	</div>
	<div>
		<c:if test="${CurrentUser.isExist == 0 }">
			<p>您的账户被封禁了1小时</p>
		</c:if>
		<c:forEach items="${usermessages}" var="usermessage" >
			<br>
        	${usermessage.messagecontent }${usermessage.messagetime }
        	<br>
        </c:forEach> 
	</div>
</body>
</html>