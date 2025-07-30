<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
<%@ include file = "header1.jsp"%>
<%@ include file="storepath.jsp"%>


<%
	String top_type = request.getParameter("t");
	if(top_type==null){top_type="";}

	String top_type_select = request.getParameter("top_type_select");
	if(top_type_select==null){top_type_select="";}
	//top_type="aa";


	//out.println("top_type="+top_type);
	//out.println("top_type_select="+top_type_select);
%>



<%

String loginEmp = (String)session.getAttribute("login");

String event_year="", event_type="", event_type_string="", event_id_toUse="", event_type_check="", event_type_check_string="", inter_code_val="";
PreparedStatement ps_cat_type=null, ps_check_inter=null, ps_check_values=null;
ResultSet rs_cat_type=null, rs_check_inter=null, rs_check_values=null;
String condition = "", inter_code="", query_tocheck_inter="", query_check_values="";
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


String id_fetch="", id_values_chosen="";
/*query_check_values = " select * FROM nomination_emp_add WHERE emp_no=? and id in ("+event_type+") ";
ps_check_values = con.prepareStatement(query_check_values);
ps_check_values.setString(1,loginEmp);
rs_check_values = ps_check_values.executeQuery();
while(rs_check_values.next()){
	id_fetch = rs_check_values.getString("id");
	id_values_chosen = rs_check_values.getString("value");

	if(id_values_chosen.equals("Yes")){
		event_type_check += "'"+id_fetch+"',";
	}
}*/

int check_actual_num=0;
query_cat_type = " SELECT * FROM nomination_addition a left join nomination_emp_add b on a.id=b.id WHERE evt_id=? and value='Yes' and b.emp_no=? "; 
//out.println("query_cat_type="+query_cat_type);
ps_cat_type = con.prepareStatement(query_cat_type);
ps_cat_type.setString(1,event_id_toUse);
ps_cat_type.setString(2,loginEmp);
rs_cat_type = ps_cat_type.executeQuery();
while(rs_cat_type.next()){
	++check_actual_num;
	id_fetch = rs_cat_type.getString("id");
	id_values_chosen = rs_cat_type.getString("value");

	if(id_values_chosen.equals("Yes")){
		event_type_check += "'"+id_fetch+"',";
	}
}

//out.println("check_actual_num="+check_actual_num);

if(event_type_check.length()>0)
event_type_check = event_type_check.substring(0, event_type_check.length() - 1);

event_type_string = " type in ("+event_type+") ";
event_type_check_string = " type in ("+event_type_check+",'"+inter_code_val_sub+"') ";

//out.println("event_type_check_string="+event_type_check_string);



query_cat_type = "select * from nomination_addition where evt_id=? and lower(lbl_name) like 'inter%' ";
ps_cat_type = con.prepareStatement(query_cat_type);
ps_cat_type.setString(1,event_id_toUse);
rs_cat_type = ps_cat_type.executeQuery();

if(rs_cat_type.next()){
	if(rs_cat_type.getString("id").equals(top_type)){
		condition = " and a.relatation='SL' ";
		check_inter = true;
		inter_code = rs_cat_type.getString("id");
	}
	else{
		condition = " ";
		check_inter = false;
	}
}else{
	condition = " ";
	check_inter = false;
}

if(top_type.equals(inter_code_val_sub)){
	check_inter=true;
	
}


%>

<style>
input[type="checkbox"][readonly] {
  pointer-events: none;
}
</style>
<script>
function goSubmit(){
	if(validate()){
		document.form1.action_type.value = "submitTeam";
		document.form1.submit();
	} else {
		return false;
	}
}
function validate(){
	var getChecked = $('[name=chk1]:checked').length;
	var teamName = $("#teamName").val();
	var empGrade = $("#empGrade").val();
	//if(!(empGrade=='10I' || empGrade=='10X' || empGrade=='10Y')){
	if(getChecked!=5){
 		alert("Select 5 members before Submission");
		return false;
	}
	if(teamName ==''){
		alert("Enter the Team Name");
		return false;
	}
	return true;
}
/* function getOnClick(val){
 $("input[value='"+val+"'][type='checkbox']").prop("checked", $(this).prop("checked"));
} */
function getOnClick(){
$("input[type='checkbox']").change(function(){	
	$("input[value='"+$(this).val()+"'][type='checkbox']").prop("checked", $(this).prop("checked"));
});
}
</script>







<div class = "container">
<form name = "form1" action = "teamCluster.jsp" method = "POST">
<input type = "hidden" name = "action_type" value = "">
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
String top_type_name="";
if(top_type_select.equals("305")){
	top_type_name="Inter-Corporate Challenge";
}
else if(top_type_select.equals("306")){
	top_type_name="Intra-Corporate Challenge";
}
else if(top_type_select.equals("305_1")){
	top_type_name="Champions League";
}

