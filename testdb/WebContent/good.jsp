<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/css/style_home.css" type="text/css" />
	<title>加精</title>
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
	<form action="boardAdmin.jsp">
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
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>工大小锤</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="isGood" value="isGood">
			是<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
	<form action="boardAdmin.jsp">
		<br>帖子关键词：<br>
		<input type="text" name="searchGoodPostByKeyWord" value="searchGoodPostByKeyWord">
		<input type="submit" name="submit" value="搜索">
		<br>
	</form>
	<table border="1">
	<caption align="top">已加精列表</caption>
	<tr>
	    <th>所属板块</th>
		<th>帖子标题</th>
		<th>帖子内容</th>
		<th>发帖人</th>
		<th>加精时间</th>
		<th>是否去精</th>
	</tr>
	<tr>
		<td>工大生活</td>
		<td>食堂美食汇总</td>
		<td>rt！</td>
		<th>工大小锤</th>
		<th>2019/06/20 23:05:07</th>
		<th>
		<form action="boardAdmin.jsp">
			<input type="radio" name="isNotGoodAnymore" value="isNotGoodAnymore">
			去精<br>
			<input type="submit" name="submit" value="确定">
			<br>
		</form>
		</th>
	</tr>
	</table>
</body>
</html>