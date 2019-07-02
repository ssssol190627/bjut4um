<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>申请新版块/申请成为板块管理员</title>
<link rel="stylesheet" href="style_home.css" type="text/css" />
<SCRIPT language=javascript>
	//function go()
	//{
	//window.history.go(-1);
	//}
	//setTimeout("go()",3000);
</SCRIPT>
</head>
<body>
 <div class="nav">
 	  <a href="accountCenter.jsp">返回个人中心</a>
 	
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
 <form action="userPreference.jsp" name="applyBoard">
 	<select name="boardname">
		<option value="情感天地">情感天地</option>
		<option value="荒野求生">荒野求生</option>
		<option value="工大学习">工大学习</option>
		<option value="工大生活">工大生活</option>
	</select>
    <textarea name="a" style="width:200px;height:50px;">申请理由</textarea>
    <input type="submit">提交申请</input>
</form>
<h3 class="post a reply">已提交申请的审核状态</h3>
<table border="1">
        <th>申请类别</th>
        <th>申请时间</th>
        <th>审核状态</th>
        <tr>
            <td>申请身为娱乐板块管理员</td>
            <td>2019-06-30</td>
            <td>通过</td>
        </tr>
        <tr>
            <td>申请读书板块</td>
            <td>2019-06-30</td>
            <td>请等待</td>
        </tr>
    </table>

</body>
</html>