<%@ include file="connection.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

 <%@ page language="java" import="java.sql.*,java.text.*,java.util.*,java.math.*" %>
    <%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource " %>
    <%@ page import="java.io.*, java.lang.*, java.net.*" %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.util.Hashtable,javax.naming.ldap.*,javax.naming.directory.*,javax.naming.*,java.util.Calendar,java.sql.Date.*,java.text.SimpleDateFormat" %>
   <html>


<HTML>        

<form method="POST" action="" name="FrontPage_Form1">
<%
		String login = request.getParameter("empno");
		String login1 =(String)session.getValue("login");
		if(request.getParameter("empno")!=null){
			session.putValue("login",login);
		}
       	
%>
 <script language="Javascript">
    document.location.href = "main.jsp"
</script>

<% %>

 </form>
</HTML>

 



 

