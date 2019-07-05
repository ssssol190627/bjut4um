<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>封禁和删除帖子</title>
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script> 
	  	<style> 
		.accountCentercontainer{ font-size:14px} 
		.table-responsive{
  			vertical-align:middle;
  			text-align:center; 
  			vertical-align:middle;
  			padding:10px 10px 10px 10px;
  		}
	</style>
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
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  		<ul class="navbar-nav">
    		<li class="nav-item active">
    			<c:if test = "${CurrentUser.isForumAdmin == 1}">
					<a class="nav-link" href="superAdmin">返回</a>
				</c:if>
				<c:if test = "${CurrentUser.isForumAdmin != 1}">
					<a class="nav-link" href="boardAdmin">返回</a>
				</c:if>
    		</li>
  		</ul>
	</nav>
	<div class="table-responsive">
	<form action="/testdb/banAndDelete">
		帖子关键词：
		<input type="text" name="searchPostByKeyWord" placeholder="searchPostByKeyWord"class="inputtable" style="padding-left;padding-right;margin-left;margin-right;width:90%" >
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<div id="context1" style="background-color:white; border: 1px solid red;width:128px;display:none" ></div>
	</div>
	<h3 class="footer">搜索结果</h3>
	<div class="table-responsive">
	<table class="table table-hover">
		<thead>
   			<tr>
		       	<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否封禁或删除</th>
   			</tr>
		</thead>
		<tbody>
						<c:forEach items="${searchedPost}" var="searchedPost" varStatus="loop">
			<tr>
				<td id="board${sboardNameList.get(loop.count-1) }">${sboardNameList.get(loop.count-1) }</td>
				<td id="title${searchedPost.title }"><a href="  /testdb/post/${searchedPost.postid}">${searchedPost.title }</a></td>
				<td id="content${searchedPost.postcontent }">${searchedPost.postcontent }</td>
				<td id="user${suserNameList.get(loop.count-1) }">${suserNameList.get(loop.count-1) }</td>
				<td>
					<form action="/testdb/banAndDelete" method="post">
			<input type="radio" name="isBanned" value="${searchedPost.postid}">
			封禁<br>
			<input type="radio" name="isDeleted" value="${searchedPost.postid}">
			删除<br>
		    <input type="text" name="bdReason" value="bdReason">
			<br>
			<input type="submit" name="submit" value="确定">
			<br>
			</form>

				</td>
		</c:forEach>
		</tbody> 
	</table>
	</div>

	
</body>
</html>