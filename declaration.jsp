<%@ include file="header.jsp"%>
<html>
<head>
<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
   <title>Declaration</title>
</head>

<script>
function checkall(){
	//alert("test");
  //alert(this.frm1.chk1.checked);
	if(!this.frm1.chk1.checked)
	{
    alert('Please Select Checkbox to point No. 1');
    return false;
	}
	 if(!this.frm1.chk2.checked)
	{
    alert('Please Select Checkbox to point No. 2');
    return false;
	}
	if(!this.frm1.chk3.checked)
	{
    alert('Please Select Checkbox to point No. 3');
    return false;
	}
	if(!this.frm1.chk4.checked)
	{
    alert('Please Select Checkbox to point No. 4');
    return false;
	}
	 if(!this.frm1.chk5.checked)
	{
    alert('Please Select Checkbox to point No. 5');
    return false;
	}
	if(!this.frm1.chk6.checked)
	{
    alert('Please Select Checkbox to point No. 6');
    return false;
	}
	if(!this.frm1.chk7.checked)
	{
    alert('Please Select Checkbox to point No. 7');
    return false;
	}
	if(!this.frm1.chk8.checked)
	{
    alert('Please Select Checkbox to point No. 8');
    return false;
	}
	if(!this.frm1.chk9.checked)
	{
    alert('Please Select Checkbox to point No. 9');
    return false;
	}
	if(!this.frm1.chk10.checked)
	{
    alert('Please Select Checkbox to point No. 10');
    return false;
	} 
	if(!this.frm1.chk11.checked)
	{
    alert('Please Select Checkbox to declaration');
    return false;
	} 
}
</script>

<style>
#tab td {
	text-align: justify;
	padding:5px 5px 5px 5px;
	text-justify: newspaper;
	font-size:16px;
}
#listTable td{
	padding:2px 2px 2px 2px;
	text-align: justify;
	text-justify: newspaper;
	font-size:16px;
}
#listTable th{
	color:#FFFFFF;