//try{
/*Connection conDev=null; 
Class.forName("oracle.jdbc.driver.OracleDriver");
conDev = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");
*/

String query = "",empZone = "",action_type = "",toMail= "",query1= "",empZoneTemp = "",memList = "",empGrade = "", query3="";
boolean isAdminTeam = false;
action_type =request.getParameter("action_type"); 
PreparedStatement ps = null,ps1 = null,ps3 = null, ps4=null;
ResultSet rs1 = null,rs2 = null,rs3= null, rs4=null;
if(("31926330".equals(loginEmp) || "35322030".equals(loginEmp))){
	isAdminTeam = true;
}
if(!isAdminTeam){
ps1 = con.prepareStatement("select zonecd,grade,bu from workflow.empmaster where emp_no =?");
ps1.setString(1,loginEmp);
rs1 = ps1.executeQuery();
if(rs1.next()){
	empZone = rs1.getString("zonecd");
	empGrade = rs1.getString("grade");
	empZoneTemp = rs1.getString("zonecd");
	if("10I,10X,10Y".contains(empGrade)){
		empZone  = " zonecd is not null and grade in('10I','10X','10Y') ";
	} else{
		if("12620".equals(empZone) || "11770".equals(empZone) || "10155808".equals(rs1.getString("BU"))){
			empZone = "(zonecd in('12620','11770') or bu ='10155808') and grade not in('10I','10X','10Y') ";
			if("10155808".equals(rs1.getString("BU"))){
				empZoneTemp = "12620";
			}
		}else if("10103".equals(empZone) || "10501".equals(empZone)){
			empZone = " zonecd in('10501','10103') and grade not in('10I','10X','10Y') ";
		}else{	
			empZone = " zonecd = '"+empZone+"' and grade not in('10I','10X','10Y') ";	
		}
	}
}
} else {
	empZone = " 1=1 ";
}
int teamCount =0,resultInt = 0 ;


Boolean check_cham=false;
ps3 = con.prepareStatement("select * from nomination_champions where event_id='"+event_id_toUse+"' and type='Champions League' and year='"+event_year+"' and emp_no=? ");
//out.println("select * from nomination_champions where event_id='"+event_id_toUse+"' and type='Champions League' and year='"+event_year+"' and emp_no=? ");
ps3.setString(1,loginEmp);
rs3 = ps3.executeQuery();
if(rs3.next()){
	check_cham=true;
}

if(check_cham){
	check_actual_num++;
}

//out.println(check_actual_num);




ResultSet rsTeamExist=null;
int check_fetch_num=0;

//previous query that was used
//query1 = "select  a.emp_no emp_no, a.child_name perCode, nvl(b.person_name,a.child_name) personName, a.age age, decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender, a.contact_no contact, (select email from workflow.empmaster where emp_no =a.emp_no) email from NOMINATION_DEPENDENTs a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code where event_name='2019_285_event' and a.emp_no in (select emp_no from workflow.empmaster where emp_no=?) and a.child_name not in (select person_code from nomination_winner where emp_no=?) ";
query1 = "select  a.emp_no emp_no, a.child_name perCode, nvl(b.person_name,a.child_name) personName, a.age age, decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender, a.contact_no contact, (select email from workflow.empmaster where emp_no =a.emp_no) email from NOMINATION_DEPENDENTs a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code where event_name='"+event_id_toUse+"' and a.emp_no in (select emp_no from workflow.empmaster where emp_no=?)  ";

query3 = "select  a.emp_no emp_no, a.child_name perCode, nvl(b.person_name,a.child_name) personName, a.age age, decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender, a.contact_no contact, (select email from workflow.empmaster where emp_no =a.emp_no) email from NOMINATION_DEPENDENTs a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code where event_name='"+event_id_toUse+"' and a.emp_no in (select emp_no from workflow.empmaster where emp_no=?)  and a.relatation='SL'";
///Event name changes by tanu
//PreparedStatement psTeamExist = con.prepareStatement("select team_name from nomination_team where (mem1 = ? or mem2 = ? or mem3 = ? or mem4 = ?) and status <>'RJ' and year='2019' and type is null "); ///previous query

