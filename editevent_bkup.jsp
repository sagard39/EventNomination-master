<%@include file="header.jsp"%>
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" />
 <link href="css/select2.min.css" rel="stylesheet" />
  <script type="text/javascript" src="js/calendar.js"></script>
  <script type="text/javascript" src="js/calendar-en.js"></script>
 <script  src="js/calendar-setup.js"></script>
 <script type="text/javascript" src="js/select2.min.js"></script>
<script type="text/javascript" src="js/jquery.autocomplete.js"></script>
<script type="text/javascript">
$( document ).ready(function() {
  $('#evtplace').select2();
});
</script>
<style>
.listTable tr > th{
border: 1px solid #FFFFFF;
box-shadow:0 0 10px #5D6D7E;
background-color: #CB4E46;
color:#FFF;
background: -webkit-linear-gradient(top ,#CB4E46, #1472C5);
background: -o-linear-gradient(top ,#CB4E46, #1472C5);
background: -moz-linear-gradient(top ,#CB4E46, #1472C5);
background: -ms-linear-gradient(top ,#CB4E46, #1472C5);
background: linear-gradient(top ,#CB4E46, #1472C5);
}
.listTable td{
	padding:1% 0%;
}
.tab2{
	--margin:5%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width: 70%;
}
.tab2 td{
	padding:1% 0%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#FDEDEC;
}
.tab2 tr:nth-child(odd){
	background:#ebf1fa ;
}
#tab1{
	 border-collapse: collapse;
}
#tab1 th{
	 border:1px solid #000;
}

.ac_results {
	padding: 0px;
	border: 1px solid #84a10b;
	background-color: #84a10b;
	overflow: hidden;
}
.ac_results ul {
	width: 100%;
	list-style-position: outside;
	list-style: none;
	padding: 0;
	margin: 0;
}
.ac_results li {
	margin: 0px;
	padding: 2px 5px;
	cursor: default;
	display: block;
	color: #fff;
	font-family:verdana;
	/*
	if width will be 100% horizontal scrollbar will apear
	when scroll mode will be used
	*/
	/*width: 100%;*/
	font-size: 12px;
	/*
	it is very important, if line-height not setted or setted
	in relative units scroll will be broken in firefox
	*/
	line-height: 16px;
	overflow: hidden;
}
.ac_loading {
	background: white url('../images/indicator.gif') right center no-repeat;
}
.ac_odd {
	background-color: #84a10b;
	color: #ffffff;
}
.ac_over {
	background-color: #5a6b13;
	color: #ffffff;
}
.input_text{
	
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	border:1px solid #84a10b;
	padding:2px;
	width:150px;
	color:#000;
	background:white url(../images/search.png) no-repeat 3px 2px;
	padding-left:17px;
}
</style>
<script>
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	var row = $("#tr").html();
	//console.log(row);
	var index = $("#ti_table tbody:first > tr").length;
	if(index>3){
		alert("maximum 3 Rows are Allowed");
		return false;
	}
	row = row.replaceAll("#id#", index);
	//alert(row);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	recalculate()

	

}
function removeRow(id,aid) {
	var row = $("#tr").html();
	$("#tr"+id).remove();
	var index = $("#ti_table tbody:first > tr").length;
	 row = row.replaceAll("#id#", index-1);
	
	$("#leg_count").val(index-1);

}
function recalculate() {
    var i = 1;

    $(".numberRow").each(function() {
        $(this).find("strong").text(i++); 
	
    });
	
}function toggleHist(obj) {
	if(obj.src.indexOf("expand") > -1) {
		obj.src = obj.src.replace("expand","collapse");
	} else {
		obj.src = obj.src.replace("collapse","expand");
	}
	$("#hist_table").toggle("blind", {}, 500);
}

jQuery(function(){
	
$("#adminEmp").autocomplete("List.jsp");

});
jQuery(function(){
	
$("#adminEmp1").autocomplete("List.jsp");

});

function delrec(r,a){
	location.replace('editevent.jsp?del='+r+'&twn='+a);
}
function editrec(evtnme,evtplace,cutofdte,priceevt,nooftickts,indi_tickets) {
      $('#evtnme').val(evtnme);
	  $('#hidevtnme').val(evtnme);
	  $('#hidevtplace').val(evtplace);
	  var dataarray=evtplace.split(",");
	  $("#evtplace").val(dataarray);
	  $('#cutofdte').val(cutofdte);
	  $('#priceevt').val(priceevt);
	  $('#nooftickts').val(nooftickts);
	  $('#maxtickemp').val(indi_tickets);
	  $('#showupdate').show();
	  $('#submit2').hide();
}
</script>
<script>
function chkVals(Obj){
	var chk1ValChange=Obj.value;
	if(chk1ValChange=="Y"){
		if(!confirm("Do You want to Add Addition Fields for This Event?"))
			return false;
		
	else{
		if(chk1ValChange=="Y"){
			$(".chkValDiv").show();
		}else{
			$(".chkValDiv").hide();
		}
	}
	}else if(chk1ValChange=="N"){
		$(".chkValDiv").hide();
	}	
}
function getFldName(Obj){
	var val1=Obj.value;
	if(val1=='misc1'){
		$(".miscShow1").toggle();
	}if(val1=='misc2'){
		$(".miscShow2").toggle();
	}if(val1=='misc3'){
		$(".miscShow3").toggle();
	}
	
}
</script>
<script>
function validation(){
	//val bus_req=$('input[name="bus_req"]:checked').length;
	var evtnme = document.getElementById("evtnme").value;
	if("" == evtnme){
		alert("Enter Event Name");
		return false;
	} 
	var evtplace = document.getElementById("evtplace").value;
	if("" == evtplace){
		alert("Select Event Place");
		return false;
	}
	var evt_date = document.getElementById("evt_date").value;
	if("" == evt_date){
		alert("Please select the Event Date ");
		return false;
	}
	var cutofdte = document.getElementById("cutofdte").value;
	if("" == cutofdte){
		alert("Select last Date ");
		return false;
	}
	
	var priceevt = document.getElementById("priceevt").value;
	if("" == priceevt || "0" == priceevt ||"0.0" == priceevt){
		alert("Total Payment cannot be 0");
		return false;
	}
	var nooftickts = document.getElementById("nooftickts").value;
	if("" == nooftickts || "0" == nooftickts ||"0.0" == nooftickts){
		alert("No. of Tickets cannot be 0");
		return false;
	}
	var evt_for=$('input[name="evt_for"]:checked').length;
	if(evt_for<1 ){
		alert("Please Check one checkbox");
		return false;
	}
	var bus_req=$('input[name="bus_req"]:checked').length;
	if(bus_req<1){
		alert("Please choose the Bus Required");
		return false;
	}
	var adminVal=document.getElementById("adminEmp").value;
	alert(adminVal);
	if(""==adminVal){
		alert("Please Choose the Admin for the Event");	
		return false;
	}	

	
}
</script>
<script language="Javascript">
  function formsubmit(frmname) {
	  $("form[name='"+frmname+"']").submit();
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
		PreparedStatement psdet = null,psEvtId=null,psBusReq=null;
		ResultSet rsdet = null,rsEvtId=null,rsBusReq=null;
		HashMap <String,String> hmsbu = new HashMap <String,String>();
		List<String> typeList=new ArrayList<String>();
		typeList.add("-1");
		typeList.add("text");
		typeList.add("file");
		typeList.add("Dropdown");
		typeList.add("Number");
		
		String key = "", value = "";
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		Date today = Calendar.getInstance().getTime();
		String createdDt = df.format(today);
		List<String> fieldList=new ArrayList<String>();
		String evt_id="";
		int evt_id1=0;
		Statement st=con.createStatement();
		ResultSet rsId=null;
		Map<String,String> buMap=new HashMap<String,String>();
		//List<String> buNameList=new ArrayList<String>();
//	try{
		rsId=st.executeQuery("select max(cast (substr(evt_id,6,3) as int)) maxId from nomination_admin");
		if(rsId.next() && rsId.getString("maxId")!=null){
			evt_id1=rsId.getInt("maxId")+1;
			evt_id=1900+today.getYear()+"_"+evt_id1+"_event";
		}	
		else
			evt_id=1900+today.getYear()+"_101_event";
			
		PreparedStatement pmstsel = null;
		String towncode = "",adminEmp="";
		
		pmstsel = con2.prepareStatement("select distinct town from empmaster where town is not null order by 1");
		%>
<form name="form"  id ="form" method="post">
<center>
<h3>Add Event</h3>
<table border="1" class="tab2">
	<tr>
		<td>Event ID</td>
		<td><center><span><%=evt_id%></span></center></td>
	</tr>
	<tr>
		<td>Event Allowed for Employees of Town</td>
		<td>
			<select multiple="multiple" name="evtplace" id="evtplace" >
			<option value="A">Select All</option>
			<%
			rs=pmstsel.executeQuery();
			while(rs.next()){%>
				<option value="<%=rs.getString("town")%>"><%=rs.getString("town")%></option>
			<%}%>
			</select>
		</td>
	</tr>
<!--	<tr>
		<td>Event City</td>
		<td>
		<select multiple="multiple" name="sbu" id="sbu" >
		<option value="A">Select All</option>
		<%
		for(Map.Entry<String,String> s : hmsbu.entrySet()){
			key = s.getKey();
			value = s.getValue();
			%>
			<option value="<%=key%>"><%=value%></option>
		<%}%>
		</select>

		</td>
	</tr>-->
	<tr>
		<td>Event Name</td><td><input type="text" name="evtnme" id ="evtnme" maxlength="100" onkeypress="return isAlphaNumeric(event)" onkeydown="return isAlphaNumeric(event)" onpaste = "isAlphaOnPaste(this);">
		<input type="hidden" name="hidevtnme" id ="hidevtnme">
		</td>
	</tr>
	<tr>
		<td>Event Date</td><td><input type="text" name="evt_date" class="datepicker" id="evt_date" readonly></td></tr>
	</tr>
	<tr>
		<td>Last date of Online Application</td><td><input type="text" name="cutofdte" class="datepicker" id ="cutofdte" readonly>
		</td>
	</tr>
	<tr>
		<td>Price per ticket</td><td><input type="text" name="priceevt" id ="priceevt" maxlength="5" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td>
	</tr>
	<tr>	
		<td>Total Tickets for Event</td><td><input type="number" name="nooftickts" id ="nooftickts" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td>
	</tr>
	<tr>
		<td>Max Tickets per employee</td><td><input type="number" name="maxtickemp" id ="maxtickemp" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td>
	</tr>
	<tr>
		<td>Event Available for</td>
		<td>
		<input type="checkbox" name="evt_for" class="evt_for_for" value="E" />For Employees <br/>
		<input type="checkbox" name="evt_for" class="evt_for_for" value="D" />For Dependents<br/>
		<input type="checkbox" name="evt_for" class="evt_for_for" value="O" />Others <br/>
		</td>
	</tr>
	<tr>
		<td>Bus Facility Required</td>
		<td>
			<input type="radio" name="bus_req" class="bus_req" value="Y"> Yes &nbsp;
			<input type="radio" name="bus_req" class="bus_req" value="N"> No &nbsp;
		</td>
	</tr>

	<tr>
		<td>Choose First Admin for Event</td><td><input type="text" name="adminEmp" id="adminEmp" value="<%=adminEmp%>" /></td>
	</tr>

	<tr>
		<td>Choose Second Admin for Event</td><td><input type="text" name="adminEmp1" id="adminEmp1" value="<%=adminEmp%>" /></td>
	</tr>
	<tr>
		<td>Addition Fields Required to get Data</td>
		<td>
		<input type="radio" name="addField" Value="Y" onClick="return chkVals(this)" > Yes &nbsp;
		<input type="radio" name="addField" Value="N" onclick="return chkVals(this)"> No &nbsp;
		</td>
	</tr>		

</table><br/>
<div style="display:none" class="chkValDiv">
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div clas="datagrid">
			<table class="listTable" style="border-collapse:collapse;width:70%" id="ti_table" border="1">
				<tr class="lst">
				<th><center>&sect;</center></th>
				<th><center>Label Name</center></th>
				<th><center>Label Type</center></th>
				<th><center>Default values</center></th>
				</tr>
				<tbody>
			<tr id="tr" style="display:none" class="tbodytr">
					<!--<td align="center"><span class="numberRow"><strong></strong></span>
					<input type="checkbox" name="chkboxx" id="chkB<%="#id#"%>" onclick="return guideLine1(<%="#id#"%>)">
					</td>-->
					<td align="center">
					<a onclick="removeRow(<%="#id#"%>,this)" href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
					<td><center><input type="text" name="fieldName" id="fieldName<%="#id#"%>" placeholder="Enter the Name of Label"></center></td>
					<td>
						<!--<span><input type="radio" name="lblType" id="lblType<%="#id#"%>" value="text"> Text &nbsp; &nbsp; &nbsp;
						<input type="radio" name="lblType" id="lblType<%="#id#"%>" value="File"> File &nbsp; &nbsp;&nbsp;
						<input type="radio" name="lblType" id="lblType<%="#id#"%>" value="Dropdown">Dropdown &nbsp;&nbsp; &nbsp; 
						<input type="radio" name="lblType" id="lblType<%="#id#"%>" value="number">Number&nbsp;&nbsp; &nbsp; </span>-->
						<select name="lblType" id="lblType<%="#id#"%>">
							<option value="file">File</option>
							<option value="text">Text</option>
							<option value="drop down">Dropdown</option>
							<option value="textarea">Textarea</option>
						</select>
					</td>
					<td><center><input type="text" name="def_type" id="def_type<%="#id#"%>" placeholder="Add the values seperated by commas"></center></td>

			</tr>
		</tbody>	
	</table></div></div><br/>
<center>
<center><input class="sendButton" type="submit" name="submit1" id="submit2" value="Add Event" onclick="return validation();">	
</center>
<center>
<input class="sendButton" style="display:none" type="submit" name="submit1" id="showupdate" value="Update" onclick="return validation();">	
</center>
		<%
		
		String adminEmp1="",allAdmin="",splitAdminNo1="",splitAdminNo2="",addFields="",lblName="",lblType="",defValues="";
		String [] lblName1=request.getParameterValues("fieldName");
		String [] lblType1=request.getParameterValues("lblType");
		String [] def_type1=request.getParameterValues("def_type");
		if(request.getParameter("submit1")!=null){
			String []splitAdmin=null;
			String []splitAdmin1=null;
			adminEmp=nullVal(request.getParameter("adminEmp"));
			adminEmp1=nullVal(request.getParameter("adminEmp1"));
			if(!"".equals(adminEmp)){
				splitAdmin=(adminEmp.split("\\("));
				splitAdminNo1=splitAdmin[1].substring(0,8);
			}
			if(!"".equals(adminEmp1)){
				splitAdmin1=adminEmp1.split("\\(");
				splitAdminNo2=splitAdmin1[1].substring(0,8);
			}

			allAdmin=splitAdminNo1+","+splitAdminNo2;
			String evtnme="",evtplace="",cutofdte="",priceevt="",nooftickts="",maxtickemp ="",evt_for="",bus_req="";
			int flag = 0,sber=0;
			evtnme = request.getParameter("evtnme");
			String [] arrevtplace =new String[]{};
			evtnme = request.getParameter("evtnme");
			evtnme = request.getParameter("evtnme");
			arrevtplace = request.getParameterValues("evtplace");
			for(int i = 0; i<arrevtplace.length; i++ ){
				evtplace += ","+arrevtplace[i];
			}
			String eventDate=request.getParameter("evt_date");
			String field2=nullVal(request.getParameter("field3"));
			String field3=nullVal(request.getParameter("field2"));
			String field1=nullVal(request.getParameter("field1"));
			String builder=field1+"-"+field3+"-"+field2;
			evtplace = evtplace.substring(1);
			cutofdte = request.getParameter("cutofdte");
			priceevt = request.getParameter("priceevt");
			nooftickts = request.getParameter("nooftickts");
			maxtickemp = request.getParameter("maxtickemp");
			String [] evt_forArr=request.getParameterValues("evt_for");
			bus_req=request.getParameter("bus_req");
			for(int i=0;i<evt_forArr.length;i++){
				evt_for+=evt_forArr[i]+",";	
			}
			rs = null;
			pmstsel = null;
			String already_exist="select EVTNME from nomination_admin where regexp_like(EVTNME, ?, 'i')";
			if(!"Update".equals(request.getParameter("submit1"))){
			pmstsel=con.prepareStatement(already_exist);
			pmstsel.setString(1,evtnme);
			rs=pmstsel.executeQuery();
			if(rs.next()){
				%>
				<script>
				alert("Event Already Exist..");
				location.href="main.jsp";
				</script>
			<%}
			}
			if("Add Event".equals(request.getParameter("submit1"))){
				//out.println("reaching here"+)
				String [] addsVal=request.getParameterValues("addField");
				if(addsVal!=null &&addsVal.length>0){
					addFields=addsVal[0];
				}
				//out.println("bbb"+addsVal.length);
				//out.println("aaa"+addFields);
				pmstsel = con.prepareStatement("insert into nomination_admin (CUTOFDTE,MAXTICK,MAXPRICE,INDIV_TICK,EVTNME,EVTPLACE,ADDFIELD,adminEmp,evt_id,NOOFMAXTICK,evt_for,bus_facility,evt_date) values(to_date(?,'dd-Mon-yyyy'),?,?,?,?,?,'"+builder+"','"+allAdmin+"','"+evt_id+"','"+maxtickemp+"','"+evt_for+"','"+bus_req+"',to_date('"+eventDate+"','dd-Mon-yyyy'))");
				/*psEvtId=con.prepareStatement("insert into nomination_BU values(?,?,?)");
				psEvtId.setString(1,evt_id);
				psEvtId.setString(2,"testBU");
				psEvtId.setString(3,evt_for);
				psEvtId.executeUpdate();
				psBusReq=con.prepareStatement("insert into nomination_BP values(?,?,?)");
				psBusReq.setString(1,evt_id);
				psBusReq.setString(2,bus_req);
				psBusReq.setString(3,"A,B,C,D");
				psBusReq.executeUpdate();*/
				if("Y".equals(addFields)){
					out.println("Value is");
					psEvtId=con.prepareStatement("insert into nomination_addition(evt_id,lbl_name,lbl_type,def_value) values(?,?,?,?)");
					for(int i=0;i<lblName1.length-1;i++){
						
						lblName=lblName1[i];
						lblType=lblType1[i];
						defValues=def_type1[i];
						out.println(lblName);
						psEvtId.setString(1,evt_id);
						psEvtId.setString(2,lblName);
						psEvtId.setString(3,lblType);
						psEvtId.setString(4,defValues);
						sber=psEvtId.executeUpdate();
						out.println("aaa"+sber);
					}
				}				
			}else if("Update".equals(request.getParameter("submit1"))){
				pmstsel = con.prepareStatement("update nomination_admin set CUTOFDTE =to_date(?,'dd-Mon-yyyy'),MAXTICK=?,MAXPRICE=?,INDIV_TICK=?,EVTNME=?,EVTPLACE=? where EVTNME=?and EVTPLACE=?");
			}
				
			pmstsel.setString(1,cutofdte);
			pmstsel.setString(2,nooftickts);
			pmstsel.setString(3,priceevt);
			pmstsel.setString(4,maxtickemp);
			pmstsel.setString(5,evtnme);
			pmstsel.setString(6,evtplace);
			if("Update".equals(request.getParameter("submit1"))){
				String hidevtnme = request.getParameter("hidevtnme");
				String hidevtplace = request.getParameter("hidevtplace");
				pmstsel.setString(7,hidevtnme);
				pmstsel.setString(8,hidevtplace);	
			}

			flag=pmstsel.executeUpdate();
			if( flag == 1 ){%>
				<script>
					alert("Details Submitted");
					location.href="editevent.jsp";
				</script>
				<%} else{ %>
					<script>
						alert("Error Occured....");
						//location.href="editevent.jsp";
					</script>
				<%}
			
		}
		PreparedStatement pmstins = null;
		if(request.getParameter("del") != null){
			String evtn=request.getParameter("evtnme");
			pmstins = con.prepareStatement("delete from nomination_admin where EVTNME=? and EVTPLACE=?");
			String delval = java.net.URLEncoder.encode(request.getParameter("del"),"UTF-8");
			String twnval = request.getParameter("twn");
			pmstins.setString(1,delval);
			pmstins.setString(2,twnval);
			int ins=pmstins.executeUpdate();
			if(ins>0){%>
				<script>
					alert("Record Deleted Successfully..");
				</script>
			<%} else {%>
				<script>
					alert("Error Occured....<%=delval%>");
					//location.href="editevent.jsp"
				</script>
			<%}
		}%>
	</form>
<div>
<div class="mb10">
	<!--<div class="" style="margin-left:10%">
		<div class="fl mr10"><h4>Event List</h4><img class="curpoint" onclick="toggleHist(this)" src="images/expand4.png" /></div>
		<div class="clear"></div>
		</div>-->
<div id="hist_table" class="" style="display: none;">
	<div class="datagrid">
	<center>
		<table id="tab1" style="width:70%">
			<thead style="background-color:#658DB5"><tr><th style="width:50%">Event Name</th><th>Event Allowed for Employees of Town</th><th>Last date of Online Application</th><th>Price per ticket</th><th>Total Tickets for Event</th><th>Max Tickets per employee</th><th style="width:10%"></th></thead></tr>
			<tbody>
			<%
			rs = null;
			int cnt = 0;
			String dbevtnme="",dbevtplace="",dbcutofdte="",dbpriceevt="",dbnooftickts="",dbinditick ="";
			String evtqry="select to_char(CUTOFDTE,'dd-Mon-yyyy'),MAXTICK,MAXPRICE,EVTNME,EVTPLACE,INDIV_TICK from nomination_admin  order by 1,5";
			rs=stmt.executeQuery(evtqry);
			while(rs.next()){
				dbcutofdte = rs.getString(1);
				dbnooftickts = rs.getString(2);
				dbpriceevt = rs.getString(3);
				dbevtnme = rs.getString(4);
				dbevtplace = rs.getString(5);
				dbinditick = rs.getString(6);
				cnt++;
			%>
			<tr>
				<td><%=dbevtnme%></td>
				<td><%=dbevtplace%></td>
				<td><%=dbcutofdte%></td>
				<td><%=dbpriceevt%></td>
				<td><%=dbnooftickts%></td>
				<td><%=dbinditick%></td>
				<td>
					<%SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
					Date currentdte =new Date();
					Date dbdate = new Date(dbcutofdte);
					String currentdteval = fmt.format(currentdte);%>
					<% if(currentdte.before(dbdate) || currentdteval.equals(dbcutofdte) ){%>
							<img src="images/edit.png" style="width:30%;height:auto;cursor:pointer" onclick="editrec('<%=dbevtnme%>','<%=dbevtplace%>','<%=dbcutofdte%>','<%=dbpriceevt%>','<%=dbnooftickts%>','<%=dbinditick%>')">
					<% } %>
					<form name="formdel<%=cnt%>" action="delevent.jsp" method="post">
						<img src="images/clear.png" style="width:30%;height:auto;cursor:pointer" onclick="formsubmit('formdel<%=cnt%>');">
						<input type="hidden"name="del" id="del" value="<%=dbevtnme%>">
						<input type="hidden"name="twn" id="twn" value="<%=dbevtplace%>">
					</form>
				</td>
			</tr>
		<%}%>
		</tbody>
	</table>
</center>
</div>

</div>
</div>
</div>
<%/*} catch(Exception e){
	out.println("Some Error Occured"+e);
}*/%>
</body>
<script>
$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			dateFormat: "dd-M-yy",
			minDate: new Date(),
			
			
		});
</script>
</html>
<%@include file="footer.jsp"%>