background-color: #5DADE2;
background: -webkit-linear-gradient(top ,#5DADE2, #1472C5);
background: -o-linear-gradient(top ,#5DADE2, #1472C5);
background: -moz-linear-gradient(top ,#5DADE2, #1472C5);
background: -ms-linear-gradient(top ,#5DADE2, #1472C5);
background: linear-gradient(top ,#5DADE2, #1472C5);	
}
#listTable{
	width:80%;
    border-collapse:collapse
}
#tab{
	width:80%;
}
#tab22 {
border: 1px solid #1472C5;
box-shadow:0 0 10px #5D6D7E;
background-color: #5DADE2;
background: -webkit-linear-gradient(top ,#5DADE2, #1472C5);
background: -o-linear-gradient(top ,#5DADE2, #1472C5);
background: -moz-linear-gradient(top ,#5DADE2, #1472C5);
background: -ms-linear-gradient(top ,#5DADE2, #1472C5);
background: linear-gradient(top ,#5DADE2, #1472C5);
border-radius: 9px;
}
</style>
<form name="frm1" id="frm1" action="declaration.jsp" method="post">
<%
String emp_no = (String)session.getAttribute("EVT_USRID");
String empTown = (String)session.getAttribute("EMP_TOWN");
//String currYear = (String)session.getAttribute("EVT_YEAR");
String flag="false";
String exist="select * from nomination_marathon  where emp_no=? and year =?";
PreparedStatement pmst_exist=con.prepareStatement(exist);
pmst_exist.setString(1,emp_no);
pmst_exist.setString(2,currYear);
ResultSet rsinfo2=pmst_exist.executeQuery();
if(rsinfo2.next()){
	flag="true";
}
String existt = "select emp_no from NOMINATION_MARATHON where emp_no =? and amount is not null";
PreparedStatement pstmt5 =null; 
ResultSet rs5 = null;

Date today = new Date();
Date cutoffdate=new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").parse("15/11/2019 23:59:59"); 
if(today.after(cutoffdate)) {
pstmt5=con.prepareStatement(existt);
pstmt5.setString(1,emp_no);
rs5=pstmt5.executeQuery();
if(rs5.next()){%>
<script>
location.href="thanku.jsp";
</script>
<% }else{%>
<script>
location.href="index.jsp";
</script>	
<%	}	
}

if(request.getParameter("submit1")!=null){
	
	
	pmst_exist=con.prepareStatement(exist);
    pmst_exist.setString(1,emp_no);
	pmst_exist.setString(2,currYear);
    rsinfo2=pmst_exist.executeQuery();
    if(rsinfo2.next()){
		
		pstmt5=con.prepareStatement(existt);
	    pstmt5.setString(1,emp_no);
	    rs5=pstmt5.executeQuery();
        if(rs5.next()){%>
		<script>
			location.href="thanku.jsp";
        </script>
	   <% }else{%>
		<script>
			location.href="index.jsp";
         </script>	
	<%	}	
     } else{
	 
	
	int ins=0;
	//String NM_DECLARATION="insert into NM_DECLARATION(empno,checkall_sts,enterdate)values(?,?,sysdate)";
	String NM_DECLARATION="insert into NOMINATION_MARATHON(EMP_NO,YEAR,DECLARATION_STS,CREATE_BY,CREATE_DATE)values(?,?,'Y',?,sysdate)";
    PreparedStatement pmst_ins=con.prepareStatement(NM_DECLARATION);
	pmst_ins.setString(1,emp_no);
	pmst_ins.setString(2,currYear);
	pmst_ins.setString(3,emp_no);
	
	ins=pmst_ins.executeUpdate();
	if(ins>0){%>
		<script>
			location.href="marathon.jsp";
		</script>
	<%}else{%>
		<script>
		alert("Error");
			location.href="declaration.jsp";
		</script>
	<%}
	}
}
%>
<!--
<table style="width: 100%;" align="center" id="tab22">
	<tr>
		<td style="height: 49px" align="left">
		<img align="left" name="alogin" src="images/HPCL.jpg" width="80" height="80"/>
		</td>
		<td align="center"><font size="6" color="#FFFFFF"><i>YPCC HP Marathon - 2019 Nomination 2018</i></font>
		</td>
		<td><img align="right" name="alogin" src="images/Reboot1.png" width="80" height="80"/>
		</td>
	</tr>
	<tr>
	<td colspan="2"></td>
	<td  >
	<%if("31919150".equals(emp_no) || "31918150".equals(emp_no) || "31908900".equals(emp_no) || "31969510".equals(emp_no) || "31926310".equals(emp_no) || "30074010".equals(emp_no)){%>
				<a style="color:#ECF0F1" href="reportByDis.jsp?cityCode=M"><font size=4>Report(MUMBAI)</font></a>&nbsp;&nbsp;
	<%} if("31919150".equals(emp_no) || "31918150".equals(emp_no) || "31908900".equals(emp_no) || "31969510".equals(emp_no) || "31926310".equals(emp_no) || "30074010".equals(emp_no) || "30040790".equals(emp_no)|| "39833130".equals(emp_no)|| "31915110".equals(emp_no)|| "31960190".equals(emp_no) || "39817770".equals(emp_no)){%>			
				<a style="color:#ECF0F1" href="reportByDis.jsp?cityCode=VZ"><font size=4>Report(VISAKH Refinary)</font></a>&nbsp;&nbsp;
	<%}%>
	<%if("30074010".equals(emp_no)){%>
				<a style="color:#ECF0F1;" href="bibEnter.jsp">Update BIB</a>&nbsp;&nbsp;
			<% } %>

				<a href="logout.jsp"><font color="#ffffff" size=4>Logout</font></a></td>
	</td>	
	</tr>
</table>-->
<center>
<table width="70%" id="tab">
	<TR>	
		<td style="padding:5px 5px 5px 5px">
		I and my family members hereby declare, confirm and agree as below.
		</td>
	</TR>
</table>
<br>
<div class="mb10">
	<div class="">
	<table border="1" style="font-size:13px;" width="70%" id="listTable">
	<thead>
		<tr>
			<th>#</th>
			<th></th>
			<th style="text-align:center;">Declarations</th>
		</tr>
	</thead>
	<tbody>	
		<tr><td>1. </td>
		<td>
		<input type="checkbox" name="chk1" id="chk1" <%if(("true").equals(flag)){%>checked<%}%>></td><td>The information submitted by me about myself and my family members in this entry form is true. I am solely responsible for the accuracy of this information.</td></tr>
		<tr><td>2. </td>
		<td>
		<input type="checkbox" name="chk" id="chk2" <%if(("true").equals(flag)){%>checked<%}%>></td><td>That I and my family members are participating out of our own free will and that there is no pressure nor requirement or is it a condition of my service to participate in the above event from HPCL or any of its representatives or Reboot@35+ - HP Mumbai Marathon and Walkathon  Organizing Committee (hereinafter referred to as RMOC).</td></tr>
		<tr><td>3. </td>
		<td>
		<input type="checkbox" name="chk" id="chk3" <%if(("true").equals(flag)){%>checked<%}%>></td><td>I understand that for a physical endurance event like the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b>, myself and my family members must be trained to an appropriate level of fitness to participate in the same. </td></tr>
		<tr><td>4. </td>
		<td>
		<input type="checkbox" name="chk" id="chk4" <%if(("true").equals(flag)){%>checked<%}%>></td><td>I am aware of the inherent risk of participating in a physical endurance event like the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b> and take full responsibility for the overall health and safety of myself and my family to participate in the same. </td></tr>
		
		<tr><td>5. </td><td><input type="checkbox" name="chk" id="chk5" <%if(("true").equals(flag)){%>checked<%}%>></td><td>That neither me or any member of my family suffer from any medical or physical condition which otherwise is a risk for their participation in the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b></font></td></tr>
		<tr><td>6. </td><td>
		<input type="checkbox" name="chk" id="chk6" <%if(("true").equals(flag)){%>checked<%}%>></td><td>That neither HPCL nor any of its representatives or <b>RMOC</b> will be held responsible for any eventuality arising out of such participation by me or my family members and that me or my legal representatives shall waive all claim of whatsoever nature against HPCL, or any of its representatives or <b>RMOC</b> for any untoward incident.</td></tr>		
		<tr><td>7. </td><td><input type="checkbox" name="chk" id="chk7" <%if(("true").equals(flag)){%>checked<%}%>></td><td>That if me or any of my family members are injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to transport me/my ward to a medical facility and or to administer emergency medical treatment. I and my family members also agree to waive all claim that might result from such transport and or treatment or delay or deficiency therein.</td></tr>
		<tr><td>8. </td><td>
		<input type="checkbox" name="chk" id="chk8" <%if(("true").equals(flag)){%>checked<%}%>></td><td>That I am not hiding or suppressing any such medical data relating to me and my family members from RMOC that may either put me or my family to risk by participating in the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b>.</td></tr>
		<tr><td>9. </td><td>
		<input type="checkbox" name="chk" id="chk9" <%if(("true").equals(flag)){%>checked<%}%>></td><td>I understand, agree and irrevocably permit RMOC to share the information given me & my family members in this application, with all/any entities associated with the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b>, at its own discretion.</td></tr>
		<tr><td>10. </td><td>
		<input type="checkbox" name="chk" id="chk10" <%if(("true").equals(flag)){%>checked<%}%>></td><td>I understand, agree and irrevocably permit <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b> to use me & my family members photograph which may be photographed on the day of the event, for the sole purpose of promoting the <b>Reboot@35+ - HP Mumbai Marathon and Walkathon </b>, at its own discretion. </td></tr>
		<tr><td>11. </td>
			<td width="3%"><input type="checkbox" name="chk" id="chk11" <%if(("true").equals(flag)){%>checked<%}%>>
			</td>
			<td>Winners of various categories will be decided based on the guidelines finalized by RMOC and the decision of RMOC in this regard will be final.
			</td>
		</tr>
	</tbody>
   </table>
</div>
</div>
   <br><br>
   <table width="70%" style="font-size:13px;" id="tab">
		<tr>
			<!--<td width="3%"><input type="checkbox" name="chk" id="chk11" <%if(("true").equals(flag)){%>checked<%}%>>
			</td>
			<td>
			I hereby declare that the information given by me about myself and my family members in this entry form is true and I am solely responsible for the accuracy of this information.
			</td>-->
		</tr>
		<tr>
		   <td colspan="2"><font color=red>Note: Race timing certificates / Link to the same would be displayed on the HPCL Event Nomination portal.</font></td>
		</tr>
   </table>
   <br>
   <input type="hidden" name="emp" id="emp" value="">
	<input type="submit" style="background-color:#108A9C;color:#FFFFFF" class="style-right-button" name="submit1" id="submit1" value="Continue" onClick="return checkall();">
  </center>
  <br/>
    <br/>
  </form>
  </html>