<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<title>管理举报信息</title>
	<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script> 
  	<style> 
		.accountCentercontainer{ font-size:14px} 
		.table-responsive{
  			margin:0px 0px 0px 0px;
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
				<a class="nav-link" href="superAdmin.jsp">返回</a>
    		</li>
  		</ul>
	</nav>

	<h3 class="footer">板块申请信息</h3>
	<div class="table-responsive">
	<table class="table table-hover">
		<thead>
   			<tr>
		       	 <th>板块名</th>
				<th>申请人</th>
				<th>申请理由</th>
				<th>申请时间</th>
				<th>是否通过</th>
   			</tr>
		</thead>
		<tbody>
		<c:forEach items="${applyboards}" var="applyboard" varStatus="loop">
		<tr>
		    <td>${applyboard.boardname }</td>
		    <td>${username.get(loop.count-1) }</td>
		    <td>${applyboard.applyingreason }</td>
		    <td>${applyboard.applytime }</td>
		    <c:if test = "${applyboard.ishandle == 0 }">
		    	<td>
					<form action="manageApplyboard">
						<input type="radio" name="newBoard" value="newBoard">通过<br>
						<input type="submit" name="submit" value="确定">
					<br>
					</form>
				</td>
			</c:if>
			<c:if test = "${applyboard.ishandle == 1 }">
				<td>已通过</td>
			</c:if>
   		</tr>
    </c:forEach>
		</tbody> 
	</table>
</div>

	<h3 class="footer">板块管理员申请信息</h3>
	<div class="table-responsive">
	<table class="table table-hover">
		<thead>
   			<tr>
		      <th>板块名</th>
		<th>申请人</th>
		<th>申请理由</th>
		<th>申请时间</th>
		<th>是否通过</th>
   			</tr>
		</thead>
		<tbody>
	<c:forEach items="${applyadmins}" var="applyadmin" varStatus="loop">
		<tr>
		    <td>${boardname.get(loop.count-1) }</td>
		    <td>${username2.get(loop.count-1) }</td>
		    <td>${applyadmin.applyingreason }</td>
		    <td>${applyadmin.applytime }</td>
		    <c:if test = "${applyadmin.ishandle == 0 }">
		    	<td>
					<form action="boardAdmin.jsp">
						<input type="radio" name="newBoardAdministrator" value="newBoardAdministrator">
							通过<br>
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
		</tbody> 
	</table>
</div>
</body>
</html>