<%@ include file = "connection.jsp"%>
<!--
without join--134 sec

-->
<%
Connection conDev=null; 
Class.forName("oracle.jdbc.driver.OracleDriver");
conDev = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment;filename=Team Details.xls");
String query = "select a.team_name as team_name,nvl(b.person_name,mem1) as Member1,nvl(c.person_name,mem2) Member2,nvl(d.person_name,mem3) Member3, nvl(e.person_name,mem4) Member4, a.zone, decode(status,'AP','Approved','RJ','Rejected','GR','Pending',Status) as Status, mem1,mem2,mem3,mem4 from nomination_team a left join jdep1 b on a.mem1=b.person_code left join jdep1 c on  a.mem2 = c.person_code left join jdep1 d on a.mem3 = d.person_code left join jdep1 e on a.mem4 = e.person_code where a.year='2019' and type is null order by status ";
Statement st = conDev.createStatement();
ResultSet rs = st.executeQuery(query);
ResultSetMetaData rsmd = rs.getMetaData();
PreparedStatement ps = con.prepareStatement(" select nvl(a.contact_no,'NA') contact_no,email  from NOMINATION_DEPENDENTS  a left join workflow.empmaster b on a.emp_no = b.emp_no where child_name = ? and event_name = '2019_285_event'");
ResultSet rsDep = null;	

int srNo = 0;
out.println("<table border='1'>");
out.println("<tr>");
out.println("<th>Sr. No.</th><th>Team Name</th>");

out.println("<th>Member1 Name</th><th>Member1 No.</th><th>Member1 Contact No</th><th>Member1 Email</th>");
out.println("<th>Member2 Name</th><th>Member2 No.</th><th>Member2 Contact No</th><th>Member2 Email</th>");
out.println("<th>Member3 Name</th><th>Member3 No.</th><th>Member3 Contact No</th><th>Member3 Email</th>");
out.println("<th>Member4 Name</th><th>Member4 No.</th><th>Member4 Contact No</th><th>Member4 Email</th>");
out.println("<th>Zone</th><th>Status");
out.println("</tr>");
while(rs.next()){
	out.println("<tr>");
	out.println("<td>");
	out.println(++srNo);
	out.println("</td>");

	out.println("<td>"+rs.getString("team_name")+"</td>");		
	out.println("<td>"+rs.getString("Member1")+"</td>");
	ps.setString(1,rs.getString("mem1"));
	rsDep = ps.executeQuery();
	if(rsDep.next()){
		out.println("<td>"+rs.getString("mem1")+"</td><td>"+rsDep.getString("contact_no")+"</td><td>"+rsDep.getString("email")+"</td>");	
	}else{
		out.println("<td></td><td></td><td></td>");
	}
	out.println("<td>"+rs.getString("Member2")+"</td>");
	ps.setString(1,rs.getString("mem2"));
	rsDep = ps.executeQuery();
	if(rsDep.next()){
		out.println("<td>"+rs.getString("mem2")+"</td><td>"+rsDep.getString("contact_no")+"</td><td>"+rsDep.getString("email")+"</td>");	
	}else{
		out.println("<td></td><td></td><td></td>");
	}	
	out.println("<td>"+rs.getString("Member3")+"</td>");
	ps.setString(1,rs.getString("mem3"));
	rsDep = ps.executeQuery();
	if(rsDep.next()){
		out.println("<td>"+rs.getString("mem3")+"</td><td>"+rsDep.getString("contact_no")+"</td><td>"+rsDep.getString("email")+"</td>");	
	}else{
		out.println("<td></td><td></td><td></td>");
	}	
	out.println("<td>"+rs.getString("Member4")+"</td>");
	ps.setString(1,rs.getString("mem4"));
	rsDep = ps.executeQuery();
	if(rsDep.next()){
		out.println("<td>"+rs.getString("mem4")+"</td><td>"+rsDep.getString("contact_no")+"</td><td>"+rsDep.getString("email")+"</td>");	
	}else{
		out.println("<td></td><td></td><td></td>");
	}
	out.println("<td>"+rs.getString("zone")+"</td><td>"+rs.getString("status")+"</td>");		

	out.println("</tr>");	
}
out.println("</tr>");
out.println("</table>");

if(conDev != null) conDev.close();
if(con != null) con.close();

%>
