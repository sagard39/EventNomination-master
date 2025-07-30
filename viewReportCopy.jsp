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
function getEvtType(Obj){
	var ObjVal = Obj.value;
	document.form1.evtType.value = ObjVal;
	document.form1.submit();
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
PreparedStatement psEvt=null;
ResultSet rsEvt=null;
String queryChild="",queryMstr="",view="";
String query="",townName="",dept="",evt_id="",action_type="",subQry="";
Map<String,String> evtMap=new LinkedHashMap<String,String>();
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
String evtType = nullVal(request.getParameter("evtType"));
if(isDefAdmin){
	subQry="";
	isAdmn=false;
}	
else if(isAdmn)
	subQry=" and (substr(adminEmp,0,8)=? or substr(adminEmp,10,18)=?)";
if("".equals(evtType))
	subQry += " and evt_date is not null ";
else if("X".equals(evtType)){
	subQry += " and evt_date< sysdate " ; 
} else if("A".equals(evtType)){
	subQry += " and evt_date>= sysdate ";
}
//try{
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
	<form name="form1" action="viewReports1.jsp" method="post">
	<input type = "hidden" name = "evtType" id = "evtType" value = ""> 
	
<div class="container">
<div class="card md-10 box shadow">		
<div class="card-header alert alert-primary">Event Reports</div>
<div class="card-body">
<div class = "row">
	<div class = "form-check">
		<input type = "radio" name = "rad1" class = "form-check-inline" <%="A".equals(evtType)?"checked":""%> value = "A" id = "evt1" onclick = "return getEvtType(this);" ><label for = "evt1"> Current Events </label>&nbsp;&nbsp;
		<input type = "radio" name = "rad1" class = "form-check-inline" value = "X" <%="X".equals(evtType)?"checked":""%> id = "evt2" onclick = "return getEvtType(this);" ><label for = "evt2"> Archived Events</label>
	</div>
</div><br/>
<%if("".equals(view)){%>		
		<div class="row">
			<div class="col-md-3" >
				<strong>Select the Event</strong>	
				<span><select class="form-control" style="width:100%" name="evtName" id="evt_id">
				<option value="">Select</option>
				<%
				for(Map.Entry<String,String> entry:evtMap.entrySet()){%>
				<option	value="<%=entry.getKey()%>"><%=entry.getValue()%></option>	
				<%}
				%>
				</select></span>
			</div>
			
			<div class="col-md-3">
				<strong>Select the Department</strong>
				<span><select class="form-control" name="dept" id="deptNo">
				<option value="">Select</option>
				<%for(Map.Entry<String,String>entryDept:deptMap.entrySet()){%>
				<option value="<%=entryDept.getKey()%>"><%=entryDept.getValue()%></option>
				<%}%>
				</select></span>
			</div>
			
			<div class="col-md-3">
				<strong>Select the Location</strong>
				<span>
					<select name="locn" class="form-control" id="locn">
						<option value="">Select</option>
						<%for(int i=0;i<townList.size();i++){%>
						<option value="<%=townList.get(i)%>"><%=townList.get(i)%></option>	
						<%}%>
					</select>
				</span>
			</div>
			<div class="col-md-3"><a href="viewReports1.jsp?q=All">Click Here for Standard Report</a>
				<input type="submit" name="submitRept" value="Submit" onclick="return submitForm1();"/></center>
			</div>
		</div>
<!--<div class="row">
			<div class="col-sm-12"><br/>
			<center>	
			</div>
</div>-->		
<%
evt_id=nullVal(request.getParameter("evtName"));
dept=nullVal(request.getParameter("dept"));	
String queryAddtionalField="select lbl_name,upper(lbl_type) lbl_type,id from NOMINATION_ADDITION where  evt_id=? ";	
String queryAdditionlFieldValue="select nvl(value,' ')value,id from NOMINATION_EMP_ADD where id in(select id from NOMINATION_ADDITION where evt_id=?) and emp_no=?";
PreparedStatement psAdditional=null;
PreparedStatement psAdditionalValue=null;
ResultSet rsAdditional=null;
ResultSet rsAdditionalValue=null;
townName=nullVal(request.getParameter("locn"));
/*if(!("".equals(evt_id)) && !("".equals(townName)) && !("".equals(dept))){
	queryChild="select distinct n.emp_no,n.TICKTSCNT,n.PAYMENTCNT,e.emp_name,e.town,(select evtnme from nomination_admin na where n.evtnme=na.evt_id) evt_name,(select to_char(n.enterdte,'dd-Mon-yyyy') evt_date from nomination_admin na where n.evtnme=na.evt_id)evt_date  from nomination n left join empmaster e on n.emp_no=e.emp_no where n.evtnme=? and e.town='"+townName+"' and e.bu='"+dept+"'";
	queryMstr=evt_id;
}else{
	if(!("".equals(evt_id))){
		queryChild="select distinct n.enterdte,na.evt_id,na.evtnme evt_name, n.emp_no,e.emp_name,na.evtnme,to_char(n.enterdte,'dd-Mon-yyyy') evt_date ,n.ticktscnt,n.PAYMENTCNT,e.town from nomination_admin na left join nomination n on na.evt_id=n.evtnme left join empmaster e on n.emp_no=e.emp_no where na.evt_id is not null and n.emp_no is not  null and na.evt_id=? order by modifydte desc";	
		queryMstr=evt_id;
		
	}else if(!("".equals(townName))){
		queryChild="select distinct n.enterdte,na.evt_id,na.evtnme evt_name,n.emp_no,e.emp_name,na.evtnme,to_char(n.enterdte,'dd-Mon-yyyy') evt_date ,n.ticktscnt,n.PAYMENTCNT,e.town from nomination_admin na left join nomination n on na.evt_id=n.evtnme left join empmaster e on n.emp_no=e.emp_no where na.evt_id is not null and n.emp_no is not  null and e.town=? order by modifydte desc,na.evtnme asc";
		queryMstr=townName;
	} else if(!("".equals(dept))){
		queryChild="select distinct n.enterdte,na.evt_id,na.evtnme evt_name,n.emp_no,e.emp_name,na.evtnme,to_char(n.enterdte,'dd-Mon-yyyy') evt_date ,n.ticktscnt,n.PAYMENTCNT,e.town from nomination_admin na left join nomination n on na.evt_id=n.evtnme left join empmaster e on n.emp_no=e.emp_no where na.evt_id is not null and n.emp_no is not  null and e.bu=? order by modifydte desc,na.evtnme asc";
		queryMstr=dept;
	}
}*/
boolean isEmpty=false;
if("".equals(evt_id) && "".equals(dept) && "" .equals(townName)){
	isEmpty=true;
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id where rownum<=50 order by modifydte1 desc ";
} else if(!"".equals(evt_id) && !"".equals(dept) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.bu='"+dept+"' and e.town='"+townName+"' and n.flag='S' order by modifydte1 desc ";
} else if((!"".equals(evt_id) && !"".equals(dept)) && "".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.bu='"+dept+"' order by modifydte1 desc ";
} else if((!"".equals(evt_id) && "".equals(dept)) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and e.town='"+townName+"' and n.flag='S' order by modifydte1 desc ";
} else if(("".equals(evt_id) && !"".equals(dept)) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1  from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.bu='"+dept+"' and e.town='"+townName+"' and n.flag='S' order by modifydte1 desc ";
} else if(!"".equals(evt_id) && "".equals(dept) && "".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where evt_id='"+evt_id+"' and n.flag='S' order by modifydte1 desc ";
} else if("".equals(evt_id) && !"".equals(dept) && "".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI:SS') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.bu='"+dept+"' and n.flag='S' order by modifydte1 desc ";	
} else if("".equals(evt_id) && "".equals(dept) && !"".equals(townName)){
	queryChild="select n.evtnme,na.evtnme event_nme,n.emp_no,e.town,e.budesc,(select emp_name from empmaster where emp_no=n.emp_no) emp_name,n.TICKTSCNT,n.paymentcnt,to_char(enterdte,'dd-Mon-YYYY HH24:MI') enterdate1,enterdte,rownum,to_char(modifydte,'dd-Mon-YYYY HH24:MI') modifydte,modifydte modifydte1   from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where e.town='"+townName+"' and n.flag='S' order by modifydte1 desc ";	
}
//out.println(queryChild);
%>		<div class="row">

		<div class="table-responsive" style="margin-top:70px;width:100%">
		<%
		evt_id=nullVal(request.getParameter("evtName"));		
	if("submitVal".equals(action_type)){%>
			<centeR>
	<%
	int cnt = 0;
	String countString = "<marquee behavior='alternate' onmouseover='this.stop()' onmouseout='this.start()'>";
	if("2018_126_event".equals(evt_id)){
		query = "select sum(ticktscnt) countTickets,count(distinct emp_no) empCount,'Submitted' as flag from nomination where evtnme = ? and flag <>'X' GROUP BY 'Submitted' ";
	} else {
		query="select Sum(Ticktscnt) countTickets,count(distinct emp_no) empCount ,decode(flag,'A','Saved','S','Submitted',flag) flag from nomination where evtnme =? and flag <>'X' group by flag order by flag desc";
	}	
	psEvt=con.prepareStatement(query);
	psEvt.setString(1,evt_id);
	rsEvt=psEvt.executeQuery();
		while(rsEvt.next()){cnt++;
			if("2018_126_event".equals(evt_id)){
				countString += "<font color='red' size='5'>Total <font size='5' color='blue'>"+rsEvt.getInt("countTickets")+"</font>  Nominations by "+rsEvt.getString("empCount")+" Employees for the Event.";
			}else{ 
				countString += "<font color='red' size='5'>Total <font size='5' color='blue'>"+rsEvt.getInt("countTickets")+"</font> "+rsEvt.getString("flag")+ " Nominations by "+rsEvt.getString("empCount")+" Employees for the Event. <br>";
			}
		}
	countString +="</marquee>";
	%>
	
		<%=countString%>
			<span  style="float:left;margin-left:30%;"><a href="viewReport_x.jsp?evt_id=<%="-1".equals(evt_id)?"":evt_id%>&locn=<%="-1".equals(townName)?"":townName%>&dept=<%="-1".equals(dept)?"":dept%>"><img src="images/excel1.png" title="Download By Employee"></a></span>
			<%if(!"".equals(evt_id)){%>
			<span ><a href="viewReport_excel.jsp?q=<%="-1".equals(evt_id)?"":evt_id%>"><img src="images/excel1.png" width="20" title="Download By Applicant"></a></span>	
			<%}%>
			<table class="table table-hover table-bordered">
				<thead class ="alert alert-success">
					<tr>
						<th>#</th>
						<th>Event Name</th>
						<th>Employee</th>
						<th>No. of Nominations</th>
						<th>Amount Payable</th>
						<th>Applied Date</th>
						<th>Modified Date</th>
<%
Set<String> lblSet = new HashSet<String>();
psAdditional = con.prepareStatement(queryAddtionalField);
psAdditional.setString(1,evt_id);
rsAdditional=psAdditional.executeQuery();
while(rsAdditional.next()){%>
						<th><%=rsAdditional.getString("lbl_name")%><br/>(<%=rsAdditional.getString("lbl_type")%>)</th>
						<%if(rsAdditional.getString("lbl_type").equals("FILE")){
							lblSet.add(rsAdditional.getString("id"));
						}%>
<%}%>
					</tr>
				</thead>
				<tbody>
<%
psEvt=con.prepareStatement(queryChild);
//psEvt.setString(1,queryMstr);
rsEvt=psEvt.executeQuery();
psAdditionalValue = con.prepareStatement(queryAdditionlFieldValue);
psAdditionalValue.setString(1,evt_id);
while(rsEvt.next()){count++;%>
					<tr>
						<td><%=count%></td>
						<td><%=rsEvt.getString("event_nme")%></td>
						<td><%=rsEvt.getString("emp_name")%>(<%=rsEvt.getString("emp_no")%>)</td>
						<td align="center"><%=rsEvt.getString("TICKTSCNT")%></td>
						<td align="center"><%=rsEvt.getString("PAYMENTCNT")%></td>
						<td><%=rsEvt.getString("enterdate1")%></td>
						<td><%=rsEvt.getString("modifydte")%></td>
<%
psAdditionalValue.setString(2,rsEvt.getString("emp_no"));
rsAdditionalValue = psAdditionalValue.executeQuery();
while(rsAdditionalValue.next()){%>
						<td>
						<%if(lblSet.contains((rsAdditionalValue.getString("id")))){%>
					<a href="useruploads1/<%=rsAdditionalValue.getString("value")%>" target="_blank"><%=rsAdditionalValue.getString("value")%></a>
<%}else{%>
					<%=rsAdditionalValue.getString("value")%>
<%}}%></td>
					</tr>
<%}
%>				
				</tbody>

			</table></center>
		<%}
		%>
		</div></div>
		<input type="hidden" name="action_type" id="" />
<%} else{%>
	<div style="margin:25px;">
		<center>
			<h3><u>Listing Report</u></h3>
		<div class="table-responsive">
		<table class="table table-hover table-bordered">
			<thead class ="alert alert-success">
				<tr>
					<th>&sect;</th>
					<th>Location Code</th>
					<th>Location Name</th>
					<th>Activity Name</th>
					<th>Date of Activity</th>
					<th>No of Employee Participated</th>
					<th>Total Participants</th>
					<th>Total Expenditure<br/>(in Rs.)</th>
					<th>Amount to be Recovered<br/>(in Rs.)</th>
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
		</table></div></center>
	</div>
<%}
/*}catch(SQLException sqle){
		out.println("SQL Exception"+sqle);
}catch(Exception e){
	//out.println("Other Exception "+e);
}*/
%>		
	</form>
</div>
</div>
