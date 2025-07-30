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
<script>
function delrec(r,a){
	location.replace('mynomination.jsp?eventname='+r+'&emp='+a);
}
function editrec(evtnme,emp) {

    location.replace('editmain.jsp?eventname='+evtnme+'&emp='+emp);
}
</script>
<script>
function validation(){
	var evtnme = document.getElementById("evtnme").value;
	if("" == evtnme){
		alert("Enter Event Name");
		return false;
	} 
	var evtplace = document.getElementById("evtplace").value;
	if("" == evtplace){
		alert("Select Event Place");
		return false;
	}
	var cutofdte = document.getElementById("cutofdte").value;
	if("" == cutofdte){
		alert("Select Date");
		return false;
	}
	var priceevt = document.getElementById("priceevt").value;
	if("" == priceevt || "0" == priceevt ||"0.0" == priceevt){
		alert("Total Payment cannot be 0");
		return false;
	}
	var nooftickts = document.getElementById("nooftickts").value;
	if("" == nooftickts || "0" == nooftickts ||"0.0" == nooftickts){
		alert("No. of Tickets cannot be 0");
		return false;
	}
	
}
</script>
<script>
  function formsubmit(frmname) {
	  $("form[name='"+frmname+"']").submit();
}
</script>
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
		<div>
	<div class="mb10">
	<div class="" style="margin-left:10%">
		<div class="fl mr10"><h4>Your Nominations</h4></div>
		<div class="clear"></div>
	</div>
	<div id="hist_table" class="">
		<div class="datagrid">
		<center>
<table id="tab1" style="width:70%">
<thead style="background-color:#658DB5"><tr><th style="width:50%">Event Name</th><th>No. of tickets required </th><th>Boarding point</th><th>Payment</th><th style="width:10%"></th></thead>
</tr>
<tbody>
		<%
		String dbempno ="",dbnoofticks ="",dbboardpnt ="",dbtotalpaymnt ="",dbsysdte ="",
		dbeventname ="",eventname="",dbcutofdte="",query1="";
		PreparedStatement pmstselqry =null,pmstselqry1=null;
		PreparedStatement pmst_nD=null;
		if(request.getParameter("eventname") != null){
			dbempno = request.getParameter("emp");
			eventname = request.getParameter("eventname");
			pmstselqry = con.prepareStatement("delete from nomination where EMP_NO=? and EVTNME=?");
			pmstselqry.setString(1,dbempno);
			pmstselqry.setString(2,eventname);
			int flag = pmstselqry.executeUpdate();
			query1="delete from nomination_dependents where emp_no=? and event_name=?";
			pmstselqry1=con.prepareStatement(query1);
			pmstselqry1.setString(1,dbempno);
			pmstselqry1.setString(2,eventname);
			int flag1=pmstselqry1.executeUpdate();
		if(flag >0){%>
			<script>alert("Nomination Deleted");
			location.href="mynomination.jsp";</script>
			<%} else{
				%>
			<script>alert("Error");
			location.href="mynomination.jsp";</script>
			<%}
		}
		Double dbpaymnt =0.0;
		int cnt= 0;
		pmstselqry = con.prepareStatement("SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.EVTNME,to_char(a.CUTOFDTE,'dd-Mon-yyyy') FROM NOMINATION N LEFT JOIN  NOMINATION_ADMIN A  ON  N.EVTNME = A.EVTNME WHERE N.EMP_NO =?  and (N.flag<>'X' or N.flag is null)");
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
			dbeventname = rs.getString(7);
			dbcutofdte = rs.getString(8); if(dbcutofdte == null){dbcutofdte = "";}
			eventname = dbeventname;
			cnt++;
%>
	<tr>
	<td><%=dbeventname%></td>
	<td><%=dbnoofticks%></td>
	<td><%=dbboardpnt%></td>
	<td><%=dbpaymnt%></td>
	<%if(!(("Bahubali2 (KSTAR MALL) 06-May-2017 1730 HRS").equals(dbeventname)) || (("Bahubali2 (KSTAR MALL) 06-May-2017 1830 HRS").equals(dbeventname)) || (("Bahubali2 (KSTAR MALL) 07-May-2017 1130 HRS").equals(dbeventname)) || (("Bahubali2 (IMAX WADALA) 07-May-2017 1115 HRS").equals(dbeventname))){%><td>
		<%
		if(!"".equals(dbcutofdte)){
		SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
		Date currentdte =new Date();
		Date dbdate = new Date(dbcutofdte);
		String currentdteval = fmt.format(currentdte);
		
		%>
		<% if(currentdte.before(dbdate) || currentdteval.equals(dbcutofdte)){%>
	<!--<img src="images/edit.png" style="width:30%;height:auto;cursor:pointer" onclick="editrec('<%=dbeventname%>','<%=dbempno%>')" >-->
			<img src="images/clear.png" style="width:30%;height:auto;cursor:pointer" onclick="formsubmit('formdel<%=cnt%>');">
				<% }if("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(dbeventname)){%>
					<a href="event_edit.jsp"><img src="images/edit.png" style="width:30%;height:auto;cursor:pointer" ></a>
				<%}%>
		
		<%} %>
	<form name="formdel<%=cnt%>" action="delevent.jsp" method="post">
	<!--<img src="images/clear.png" style="width:30%;height:auto;cursor:pointer" onclick="formsubmit('formdel<%=cnt%>');">-->
	<input type="hidden" name="evtplace" id="evtplace" value="<%=dbeventname%>">
	<input type="hidden" name="dbempno" id="dbempno" value="<%=dbempno%>">
		</form>
	</td><%}else{%>
	<td>
	</td><%}%>
	</tr>
	  <%}%>
</tbody>
</table>
</center>
</div>
</div>
</div>
</div>
</body>

</html>
<%@include file="footer.jsp"%>
