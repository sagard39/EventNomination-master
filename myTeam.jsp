<%@ include file = "header1.jsp"%>
<%@ include file="storepath.jsp"%>

<%!
public String nullValue(String str){
	String valStr=str;
	if(str==null){
		valStr="";
	}else if((str.trim()).equals("null")){
		valStr="";
	}else if("".equals(str)){
		valStr="";
	}
	return valStr;
}
%>

<%
String loginEmp = (String)session.getAttribute("login");
try{
//Connection conDev=null; 
//Class.forName("oracle.jdbc.driver.OracleDriver");
//conDev = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");

String event_year="", event_type="", event_type_string="", event_id_toUse="", inter_code_val="";

event_year="2021";
event_type=" 'Inter-Corporate Challenge','Intra-Corporate Challenge' ";
event_type_string = " type in ("+event_type+") ";
event_id_toUse ="2021_409_event";///use of production, change upon deployment
inter_code_val="305";

String inter_code_val_sub="";
inter_code_val_sub=inter_code_val+"_1";

PreparedStatement ps = null;
ResultSet rs1 = null;
String query = "select rowid,Team_NAME, type, (select lbl_name from nomination_addition x WHERE x.id=a.type) as type_name, team_name,mem1,(select person_name from "+tempJdep+"jdep where person_code = a.mem1) memName1,(select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem1) RelName1,(select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem2) RelName2,(select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem3) RelName3,(select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem4) RelName4,(select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem5) RelName5,mem2,mem3,mem4,mem5,(select person_name from "+tempJdep+"jdep where person_code = a.mem2) memName2,(select person_name from "+tempJdep+"jdep where person_code = a.mem3) memName3,(select person_name from "+tempJdep+"jdep where person_code = a.mem4) memName4,(select person_name from "+tempJdep+"jdep where person_code = a.mem5) memName5,zone,to_char(updated_date,'dd-Mon-YYYY') updt_dt,updated_date,decode(status,'GR','Pending for Approval','AP','Approved','RJ','Rejected',status) status1,status  from nomination_team a where (mem1 =? or mem2 = ? or mem3= ? or  mem4 = ? or mem5=?) and year='"+event_year+"'";
//out.println(query);
ps = con.prepareStatement(query);
ps.setString(1,loginEmp);
ps.setString(2,loginEmp);
ps.setString(3,loginEmp);
ps.setString(4,loginEmp);
ps.setString(5,loginEmp);
rs1 = ps.executeQuery();
%>
<div class = "container">
	<div class = "card mb10 box-shadow">
		<div class = "card-header alert alert-warning"><h4>MY TEAM</div>
		<div class = "card-body">
		<div class ="table-responsive">
			<table class = "table table-bordered table-stripped table-hover">
				<thead>
					<tr class = "alert alert-primary">
						<th>Team Name</th>
						<th>Member1</th>
						<th>Member2</th>
						<th>Member3</th>
						<th>Member4</th>
						<th>Member5</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
				<%while(rs1.next()){%>
					<tr class='alert <%=rs1.getString("status").equals("GR")?"alert-warning":(rs1.getString("status").equals("RJ")?"alert-danger":"alert-success")%>'>
						<td><%=nullValue(rs1.getString("team_name"))%> 
							<%if(rs1.getString("type").equals(inter_code_val_sub)){out.println("(Champions League)");}else{%>
								(<%=nullValue(rs1.getString("type_name"))%>)</td>
							<%}%>							
						<td><%=nullValue(rs1.getString("memName1"))%>(<%=nullValue(rs1.getString("mem1"))%>)<br/>(<%=nullValue(rs1.getString("RelName1"))%>)</td>	
						<td><%=nullValue(rs1.getString("memName2"))%>(<%=nullValue(rs1.getString("mem2"))%>)<br/>(<%=nullValue(rs1.getString("RelName2"))%>)</td>	
						<td><%=nullValue(rs1.getString("memName3"))%>(<%=nullValue(rs1.getString("mem3"))%>)<br/>(<%=nullValue(rs1.getString("RelName3"))%>)</td>	
						<td><%=nullValue(rs1.getString("memName4"))%>(<%=nullValue(rs1.getString("mem4"))%>)<br/>(<%=nullValue(rs1.getString("RelName4"))%>)</td>
						<td><%=nullValue(rs1.getString("memName5"))%>(<%=nullValue(rs1.getString("mem5"))%>)<br/>(<%=nullValue(rs1.getString("RelName5"))%>)</td>
						<td><%=rs1.getString("status1")%></td>	
					</tr>
				<%}
} catch (Exception e){
	out.println("Some Error Occured"+e);
}%>	
				</tbody>
			</table>
		</div>
		</div>
	</div>
</div>