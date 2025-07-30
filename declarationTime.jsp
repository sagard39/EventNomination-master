<%@include file="connection.jsp" %>

<%
String empno=(String)session.getAttribute("login");
String output="";
String eno1=request.getParameter("eno");
String query="update nm_marathon set declaration_date=sysdate,declaration_status='Y' where updaetd_by=?";
PreparedStatement ps=con.prepareStatement(query);
ps.setString(1,eno1);
if(empno==null) {
	output = "{'status':'error','message':'Session expired. Please login again.'}";
} else {

ps.executeUpdate();
output = "{'status':'success'}";
}
output = output.replaceAll("'","\"");
out.println(output);
out.flush();
if(ps != null)
	ps.close();
if(con != null)
	con.close();
%>