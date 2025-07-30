<%@ include file="header1.jsp"%>
<%@ include file = "storepath.jsp"%>
<script>
 function sfresh(Obj){
	 document.form1.action_type.value=Obj.value;
	 document.form1.submit();
 }
 
</script>
<%
int count = 0;
String eventName=request.getParameter("action_type");
String query="select distinct a.event,b.evtnme from nomination_feedback a left join nomination_admin b on a.event = b.evt_id where event is not null";
Statement stEventName = con.createStatement();
ResultSet rsEventName = stEventName.executeQuery(query);
//String query1="select emp_no,trim(emp_name) emp_name,emp_designation,grade,budesc from nomination_feedback left join empmaster on a.emp_no = jdep using(emp_no) where event=?";
String query1 = "select distinct  a.emp_no,c.person_name emp_name,case substr(a.emp_no,8,8) when '0' then b.emp_designation else '-' end Designation,case substr(a.emp_no,8,8) when '0' then b.grade else '-' end Grade,case substr(a.emp_no,8,8) when '0' then b.budesc else '-' end budesc,case substr(a.emp_no,8,8) when '0' then 'self' else 'Spouse ('||(trim(b.emp_name))||')' end Relation from nomination_feedback a left join  empmaster b on substr(a.emp_no,0,7) = substr(b.emp_no,0,7) left join "+tempJdep+"jdep c on a.emp_no = c.person_code where event= ? order by a.emp_no";

PreparedStatement psEvtEmp = con.prepareStatement(query1);
psEvtEmp.setString(1,eventName);
ResultSet rsEvtEmp  = psEvtEmp.executeQuery();
%>
<div class="container" style="min-height: 488px;" >
<form name="form1" method="post" action="">
<input type="hidden" name="action_type" value="">
	<div class="card md-10 box shadow">
	  <div class="card-header alert alert-primary style-app-name"><h4 class="text-white">Employee Feedback List</h4></div>
		<div class="row">	
			<div class="card-body">
			<div class="row"><div class="col-md-2">Select the Event</div>
			<div class="col-md-10">
			 <select class="form-control" name="eventDrop" onchange="return sfresh(this);" >
			 	<option value="-1">Select</option>
			 	<%while(rsEventName.next()){%>
				<option value="<%=rsEventName.getString("event")%>" <%=!("".equals(eventName) || eventName==null)?"selected":""%> ><%=rsEventName.getString("evtnme")%></option>
				<%}%>
			 </select>
			</div></div>
		 </div>			
		</div>
	<%if(!("".equals(eventName) || eventName==null)){%>	
	<div class="row">
	  <div class="card-body table-responsive">	
		<div style = "float:right"><a href ="feedbackReport_x.jsp?q=<%=eventName%>"><img src = "images/down1.jpg" width="100" title ="download"></a></div>
		<table class="table table-hover table-bordered listTable">	
		  <thead class ="alert alert-success"><tr>
				<th>#</th>
				<th>Employee</th>
				<th>Grade</th>
				<th>Designation</th>
				<th>BU</th>
				<th>Feedback for</th>
				
		  </tr></thead>	
		  <tbody>
		  <%while(rsEvtEmp.next()){count++;%>
			<tr>
				<td><%=count%></td>
				<td><a href="feedback.jsp?evtnme=<%=eventName%>&feedPerson=<%=rsEvtEmp.getString("emp_no")%>&isAdminFeed=Y"><%=rsEvtEmp.getString("emp_name")%>(<%=rsEvtEmp.getString("emp_no")%>)</td>
				<td><%=rsEvtEmp.getString("grade")%></td>
				<td><%=rsEvtEmp.getString("Designation")%></td>
				<td><%=rsEvtEmp.getString("budesc")%></td>
				<td><%=rsEvtEmp.getString("Relation")%></td>
			</tr>
		  <%}%>
		  </tbody>
		</table>
	  </div>	
    </div>
	<%}%>
  </div>
</form> 
</div>
<%@include file="footer.jsp"%>