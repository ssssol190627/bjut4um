<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>加精</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  	
  	<link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">
    <!-- Bootstrap core CSS -->
    <link href="https://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!-- Custom styles for this template -->
	<link rel="stylesheet" href="https://getbootstrap.com/docs/4.1/examples/offcanvas/offcanvas.css" type="text/css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<link rel="stylesheet" href="style_home.css" type="text/css" />
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
		      			<c:if test ="${CurrentUser.isBoardAdmin !=0 }">
	          				<li class="nav-item">
	            				<a class="nav-link" href="boardAdmin">返回管理板块</a>
	          				</li> 
	          			</c:if>
	          			<c:if test ="${CurrentUser.isForumAdmin !=0 }">	          		
		          			<li class="nav-item">
		            			<a class="nav-link" href="superAdmin.jsp">返回管理论坛</a>
		          			</li>
	          			</c:if>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/home1">主页</a>
	     				</li>
		      			<li class="nav-item">
	       					<a class="nav-link" href="/testdb/accountCenter">个人中心</a>
	     				</li>

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
	<c:if test="${CurrentUser.isBoardAdmin != 0 || CurrentUser.isForumAdmin == 1 }">
	<div class="table-responsive">
	<form action="/testdb/good">
		帖子关键词：
		<input type="text" name="searchPostByKeyWord" placeholder="searchPostByKeyWord" class="inputtable" style="padding-left;padding-right;margin-left;margin-right;width:90%">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<div id="context1" style="background-color:white; border: 1px solid red;width:128px;display:none" ></div>
	</div>

	<h3 class="footer">搜索结果</h3>
	<div class="table-responsive">
	<table class="table table-hover table-bordered">
		<thead>
   			<tr>
		       	<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否加精</th>
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
					<form action="/testdb/good" method="post">
						<input type="hidden" name="isGoodNow" value="${searchedPost.postid}">
						<input type="submit" name="submit" value="加精"> <br>
					</form>
				</td>
		</c:forEach>
		</tbody> 
	</table>
	</div>
	
	<h3 class="footer">已加精列表</h3>
	<div class="table-responsive">
	<table class="table table-hover table-bordered">
		<thead>
   			<tr>
		       	<th>所属板块</th>
			<th>帖子标题</th>
			<th>帖子内容</th>
			<th>发帖人</th>
			<th>是否去精</th>
   			</tr>
		</thead>
		<tbody>
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
		</tbody> 
	</table>
	</div>
	</c:if>
	<c:if test="${CurrentUser.isBoardAdmin == 0  && CurrentUser.isForumAdmin ==0 }">
		<font color="red">您没有权限访问此页面，您可以</font>
		<a href="/testdb/applyBoard">申请成为板块管理员</a>
	</c:if>
	<h6 class="footer">© www.bjut4um.cn</h6>
	    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="https://getbootstrap.com/docs/4.0/assets/js/vendor/popper.min.js"></script>
    <script src="https://getbootstrap.com/docs/4.0/dist/js/bootstrap.min.js"></script>
</body>
</html>