String type_exists="";
PreparedStatement psTeamExist = con.prepareStatement("select team_name, type from nomination_team where (mem1 = ? or mem2 = ? or mem3 = ? or mem4 = ? or mem5=?) and status <>'RJ' and year='"+event_year+"' and "+event_type_check_string+" ");////year and type changes by tanu
//out.println("psTeamExist= select team_name from nomination_team where (mem1 = ? or mem2 = ? or mem3 = ? or mem4 = ? or mem5=?) and status <>'RJ' and year='"+event_year+"' and "+event_type_check_string+" ");

psTeamExist.setString(1,loginEmp);
psTeamExist.setString(2,loginEmp);
psTeamExist.setString(3,loginEmp);
psTeamExist.setString(4,loginEmp);
psTeamExist.setString(5,loginEmp);
//try{
	rsTeamExist = psTeamExist.executeQuery();	
//}catch(Exception ex){out.println("exception="+ex);}
if(!isAdminTeam){
while(rsTeamExist.next()){
	++check_fetch_num;
	type_exists += "'"+rsTeamExist.getString("type")+"',";
}

//out.println(check_fetch_num);

if(type_exists.length()>0)
type_exists = type_exists.substring(0, type_exists.length() - 1);



psTeamExist = con.prepareStatement("select team_name, type from nomination_team where (mem1 = ? or mem2 = ? or mem3 = ? or mem4 = ? or mem5=?) and status <>'RJ' and year='"+event_year+"' and type='"+top_type+"' ");////year and type changes by tanu
//out.println(" select team_name, type from nomination_team where (mem1 = ? or mem2 = ? or mem3 = ? or mem4 = ? or mem5=?) and status <>'RJ' and year='"+event_year+"' and type='"+top_type+"'  ");
psTeamExist.setString(1,loginEmp);
psTeamExist.setString(2,loginEmp);
psTeamExist.setString(3,loginEmp);
psTeamExist.setString(4,loginEmp);
psTeamExist.setString(5,loginEmp);
rsTeamExist = psTeamExist.executeQuery();

	if(rsTeamExist.next()){
%>
	<script>
		//alert("hi");
			location.href = "myTeam.jsp";
	</script>
<%}
}

/*psTeamExist = con.prepareStatement("select * from nomination_winner where emp_no=?");
psTeamExist.setString(1,loginEmp);
rsTeamExist = psTeamExist.executeQuery();
if(!isAdminTeam){
if(rsTeamExist.next()){%>
	<script>
		//alert("Congratulations. Basis your stupendous performance in #Hum Fit Toh HP Fit Challenge 2018, you have been elevated to 'League of the Champions' for the  #Hum Fit Toh HP Fit Challenge 2019");
		//location.href = "home.jsp";
	</script>
<%}
}*/

