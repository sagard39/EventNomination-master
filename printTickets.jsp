
<%@include file="connection.jsp" %>
<script src="js/jquery-1.10.2.js"></script>
<style>

@media print{
	   #print{
		   display:none;
	   }
	   #home{
		   display:none;
	   }
	   #radiolist{
		   display:none;  
	   }
}
@page {
    size: 100%;   /* auto is the initial value */
    margin: 10;  /* this affects the margin in the printer settings */
	align:center;
	//size: landscape;
	//orientation: landscape;
          
}
</style>


<script>
/* function getPrint(){
	window.print();
return false;	
} */
</script>
<script>

$(document).ready(function() {
   window.print();
});
</script>
<%
//response.setContentType("application/pdf");
Statement st=con.createStatement();
Statement st1=con.createStatement();
PreparedStatement ps = null;
ResultSet rs = null;
ResultSet rs1 = null;
boolean isEntry=false;
String login_emp = request.getParameter("emp_no");
//String action = request.getParameter("action");
String emp_no="",emp_name="",emp_designation="",emp_grade="",emp_bu="",emp_contact="",emp_budesc="";
String query="";
int tempCountObj=0, index=0;
int status_id=0;
String[] contArr = new String[5];
String[] perfArr = new String[5]; 
boolean emp_edit=false, ro_edit=false, rvo_edit=false;
boolean showPage=true;




if(!"".equals(login_emp)) {
	query = "select emp_no,trim(emp_name) emp_name,emp_designation,grade,bu,budesc,contact_no from empmaster where emp_no='"+login_emp+"'";
	rs = st.executeQuery(query);
	if(rs.next()) {
		//showPage = false;
		emp_no=rs.getString("emp_no");
		emp_name=rs.getString("emp_name");
		emp_designation=rs.getString("emp_designation");
		emp_grade=rs.getString("grade");
		emp_bu=rs.getString("bu");
		emp_budesc=rs.getString("budesc");
		emp_contact	=rs.getString("contact_no");
	}
}


String dep_mame="",age="",contact_no="",relation="",gender="";
	query = "select a.emp_no emp_no,nvl2(b.person_code,upper(b.person_name),upper(a.child_name) )name,a.age,a.contact_no,decode(upper(a.relatation),'SL','EMPLOYEE','SP','SPOUSE','CH','CHILD','MO','MOTHER','FA','FATHER',upper(a.relatation))relation,decode(a.gender,'M','MALE','F','FEMALE',a.gender)gender from nomination_dependents a left join portal.jdep b on a.emp_no=b.emp_no and a.child_name=b.person_code where a.emp_no='"+login_emp+"' and a.event_name='2018_101_event'";
	rs = st.executeQuery(query);%>
	
	
	
	<div style="margin-left:15%;margin-right:15%">
	<div style="float:left;">
		<img src="images/HPCL.jpg" width="20%">
	</div><br/><br/><br/><br/>
	<div>
		<centeR>	<h3>Cultural Fest MR GOT TALENT</h3></centeR>
			
	</div><br/>
	<div >
	<b>Venue</b> : HPNW Ground , Chembur<br/>
	<b>Date </b> : February 18, 2018<br/>
	<b>Time </b> : 5.30 PM onward<br/>
	</div><br/><br/><br/><br/>
	
	<center><table border="1" style="border-collapse:collapse">
		<tr >
			<th align="left">Employee</td><td><%=emp_name+"("+emp_no+")"%></td>
			<th align="left">Print Date</td><td><%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss a").format(new Date())%>
		</tr>
		<tr>
			<th align="left">Designation</th><td><%=emp_designation%></td>
			<th align="left">Grade</th><td><%=emp_grade%></td>
		</tr>	
		<tr>
			<th align="left">Bu</th><td><%=emp_budesc%>(<%=emp_bu%>)</td>
			<th align="left">Contact No</th><td><%=emp_contact%></td>
		</tr>
	</table><centeR><br/><br/><br/><br/>
	<table border="1" style="border-collapse:collapse;width:100%">
	
		<tr>
			<th>Sr.No.</th>
			<th>Name</th>
			<th>Gender</th>
			<th>Age</th>
			<th>Relation</th>
			<th>Contact No.</th>
		</tr>
		<%while(rs.next()){%>
			<tr>
				<td><%=++index%></td>
				<td><%=rs.getString("name")%>
				<td><%=rs.getString("gender")%>
				<td><%=rs.getString("age")%>
				<td><%=rs.getString("relation")%>
				<td><%=rs.getString("contact_no")%>
			</tr>
		<%}%>
	</table><br/><br/><br/><br/><br/>
	<center><font size="4" face="bold">Note : </font><font size="3">This Printout has to be brought to Venue for entry for the said program.Entry would  not  be allowed without this Printout.</font></center><br/>
	<centeR><!--<input type="submit" name="print" id="print" Value="Print" onclick="return getPrint();">--><center></div>
	