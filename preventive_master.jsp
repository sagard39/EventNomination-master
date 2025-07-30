<%@ page language ="java" import="java.util.*, java.text.*, java.sql.*, java.io.*"%>
<%@ include file="connection.jsp" %>
<html >

<head>

<title>PREVENTIVE MAINTENANCE FORM</title>
<script language="javascript" src="validate.js"></script>
<script type="text/javascript">
 function validatee()
{
var asset=document.forms["pmform"]["asset"].value;
var assetm=document.forms["pmform"]["assetmake"].value;
var assetn=document.forms["pmform"]["assetno"].value;
var assett=document.forms["pmform"]["assettag"].value;
var massetnam=document.forms["pmform"]["assetnam"].value;
var machineno=document.forms["pmform"]["machineno"].value;
var mac=document.forms["pmform"]["mac"].value;
var modelno=document.forms["pmform"]["modelno"].value;
var vtag=document.forms["pmform"]["vtag"].value;

if(asset=="" || asset=="Select")
{
alert("Select Asset");
return false;
}
else if(assetm=="" || assetm=="null" || assetm==null || assetm=="Select")
{
alert("Enter Asset Make");
return false;
}
else if(assetn=="" || assetn=="null" || assetn==null || assetn=="Select")
{
alert("Enter Asset Sr.No");
return false;
}
 else if(assett=="" || assett=="null" || assett==null || assett=="Select")
{
alert("Enter Asset TagNo");
return false;
}
/*else if(massetnam=="" || massetnam=="null" || massetnam==null || massetnam=="Select")
{
alert("Enter Monitor Name");
return false;
}
else if(machineno=="" || machineno=="null" || machineno==null || machineno=="Select")
{
alert("Enter Monitor  Sr.No");
return false;
} */
else if(mac=="" || mac=="null" || mac==null || mac=="Select")
{
alert("Enter MAC");
return false;
}
else if(modelno=="" || modelno=="null" || modelno==null || modelno=="Select")
{
alert("Enter Model Number");
return false;
}
else if(vtag=="" || vtag=="null" || vtag==null || vtag=="Select")
{
alert("Enter Vendor Tag Number");
return false;
}

else;
}
</script>

<style type="text/css">
.style1 {
	color: #FF0000;
}
.style2 {
	border-style: solid;
	border-width: 1px;
	font-size:xx-small;
	font-family:Verdana;
}
.style3 {
	border-width: 0px;
}
.style4 {
	border-right-style: solid;
	border-right-width: 1px;
	border-top-style: solid;
	border-top-width: 1px;
	border-bottom-style: solid;
	border-bottom-width: 1px;
	font-family:Verdana;
	font-size:xx-small;
}
.style5 {
	border-top-style: solid;
	border-top-width: 1px;
	border-bottom-style: solid;
	border-bottom-width: 1px;
}
.style6 {
	color: #FF0000;
	font-family: Verdana;
	font-size: x-small;
}
</style>
<script type="text/javascript" src="jtable/Scripts/jquery-1.6.4.min.js"></script>
<script>
 $(document).ready(function(){
	 
/******* Asset Name *****************/
	 if($("#asset").val() == "Select")
	 {
		 $("#printoptn").hide(); 
	 }
	 
 $("#asset").change(function(){
	 
    if($("#asset").val() == "Printer"){
             $("#printoptn").show();
			 $("#assetnam").hide();
			 $("#machineno").hide();
                            }
	else if($("#asset").val() == "Scanner"){
		     $("#printoptn").hide();
			 $("#assetnam").hide();
			 $("#machineno").hide();
	 }					
                            else
                            {
             $("#printoptn").hide();
			 $("#assetnam").show();
			 $("#machineno").show();
                            }
							});
							
/******* Printer Other *****************/
 if($("#printoptn").val() == "Select")
	 {
		 $("#printother").hide(); 
	 }
$("#printoptn").change(function(){
	 if($("#printoptn").val() == "OTHER")
	 {
		 $("#printother").show(); 
	 }
	 else
	 {
		 $("#printother").hide(); 
	 }
	});						
/****************** Model Num *****************/							
			if($("#modelno").val() == "Select")
	 {
		 $("#modelnoother").hide(); 
	 }
	 
 $("#modelno").change(function(){
    if($("#modelno").val() == "OTHER"){
             $("#modelnoother").show();
                            }
                            else
                            {
             $("#modelnoother").hide();
                            }
							});	
							
/******************* Model Make *************************/  
	if($("#assetnam").val() == "Select")
	 {
		 $("#monitermakeother").hide(); 
	 }
	 
 $("#assetnam").change(function(){
    if($("#assetnam").val() == "OTHER"){
             $("#monitermakeother").show();
                            }
                            else
                            {
             $("#monitermakeother").hide();
                            }
							});	
							
 /******************* Make *************************/  
 if($("#assetmake").val() == "Select")
	 {
		 $("#assetmakeother").hide(); 
	 }
	 
 $("#assetmake").change(function(){
    if($("#assetmake").val() == "OTHER"){
             $("#assetmakeother").show();
                            }
                            else
                            {
             $("#assetmakeother").hide();
                            }
							});	
 
 });
 

