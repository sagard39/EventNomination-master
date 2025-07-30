<%@ include file = "header.jsp"%>

<script>
function getSubmit(){
	if(Validation()){
		if(!confirm("Are You sure,Do you really want to submit?"))
				return false;
		else{
			document.form1.action_type.value = "goSubmit";
			document.form1.submit();
		}
	} else 
		return false;
}
function Validation(){
	var chkVal = $("#total_cnt").val();
	for(var i = 1 ;i<=chkVal;i++){
		if($("#contact_no"+i).val()==""){
			alert("Please Enter the Contact no in Row No : "+i);
			return false;
		}
	}
	return true;
}

</script>
<%String query = "",action_type = "";
PreparedStatement psChange= null,psUpdate = null;
ResultSet rsChange = null,rsUpdate = null;

String logEmp = (String)session.getAttribute("EVT_USRID");
String logEmp_Town = (String)session.getAttribute("TOWN");
String logEmp_Year = (String)session.getAttribute("EVT_YEAR");

query = "select  distinct nvl(b.person_name,a.person_code) person_code,a.gender,a.age,decode(a.running_mode,'M','Marathon','W','Walkathon',a.running_mode) running_mode,a.distance,case when cast(age as int) between 9 and 11 then '9 to 12 (Non-Compete Category)' when cast(age as int) between 12 and 14 then '12 to 15' when cast(age as int) between 15 and 23 then  '15 to 24' when cast(age as int) between 24 and 34 then  '24 to 35' when cast(age as int) between 35 and 49 then  '35 to 50' when cast(age as int) between 50 and 60 then  '50 to 60' else 'over 60 (Non-Compete Category)' end as Age_grp,tshirt_size,nvl(contact_no,'') contact_no,a.rowid from  nomination_marathon_entry a left join "+tempTable+"jdep b on a.person_code = b.person_code where a.emp_no=? and a.year = ? and a.person_code <>?"; 

action_type = request.getParameter("action_type");

psChange = con.prepareStatement(query);
psChange.setString(1,logEmp);
psChange.setString(2,logEmp_Year);
psChange.setString(3,logEmp);
rsChange = psChange.executeQuery();
int cntVal = 0,updateCnt = 0;
if("goSubmit".equals(action_type)){
	String[] chkArr = request.getParameterValues("chk1");
	String[] contactArr = request.getParameterValues("contact_no");
	query = "update nomination_marathon_entry set contact_no = ? where rowid= ?";
	psUpdate = con.prepareStatement(query);
	for(int i =0 ;i<chkArr.length;i++){
		psUpdate.setString(1,contactArr[i]);
		psUpdate.setString(2,chkArr[i]);
		updateCnt = psUpdate.executeUpdate();
	}
}
if(updateCnt>0){%>
	<script>
		alert("Contacts updated successfully");
		location.href = "thanku.jsp";
	</script>
<%}%>

<form name = "form1" action = "" method = "POST">
<div class = "" align = "center">
		<br/>
		<div><font size = "4" color = "red">Please provide the correct mobile no.as the result will be delivered vide  SMS to this No.</font></div>
	<br/><table class="listTable" border="1" style="border-collapse:collapse;width:60%">
		<thead>
			<tr>
				<th>#</th>
				<th>Participant Name</th>
				<th>Gender</th>
				<th>Age</th>
				<th>Event Catrgory</th>
				<th>Distance (in Kms.)</th>
				<th>Age Group</th>
				<th>T-Shirt Size</th>
				<th>Contact No</th>
			</tr>
		</thead>
		<tbody>
		<%while(rsChange.next()){cntVal++;%>
			<tr>
				<td><%=cntVal%><input type = "hidden" name = "chk1" id = "chk<%=cntVal%>" class = "chk" value = "<%=rsChange.getString("rowid")%>" /></td>
				<td><%=rsChange.getString("person_code")%></td>
				<td><%=rsChange.getString("gender")%></td>
				<td><%=rsChange.getString("age")%></td>
				<td><%=rsChange.getString("running_mode")%></td>
				<td><%=rsChange.getString("distance")%></td>
				<td><%=rsChange.getString("Age_grp")%></td>
				<td><%=rsChange.getString("tshirt_size")%></td>
				<td style = "padding:5px;"><input type = "text" name = "contact_no" id = "contact_no<%=cntVal%>" value = "<%=rsChange.getString("contact_no")%>" /></td>
			</tr>
		<%}%>
		</tbody>
	</table><br>
	<input type = "hidden" name = "total_cnt" id = "total_cnt" value = "<%=cntVal%>" />
	<input type = "submit" name = "submitFun" value = "Submit" onclick = "return getSubmit();">
</div>
<input 