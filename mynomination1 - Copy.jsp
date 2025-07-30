<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
<%@include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
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
function DelEntry(evt_id){
	if(!confirm("Do you really want to delete the Entry ? After submission ,you won't be able to modify the data"))
		return false;
	else {	
		document.form1.action_type.value=evt_id;
		document.form1.submit();
	}
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
<form name="form1" action="" method="post">	<br/>	
<div class="container">
		<div class = "row">
			<p>To know how to form your team, <a target = "_blank" href="data/Team formation Know How.pdf">click here</a> 
		</div>
		<div class="card md-10 box shadow" >
		<div class="card-header alert alert-primary"><h4>My Nominations</h4></div>
		<div class="card-body table-responsive">
	
<table class="table table-bordered table-hover table-sm">
<thead class ="alert alert-success"><tr ><th style="width:30%;">Event Name</th><th style="width:10%">Tickets</th><th>Event Date</th><th>Last Date to Apply</th><th>Boarding point</th><th>Payment</th><th>Action</th><th style="width:5%">Feedback</th></tr></thead>

<tbody>
		<%
		String dbempno ="",dbnoofticks ="",dbboardpnt ="",dbtotalpaymnt ="",dbsysdte ="",dbeventname ="",eventname="",dbcutofdte="",email_str = "";
		PreparedStatement pmstselqry =null;
		PreparedStatement pmst_nD=null;
		if(request.getParameter("eventname") != null){
			dbempno = request.getParameter("emp");
			eventname = request.getParameter("eventname");
			//pmstselqry = con.prepareStatement("delete from nomination where EMP_NO=? and EVTNME=?");
			pmstselqry.setString(1,dbempno);
			pmstselqry.setString(2,eventname);
			int flag = pmstselqry.executeUpdate();
			
			if(flag > 0 ){%>
			<script>alert("Nomination Deleted");
			location.href="mynomination1.jsp";</script>
			<%} else{
				%>
			<script>alert("Error");
			location.href="mynomination.jsp";</script>
			<%}
		}
boolean isPower=false;		
String altQry="",altName="",altTicks="",altEvtDate="",altPayment="",evtFlag="";
String powerEvt="select TICKTSCNT,PAYMENTCNT,evtnme from workflow.nomination where evtnme like 'Power%' and flag is null and emp_no=?";
pmstselqry=con.prepareStatement(powerEvt);
pmstselqry.setString(1,emp);
rs=pmstselqry.executeQuery();
if(rs.next()){
	altTicks=rs.getString(1);
	altPayment=rs.getString(2);
	altName=rs.getString(3);
	isPower=true;
}
String action_type=request.getParameter("action_type");
if(action_type!=null){
	String message = "",eventNameTemp = "",ticktsCnt = "",empMail = "",ccMail = "";
	String newUpdateQry = "select distinct  a.evtnme evtnme,b.ticktscnt tickets,(select email from empmaster where emp_no =b.emp_no)  empMail,(select email from empmaster where emp_no=substr(a.adminemp,0,8)) adminMail1,(select email from empmaster where emp_no=substr(a.adminemp,10)) adminMail2,(select email from empmaster where emp_no =b.emp_no) empmail   from nomination_admin a left join nomination b on a.evt_id = b.evtnme  where b.evtnme = ? and emp_no =? and flag  = 'S'";
	PreparedStatement psUpdate= con.prepareStatement(newUpdateQry);
	psUpdate.setString(1,action_type);
	psUpdate.setString(2,emp);
	ResultSet rsUpdate = psUpdate.executeQuery();
	if(rsUpdate.next()){
		eventNameTemp = rsUpdate.getString("evtnme");
		ticktsCnt = rsUpdate.getString("tickets");
		empMail = rsUpdate.getString("empMail");
		ccMail = rsUpdate.getString("adminMail1")+","+rsUpdate.getString("adminMail2");
	}
	String query="update  nomination set flag='X',Modifydte=sysdate  where evtnme=? and emp_no=?";
	pmstselqry=con.prepareStatement(query);
	pmstselqry.setString(1,action_type);
	pmstselqry.setString(2,emp);
	int newUpdateCount = pmstselqry.executeUpdate();
	message = devMsgBody+"Your nomination for the event <b>"+eventNameTemp+"</b> for <b>"+ticktsCnt+"</b> participants is cancelled.<br/> <br/> Thank You, <br/>"+"<br/>"+ "\""+eventNameTemp+"\""+" Team";
	String subject = devMsgSub+"Event Nomination-"+eventNameTemp ;
	if(newUpdateCount>0){
		//email_str = email.gen_email_call("APP208","D", " ",message,empMail,ccMail,"",subject,request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
	}
}	
		
		Double dbpaymnt =0.0;
		int cnt= 0;
		pmstselqry = con.prepareStatement("SELECT  N.EMP_NO,N.TICKTSCNT,decode(n.boardpnt,'-1','Not Selected','2','Not Applicable',n.boardpnt) boarding_point,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,A.EVTNME EVTNAME,a.evt_id evt_id,to_char(a.CUTOFDTE,'dd-Mon-yyyy') cutoff_date,to_char(a.evt_date,'dd-Mon-yyyy') evt_date,A.EVTNME,N.flag flag FROM NOMINATION N LEFT JOIN  NOMINATION_ADMIN A  ON  N.EVTNME = A.EVT_ID WHERE a.evt_id is not null and N.EMP_NO =?  and (N.flag<>'X' or N.flag is null) order by evt_date desc");
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
			dbeventname = rs.getString("EVTNAME");
			dbcutofdte = rs.getString("cutoff_date"); if(dbcutofdte == null){dbcutofdte = "";}
			eventname = dbeventname;
			evtFlag=rs.getString("flag");
			cnt++;
			
%>
	<tr>
	<td ><%=dbeventname%></td>
	<td align="center"><%=dbnoofticks%></td>
	<td align="center"><%=rs.getString("evt_date")%>
	<td align="center"><%=rs.getString("cutoff_date")%>
	<td align="center"><%=dbboardpnt%></td>
	<td align="center"><%=dbpaymnt%></td>
	<td>
		<div>
	<%
		boolean fback=false,printTicket=false;
		if(!"".equals(dbcutofdte)){
		SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
		Date currentdte =new Date();
		Date dbdate = new Date(dbcutofdte);
		String currentdteval = fmt.format(currentdte);
		Date feedDate=new Date(rs.getString("evt_date"));
		if(currentdte.after(feedDate)){
			fback=true;
		
		}

		%>
		<% if(currentdte.before(dbdate) || currentdteval.equals(dbcutofdte)){
			if(!"2018_126_event".equals(rs.getString("evt_id"))){%>
				
				<a href="#" onclick="return DelEntry('<%=rs.getString("evt_id")%>')"><img src="images/clear.png" width="18" title="Cancel"></a>
			<%}%>	
			<%if("A".equals(rs.getString("flag"))){%>
				<a href="mainSubmit.jsp?eventId=<%=rs.getString("evt_id")%>"><img src="images/edit.png" width="18" title="Edit"></a>&nbsp;&nbsp
			<%}%>
		<% }
		}if("2018_126_event".equals(rs.getString("evt_id")))
				printTicket=true;%>
		<%if(printTicket){%>
			<a href="<%=("31976260".equals(emp)||"31976260".equals(emp))?"teamCluster":"myTeam"%>.jsp"><img src="images/redirect.jpg" title = "To Create / View Team,Click Here" width="40"></a>
		<%}%>
		</div>
	</td>
	<td align="center">
		<%if(fback){
			if(printTicket){%>
				<a href="fitFeedBack.jsp"><img src="images/feedback.png" width="50%" title="Feedback"></a>
			<%} else{%>
				<a href="feedback.jsp?evtnme=<%=rs.getString("evt_id")%>"><img src="images/feedback.png" width="50%" title="Feedback"></a>
			<%}%>
		<%}%>
	</td>	
	</tr>
		<%}%>
	<%if(isPower){%>
		<tr>
			<td align="center"><%=altName%></td>
			<td align="center"><%=altTicks%></td>
			<td align="center">05-Feb-2018</td>
			<td align="center">25-Jan-2018</td>
			<td align="center"></td>
			<td align="center"><%=altPayment%></td>
			<td align="center"></td>
			<td align="center"><a href="feedback.jsp?evtnme=<%=altName%>"><img src="images/feedback.png" width="50%" title="Feedback"></a></td>
		</tr>	
	<%}%>	
</tbody>
</table>
</div>
</div>
</div>
<input type="hidden" name="action_type" value="">
</form>
</body>

</html>
<%@include file="footer.jsp"%>