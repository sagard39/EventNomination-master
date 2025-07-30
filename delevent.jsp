<%@include file="header.jsp"%>
<style>
.tab2{
	margin:10% 0% 1% 15%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width: 70%;
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
#tab1{
	 border-collapse: collapse;
}
#tab1 th{
	 border:1px solid #000;
}
</style>


<link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" />
<!-- main calendar program -->
  <script type="text/javascript" src="js/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="js/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="js/calendar-setup.js"></script>

		<%
		
		PreparedStatement pmstins = null;
		PreparedStatement pmst_nD=null;
		if(request.getParameter("del") != null){
			pmstins = con.prepareStatement("delete from nomination_admin where EVTNME=? and EVTPLACE=?");
			String delval = request.getParameter("del");
			String twnval = request.getParameter("twn");
			pmstins.setString(1,delval);
			pmstins.setString(2,twnval);
			
		}
		if(request.getParameter("evtplace") != null){
			pmstins = con.prepareStatement("update  nomination set flag='X' where EMP_NO=? and EVTNME=?");
			String evtplace = request.getParameter("evtplace");
			String dbempno = request.getParameter("dbempno");
			pmstins.setString(1,dbempno);
			pmstins.setString(2,evtplace);
		}
			int ins=pmstins.executeUpdate();
			pmst_nD=con.prepareStatement("delete from nomination_dependents where emp_no=? and event_name=? ");
				pmst_nD.setString(1,request.getParameter("dbempno"));
				pmst_nD.setString(2,request.getParameter("evtplace"));
			int flag1=pmst_nD.executeUpdate();
			if(ins>0){
				%>
				<script>
				alert("Record Deleted Successfully..");
				location.href="main.jsp"
				</script>
			<%	
			} else {
				%>
				<script>
				alert("Error Occured....");
				location.href="main.jsp"
				</script>
			<%
			}
		
		
		%>
</body>

</html>
<%@include file="footer.jsp"%>