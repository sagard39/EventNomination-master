<%@ include file="header1.jsp"%>
<script>
function submitForm1(){
	if(validate()){
		document.form1.action_type.value="submitVal";
		document.form1.submit();
	}else{
		return false;
	}
}
function validate(){
	var evt=$("#evt_id").val();
	var locn=$("#locn").val();
	var deptNo=$("#deptNo").val();
	if(evt=='-1' && locn=='-1' && deptNo=='-1'){
		alert("Select atleast one Entry");
		return false;
	}
	return true;
}
</script>
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
int count=0;
boolean isFlag=false;
PreparedStatement psEvt=null;
ResultSet rsEvt=null;
String queryChild="",queryMstr="",view="";
String query="",townName="",dept="",evt_id="",action_type="",subQry="";
Map<String,String> evtMap=new HashMap<String,String>();
Map<String,String> deptMap=new HashMap<String,String>();
List<String> townList=new ArrayList<String>();
view=nullVal(request.getParameter("q"));
if(!(isAdmn || isDefAdmin)){%>
	<script>
		alert("You are not Allowed to access this Page");
		//window.location.href="home.jsp";
	</script>
<%}
action_type=nullVal(request.getParameter("action_type"));
if(isDefAdmin){
	subQry="";
	isAdmn=false;
}	
else if(isAdmn)
	subQry=" and (substr(adminEmp,0,8)=? or substr(adminEmp,10,18)=?)";
