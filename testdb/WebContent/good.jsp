<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<title>加/去精</title>
	<script src="${pageContext.request.contextPath }/js/jquery-3.4.1.min.js"></script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".inputtable").keydown(function(){
			    $(".inputtable").css("background-color","#FFFFCC");
			  });
			$(".inputtable").keyup(function(){
				$(".inputtable").css("background-color","#D6D6FF");
				var content=$(this).val();
			  	//如果当前搜索内容为空，无须进行查询
			  	if(content==""){
			      	$("#context1").css("display","none");
			      	return ;
			  	}
			  	//由于浏览器的缓存机制 所以我们每次传入一个时间
			  	var time=new Date().getTime();
			  	$.ajax({
			      	type:"get",
			      	//新建一个名为findBooksAjaxServlet的servlet
			      	url:"/testdb/findPostsAjaxServlet",
			      	data:{name:content,time:time},
			      	success:function(data){
				        //拼接html
				        var res=data.split(",");
				        var html="";
				        for(var i=0;i<res.length;i++){
				        	 //每一个div还有鼠标移出、移入点击事件
				         	  html+="<div onclick='setSearch_onclick(this)' onmouseout='changeBackColor_out(this)' onmouseover='changeBackColor_over(this)'>"+res[i]+"</div>";
				      	}
				       	$("#context1").html(html);
				        //显示为块级元素
				       	$("#context1").css("display","block");
			      	}
			  });
			});
		});
		//鼠标移动到内容上
	 	function changeBackColor_over(div){
	     	$(div).css("background-color","#CCCCCC");
	 	}
	 	//鼠标离开内容
	 	function changeBackColor_out(div){
	     	$(div).css("background-color","");
		 }
	 	//将点击的内容放到搜索框
	 	function setSearch_onclick(div){
	     	$(".inputtable").val(div.innerText);
	    	 $("#context1").css("display","none");
	 	}
	</script>
	<div class="nav">
		<a href="boardAdmin.jsp">返回</a>
	</div>
	<form action="/testdb/good">
		<br>帖子关键词：<br>
		<input type="text" name="searchPostByKeyWord" placeholder="searchPostByKeyWord" class="inputtable" >
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<div id="context1" style="background-color:white; border: 1px solid red;width:128px;display:none" ></div>


	<table border="1">
		<tr>
			<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否加精</th>
		</tr>
		<c:forEach items="${searchedPost}" var="searchedPost" varStatus="loop">
			<tr>
				<td id="board${sboardNameList.get(loop.count-1) }">${sboardNameList.get(loop.count-1) }</td>
				<td id="title${searchedPost.title }"><a href="  /testdb/post/${searchedPost.postid}">${searchedPost.title }</a></td>
				<td id="content${searchedPost.postcontent }">${searchedPost.postcontent }</td>
				<td id="user${suserNameList.get(loop.count-1) }">${suserNameList.get(loop.count-1) }</td>
				<td>
					<form action="/testdb/good" method="post">
						<input type="hidden" name="isGoodNow" value="${searchedPost.postid}">
						<input type="submit" name="submit" value="加精"> <br>
					</form>
				</td>
		</c:forEach>
	</table>
	<br>

	<table border="1">
		<caption align="top">已加精列表</caption>
		<tr>
			<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否去精</th>
		</tr>
		<c:forEach items="${goodPost}" var="goodPost" varStatus="loop">
			<tr>
				<td id="board${boardNameList.get(loop.count-1) }">${boardNameList.get(loop.count-1) }</td>
				<td id="title${goodPost.title }"><a href="  /testdb/post/${goodPost.postid}">${goodPost.title }</a></td>
				<td id="content${goodPost.postcontent }">${goodPost.postcontent }</td>
				<td id="user${userNameList.get(loop.count-1) }">${userNameList.get(loop.count-1) }</td>
				<td>
					<form action="/testdb/good" method="post">
						<input type="hidden" name="isNotGoodAnymore" value="${goodPost.postid}">
						<input type="submit" name="submit" value="去精"> <br>
					</form>
				</td>
		</c:forEach>


	</table>
</body>
</html>