</script>
</head>

<body >

<h4><center class="style1">  <span class="style5"><u>PREVENTIVE MAINTENANCE FORM</u></span> </center><br/></h4>
<span class="style6">* Fields are Mandatory</span><FORM name="pmform" id="pmform"   method="post" onsubmit="return validatee();" action="prevmaster.jsp" >

<%
String empno="";
Statement st=con.createStatement();
PreparedStatement prest=null;

ResultSet rs=null;
String MYSQL="",tempmakedp="";
String empname="",location="",locn="",tempmodeldp="",tempmmkedp="",temprintdp="";

String modalqry="select modelname from pm_modelnum";
rs=st.executeQuery(modalqry);
while(rs.next())
{
tempmodeldp=tempmodeldp+"<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>";	
}
String [] modelmke={"ACER","DELL","HCL","LENOVO","SAMSUNG","OTHER"};
for(int i=0;i<modelmke.length;i++)
{
tempmmkedp=tempmmkedp+"<option value='"+modelmke[i]+"'>"+modelmke[i]+"</option>";	
}

String [] printerdp={"ALL IN ONE","DESKJET/INKJET","MONO LASERJET","COLOR LASERJET","NETWORK LASERJET","OTHER"};
for(int i=0;i<printerdp.length;i++)
{
temprintdp=temprintdp+"<option value='"+printerdp[i]+"'>"+printerdp[i]+"</option>";	
}

String [] makedp={"ACER","DELL","HCL","LENOVO","HP","CANON","EPSON","SAMSUNG","RICOH","LEXMARK","BROTHER","TVS","XEROX","CISCO","OTHER"};
for(int i=0;i<makedp.length;i++)
{
tempmakedp=tempmakedp+"<option value='"+makedp[i]+"'>"+makedp[i]+"</option>";	
}

rs=null;
if(request.getParameter("empno")!=null)
{
	empno=request.getParameter("empno");
  MYSQL="select  emp_name,locn,location from workflow.emp_master where '3'||emp_no||'0'=?";
  prest = con.prepareStatement(MYSQL);
  prest.setString(1,empno);

  rs = prest.executeQuery();

  while(rs.next())
	  {
empname=rs.getString(1);
locn=rs.getString(2);
location=rs.getString(3);
	  }
 }

%>


<table align=center><tr><td>Enter Employee Number(8 Digit):<input type=text name=empno id=empno maxlength="8" value=<%=empno%>>:<%=empname%></td><td><input type=button name=Submit id=Submit value="Enter" onclick="go();"></td></tr></table>
<hr>
<table border="1" align="center"><tr><td  style="height: 26px" class="style4">
	<span >Location/Dept.Code</span>:</td>
	<td style="height: 26px">
<input type="text" name="loccode" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=locn%>" readonly></td>
	<td class="style4" style="height: 26px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Location/Dept.Name:</td>
	<td style="height: 26px"  >
	<input type="text" style="font-family:Verdana;font-size:xx-small; width: 127px;" name="locname"  value="<%=location%>" readonly></td></tr>
<tr><td class="style4">Employee Name:</td><td><input type="text" name="empname" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=empname%>" readonly></td><td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Employee No:</td><td><input type="text" name="empno" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=empno%>" readonly></td></tr>
<tr><td class="style4">Type Of Asset:<span class="style1">*</span></td><td>
		<select style="width: 155px" name="asset" id="asset" style="font-family:Verdana;font-size:xx-small; width: 127px;"><option value="Select">Select</option>
		<option value="Laptop">Laptop</option>
		<option value="PC">PC</option>
		<option value="Printer">Printer</option>
		<option value="Scanner">Scanner</option>
		<option value="IP Phone">IP Phone</option>
		<option value="VC Equip">VC Equipment</option>
		<option value="TV Screen">TV Screen</option>	
		</select> 
		<select name="printoptn" id="printoptn" style="font-family:Verdana;font-size:xx-small;width: 127px;"><option value="Select">Select</option><%=temprintdp%></select>
	
		<input type="text" name="printother" id="printother" style="font-family:Verdana;font-size:xx-small;width: 127px;">
	</td><td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Make:<span class="style1">*</span></td><td><select name="assetmake" id="assetmake" style="font-family:Verdana;font-size:xx-small; width: 127px;"><option name="Select">Select</option><%=tempmakedp%></select>
	<input type="text" name="assetmakeother" id="assetmakeother" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="" maxlength="25"></td></tr>