try{
query="select distinct evt_id,evtnme,evt_date from nomination_admin where evt_id is not null"+subQry+" order by evt_date desc";
psEvt=con.prepareStatement(query);

if(isAdmn){
	psEvt.setString(1,emp);
	psEvt.setString(2,emp);
}
rsEvt=psEvt.executeQuery();
while(rsEvt.next())
	evtMap.put(rsEvt.getString("evt_id"),rsEvt.getString("evtnme"));

query="select distinct b.budesc,b.bu from bu b left join empmaster e on b.bu=e.bu left join nomination n on n.emp_no=e.emp_no left join nomination_admin na on n.evtnme=na.evt_id where na.evt_id is not null"+subQry;
psEvt=con.prepareStatement(query);
if(isAdmn){
	psEvt.setString(1,emp);
	psEvt.setString(2,emp);
}
rsEvt=psEvt.executeQuery();
while(rsEvt.next())
	deptMap.put(rsEvt.getString("bu"),rsEvt.getString("budesc"));

query="select distinct e.town from empmaster e  left join nomination n on n.emp_no=e.emp_no left join nomination_admin na on n.evtnme=na.evt_id where na.evt_id is not null"+subQry;
psEvt=con.prepareStatement(query);
if(isAdmn){
psEvt.setString(1,emp);
psEvt.setString(2,emp);
}
rsEvt=psEvt.executeQuery();
while(rsEvt.next())
	townList.add(rsEvt.getString("town"));


%>
<div class="id">
	<form name="form1" action="viewReports1.jsp" method="post">
		<div style="margin:30px;float:right"><a href="viewReports1.jsp?q=All">Click Here for Standard Report</a></div>
<%if("".equals(view)){%>		
		<div style="margin:30px;width:100%">
			<div style="width:20%;float:left">
				<strong>Select the Event</strong>	
				<span><select style="width:100%" name="evtName" id="evt_id">
				<option value="">Select</option>
				<%
				for(Map.Entry<String,String> entry:evtMap.entrySet()){%>
				<option	value="<%=entry.getKey()%>"><%=entry.getValue()%></option>	
				<%}
				%>
				</select></span>
			</div>
			<div style="margin:20px;float:left"><strong><center></center></strong></div>
			<div style="margin-left:40px;width:20%;float:left">
				<strong>Select the Department</strong>
				<span><select name="dept" id="deptNo">
				<option value="">Select</option>
				<%for(Map.Entry<String,String>entryDept:deptMap.entrySet()){%>
				<option value="<%=entryDept.getKey()%>"><%=entryDept.getValue()%></option>
				<%}%>
				</select></span>
			</div>
			<div style="margin:20px;float:left"><strong><center></center></strong></div>
			<div style="margin-left:40px;width:20%;float:left">
				<strong>Select the Location</strong>
				<span>
					<select name="locn" id="locn">
						<option value="">Select</option>
						<%for(int i=0;i<townList.size();i++){%>
						<option value="<%=townList.get(i)%>"><%=townList.get(i)%></option>	
						<%}%>
					</select>
				</span>
			</div>
			<div style="margin-left:60px;margin-top:10px;float:left;">
				<input type="submit" name="submitRept" value="Submit" onclick="return submitForm1();"/>
			</div>
		</div>
		<div id="clear" class="clear"></div><br/>
<%
evt_id=nullVal(request.getParameter("evtName"));
dept=nullVal(request.getParameter("dept"));		
townName=nullVal(request.getParameter("locn"));
boolean isEmpty=false;
 if(!"".equals(evt_id) && !"".equals(dept) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.bu='"+dept+"' and e.town='"+townName+"' and n.flag='S' order by enterdte desc ";
} else if((!"".equals(evt_id) && !"".equals(dept)) && "".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.bu='"+dept+"' order by enterdte desc ";
} else if((!"".equals(evt_id) && "".equals(dept)) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.town='"+townName+"' and n.flag='S' order by enterdte desc ";
} else if(("".equals(evt_id) && !"".equals(dept)) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.bu='"+dept+"' and e.town='"+townName+"' and n.flag='S' order by enterdte desc ";
} else if(!"".equals(evt_id) && "".equals(dept) && "".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and n.flag='S' order by enterdte desc ";
} 

if("".equals(evt_id) && !"".equals(dept) && "".equals(townName)){
	isFlag=true;
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.bu='"+dept+"' and n.flag='S' order by enterdte desc ";	
} else if("".equals(evt_id) && "".equals(dept) && !"".equals(townName)){
	isFlag=true;
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') enterdate1,enterdte,rownum  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.town='"+townName+"' and n.flag='S' order by enterdte desc ";	
}
//out.println(queryChild);
%>		
		<div class="" style="margin-top:70px;width:100%">
		<%
		evt_id=nullVal(request.getParameter("evtName"));		
	if("submitVal".equals(action_type)){%>
			<centeR>
	<%
	query="Select Sum(Ticktscnt) count From Nomination Where Evtnme=? And Flag='S' ";
	psEvt=con.prepareStatement(query);
	psEvt.setString(1,evt_id);
	rsEvt=psEvt.executeQuery();
	if(rsEvt.next()){
	%>		
			<marquee behavior='alternate' onmouseover="this.stop()" onmouseout="this.start()"><font color="red" size="5">Total <font size="5" color="blue"><%=rsEvt.getInt("count")%></font> Entries for the Event</marquee>
	<%}%>		
			<span  style="float:left;margin-left:30%;"><a href="viewReport_x.jsp?evt_id=<%="-1".equals(evt_id)?"":evt_id%>&locn=<%="-1".equals(townName)?"":townName%>&dept=<%="-1".equals(dept)?"":dept%>"><img src="images/excel1.png" title="Download By Employee"></a></span>
			<%if(!"".equals(evt_id)){%>
			<span ><a href="viewReport_excel.jsp?q=<%="-1".equals(evt_id)?"":evt_id%>"><img src="images/excel1.png" width="20" title="Download By Applicant"></a></span>	
			<%}%>
			<table class="listTable1" border="1" style="width:70%;border-collapse:collapse;">
				<br/><thead>
					<tr>
						<th>#</th>
						<th>Event Name</th>
						<th>Employee</th>
						<th>Total Tickets</th>
						<th>Payable Amount</th>
						<th>Applied Date</th>
					</tr>
				</thead>
				<tbody>
<%
psEvt=con.prepareStatement(queryChild);
//psEvt.setString(1,queryMstr);
rsEvt=psEvt.executeQuery();
while(rsEvt.next()){count++;%>
					<tr>
						<td><%=count%></td>
						<td><%=rsEvt.getString("event_nme")%></td>
						<td><%=rsEvt.getString("emp_name")%>(<%=rsEvt.getString("emp_no")%>)</td>
						<td align="center"><%=rsEvt.getString("TICKTSCNT")%></td>
						<td align="center"><%=rsEvt.getString("PAYMENTCNT")%></td>
						<td><%=rsEvt.getString("enterdate1")%></td>
					</tr>
<%}
%>				
				</tbody>

			</table></center>
		<%}
		%>
		</div>
		<input type="hidden" name="action_type" id="" />
<%} else{%>
	<div style="margin:30px;">
		<center>
			<h3><u>Standard Report</u></h3>
		<table class="listTable1" border="1" style="width:70%;border-collapse:collapse;">
			<thead>
				<tr>
					<th>&sect;</th>
					<th>Location Code</th>
					<th>Location Name</th>
					<th>Activity Name</th>
					<th>Date of Activity</th>
					<th>No of Employee Participated</th>
					<th>Total Participants</th>
					<th>Total Expenditure<br/>(in Rs.)</th>
					<th>Total Amount Recovered from Employees<br/>(in Rs.)</th>
				</tr>
			</thead>
			<tbody>
<%count=0;
query="select e.bu,e.budesc,initcap(na.evtnme) evtnme,sum(n.ticktscnt) total_count,sum(n.paymentcnt) toal_payment,to_char(na.evt_date,'dd-Mon-yyyy') event_date,count(distinct n.emp_no) empcnt from nomination_admin na left join nomination n on na.evt_id=n.evtnme left join empmaster e on n.emp_no=e.emp_no where na.evt_id is not null and n.ticktscnt is not null and flag='S'  group by e.bu,e.budesc,na.evtnme, na.evt_date order by evtnme asc ";
psEvt=con.prepareStatement(query);
rsEvt=psEvt.executeQuery();
while(rsEvt.next()){%>
				<tr>
					<td><%=++count%></td>	
					<td><%=nullVal(rsEvt.getString("bu"))%></td>
					<td><%=nullVal(rsEvt.getString("budesc"))%></td>
					<td><%=rsEvt.getString("evtnme")%></td>	
					<td><%=rsEvt.getString("event_date")%></td>	
					<td align="center"><%=rsEvt.getString("empcnt")%></td>	
					<td align="center"><%=rsEvt.getString("total_count")%></td>	
					<td></td>
					<td align="center"><%=rsEvt.getString("toal_payment")%></td>					
				</tr>
<%}%>
			</tbody>	
		</table></center>
	</div>
<%}
}catch(SQLException sqle){
		out.println("SQL Exception"+sqle);
}catch(Exception e){
	out.println("Other Exception "+e);
}
%>		
	</form>
</div>