<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
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

<script>
function sfresh(){
	document.form1.submit();
}

function goAppr(){
	if(validate()){
		document.form1.action_type.value = "goApprove";
		//alert(document.form1.action_type.value);
		document.form1.submit();
	} else {
		return false;
	}
}
function goRej(){
	if(validate()){
		document.form1.action_type.value = "goReject";
		document.form1.submit();
	} else {
		return false;
	}
}
function validate(){
	var tempChk =$('[name=chk1]:checked').length;
	if(tempChk<=0){
		alert("Please Choose alteast One team before Submission");
		return false;
	}
	return true;
}
</script>

<%
String event_year="", event_type="", event_type_string="", event_id_toUse="", event_type_check="", event_type_check_string="";
PreparedStatement ps_cat_type=null, ps_check_inter=null, ps_check_values=null;
ResultSet rs_cat_type=null, rs_check_inter=null, rs_check_values=null;
String condition = "", inter_code="", query_tocheck_inter="", query_check_values="", inter_code_val="";
Boolean check_inter=false;

event_year="2021";
//event_type=" 'Inter-Corporate Challenge','Intra-Corporate Challenge' ";
//event_type_string = " type in ("+event_type+") ";
event_id_toUse ="2021_409_event";///use of production, change upon deployment
inter_code_val="305";

String inter_code_val_sub="";
inter_code_val_sub=inter_code_val+"_1";


String query_cat_type = "select * from nomination_addition where evt_id=?";
ps_cat_type = con.prepareStatement(query_cat_type);
ps_cat_type.setString(1,event_id_toUse);
rs_cat_type = ps_cat_type.executeQuery();
while(rs_cat_type.next()){
	event_type += "'"+rs_cat_type.getString("id")+"',";
}

if(event_type.length()>0)
event_type = event_type.substring(0, event_type.length() - 1);

event_type_string = " and type in ("+event_type+",'"+inter_code_val_sub+"') ";

%>

