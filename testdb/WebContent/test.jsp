<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script type="text/javascript">
function f1(){
	
	return this.m_name;
}
function TestObject(name){
	this.m_name=name;
	this.f1=f1;
	this.f2=function(){
		document.write("this.f2() <br>");
	}
}
TestObject.prototype.ShowName=function(){
	document.write(this.m_name);
}
</script>

<title>Insert title here</title>
</head>
<body>
<script language="text/javascript">
a=new TestObject("Obj a");
b=new TestObject("Obj b");
a.ShowName();
b.ShowName();
document.write(a.f1==b.f1);
document.write(a.f2==b.f2);
document.write(a.ShowName==b.ShowName);
</script>
</body>
</html>