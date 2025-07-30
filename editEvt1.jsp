<%@include file="header.jsp"%>
<script src="js/jquery.autocomplete.js"></script>
<link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" />
 <link href="css/select2.min.css" rel="stylesheet" />
 <script type="text/javascript" src="js/calendar.js"></script>
 <script type="text/javascript" src="js/calendar-en.js"></script>
 <script  src="js/calendar-setup.js"></script>
 <script type="text/javascript" src="js/select2.min.js"></script>

<style>
.tab2{
	margin:5%; 
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
	
}
function toggleHist(obj) {
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
	if(!confirm("Do You want to Add Addition Fields for This Event?"))
		return false;
	else{
		if(chk1ValChange=="Y"){
			$(".chkValDiv").show();
		}else{
			$(".chkValDiv").hide();
		}
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
	var cutofdte = document.getElementById("cutofdte").value;
	if("" == cutofdte){
		alert("Select Date");
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
	
}
</script>
<script language="Javascript">
  function formsubmit(frmname) {
	  $("form[name='"+frmname+"']").submit();
}
</script>
<link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" />
 <link href="css/select2.min.css" rel="stylesheet" />
  <script type="text/javascript" src="js/calendar.js"></script>
  <script type="text/javascript" src="js/calendar-en.js"></script>
 <script type="text/javascript" src="js/calendar-setup.js"></script>
 <script src="js/select2.min.js"></script>
		<%
		PreparedStatement psdet = null,psEvtId=null,psBusReq=null;
		ResultSet rsdet = null,rsEvtId=null,rsBusReq=null;
		HashMap <String,String> hmsbu = new HashMap <String,String>();
		String key = "", value = "";
		String qry = "";
		qry =  "SELECT trim(DRKY),DRKY||'-'||DRDL01 FROM PRODCTL/F0005 WHERE DRSY='00' AND DRRT='24'";
		psdet = conerp.prepareStatement(qry);
		rsdet = psdet.executeQuery();
		while(rsdet.next()){
			hmsbu.put(rsdet.getString(1),rsdet.getString(2));
		}
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		Date today = Calendar.getInstance().getTime();
		String createdDt = df.format(today);
		List<String> fieldList=new ArrayList<String>();
		String evt_id="";
		Statement st=con.createStatement();
		ResultSet rsId=null;
		Map<String,String> buMap=new HashMap<String,String>();
		//List<String> buNameList=new ArrayList<String>();
		rsId=st.executeQuery("select max(cast(evt_id as int)) maxId from nomination_BU");
		if(rsId.next() && rsId.getString("maxId")!=null)
			evt_id=rsId.getString("maxId");
		else
			evt_id="101";
		/*rsId=st.executeQuery("select BU,budesc from bu");
		while(rsId.next()){
			buMap.put(rsId.getString("bu"),rsId.getString("budesc"));
			//buDesc.add(rs.getString("buDesc"));
		}*/
			
		PreparedStatement pmstsel = null;
		String towncode = "",adminEmp="";
		
		pmstsel = con.prepareStatement("select distinct town from empmaster where town is not null order by 1");
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
		<td><select name="evtplace" id ="evtplace" onchange="return chkVals(this);" ><option value="-1">Select</option>
		<%
		rs = pmstsel.executeQuery();
		while(rs.next()){
			towncode = rs.getString(1);
		%>
			<option value="<%=towncode%>"><%=towncode%></option>
		<%}%>
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
		<td>Event Available for</td><td><input type="checkbox" name="evt_for" value="E" />For Employees <br/>
		<input type="checkbox" name="evt_for" value="D" />For Dependents<br/>
		<input type="checkbox" name="evt_for" value="O" />Others <br/>
		</td>
	</tr>
	<tr>
		<td>Bus Facility Required</td>
		<td>
			<input type="radio" name="bus_req" value="Y"> Yes &nbsp;
			<input type="radio" name="bus_req" value="N"> No &nbsp;
		</td>
	</tr>
	<tr>
		<td>Addition Fields Required to get Data</td>
		<td>
		<input type="radio" name="addField" Value="Y" onClick="return chkVals(this)" > Yes &nbsp;
		<input type="radio" name="addField" Value="N" onclick="chkVals(this)"> No &nbsp;
		<div style="display:none" class="chkValDiv">
			<input type="hidden" name="hidevtplace" id ="hidevtplace">
			Additional Required Field1<input type="checkbox" name="chk1" id="chk1" class="chk1" value="misc1" onclick="return getFldName(this)"/>
			<input type="text" value="" name="field1" style="display:none" class="miscShow1" placeholder="Enter the Name of Level for Required field" /><br/>
			Additional Required Field2<input type="checkbox" name="chk1" id="chk2" class="chk1" value="misc2" onclick="return getFldName(this)"/>
			<input type="text" value="" name="field2" size="2" style="display:none" class="miscShow2" placeholder="Enter the Name of Level for Required field" /><br/>
			Additional Required Field3<input type="checkbox" name="chk1" id="chk3" class="chk1" value="misc3" onclick="return getFldName(this)"/>
			<span style="display:none" class="miscShow3"><input type="text" value="" name="field3" placeholder="Enter the Name of Level for Required field" /></span><br/>
		</div>
		</td>
	</tr>	
	<tr>
		<td>Choose First Admin for Event</td><td><input type="text" name="adminEmp" id="adminEmp" value="<%=adminEmp%>" /></td>
	</tr>

	<tr>
		<td>Choose Second Admin for Event</td><td><input type="text" name="adminEmp1" id="adminEmp1" value="<%=adminEmp%>" /></td>
	</tr>

</table>
<center>
<center><input class="sendButton" type="submit" name="submit1" id="submit2" value="Add Event" onclick="return validation();">	
</center>
<center>
<input class="sendButton" style="display:none" type="submit" name="submit1" id="showupdate" value="Update" onclick="return validation();">	
</center>
		<%
		
		String adminEmp1="";
		if(request.getParameter("submit1")!=null){
			String []splitAdmin=null;
			String []splitAdmin1=null;
			adminEmp=request.getParameter("adminEmp");
			adminEmp1=request.getParameter("adminEmp1");
			if(!("".equals(adminEmp) || adminEmp==null))
				splitAdmin=adminEmp.split("\\(");
			if(!("".equals(adminEmp1) || adminEmp1==null))
				splitAdmin1=adminEmp1.split("\\(");
			String evtnme="",evtplace="",cutofdte="",priceevt="",nooftickts="",maxtickemp ="",evt_for="",bus_req="";
			int flag = 0;
			evtnme = request.getParameter("evtnme");
			String [] arrevtplace =new String[]{};
			evtnme = request.getParameter("evtnme");
			evtnme = request.getParameter("evtnme");
			arrevtplace = request.getParameterValues("evtplace");
			for(int i = 0; i<arrevtplace.length; i++ ){
				evtplace += ","+arrevtplace[i];
				
			}
			String field2=nullVal(request.getParameter("field1"));
			String field3=nullVal(request.getParameter("field2"));
			String field1=nullVal(request.getParameter("field3"));
			String builder=field1+"-"+field2+"-"+field3;
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
				pmstsel = con.prepareStatement("insert into nomination_admin (CUTOFDTE,MAXTICK,MAXPRICE,INDIV_TICK,EVTNME,EVTPLACE,ADDFIELD,adminEmp) values(to_date(?,'dd-Mon-yyyy'),?,?,?,?,?,'"+builder+"','"+splitAdmin[1].substring(0,8)+"')");
				psEvtId=con.prepareStatement("insert into nomination_BU values(?,?,?)");
				psEvtId.setString(1,"101");
				psEvtId.setString(2,"testBU");
				psEvtId.setString(3,evt_for);
				psEvtId.executeUpdate();
				psBusReq=con.prepareStatement("insert into nomination_BP values(?,?,?)");
				psBusReq.setString(1,"101");
				psBusReq.setString(2,bus_req);
				psBusReq.setString(3,"A,B,C,D");
				psBusReq.executeUpdate();	
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
			//flag=pmstsel.executeUpdate();
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
					location.href="editevent.jsp"
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
</div>
</div>
</div>
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