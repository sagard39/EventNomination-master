<html>
<head></head>
<body>
<%

String empno=request.getParameter("emp_no");
if(empno != null) {
	session.putValue("empno",empno);
	response.sendRedirect("cricket.jsp");
}
%>
<form method="post" action="" name="forms">
<input type="text" name="emp_no">
<input type="submit" value="Enter">
</form>
</body>
</html>