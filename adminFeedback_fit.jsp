<%@ include file = "header1.jsp"%>
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
//String query1="select emp_no,trim(emp_name) emp_name,emp_designation,grade,budesc from nomination_fit_feedback left join empmaster on a.emp_no = jdep using(emp_no) where event=?";
String query1 = "select distinct a.emp_no, a.person_code,nvl(c.person_name,a.person_code) emp_name,case substr(a.person_code,8,8) when '0' then b.emp_designation else '-' end Designation,case substr(a.person_code,8,8) when '0' then b.grade else '-' end Grade,case substr(a.person_code,8,8) when '0' then b.budesc else '-' end budesc,case substr(a.person_code,8,8) when '0' then 'Self' else 'Spouse ('||(trim(b.emp_name))||')' end Relation from nomination_fit_feedback a left join  empmaster b on substr(a.emp_no,0,7) = substr(b.emp_no,0,7) left join "+tempJdep+"jdep c on a.person_code = c.person_code where publish is null  order by a.emp_no";

PreparedStatement psEvtEmp = con.prepareStatement(query1);
ResultSet rsEvtEmp  = psEvtEmp.executeQuery();
%>


<div class="container" style="min-height: 488px;">
<form name="form1" method="post" action="">
<input type="hidden" name="action_type" value="">
	<div class="card md-10 box shadow">
	  <div class="card-header alert alert-primary style-hp-navyBlue"><h4>Feedback List for Hum Fit Toh HP Fit</h4></div>

	<div class="row">
	  <div class="card-body table-responsive">	
		<!--<div style = "float:right"><a href ="feedbackReport_x.jsp?q=<%=eventName%>"><img src = "images/down1.jpg" width="100" title ="download"></a></div>-->
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
				<td><a href="fitFeedBack.jsp?feedPerson=<%=rsEvtEmp.getString("person_code")%>&isAdminFeed=Y"><%=rsEvtEmp.getString("emp_name")%>(<%=rsEvtEmp.getString("emp_no")%>)</td>
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

  </div>
</form> 
</div>
<%@include file="footer.jsp"%>