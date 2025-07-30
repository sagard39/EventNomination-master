
<%@include file="header.jsp"%>
<script>
$(document).ready(function() {
$('div#dialog').dialog({ autoOpen: false })
$('#confirm').click(function(){ $('div#dialog').dialog('open'); });
})
  </script>
		<%
		/* JDE Data  */
		//31952830
		String maritalsts = "";
		PreparedStatement pmstgetsts = null;
		ResultSet rsgetsts = null;
		pmstgetsts = con1.prepareStatement("select YAMSA,YAAN8 FROM PRODDTA/F060120  WHERE YAAN8 ='"+emp+"'");
		//pmstgetsts.setString(1,emp);
		rsgetsts = pmstgetsts.executeQuery();
		if(rsgetsts.next()){
			maritalsts =rsgetsts.getString(1);
		}
		
		String eventname = request.getParameter("eventname");
		PreparedStatement pmstselqry = null;
		String dbempno ="",dbboardpnt="",dbnoofticks ="",dbtotalpaymnt="0",dbsysdte="";
		Double dbpaymnt = 0.0;
		String dbeventname="",dbflag="";
		pmstselqry = con.prepareStatement("select EMP_NO,TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,EVTNME,FLAG from nomination where EMP_NO =? and EVTNME =?  and (flag<>'X' or flag is null)");
		pmstselqry.setString(1,emp);
		pmstselqry.setString(2,eventname);
		rs = pmstselqry.executeQuery();
		if(rs.next()){
			dbempno = rs.getString(1);
			emp = dbempno;
			dbnoofticks = rs.getString(2); if(dbnoofticks == null){dbnoofticks = "";}
			dbboardpnt = rs.getString(3);
			dbtotalpaymnt = rs.getString(4);if(dbtotalpaymnt == null){dbtotalpaymnt = "0";}
			dbpaymnt = Double.parseDouble(dbtotalpaymnt);
			dbsysdte = rs.getString(5);
			dbeventname = rs.getString(7);
			eventname = dbeventname;
			dbflag = rs.getString(8);
			
		}
		String evtplace="",cutofdte="",maxnoofticks="0",maxprice="0",evtnme="",maxtickemp="";
		String tempevt = "";
		boolean isExist =false;
		pmstselqry = con.prepareStatement("select distinct EVTNME from NOMINATION_ADMIN where regexp_like(EVTPLACE, ?, 'i')");
		pmstselqry.setString(1,town);
		rs = pmstselqry.executeQuery();
		while(rs.next()){
			evtnme = rs.getString(1);
			if(evtnme.equals(eventname)){
				tempevt+="<option value='"+evtnme+"' selected>"+evtnme+"</option>";
			} 
			
			isExist = true;
		}
		if(isExist==false){
			%>
			<script>
			alert("There is no event in your town at present");
			location.href="index.jsp";
			</script>
		<%
		}
		int ticktsremain = 0;
		int nettickremain = 0;
		int remaingtick =0;
		pmstselqry = con.prepareStatement("SELECT sum(TICKTSCNT) FROM NOMINATION WHERE EVTNME=? and  (flag<>'X' or flag is null)");
		pmstselqry.setString(1,eventname);
		rs = pmstselqry.executeQuery();
		if(rs.next()){
			nettickremain = rs.getInt(1);
			if(String.valueOf(nettickremain) == null){
				nettickremain = 0;
			}
		}else {
			nettickremain = 0;
		}
		
		rs = null;
		pmstselqry = null;
		pmstselqry = con.prepareStatement("select EVTPLACE,to_char(CUTOFDTE,'dd-Mon-yyyy'),MAXTICK,MAXPRICE,EVTNME,INDIV_TICK from NOMINATION_ADMIN where regexp_like(EVTPLACE, ?, 'i') and EVTNME=?");
		pmstselqry.setString(1,town);
		pmstselqry.setString(2,eventname);
		rs = pmstselqry.executeQuery();
		while(rs.next()){
			evtplace = rs.getString(1);
			cutofdte = rs.getString(2);
			maxnoofticks = rs.getString(3);
			ticktsremain = Integer.parseInt(maxnoofticks);
			maxprice = rs.getString(4);
			eventname = rs.getString(5);
			maxtickemp = rs.getString(6);
			maxnoofticks = maxtickemp;
			/* if(("M").equals(maritalsts)){
			maxnoofticks = maxtickemp;
			} else{
				maxnoofticks = "2";
			} */
		} 
		if(eventname!=null){
		remaingtick = ticktsremain - nettickremain;
		if(remaingtick <= 0){
			%>
			<script>alert("We have already reached the maximum no. of Requests that could be accommodated for this event. Thank You !!");
			//location.href="mynomination.jsp";
			</script>
		<%}
		}
		//String [] boardloc = new String[]{"Andheri","Borivali","BKC","HP Nagar (W)","Dadar","HP Nagar (E)","Thane","Own arrangement","Vashi"};
		String [] boardloc = new String[]{"Own arrangement"};
		%>
