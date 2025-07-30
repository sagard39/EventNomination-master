<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
<%@ include file="header1.jsp"%>
<head>
	<style>
		div.ex3 {
			height: 400px;
			overflow: auto;
			position: relative;
		}
</style>
</head>
<script>
	function publishEvt(id){
		
	}
	window.onload = function(){
  var tableCont = document.querySelector('#show_list')
  function scrollHandle (e){
    var scrollTop = this.scrollTop;
    this.querySelector('thead').style.transform = 'translateY(' + scrollTop + 'px)';
  }
  
  tableCont.addEventListener('scroll',scrollHandle)
}
</script>
<%
String query="",evt_for="",evt_admin="",email_str = "",message="",empMail = "",evtName="",eventAdmins="",evt_created_by= "",evt_created_byMail="", admin1_email="", admin2_email="", toMail="", ccMail="", bccMail="", subjectMail = "";
PreparedStatement ps=null;
ResultSet rsPub=null;
String evt_id=request.getParameter("id");
String evt_act=request.getParameter("q");
int intVal=0;
if(evt_id!=null && "e".equals(evt_act)){
	query="update nomination_admin set status='P' where evt_id=?";
	ps=con.prepareStatement(query);
	ps.setString(1,evt_id);
	intVal=ps.executeUpdate();
	
	if(intVal>0){	
		ps = con.prepareStatement("select evtnme,ADMINEMP,EVT_CREATED_BY  from nomination_Admin where evt_id = ?");
		ps.setString(1,evt_id);
		rsPub = ps.executeQuery();
		if(rsPub.next())
			evtName = rsPub.getString("evtnme");

//---------Added by Prajakta for Event publish mail------------

			eventAdmins = rsPub.getString("ADMINEMP");
			evt_created_by = rsPub.getString("EVT_CREATED_BY");
			message = "Event "+evtName+" has been published.";
				empMail = publishMail;
				//empMail = "prajakta26297@gmail.com";
				String[] adminArr = eventAdmins.split(",");
				PreparedStatement psEmpMail=null;
				psEmpMail = con.prepareStatement("select emp_no,email from empmaster where emp_no=?");
				ResultSet rsEmpMail = null;
				for (int i = 0; i < adminArr.length; i++) {
				psEmpMail.setString(1, adminArr[i]);
				rsEmpMail = psEmpMail.executeQuery();
				if (rsEmpMail.next()) {
					if (i == 0) {
						admin1_email = rsEmpMail.getString("email");
						//out.println(admin1_email);
					} else if (i == 1) {
						admin2_email = rsEmpMail.getString("email");
						//out.println(admin1_email);
					}
				}
			}

				psEmpMail = con.prepareStatement("select emp_no,email from empmaster where emp_no=?");
				psEmpMail.setString(1, evt_created_by);
				rsEmpMail = psEmpMail.executeQuery();
				if (rsEmpMail.next()) {
					evt_created_byMail = rsEmpMail.getString("email");
				}
			subjectMail= "Event Nomination-"+evtName;

			/*message=message+"  toMail=  "+admin1_email;
			toMail="prajakta26297@gmail.com";

			message=message+"  ccMail=  "+admin2_email+", "+evt_created_byMail;
			ccMail="prajakta26297@gmail.com";

			message=message+" bccMail= "+"Vivekt@hpcl.in "+" tanu.sharma@hpcl.in";
			bccMail="prajakta26297@gmail.com";
			*//////dev
			
				email_str = email.gen_email_call("APP208","D", " ",message,toMail,ccMail,bccMail,subjectMail,request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());

			}
}

//---------End by Prajakta for Event publish mail------------


if(isDefAdmin)
	query="select evt_id,evtnme,evtplace,to_char(evt_date,'dd-Mon-yyyy') evt_date,adminEmp,decode(bus_facility,'Y','Yes','N','No',bus_facility) bus_req,evt_for,evt_bu from nomination_admin where  status='S' and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy')";
else 
	query="select evt_id,evtnme,evtplace,to_char(evt_date,'dd-Mon-yyyy') evt_date,adminEmp,decode(bus_facility,'Y','Yes','N','No',bus_facility) bus_req,evt_for,evt_bu from nomination_admin where  status='S' and regexp_like(adminemp, '"+adminComp+"', 'i') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy')";
ps=con.prepareStatement(query);
rsPub=ps.executeQuery();

//out.println("query="+query);

%>
<body>
<form name="form1" action="evtPublish.jsp" method="post">
	<div class="container" style="min-height: 488px;">
		<div class="card">
<div class="card-header alert alert-primary style-app-name"><h3 class="text-white">Pending Events</h3></div>
	<div class="card-body">		
		<%if(intVal!=0){%>
			<div class="alert alert-success" ><font size="5">Event Published Successfully</font></div> 
		<%}%>
	<div class="col-sm-12 ex3" id="show_list">
		<table  class="table table-hover table-bordered listTable ex3" style="width: 100%;">
			<thead class ="alert alert-success">
				<tr>
					<th>&sect;</th>
					<th>Event Name</th>
					<th>Event ID</th>
					<th>Event Location</th>
					<th>Event Date</th>
						<!--<th>Event Admin</th>-->
					<th>Bus Facility</th>
					<th>Event For</th>
					<th>Action</th>
				</tr>
			</thead>	
			<%int count=0;
while(rsPub.next()){
	String evt_for1=rsPub.getString("evt_for");
	if(evt_for1.contains("E")){
		evt_for +=",Employees";
	}if(evt_for1.contains("D")){
		evt_for +=",Dependents";
	}if(evt_for1.contains("O")){
		evt_for +=",Others";
	}if(evt_for1.contains("S")){
		evt_for +=",Spouse";
	}if(evt_for1.contains("C")){
		evt_for +=",Children";
	}if(evt_for1.contains("P")){
		evt_for +=",Parents";
	}
	evt_for=evt_for.substring(1);
	//out.println(evt_for);
	%>
			<tbody>
				<tr>
					<td><%=++count%></td>
					<td><%=rsPub.getString("evtnme")%></td>
					<td><%=rsPub.getString("evt_id")%></td>
					<td style="max-width:250px"><%=rsPub.getString("evtplace")%></td>
					<td><%=rsPub.getString("evt_date")%></td>
						<!--<td><%=rsPub.getString("adminEmp")%></td>-->
					<td><%=rsPub.getString("bus_req")%></td>
					<td style="max-width: 150px"><%=evt_for%></td>
					<td>
						<a href="evtPublish.jsp?id=<%=rsPub.getString("evt_id")%>&q=e"><img src="images/Publish.png" width="25"></a>&nbsp;&nbsp;&nbsp;
						<a href="evtPublish.jsp?id=<%=rsPub.getString("evt_id")%>&q=d"><img src="images/clear.png" width="25"></a>
					</td>
				</tr>
			</tbody>
<%evt_for="";
evt_for1="";}%>				
		</table>
	</div>
	</div>
	</div>
	</div>
</form>
</body>
<%@include file="footer.jsp"%>