//String query2 = "insert into nomination_team(TEAM_NAME, ZONE, MEM1, MEM2, MEM3, MEM4, UPDATED_BY, UPDATED_DATE, STATUS, YEAR) values (?,?,?,?,?,?,?,sysdate,'GR','2019')";////previous query
String query2 = "insert into nomination_team(TEAM_NAME, ZONE, MEM1, MEM2, MEM3, MEM4, MEM5, UPDATED_BY, UPDATED_DATE, STATUS, YEAR, TYPE) values (?,?,?,?,?,?,?,?,sysdate,'GR','"+event_year+"',?)"; ////year changes by tanu
PreparedStatement psTeam = con.prepareStatement(query2);
ps3 = con.prepareStatement(query1);
Set<String> mailSet = new LinkedHashSet<String>(); 
Set<String> empSet = new LinkedHashSet<String>(); 
List<String> mailList = new ArrayList<String>();
List<String> empList = new ArrayList<String>();
if("submitTeam".equals(action_type)){
	//try{
	String[] chkmails = request.getParameterValues("chk1");
	for(int i =0 ;i<chkmails.length;i++){
		empSet.add(chkmails[i]);
	}
//}catch(Exception ex){out.println(ex);}

	//out.println("tanu="+request.getParameterValues("chk1").length);


	empList.addAll(empSet);

	//out.println(empList);

	PreparedStatement psMailEmp = con.prepareStatement("select email from empmaster where emp_no=?");
	ResultSet rsMailEmp = null;
	for(int i=0;i<empList.size();i++){
		psMailEmp.setString(1,empList.get(i));
		rsMailEmp = psMailEmp.executeQuery();
		if(rsMailEmp.next()){
			mailList.add(rsMailEmp.getString("email"));
		}
	}
	//psMailEmp.setString()
	String message = "";
	String teamName = request.getParameter("teamName");
	//PreparedStatement psTemp = con.prepareStatement("select team_name from nomination_team where trim(upper(team_name))=? and status <>'RJ' and year='2019' and type is null"); ////previous query
	PreparedStatement psTemp = con.prepareStatement("select team_name from nomination_team where trim(upper(team_name))=? and status <>'RJ' and year='"+event_year+"' and "+event_type_check_string+" ");  ////year & type changes by tanu
	psTemp.setString(1,teamName.toUpperCase());
	ResultSet rsTemp = psTemp.executeQuery();
	if(rsTemp.next()){%>
		<script>
			alert("Team Name already Exist");
			location.href = "teamCluster.jsp";
		</script>
	<%} else {

		psTeam.setString(1,teamName);
		if(!isAdminTeam)
			psTeam.setString(2,empZoneTemp);
		else 
			psTeam.setString(2,request.getParameter("zonecdName"));
		message = "Team formation request has been received  from the following -<br/>Team Name <b>"+teamName+"</b><br>";
		message += "<table border=1 style=\"border-collapse: collapse;width:100%\" style=\"border-collapse: collapse\"><tr><td style=\"border-collapse: collapse;width:10%\">Employee No</td><td style=\"border-collapse: collapse;width:30%\">Name</td><td style=\"border-collapse: collapse;width:20%\">Relationship</td><td style=\"border-collapse: collapse;width:20%\">Phone No.</td><td style=\"border-collapse: collapse;width:20%\">Email ID</td></tr>";
 		//out.println("Mail is : "+mailList);
		//out.println("emp is : "+empList);
		for(int i=3; i<=7; i++) {
			psTeam.setString(i, "");
		}

query_cat_type = "select * from nomination_addition where evt_id=? and lower(lbl_name) like 'inter%' ";
ps_cat_type = con.prepareStatement(query_cat_type);
ps_cat_type.setString(1,event_id_toUse);
rs_cat_type = ps_cat_type.executeQuery();

//out.println("Riha-"+top_type_select);

if(rs_cat_type.next()){
if(rs_cat_type.getString("id").equals(top_type_select)){
	check_inter = true;
}
}


if(top_type_select.equals(inter_code_val_sub)){
	check_inter=true;
}





int loop_no=0;
//out.println("test1="+top_type_select);
	if(!check_inter){
		//out.println(check_inter);
		for(int i=0;i < mailList.size();i++){
			toMail  += ","+mailList.get(i);
			ps3.setString(1,empList.get(i));
			//ps3.setString(2,empList.get(i));
			rs3 = ps3.executeQuery();
			while(rs3.next()){
				teamCount++;
				message += "<tr><td style=\"border-collapse: collapse;width:10%\">"+rs3.getString("emp_no")+"</td><td style=\"border-collapse: collapse;width:30%\">"+rs3.getString("personName")+"</td><td style=\"border-collapse: collapse;width:20%\">"+rs3.getString("relation")+"</td><td style=\"border-collapse: collapse;width:20%\">"+rs3.getString("Contact")+"</td><td style=\"border-collapse: collapse;width:20%\">"+mailList.get(i)+"</td></tr>" ;
				if(teamCount<=5){
					psTeam.setString(2+teamCount,rs3.getString("perCode"));
				}
				/* out.println("person"+rs3.getString("perCode")); */
				memList += ",'"+rs3.getString("perCode")+"'";	
			}
		}
	}else{

	ps4 = con.prepareStatement(query3);
		//out.println("hi else");
		for(int i=0;i<empList.size();i++){
			++loop_no;
			toMail  += ","+mailList.get(i);

			//changed by Riha
			//toMail  += ","+mailList.get(i);
			memList += ",'"+empList.get(i)+"'";
			psTeam.setString(2+loop_no,empList.get(i));

			//out.print("/////////////"+empList.get(i));

			ps4.setString(1,empList.get(i));
			//ps4.setString(2,empList.get(i));
			rs4 = ps4.executeQuery();
			//out.print(empList.get(i)+"-");
			
			while(rs4.next()){

			//out.print("empno-"+rs4.getString("emp_no")+"-name-"+rs4.getString("personName")+"-relation-"+rs4.getString("relation")+"-contact-"+rs4.getString("Contact")+"-mailId-"+mailList.get(i));

				message += "<tr><td style=\"border-collapse: collapse;width:10%\">"+rs4.getString("emp_no")+"</td><td style=\"border-collapse: collapse;width:30%\">"+rs4.getString("personName")+"</td><td style=\"border-collapse: collapse;width:20%\">"+rs4.getString("relation")+"</td><td style=\"border-collapse: collapse;width:20%\">"+rs4.getString("Contact")+"</td><td style=\"border-collapse: collapse;width:20%\">"+mailList.get(i)+"</td></tr>" ;
				if(teamCount<=5){
					psTeam.setString(2+teamCount,rs4.getString("perCode"));
				}
				
				memList += ",'"+rs4.getString("perCode")+"'";	
			}
		}
	}


		/*for(int i=2+teamCount+1; teamCount<4; teamCount++){
			psTeam.setString(i, "");
		}*/
/* 		out.println("mss"+message+"<br/>");
		out.println("mss"+toMail+"<br/>");
		out.println("mss"+message+"<br/>"); */
		psTeam.setString(8,loginEmp);
		psTeam.setString(9,top_type_select);
		memList = memList.substring(1);
		//previous query
		//String participantCheck = "select team_name from nomination_team where (mem1 in ("+memList+") or mem2 in ("+memList+") or mem3 in ("+memList+") or mem4 in ("+memList+")) and status <> 'RJ' and year='2019' and type is null";
		String participantCheck = "select team_name from nomination_team where (mem1 in ("+memList+") or mem2 in ("+memList+") or mem3 in ("+memList+") or mem4 in ("+memList+")) and status <> 'RJ' and year='"+event_year+"' and "+event_type_check_string+" and type='"+top_type+"' "; ///year & type changes by tanu
		PreparedStatement psParticipantCheck = con.prepareStatement(participantCheck);
		ResultSet rsParticipantCheck = psParticipantCheck.executeQuery();
		if(rsParticipantCheck.next()){%>
			<script>
				alert("Some Team Member already applied for other group");
				location.href = "teamCluster.jsp";
			</script>			
		<%} else {
			if(teamCount<6){
				resultInt = psTeam.executeUpdate();   ////uncomment later
			}	
			message +="</table>";
			//Riha
			toMail = toMail.substring(1);
			//toMail= "tanu.sharma@hpcl.in";

			if(resultInt >0){ //khushboorajpal@hpcl.in
				String email_str = email.gen_email_call("APP208","D", " ",message,"khushboorajpal@hpcl.in",toMail,"","Event Nomination- Hum fit toh HP fit ("+top_type_name+")",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
				///uncomment in production
			%>
				<script>
					alert("You have successfully submitted your request for Team formation.");
					location.href = "myTeam.jsp";
				</script>
				<%} else {%>
				<script>
					alert("Select Team Members Properly");
				</script>
			<%}
		}
	}
}
List <String> teamList = new ArrayList <String>();
//previous query
//String queryExist = "select mem1,mem2,mem3,mem4 from nomination_team where status <>'RJ' and year='2019' and type is null";
String queryExist = "select mem1,mem2,mem3,mem4, mem5, type from nomination_team where status <>'RJ' and year='"+event_year+"' and "+event_type_check_string+" and type='"+top_type+"' " ; ///year & type changes by tanu
Statement psExistTeam = con.createStatement();
ResultSet rsExistTeam = psExistTeam.executeQuery(queryExist);
while(rsExistTeam.next()){
	teamList.add(rsExistTeam.getString("mem1"));
	teamList.add(rsExistTeam.getString("mem2"));
	teamList.add(rsExistTeam.getString("mem3"));
	teamList.add(rsExistTeam.getString("mem4"));
	teamList.add(rsExistTeam.getString("mem5"));
}

//out.print(teamList);
//previous query for event_id
//query = "select a.emp_no emp_no,a.child_name perCode,nvl(b.person_name,a.child_name) personName,a.age age,decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender,a.contact_no contact,e.zonecd, e.grade, e.budesc, e.bu, (select count(*) from NOMINATION_DEPENDENTS where event_name = '2019_285_event' and emp_no=a.emp_no) count from NOMINATION_DEPENDENTS a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code left join workflow.empmaster e on a.emp_no=e.emp_no where event_name = '2019_285_event' and a.emp_no in(select emp_no from empmaster where "+empZone+" ) and a.child_name not in (select person_code from nomination_winner) order by zonecd, bu, grade, (case emp_no when '"+loginEmp+"' then 0 else 1 end), perCode"; ///Change before Deploy portal.jdep to jdep1





query_tocheck_inter = "select * from nomination_emp_add where id=? ";
ps_check_inter = con.prepareStatement(query_tocheck_inter);

//out.print("/////"+event_id_toUse+"-"+tempJdep+"-"+event_id_toUse+"-"+condition+"-"+top_type+"-"+empZone+"-"+loginEmp+"////");

/*if(top_type.equals("Inter")){
	condition = " and a.relatation='SL' ";
}else if(top_type.equals("Intra")){
	condition = " ";
}else{
	condition = " ";
}*/

///older query 
//query = "select a.emp_no emp_no,a.child_name perCode,nvl(b.person_name,a.child_name) personName,a.age age,decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender,a.contact_no contact,e.emp_name employee_name,e.zonecd, e.grade, e.budesc, e.bu, (select count(*) from NOMINATION_DEPENDENTS where event_name = '"+event_id_toUse+"' and emp_no=a.emp_no) count from NOMINATION_DEPENDENTS a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code left join workflow.empmaster e on a.emp_no=e.emp_no where event_name = '"+event_id_toUse+"' "+condition+" and a.emp_no in(select emp_no from empmaster where "+empZone+" ) and a.child_name not in (select person_code from nomination_winner) order by zonecd, bu, grade, (case emp_no when '"+loginEmp+"' then 0 else 1 end), perCode"; ///Change before Deploy portal.jdep to jdep1
///event id changed by tanu, in prod correct id will be replaced

///new query

if(top_type.equals(inter_code_val_sub)){
	query = "select nom.emp_no, (select emp_name from workflow.empmaster e where e.emp_no=nom.emp_no) as employee_name,(select decode(em.sex,'M','MALE','F','FEMALE', em.sex) from workflow.empmaster em where em.emp_no=nom.emp_no) as gender,(select distinct(decode(nd.relatation,'SL','EMPLOYEE', nd.relatation)) from NOMINATION_DEPENDENTS nd where nd.child_name=nom.emp_no) as relation, (select nd.age from NOMINATION_DEPENDENTS nd where nd.child_name=nom.emp_no and nd.event_name=nom.evtnme) as age, (select nd.contact_no from NOMINATION_DEPENDENTS nd where nd.child_name=nom.emp_no and nd.event_name=nom.evtnme) as contact, (select em.grade from workflow.empmaster em where em.emp_no=nom.emp_no) as grade, (select em.bu from workflow.empmaster em where em.emp_no=nom.emp_no) as bu, (select em.zonecd from workflow.empmaster em where em.emp_no=nom.emp_no) as zonecd, (select nd.child_name from NOMINATION_DEPENDENTS nd where nd.child_name=nom.emp_no and nd.event_name=nom.evtnme) as perCode, (select jp.person_name from "+tempJdep+"jdep jp where jp.person_code=nom.emp_no) as personName from nomination nom where nom.emp_no in (select a.emp_no from nomination_champions a left join nomination_emp_add b on a.emp_no=b.emp_no where a.event_id='"+event_id_toUse+"' and b.id='"+inter_code_val+"' and b.value='Yes') and nom.evtnme = '"+event_id_toUse+"' order by nom.enterdte asc";
	//query = "select a.emp_no emp_no,a.child_name perCode,nvl(b.person_name,a.child_name) personName,a.age age,decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender,a.contact_no contact,e.emp_name employee_name,e.zonecd, e.grade, e.budesc, e.bu, (select count(*) from NOMINATION_DEPENDENTS where event_name = '"+event_id_toUse+"' and emp_no=a.emp_no) count from NOMINATION_DEPENDENTS a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code left join nomination_emp_add b on a.emp_no = b.emp_no left join workflow.empmaster e on a.emp_no=e.emp_no where event_name = '"+event_id_toUse+"' "+condition+" and b.value='Yes' and b.id='"+top_type+"' and a.emp_no in(select emp_no from empmaster where "+empZone+" ) and a.child_name not in (select person_code from nomination_winner) order by zonecd, bu, grade, (case emp_no when '"+loginEmp+"' then 0 else 1 end), perCode";
}
else if(top_type.equals(inter_code_val)){
query = "select a.emp_no emp_no,a.child_name perCode,nvl(b.person_name,a.child_name) personName,a.age age,decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender,a.contact_no contact,e.emp_name employee_name,e.zonecd, e.grade, e.budesc, e.bu, (select count(*) from NOMINATION_DEPENDENTS where event_name = '"+event_id_toUse+"' and emp_no=a.emp_no) count from NOMINATION_DEPENDENTS a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code left join nomination_emp_add c on a.emp_no = c.emp_no left join workflow.empmaster e on a.emp_no=e.emp_no where event_name = '"+event_id_toUse+"' "+condition+" and c.value='Yes' and c.id='"+top_type+"' and a.emp_no in(select emp_no from empmaster where "+empZone+" ) and a.emp_no not in (select emp_no from nomination_champions where event_id='"+event_id_toUse+"') order by zonecd, bu, grade, (case emp_no when '"+loginEmp+"' then 0 else 1 end), perCode"; ///Change before Deploy portal.jdep to jdep1
///event id changed by tanu, in prod correct id will be replaced
}
else{
query = "select a.emp_no emp_no,a.child_name perCode,nvl(b.person_name,a.child_name) personName,a.age age,decode(a.relatation,'SL','EMPLOYEE','SP','SPOUSE',a.relatation) relation, decode(a.gender,'M','MALE','F','FEMALE',a.gender) gender,a.contact_no contact,e.emp_name employee_name,e.zonecd, e.grade, e.budesc, e.bu, (select count(*) from NOMINATION_DEPENDENTS where event_name = '"+event_id_toUse+"' and emp_no=a.emp_no) count from NOMINATION_DEPENDENTS a left join "+tempJdep+"jdep b on a.emp_no =b.emp_no and a.child_name = b.person_code left join nomination_emp_add c on a.emp_no = c.emp_no left join workflow.empmaster e on a.emp_no=e.emp_no where event_name = '"+event_id_toUse+"' "+condition+" and c.value='Yes' and c.id='"+top_type+"' and a.emp_no in(select emp_no from empmaster where "+empZone+" ) order by zonecd, bu, grade, (case emp_no when '"+loginEmp+"' then 0 else 1 end), perCode"; ///Change before Deploy portal.jdep to jdep1
///event id changed by tanu, in prod correct id will be replaced
}


//out.println(query);
ps = con.prepareStatement(query);
//rs2 = ps.executeQuery();
%>

<script>
	function submit_top_type(id){
		//alert(id.value);
		window.location.href= "teamCluster.jsp?t="+id.value;
	}
</script>


<br/>
	<div class = "card row">
	<div class = "card-header alert alert-success"><h4>Choose your Team </h4></div>
	<div class = "card-body">

		<div class= "row">

		<div class="col-sm-4">
			<label for = "top_type_select" style = "color:red">Select Category</label> 
			<%
			if(type_exists.equals("")){

			//out.print("case if1");
				query_cat_type = " SELECT * FROM nomination_addition a left join nomination_emp_add b on a.id=b.id WHERE evt_id=? and value='Yes' and b.emp_no=?  "; 
			}else{
			//out.print("case else1");
				query_cat_type = " SELECT * FROM nomination_addition a left join nomination_emp_add b on a.id=b.id WHERE evt_id=? and 	value='Yes' and b.emp_no=? and a.id not in ("+type_exists+") "; 
			}
				//out.println("query="+query_cat_type);
			%>
			<select id="top_type_select" name="top_type_select" class="form-control" onchange="submit_top_type(this)">
				<option value="">Select Category</option>
				<%
				//query_cat_type = "select * from nomination_addition where evt_id=?";
				ps_cat_type = con.prepareStatement(query_cat_type);
				ps_cat_type.setString(1,event_id_toUse);
				ps_cat_type.setString(2,loginEmp);
				rs_cat_type = ps_cat_type.executeQuery();
				while(rs_cat_type.next()){
					if(check_cham && !rs_cat_type.getString("lbl_name").equals("Inter-Corporate Challenge")){
				%>
					<option value="<%=rs_cat_type.getString("id")%>" <%=(top_type.equals(rs_cat_type.getString("id"))? "selected='selected'" : "" ) %>  ><%=rs_cat_type.getString("lbl_name")%></option>
				<%}else if(!check_cham){%>
					<option value="<%=rs_cat_type.getString("id")%>" <%=(top_type.equals(rs_cat_type.getString("id"))? "selected='selected'" : "" ) %>  ><%=rs_cat_type.getString("lbl_name")%></option>
				<%}else{%>
				<%}
				}

				//ps3 = con.prepareStatement("select * from nomination_champions where event_id='"+event_id_toUse+"' and type='Champions League' and year='"+event_year+"' and emp_no=? "

ps3 = con.prepareStatement("select nc.percode, nc.type,(select distinct(id) from nomination_emp_add nea where nea.emp_no=nc.percode and id='"+inter_code_val+"' and value='Yes') as id_val from nomination_champions nc where event_id='"+event_id_toUse+"' and nc.type='Champions League' and nc.year='"+event_year+"' and nc.emp_no=?");

				//out.println("select nc.percode, nc.type,(select distinct(id) from nomination_emp_add nea where nea.emp_no=nc.percode and id='796' and value='Yes') as id_val from nomination_champions nc where event_id='"+event_id_toUse+"' and nc.type='Champions League' and nc.year='"+event_year+"' and nc.emp_no=? ");
				ps3.setString(1,loginEmp);
				rs3 = ps3.executeQuery();

//&& teamList.contains(rs3.getString("emp_no") )

				if(rs3.next() && !nullVal(rs3.getString("id_val")).equals("") ){					
				%>
					<option value="<%=inter_code_val_sub%>" <%=(top_type.equals(inter_code_val_sub)? "selected='selected'" : "" ) %>  ><%=rs3.getString("type")%></option>
				<%}

				%>
				<!--<option value="Inter" <%= (top_type.equals("Inter")? "selected='selected'" : "" ) %>  >Inter-Corporate Challenge</option>
				<option value="Intra" <%= (top_type.equals("Intra")? "selected='selected'" : "" ) %> >Intra-Corporate Challenge</option>-->
			</select>
		</div>

		<%if(!top_type.equals("")){%>	
		<div class ="col-sm-4">
			<label for = "teamName" style = "color:red">TEAM NAME</label>
			<input type = "text" class = "form-control" name = "teamName" id = "teamName"><br/>
		</div>
		<div class = "col-sm-4" align="center">
			<button name = "goTeam" class ="btn style-right-button" onclick = "return goSubmit();" style="margin-top:8%">Submit</button>
		</div>
		<%}%>
		</div>
	<%if(isAdminTeam){%>
		<br><div class = "row">
			<div class ="col-md-6">
				<label for = "zonecdName">Select the Zone</label>
				<select name = "zonecdName" class = "form-control" id = "zonecdName">
					<option value = "10501">HQO</option>
					<option value = "48000">Mumbai Refinery</option>
					<option value = "46000">Visakh Refinery</option>
					<option value = "11350">West Zone</option>
					<option value = "11370">North West Zone</option>
					<option value = "11600">East Zone</option>
					<option value = "11100">North Zone</option>
					<option value = "11120">North Central Zone</option>
					<option value = "11750">South Zone</option>
					<option value = "11770">South Central Zone</option>
				</select>
			</div>
		</div><br>	
	<%}%>

	<%if(!top_type.equals("")){%>

<br/>
		<div class="row">
		<div class="col-sm-4">
		<input type="text" id="myInput" class="style-left style-border style-border-blue-gray form-control" onkeyup="myFunction()" placeholder="&#128269; &nbsp;Search Employee">
		</div>
		</div>

		<br/>
		<div class ="table-responsive">
			<table class= "table table-bordered table-stripped table-hover listTable" id="table1" >
				<thead>
					<tr>
						<th>#</th>
						<th style="display: none;">Hidden</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Relation</th>
						<th>Age</th>
						<th>Contact No</th>
						<th>Grade</th>
						<th>BU</th>
						<th>Zone</th>
					</tr>
				</thead>
				<tbody>
				<%
				rs2 = ps.executeQuery();
				while(rs2.next()){
if(!teamList.contains(rs2.getString("perCode"))){
					if(!(isAdminTeam && teamList.contains(rs2.getString("perCode"))) || !(teamList.contains(rs2.getString("perCode"))) ){
				%>
					<tr <%=teamList.contains(rs2.getString("perCode"))?"class='alert alert-danger'":""%>>
						<td>
						<%if(!teamList.contains(rs2.getString("perCode"))){%>
						<input type = "checkbox" name ="chk1" value = "<%=rs2.getString("emp_no")%>" <%=!isAdminTeam && rs2.getString("emp_no").equals(loginEmp)?"checked":""%> <%=!isAdminTeam && (rs2.getString("emp_no").equals(loginEmp))?"readonly":""%> onclick = "return getOnClick('<%=rs2.getString("emp_no")%>')" >
						<%}%>
						</td>
						</td>
						<td style="display: none;"><%=rs2.getString("employee_name")%> - <%=rs2.getString("emp_no")%></td>
						<td><%=rs2.getString("personName")%> <%if(top_type.equals("Intra")){%> (<%=rs2.getString("count")%>) <%}%> </td>
						<td><%=rs2.getString("gender")%></td>
						<td><%=rs2.getString("relation")%></td>
						<td><%=rs2.getString("age")%></td>
						<td><%=rs2.getString("contact")%></td>
						<td><%=rs2.getString("grade")%></td>
						<td><%=rs2.getString("bu")%></td>
						<td><%=rs2.getString("zonecd")%></td>
					</tr>
				<%
				} }
			}
/*} catch (Exception e){
		out.println("Some Error Occured"+e);
}*/%>
				</tbody>
			</table>
		</div>
<%}%>


		<center></center>
		</div>
	</div>
	<input type = "hidden" name = "empGrade" id = "empGrade" value = "<%=empGrade%>">
</form>	
</div>

<script>
function myFunction() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  //alert(input);
 // alert("input value="+input.value);
  filter = input.value.toUpperCase();
  table = document.getElementById("table1");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}
</script>

<%
//if(conDev!=null) conDev.close();
%>



