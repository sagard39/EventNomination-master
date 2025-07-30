<%@include file="header1.jsp"%>
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
		PreparedStatement pmstsel = null;
		String towncode = "";
		pmstsel = con.prepareStatement("select distinct town from empmaster where town is not null order by 1");
		%>
		
	<div class="container " style="min-height: 488px; ">
	<div class="card md-10 box shadow">
	
		<div class="card-header alert alert-primary  style-app-name"><h5 class="text-white">Your Nominations(Cancelled)</h5></div>
		<div class="card-body table responsive">
<table  class="table table-hover table-bordered listTable">
<thead class ="alert alert-success"><tr><th style="width:50%">Event Name</th><th>No. of tickets required </th><th>Boarding point</th><th>Payment</th></thead>
</tr>
<tbody>
		<%
		String dbempno ="",dbnoofticks ="",dbboardpnt ="",dbtotalpaymnt ="",dbsysdte ="",
		dbeventname ="",eventname="",dbcutofdte="";
		PreparedStatement pmstselqry =null;
		Double dbpaymnt =0.0;
		int cnt= 0;
		pmstselqry = con.prepareStatement("SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.EVTNME,to_char(a.CUTOFDTE,'dd-Mon-yyyy'),a.evtnme evtname FROM NOMINATION N LEFT JOIN  NOMINATION_ADMIN A  ON  N.EVTNME = A.EVT_id WHERE N.EMP_NO =? and n.flag ='X'");
		pmstselqry.setString(1,emp);
		rs = pmstselqry.executeQuery();
		while(rs.next()){
			dbempno = rs.getString(1);
			emp = dbempno;
			dbnoofticks = rs.getString(2); if(dbnoofticks == null){dbnoofticks = "";}
			dbboardpnt = rs.getString(3);
			dbtotalpaymnt = rs.getString(4);if(dbtotalpaymnt == null){dbtotalpaymnt = "0";}
			dbpaymnt = Double.parseDouble(dbtotalpaymnt);
			dbsysdte = rs.getString(5);
			dbeventname = rs.getString("evtname");
			dbcutofdte = rs.getString(8); if(dbcutofdte == null){dbcutofdte = "";}
			eventname = dbeventname;
			cnt++;
%>
	<tr>
	<td><%=dbeventname%></td>
	<td><%=dbnoofticks%></td>
	<td><%=dbboardpnt%></td>
	<td><%=dbpaymnt%></td>
	</tr>
	  <%}%>
</tbody>
</table>
</div>
</div>

</div>
<!-- .masthead -->



</html>
<%@include file="footer.jsp"%>