<%!
public String nullVal(String str){
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
try {
//Connection conDev=null; 
//Class.forName("oracle.jdbc.driver.OracleDriver");
//conDev = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");



String loginEmp = (String)session.getAttribute("login");
String query = "",action_type = "",empZone = "",queryTest = "",queryTeamName = "",tempSts = "",tempStatusName = "";
 

empZone = nullVal(request.getParameter("zone"));
//if("".equals(empZone))
	//empZone = " and zone is null";
PreparedStatement ps = null,ps1= null,psTeamName = null;
ResultSet rs2 = null,rs3 = null,rsTeam = null,rsTeamName = null;
List <String> zoneList = new ArrayList<String>();
String empMails = "";
query = "select distinct substr(zonecd,7) name,substr(zonecd,0,5) code from elgzonebu  where substr(zonecd,0,5) not in('10501','10103','12620','11770') and bu <> '10155808'";
ps = con.prepareStatement(query);
rs2 = ps.executeQuery();
action_type = request.getParameter("action_type");
ResultSet rsStmt = null;
if("goApprove".equals(action_type) || "goReject".equals(action_type) ){

//out.print(event_year+"-"+event_type_string);

	queryTeamName = "select rowid,Team_NAME team_name, type,mem1,(select person_name from "+tempJdep+"jdep where person_code = a.mem1) memName1,nvl((select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem1),'Spouse') RelName1,nvl((select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem2),'Spouse') RelName2,nvl((select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem3),'Spouse') RelName3,nvl((select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem4),'Spouse') RelName4,nvl((select decode(relation_code,'SL','Employee','SP','Spouse',relation_code) from "+tempJdep+"jdep where person_code = a.mem5),'Spouse') RelName5,mem2,mem3,mem4,mem5,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem2),mem2) memName2,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem3),mem3) memName3,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem4),mem4) memName4,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem5),mem5) memName5,zone,to_char(updated_date,'dd-Mon-YYYY') updt_dt,updated_date,decode(status,'GR','pending for Approval','AP','Approved by Admin',status) status1,status  from nomination_team a where rowid = ? and year='"+event_year+"' "+event_type_string+" ";
	psTeamName = con.prepareStatement(queryTeamName);
	if("goApprove".equals(action_type)){
		tempSts = "AP";
		tempStatusName = "Approved";
	} else if("goReject".equals(action_type)){
		tempSts = "RJ";
		tempStatusName = "Rejected";
	}
	query = "update nomination_team set status ='"+tempSts+"',APPROVED_BY = '"+loginEmp+"' where rowid = ? and year='"+event_year+"' "+event_type_string+" ";
	PreparedStatement psUpdate = con.prepareStatement(query);
	Statement stmt1 = con.createStatement();
	String[] chkVal = request.getParameterValues("chk1");

	//changed by Riha
	//String queryResult = "select (''''|| mem1 ||''''||','||''''||mem2 ||''''||','||''''||mem3||''''||','||''''||mem4 ||'''','||''''||mem5 ||'''') members from nomination_team where rowid = ? and year='"+event_year+"' "+event_type_string+" ";
	String queryResult = "select (''''|| mem1 ||''''||','||''''||mem2 ||''''||','||''''||mem3||''''||','||''''||mem4||''''||','||''''||mem5 ||'''') members from nomination_team where rowid = ? and year='"+event_year+"' "+event_type_string+" ";
	PreparedStatement psQry = con.prepareStatement(queryResult);
	
	if(chkVal!=null){
		for(int i = 0;i<chkVal.length;i++){

			//out.print("/////"+chkVal[i]+"///////");

			psQry.setString(1,chkVal[i]);
			//out.print(queryResult);
			ResultSet rsQry = psQry.executeQuery();

			if(rsQry.next()){
				//out.print("    -"+rsQry.getString("members"));
				//in production use this query
				//rsStmt = stmt1.executeQuery("select email from workflow.empmaster where emp_no in(select emp_no from portal.jdep where person_code in("+rsQry.getString("members")+"))");
				//in developement use this query
				rsStmt = stmt1.executeQuery("select email from workflow.empmaster where emp_no in(select emp_no from "+tempJdep+"jdep where person_code in("+rsQry.getString("members")+"))");
				while(rsStmt.next()){
					empMails +=","+rsStmt.getString("email");
				}
			}

			if(!"".equals(empMails))
				empMails = empMails.substring(1);
			psUpdate.setString(1,chkVal[i]);
			
			int cnt = psUpdate.executeUpdate(); 
			if(cnt>0){
				//String message = "This is the test environment ,Please ignore the mail.<br> Kindly note that your request for the team formation has been approved,as per details below-<br/>", type_fetch="";
				String message = " Kindly note that your request for the team formation has been "+tempStatusName+",as per details below-<br/>", type_fetch=""; 
				message += "<table border=1 style=\"border-collapse: collapse;width:100%\" style=\"border-collapse: collapse\"><tr><td style=\"border-collapse: collapse;width:20%\">Team Name</td><td style=\"border-collapse: collapse;width:10%\">Member1</td><td style=\"border-collapse: collapse;width:10%\">Member2</td><td style=\"border-collapse: collapse;width:10%\">Member3</td><td style=\"border-collapse: collapse;width:10%\">Member4</td><td style=\"border-collapse: collapse;width:10%\">Member5</td><td style=\"border-collapse: collapse;width:10%\">Emails</td></tr>";
				psTeamName.setString(1,chkVal[i]);
				rsTeamName = psTeamName.executeQuery();
				if(rsTeamName.next()){
					type_fetch=rsTeamName.getString("type");
					if(type_fetch.equals(inter_code_val_sub)){type_fetch="Champions League";}
					else if(type_fetch.equals(inter_code_val)){type_fetch="Inter-Corporate Challenge";}
					else{type_fetch="Intra-Corporate Challenge";}
					message += "<tr><td style=\"border-collapse: collapse;width:20%\">"+rsTeamName.getString("team_name")+"</td><td style=\"border-collapse: collapse;width:10%\">"+rsTeamName.getString("memName1")+"("+rsTeamName.getString("RelName1")+")</td><td style=\"border-collapse: collapse;width:10%\">"+rsTeamName.getString("memName2")+"("+rsTeamName.getString("RelName2")+")</td><td style=\"border-collapse: collapse;width:10%\">"+rsTeamName.getString("memName3")+"("+rsTeamName.getString("RelName3")+")</td><td style=\"border-collapse: collapse;width:10%\">"+rsTeamName.getString("memName4")+"("+rsTeamName.getString("RelName4")+")</td><td style=\"border-collapse: collapse;width:10%\">"+rsTeamName.getString("memName5")+"("+rsTeamName.getString("RelName5")+")</td><td style=\"border-collapse: collapse;width:10%\">"+empMails+"</td></tr>" ;
				}
					message +="</table>";
				String email_str = email.gen_email_call("APP208","D", " ",message,empMails,"khushboorajpal@hpcl.in","raghavansv@hpcl.in","Team formation ("+type_fetch+") Request ",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());

				//String email_str = email.gen_email_call("APP208","D", " ",message,empMails,"tanu.sharma@hpcl.in","raghavansv@hpcl.in","Team formation ("+type_fetch+") Request ",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
			}
		
			empMails = "";
		}
	}

}

//out.print(event_year+"-"+event_type_string+"-"+empZone);

String empSearch = nullVal(request.getParameter("empFilter"));
if("".equals(empSearch)){

	//out.print("select 1");
	query = "select rowid,Team_NAME,type,(select lbl_name from nomination_addition x WHERE x.id=a.type) as type_name,mem1,(select person_name from "+tempJdep+"jdep where person_code = a.mem1) memName1,mem2,mem3,mem4,mem5,status,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem2),mem2) memName2,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem3),mem3) memName3,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem4),mem4) memName4,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem5),mem5) memName5,zone,to_char(updated_date,'dd-Mon-YYYY') updt_dt,updated_date from nomination_team a where year='"+event_year+"' "+event_type_string+" and status in ('GR','AP')  "+ empZone+"  order by updated_date desc";
} else {
	//out.print("select 2");
	query = "select rowid,Team_NAME,type,(select lbl_name from nomination_addition x WHERE x.id=a.type) as type_name,mem1,(select person_name from "+tempJdep+"jdep where person_code = a.mem1) memName1,mem2,mem3,mem4,mem5,status,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem2),mem2) memName2,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem3),mem3) memName3,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem4),mem4) memName4,nvl((select person_name from "+tempJdep+"jdep where person_code = a.mem5),mem5) memName5,zone,to_char(updated_date,'dd-Mon-YYYY') updt_dt,updated_date from nomination_team a where year='"+event_year+"' "+event_type_string+" and status in ('GR','AP') and (mem1='"+empSearch+"' or mem2 ='"+empSearch+"' or mem3 = '"+empSearch+"' or mem4 = '"+empSearch+"' or mem5 = '"+empSearch+"')";
}

//out.println(query);
ps1 = con.prepareStatement(query);
rs3 = ps1.executeQuery();

%>

<div class = "container-fluid">
<form name ="form1" action = "" method = "POST">
<input type = "hidden" name = "action_type" value = "">
	<div class ="card mb10 box-shadow">
		<div class = "card-header alert alert-success"><h4>Admin Team Cluster</h4></div>
		<div class = "card-body">
			<div class = "row col-md-12">
			<div class = "col-md-4">
			<label for = "zoneName">Choose the Zone</label>
			<select name = "zone" id ="zoneName" onchange = "return sfresh();" class = "form-control">
				<option value = "">Select</option>
				<option value = " and zone in ('10501','10103')">HQO</option>
				<%while(rs2.next()){
					
					%>
					<option value = " and zone in ('<%=rs2.getString("code")%>')"><%=rs2.getString("name")%></option>
				<%}%>
				<option value = " and zone in ('12620','11770')">South Central Zone</option>
				
			</select>
			</div>
			<div class = "col-md-2">
				<label for = "empFilter">Enter the Employee No.</label>
				<input type = "text" name = "empFilter" id = "empFilter" class ="form-control" />
				<br>
				<button type = "submit" name = "submit1" class = "btn btn-danger btn-md" >Search</button>
			</div>
			<div class = "col-md-3" align = "right">
			<button class = "btn btn-md btn-primary" onclick = "return goAppr();">Approve </button>
			</div>
			<div class = "col-md-3" align = "left">
			<button class = "btn btn-md btn-danger" onclick = "return goRej();">Reject </button>
			</div>
			</div><br>
			<div class = "row">
					<span><a href = "reportNewTeam.jsp">Click Here</a> to download the report in excel<span> 
			</div><br/>


<a id="dlink"  style="display:none;"></a>

<input type="button" onclick="tableToExcel('table_data', 'table_data', 'Data.xls')" value="Export to Excel">

			<div class= "table-responsive" id="table_data">
			<table class= "table table-bordered table-stripped table-hover">
				<thead>
					<tr>
						<th>#</th>
						<th>Team Name</th>
						<th>Member1</th>
						<th>Member2</th>
						<th>Member3</th>
						<th>Member4</th>
						<th>Member 5</th>
						<th>Team Requested On</th>
					</tr>
				</thead>
				<tbody>
				<%while(rs3.next()){
					
					%>
					<tr <%=!"AP".equals(rs3.getString("status"))?"GR".equals(rs3.getString("status"))?"":"class ='alert-danger'":"class ='alert-success'"%>>
						<td>
							<input type = "checkbox" name = "chk1" value = "<%=rs3.getString("rowid")%>" >
						</td>
						<td><%=rs3.getString("team_name")%>							
							<%if(rs3.getString("type").equals(inter_code_val_sub)){out.println("(Champions League)");}else{%>
								(<%=nullValue(rs3.getString("type_name"))%>)</td>
							<%}%>
						</td>
						<td><%=rs3.getString("memName1")%> (<%=rs3.getString("mem1")%>)</td>
						<td><%=rs3.getString("memName2")%> (<%=rs3.getString("mem2")%>)</td>
						<td><%=rs3.getString("memName3")%> (<%=rs3.getString("mem3")%>)</td>
						<td><%=rs3.getString("memName4")%> (<%=rs3.getString("mem4")%>)</td>
						<td><%=rs3.getString("memName5")%> (<%=rs3.getString("mem5")%>)</td>
						<td><%=rs3.getString("updt_dt")%></td>
					</tr>
				<%}
} catch(Exception e){
	out.println("Some Error Occured"+e);
}%>
				</tbody>
			</table>			
			</div>
		</div>
	</div>
</form>	
</div>

<script>
	var tableToExcel = (function () {
        var uri = 'data:application/vnd.ms-excel;base64,'
        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
        , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
        , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
        return function (table, name, filename) {
            if (!table.nodeType) table = document.getElementById(table)
            var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML }

            document.getElementById("dlink").href = uri + base64(format(template, ctx));
            document.getElementById("dlink").download = filename;
            document.getElementById("dlink").click();

        }
    })()
</script>
