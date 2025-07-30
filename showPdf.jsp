<%@ include file = "storepath.jsp"%>



<!DOCTYPE html>
<html>
<head>
<script type='text/javascript'
  src='http://code.jquery.com/jquery-1.10.1.js'></script>
<script type='text/javascript'>
$(window).load(function(){
	$("#sample")[0].click()
});
</script>
</head>
<%
String newLocn  = "180807092052.pdf";
%>
<body onload=' location.href="#<%=newLocn%>" '>

  <a href= "<%=newLocn%>" id="sample"></a>
</body>
</html>