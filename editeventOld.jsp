<%@include file="header.jsp"%>
<style>
.tab2{
	margin:10% 0% 1% 15%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width: 70%;
}
.tab2 td{
	padding:2% 0%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#fff;
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
</style>
<script>
function toggleHist(obj) {
	if(obj.src.indexOf("expand") > -1) {
		obj.src = obj.src.replace("expand","collapse");
	} else {
		obj.src = obj.src.replace("collapse","expand");
	}
	$("#hist_table").toggle("blind", {}, 500);
}

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

<!-- main calendar program -->

  <!-- language for the calendar -->

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
		<%
		PreparedStatement pmstsel = null;
		String towncode = "";
		pmstsel = con.prepareStatement("select distinct town from empmaster where town is not null order by 1");
		%>
		<form name="form" id ="form" method="post">
<table class="tab2">
<tr><td>Event Name</td><td><input type="text" name="evtnme" id ="evtnme" maxlength="100" onkeypress="return isAlphaNumeric(event)" onkeydown="return isAlphaNumeric(event)" onpaste = "isAlphaOnPaste(this);">
<input type="hidden" name="hidevtnme" id ="hidevtnme">
</td></tr>
<tr><td>Event Allowed for Employees of Town</td>
<td><select name="evtplace" id ="evtplace" multiple ><option value="">Select</option>
		<%
		rs = pmstsel.executeQuery();
		while(rs.next()){
			towncode = rs.getString(1);
		%>
			<option value="<%=towncode%>"><%=towncode%></option>
		<%}
		%>

</select>
<input type="hidden" name="hidevtplace" id ="hidevtplace">
</td></tr>
<tr><td>Last date of Online Application</td><td><input type="text" name="cutofdte" id ="cutofdte" class="datepicker" readonly>
<script type="text/javascript">
$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			dateFormat: "dd-M-yy",
			minDate: new Date(),
			
			
		});
</script></td></tr>
<tr><td>Price per ticket</td><td><input type="text" name="priceevt" id ="priceevt" maxlength="5" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td></tr>
<tr><td>Total Tickets for Event</td><td><input type="number" name="nooftickts" id ="nooftickts" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td></tr>
<tr><td>Max Tickets per employee</td><td><input type="number" name="maxtickemp" id ="maxtickemp" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"></td></tr>
</table>	
<center><input class="sendButton" type="submit" name="submit1" id="submit2" value="Add" onclick="return validation();">	
</center>
<center>
<input class="sendButton" style="display:none" type="submit" name="submit1" id="showupdate" value="Update" onclick="return validation();">	
</center>
		<%
		if(request.getParameter("submit1")!=null){
			String evtnme="",evtplace="",cutofdte="",priceevt="",nooftickts="",maxtickemp ="";
			//String eventName=""
			int flag = 0;
			evtnme = request.getParameter("evtnme");
			String [] arrevtplace =new String[]{};
			evtnme = request.getParameter("evtnme");
			evtnme = request.getParameter("evtnme");
			arrevtplace = request.getParameterValues("evtplace");
			for(int i = 0; i<arrevtplace.length; i++ ){
				evtplace += ","+arrevtplace[i];
				
			}
			evtplace = evtplace.substring(1);
			cutofdte = request.getParameter("cutofdte");
			priceevt = request.getParameter("priceevt");
			nooftickts = request.getParameter("nooftickts");
			maxtickemp = request.getParameter("maxtickemp");
			rs = null;
			pmstsel = null;
			String already_exist="select EVTNME from nomination_admin where regexp_like(EVTNME, ?, 'i')";
			if(!"Update".equals(request.getParameter("submit1"))){
			pmstsel=con.prepareStatement(already_exist);
			pmstsel.setString(1,evtnme);
			//pmstsel.setString(2,evtplace);
			rs=pmstsel.executeQuery();
			if(rs.next()){
				%>
				<script>
				alert("Event Already Exist..");
				location.href="main.jsp";
				</script>
			<%}
			}		
				if("Add".equals(request.getParameter("submit1"))){
					pmstsel = con.prepareStatement("insert into nomination_admin (CUTOFDTE,MAXTICK,MAXPRICE,INDIV_TICK,EVTNME,EVTPLACE) values(to_date(?,'dd-Mon-yyyy'),?,?,?,?,?)");
				}
				if("Update".equals(request.getParameter("submit1"))){
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
				flag = pmstsel.executeUpdate();
				if( flag == 1 ){
				%>
			<script>alert("Details Submitted");
			location.href="editevent.jsp";</script>
				<%} else{
				%>
			<script>alert("Error Occured....");
			location.href="editevent.jsp";</script>
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
			
			if(ins>0){
				%>
				<script>
				alert("Record Deleted Successfully..");
				
				</script>
			<%	
			} else {
				%>
				<script>
				alert("Error Occured....<%=delval%>");
				location.href="editevent.jsp"
				</script>
			<%
			}
		}
		
		
		%>
		</form>
		<div>
	<div class="mb10">
	<div class="" style="margin-left:10%">
		<div class="fl mr10"><h4>Event List</h4><img class="curpoint" onclick="toggleHist(this)" src="images/expand4.png" /></div>
		<div class="clear"></div>
	</div>
	<div id="hist_table" class="" style="display: none;">
		<div class="datagrid">
		<center>
<table id="tab1" style="width:70%">
<thead style="background-color:#658DB5"><tr><th style="width:50%">Event Name</th><th>Event Allowed for Employees of Town</th><th>Last date of Online Application</th><th>Price per ticket</th><th>Total Tickets for Event</th><th>Max Tickets per employee</th><th style="width:10%"></th></thead>
</tr>
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
		<%
		SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
		Date currentdte =new Date();
		Date dbdate = new Date(dbcutofdte);
		String currentdteval = fmt.format(currentdte);
		%>
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
</body>

</html>
<%@include file="footer.jsp"%>
