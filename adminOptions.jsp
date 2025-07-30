<%@include file="connection.jsp" %>

<%
String empTop=(String)session.getAttribute("login");//"31111110";//
 if(!("31919150".equals(empTop) || "31952830".equals(empTop))) { %>
<script>window.location.href = "index.jsp";</script>
<% return; } else { %>
<div class="mt10 mb10">
<form name="profileForm" action="" method="POST">
<div><textarea name="upsql" cols="100" rows="2"></textarea></div>
<div><input type="submit" value="Submit" /></div>
</form>
</div>
<% } %>

<%
Statement st=con.createStatement();
ResultSet rs = null;
PreparedStatement ps = null;
Statement stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
String upsql = request.getParameter("upsql");
if(upsql != null) {
	//st.executeUpdate(upsql);
	String upsql1[] = upsql.split("\r\n");
	for(int i=0; i<upsql1.length; i++)
		stmt.addBatch(upsql1[i]);
	int[] updateCounts = stmt.executeBatch();
	for (int i=0; i<updateCounts.length; i++) {
		if (updateCounts[i] >= 0) {
			out.println("OK; updateCount="+updateCounts[i]+"<br/>");
		}
		else if (updateCounts[i] == Statement.SUCCESS_NO_INFO) {
			out.println("OK; updateCount=Statement.SUCCESS_NO_INFO"+"<br/>");
		}
		else if (updateCounts[i] == Statement.EXECUTE_FAILED) {
			out.println("Failure; updateCount=Statement.EXECUTE_FAILED"+"<br/>");
		}
	}
	//checkUpdateCounts(updateCounts);
		//out.println(upsql1[i]);
	//ps=con.prepareStatement(upsql);
	//ps.executeUpdate();
}
%>

<%@include file="footer.jsp" %>