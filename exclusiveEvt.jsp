<%@ include file = "header1.jsp"%>
<script>
function getSubmit(){
	if(validate()){
		document.form1.action.value = "submit1";
		document.form1.submit();
	}else {
		return false;
	}
}

function validate(){
	var chkLen = $("[name=chk1]:checked").length;
	if(chkLen<2){
		alert("Please select alteast two events to make excluseive");
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

<div class = "container" style = "margin-top:5%">
<%
String loginEmpNo = (String)session.getAttribute("login");
String query = "select evtnme,evt_id,(select trim(emp_name) from empmaster where emp_no=substr(a.adminemp,0,8)) adminEmp1,(select trim(emp_name) from empmaster where emp_no=substr(a.adminemp,10)) adminEmp2,to_char(evt_date,'dd-Mon-yyyy') evtDate from nomination_admin a where evt_date>=sysdate and evt_id not in(select EVENT_ID from nomination_exclusive where key is not null)";
PreparedStatement ps = null,ps1 = null,ps2 = null;
ps = con.prepareStatement(query);
ResultSet rs1 = null ,rs2 = null;
rs1 = ps.executeQuery();
int newCnt = 0;
String action = nullVal(request.getParameter("action"));
String maxId = "";
String[] chkVal = request.getParameterValues("chk1");
if("submit1".equals(action)){
	query = "select nvl(max(cast (key+1 as int)),'1') as keyVal from nomination_exclusive";
	ps1 = con.prepareStatement(query);
	rs2 = ps1.executeQuery();
	if(rs2.next()){
		maxId = rs2.getString("keyVal");
	}	
	query  = "insert into nomination_exclusive (KEY,EVENT_ID,UPDATE_BY,UPDATE_DATE) values (?,?,?,sysdate)";
	ps2 = con.prepareStatement(query);
	for(int i=0;i<chkVal.length;i++){
		ps2.setString(1,maxId);
		ps2.setString(2,chkVal[i]);
		ps2.setString(3,emp);
		newCnt = ps2.executeUpdate();
	}	
}
if(newCnt>0){%>
	<script>
		alert("Events Updated successfully");
		location.href = "excluseiveEvt.jsp";
	</script>
<%}
%>
<form name = "form1" action= "" method = "POST">	
	<div class = "table-responsive">
		<table class = "table table-bordered table-hover">
			<tr class ="alert-primary">
				<th>#</th>
				<th>Event Name</th>
				<th>Event Date</th>
				<th>Admin1</th>
				<th>Admin2</th>
			</tr>
			<%while(rs1.next()){%>
			<tr>
				<td><input type = "checkbox" name = "chk1" value = "<%=rs1.getString("evt_id")%>" ></td>
				<td><%=rs1.getString("evtnme")%></td>
				<td><%=rs1.getString("evtDate")%></td>
				<td><%=rs1.getString("adminEmp1")%></td>
				<td><%=rs1.getString("adminEmp2")%></td>
			</tr>
			<%}%>
		</table>		
		<button name =  "btn1" class = "btn btn-lg btn-danger" onclick= "return getSubmit();">Submit</button>
	</div>
<input type = "hidden" name = "action" value = "">	
</form>	
</div>