<script>
$( document ).ready(function() {
	var noofticks =0;
	$("#noofticks").on("keyup keydown change",function(){
		noofticks = this.value;
		$("#paymnt").val(<%=maxprice%> * noofticks);
		$("#totval").html($("#paymnt").val());
	});	
	$("#totval").html($("#paymnt").val());
	$('input[type="checkbox"]').click(function(){
            if($(this).prop("checked") == true){
				$(".submitcls").show();
            }
            else if($(this).prop("checked") == false){
				$(".submitcls").hide();
            }
	});	
});
</script>
<script>
function validate(){
	var paymnt = document.getElementById("paymnt").value;
	if("" == paymnt || "0" == paymnt || "0.0" == paymnt){
		alert("You have not selected no. of Tickets");
		return false;
	} 
	var noofticks = document.getElementById("noofticks").value;
	if("" == noofticks || "0" == boardpnt ||"0.0" == noofticks){
		alert("You have not selected no. of Tickets");
		return false;
	}
	if(noofticks > <%=remaingtick%>){
		alert("Tickets cannot exceed <%=remaingtick%>");
		return false;
	}
	if(noofticks > <%=maxnoofticks%>){
		alert("No. of Tickets cannot exceed <%=maxnoofticks%>");
		return false;
	}
	var boardpnt = document.getElementById("boardpnt").value;
	if("" == boardpnt){
		alert("Please select Boarding Point");
		return false;
	}
}
</script>
<style>
.tab2{
	margin:10% 20% 2% 20%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width:70%;
}
.tab2 td{
	padding:2% 0%;
	width:20%;
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
.req{
	color:red;
}
</style>		
<form name="form" method="post">

<table class="tab2">
<tr><td>Select Event</td>
<td><select name="eventname" id="eventname" onchange="sfresh()"><%=tempevt%></select>
</td></tr>
<tr>
<td>No. of tickets required <br/><br/>Note: Children below 3 years do not require Tickets,<br/>however carry valid age proof.
<br/>
<span class="req">
<%		if(("S").equals(maritalsts)){%>
<!--( Maximum of <maxnoofticks%> tickets  for Single employees )-->
<%		} else { %>
<!--( Maximum of <maxnoofticks%> tickets  for Married employees )-->	
<%      }%></span></td>
<td>
<input type="hidden" name="empn" id="emp" value="<%=emp%>"/>
<input type="hidden" name="maxnoofticks" id="maxnoofticks" value="<%=maxnoofticks%>"/>
<input type="hidden" name="sysdte" id="sysdte" value="<%=dbsysdte%>"/>
<input type="number" name="noofticks" id="noofticks" min="0" value="<%=dbnoofticks%>" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)"/></td>
</tr>
<tr>
<!--<td>Select Boarding point <!--<br/>(Will be applicable only if bus service is arranged.)--><!--</td><td><select name="boardpnt" id="boardpnt" >
<option value="">Select</option>
		<%
		for(int i = 0; i<boardloc.length; i++){
			%>
			<option value="<%=boardloc[i]%>" <%if(boardloc[i].equals(dbboardpnt)){
				%>
				selected
			<%}%>>
			<%=boardloc[i]%></option>
		<%}
		%>

</select></td>-->
</tr>
<tr>
<td>Payment</td><td><input type="number" name="paymnt" id="paymnt" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" value="<%=dbpaymnt%>" readonly ></td>
</tr>
</table>
<center>
		<%
		if(("47".equals(bucode.substring(0,2))) || ("48".equals(bucode.substring(0,2)))){
		%>
		<!--<input type="hidden" name="sts" id="sts" value="Pending with HR"/>-->
		<%
		} else {
		%>	
		<!--<input type="hidden" name="sts" id="sts" value="A"/>-->
		<%}
		%>
		<input type="hidden" name="sts" id="sts" value="<%=dbflag%>"/>
		<p>
<input type="checkbox" id="checkval" name="checkval"> "I hereby authorize recovery of (Rs. <b><u><span id="totval"></span></u></b>
 ) (total amount) through payroll towards employee contribution for "<b><u><%=eventname%></u></b>". In case of drop out, there shall be no refund".
<br/>
"I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or
injury occurring during the trip."
<br/><br/>
<input type="submit" name="submit1" id="submit1" style="display:none" class="submitcls" value="Confirm Submission" onclick="return validate();">		
</p>

<br/>
<br/>
Note: <span class="req">Payment will be deducted from your salary through automated PTA.<br/>
However you may edit your requirment of tickets till cut of date <%=cutofdte%>.
		</span>
</center>
</form>
		<%
		if(request.getParameter("submit1")!=null ){
			String boardpnt="",empn="",sysdte="";
			String qryins = "",sts="";
			int noofticks = 0;
			double paymnt = 0.0;
			int flag = 0;
			noofticks = Integer.parseInt(request.getParameter("noofticks"));
			paymnt = Double.parseDouble(request.getParameter("paymnt"));
			boardpnt = request.getParameter("boardpnt");
			empn = request.getParameter("empn");
			sysdte = request.getParameter("sysdte");
			eventname = request.getParameter("eventname");
			sts = request.getParameter("sts");
			PreparedStatement pmstins = null;
			if((sysdte!=null) && (!("").equals(sysdte))){
				qryins = "update NOMINATION set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,modifydte=sysdate,ENTERBY=? where EMP_NO =? and EVTNME =? and flag = ?";
			} else{
				//qryins = "insert into NOMINATION (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,flag,EMP_NO,EVTNME) values(?,?,?,sysdate,?,?,?,?)";
			}
			pmstins = con.prepareStatement(qryins);
			pmstins.setInt(1,noofticks);
			pmstins.setString(2,boardpnt);
			pmstins.setDouble(3,paymnt);
			pmstins.setString(4,login1);
			//pmstins.setString(5,sts);
			pmstins.setString(5,empn);
			pmstins.setString(6,eventname);
			pmstins.setString(7,sts);
			
			flag = pmstins.executeUpdate();
			if( flag >= 1 ){
				%>
			<script>alert("Details Submitted");
			location.href="mynomination.jsp";</script>
			<%} else{
				%>
			<script>alert("Error");
			location.href="mynomination.jsp";</script>
			<%}
		}
		
		%>
		
</body>

</html>
<%@include file="footer.jsp"%>