<tr><td class="style4">Sr.No:<span class="style1">*</span></td><td><input type="text" name="assetno" maxlength="30" style="font-family:Verdana;font-size:xx-small; width: 127px;" onkeypress="return isAlphaNumeric(event)" ></td><td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAG No:<span class="style1">*</span></td><td><input type="text" style="font-family:Verdana;font-size:xx-small; width: 127px;" name="assettag" id="assettag" value="" maxlength="30"></td></tr>
<tr><td class="style4">Monitor Make:<span class="style1">*</span></td><td>
<select  name="assetnam" id="assetnam" style="font-family:Verdana;font-size:xx-small; width: 127px;" ><option value="Select">Select</option><%=tempmmkedp%></select>
<input type="text" name="monitermakeother" id="monitermakeother" style="font-family:Verdana;font-size:xx-small; width: 127px;" maxlength="20" ></td>
<td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Monitor Sr.No.:<span class="style1">*</span></td><td><input type="text" name="machineno" id="machineno" maxlength="20" style="font-family:Verdana;font-size:xx-small; width: 127px;"></td></tr>
<tr><td class="style4">Mac Address:<span class="style1">*</span></td><td><input type="text" name="mac" maxlength="30"  style="font-family:Verdana;font-size:xx-small; width: 127px;"></td>
<td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Model Number:<span class="style1">*</span></td><td>
<select name="modelno" id="modelno" style="font-family:Verdana;font-size:xx-small; width: 127px;"><option value="Select">Select</option><%=tempmodeldp%></select>
<input type="text" name="modelnoother" id="modelnoother" maxlength="20" style="font-family:Verdana;font-size:xx-small; width: 127px;"></td>
</tr>
<tr><td class="style4">Vendor Tag No:<span class="style1">*</span></td><td colspan="3"><input type="text" name="vtag" maxlength="16"  style="font-family:Verdana;font-size:xx-small; width: 127px;"></td>
</tr>

</table>
<br>
<div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;
<input type="submit" value="Submit Details" name="submit1"> 
</div>
<br>
<div>
<table align="center" class="style3"><tr><th class="style2">Type Of Asset</th>
	<th class="style2">Make</th><th class="style2">Sr.No</th><th class="style2">
	TAG No</th><th class="style2">Monitor Name</th><th class="style2">Monitor Sr.No</th>
	<th class="style2">Mac Address</th><th class="style2">
	Model Number</th><th class="style2">
	Entered By</th></tr>

	
		<% try{
String query="select * from pm_master where emp_no='"+empno+"'";
rs=st.executeQuery(query);
while(rs.next())
{
%>
<tr>
	<td class="style2"><%=rs.getString(5)%></td><td class="style2"><%=rs.getString(7)%></td>
	<input type="hidden" name="type" value="<%=rs.getString(5)%>">
		<td class="style2"><%=rs.getString(8)%></td>
	<td class="style2"><%=rs.getString(9)%></td><td class="style2"><%=rs.getString(6)%></td>
		<td class="style2"><%=rs.getString(11)%></td><td class="style2"><%=rs.getString(12)%></td>
	<td class="style2"><%=rs.getString(10)%></td><td class="style2"><%=rs.getString(14)%></td><td><a href="prevdel.jsp?empno=<%=empno%>&type=<%=rs.getString(5)%>&seq=<%=rs.getString(15)%>&assetsr=<%=rs.getString(8)%>">Delete</a></td>
	<td ><a href="preventive.jsp?empno=<%=empno%>&type=<%=rs.getString(5)%>&assetsr=<%=rs.getString(8)%>">Preventive Form</td>
	<td ><a href="savemaster.jsp?empno=<%=empno%>&type=<%=rs.getString(5)%>&seq=<%=rs.getString(15)%>">Modify</td>

	<%}
}catch(Exception e)
{
out.println(e);
}
%>
	


</tr></table>
</div>
</form>
</body>
<script language="javascript">
function go()
{
	document.pmform.action="preventive_master.jsp";
	document.pmform.submit();

}
function go1()
{
	document.pmform.action="prevmaster.jsp?opt=1";
	document.pmform.submit();

}

function go2()
{
	document.pmform.action="prevmaster.jsp?opt=2";
	document.pmform.submit();

}


</script>

</html>
