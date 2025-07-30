<%@include file="header.jsp"%>
<style>
.tab2{
	margin:10% 20% 2% 30%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
}
.tab2 td{
	padding:2% 0%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#fff;
}
.tab2 tr:nth-child(odd){
	background:#ebf1fa ;
}
</style>
<script>
function formsubmit(a){
	document.getElementById(a).submit();
}
</script>
<table class="tab2">
<tr><th>#</th><th>Event Name</th></tr>
		<%
		PreparedStatement pmstsel = null;
		String temptwn = "", evtnme = "";
		String rep = "";
		if(request.getParameter("rep")!=null){
			rep = request.getParameter("rep");
		}
		int cnt = 0;
		pmstsel = con.prepareStatement("select distinct evtnme from nomination_admin");
		rs = pmstsel.executeQuery();
		while(rs.next()){
			evtnme = rs.getString(1);
			cnt++;
		%>
			<tr><td><%=cnt%></td><td><form name="form<%=cnt%>" id="form<%=cnt%>" method="post" action="viewreports.jsp"><a href="#" onclick="formsubmit('form<%=cnt%>')"><%=evtnme%></a>
			<input type="hidden" name="rep" id="rep" value="<%=rep%>">
			<input type="hidden" name="evtnme" id="evtnme" value="<%=evtnme%>">
			</form></td></tr>
		<%}
		%>
</body>

</html>