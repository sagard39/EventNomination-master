<%@ page language ="java" import="java.util.*, java.text.*, java.sql.*, java.io.*"%>
<%@ include file="connection.jsp" %>
<html >
<%String empn="";
 empn=(String)session.getAttribute("empn"); 
   if(empn==null || empn.equals("null"))
            {
	 %>
            <script language=javascript>
	          open("sessout.html","_self");
	        </script>
	 <%}
%>
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
else if(assetm=="" || assetm=="null" || assetm==null)
{
alert("Enter Asset Make");
return false;
}
else if(assetn=="" || assetn=="null" || assetn==null)
{
alert("Enter Asset Sr.No");
return false;
}
else if(assett=="" || assett=="null" || assett==null)
{
alert("Enter Asset TagNo");
return false;
}
else if(massetnam=="" || massetnam=="null" || massetnam==null)
{
alert("Enter Monitor Name");
return false;
}
else if(machineno=="" || machineno=="null" || machineno==null)
{
alert("Enter Monitor  Sr.No");
return false;
}
else if(mac=="" || mac=="null" || mac==null)
{
alert("Enter MAC");
return false;
}
else if(modelno=="" || modelno=="null" || modelno==null)
{
alert("Enter Model Number");
return false;
}
else if(vtag=="" || vtag=="null" || vtag==null)
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
 

</head>

<body >

<center class="style1">  <span class="style5"><u>PREVENTIVE MAINTENANCE FORM</u></span> </center><br/>
<span class="style6">* Fields are Mandatory</span>
<%
String empno=request.getParameter("empno");
String type=request.getParameter("type");
String seq=request.getParameter("seq");
%>
<FORM name="pmform" id="pmform"   method="post" onsubmit="return validatee();" action="svupdatemaster.jsp?empno=<%=empno%>&seq=<%=seq%>" >

<% try
{
PreparedStatement prest=null;

ResultSet rs=null;
String MYSQL="";
String empname="",location="",locn="",empnum="",asset="",assetname="",assetmake="",assetsr="",assettag="",modelno="",machineno="",mac="",vtag="";
MYSQL="select LOCN,LOCATION,EMP_NO,EMP_NAME,ASSET_TYPE,ASSET_NAME,ASSET_MAKE,ASSET_SRNO,ASSET_TAGNO,MODEL_NO,MACHINE_NO,MAC_ADDRESS,VENDOR_TAG from pm_master where emp_no='"+empno+"' and asset_type='"+type+"' and srno='"+seq+"'";

  prest = con.prepareStatement(MYSQL);
  rs = prest.executeQuery();

  while (rs.next())
	  {
empname=rs.getString(4);
locn=rs.getString(1);
location=rs.getString(2);
empnum=rs.getString(3);
asset=rs.getString(5);
assetname=rs.getString(6);
assetmake=rs.getString(7);
assetsr=rs.getString(8);
assettag=rs.getString(9);
modelno=rs.getString(10);
machineno=rs.getString(11);
mac=rs.getString(12);
vtag=rs.getString(13);
	  }
     


%>


<table align=center><tr></tr></table>
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
		<select style="width: 155px" name="asset" style="font-family:Verdana;font-size:xx-small; width: 127px;">
		<option value="<%=asset%>"><%=asset%></option>
		<option value="Laptop">Laptop</option>
		<option value="PC">PC</option>
		<option value="Printer">Printer</option>
		<option value="Scanner">Scanner</option>
		<option value="IP Phone">IP Phone</option>
		<option value="VC Equip">VC Equip</option>
		<option value="TV Screen">TV Screen</option>
		</select>
		</td>
		<td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Make:<span class="style1">*</span></td><td>
		<input type="text" name="assetmake" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=assetmake%>" maxlength="25"></td></tr>
<tr><td class="style4" style="height: 24px">Sr.No:<span class="style1">*</span></td>
	<td style="height: 24px">
	<input type="text" name="assetno" maxlength="30" style="font-family:Verdana;font-size:xx-small; width: 127px;" onkeypress="return isAlphaNumeric(event)" value="<%=assetsr%>" ></td>
	<td class="style4" style="height: 24px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAG No:<span class="style1">*</span></td>
	<td style="height: 24px">
	<input type="text" style="font-family:Verdana;font-size:xx-small; width: 127px;" name="assettag" value="<%=assettag%>" maxlength="30"></td></tr>
<tr><td class="style4">Monitor Name:<span class="style1">*</span></td><td>
		<input type="text" name="assetnam" style="font-family:Verdana;font-size:xx-small; width: 127px;" maxlength="20" value="<%=assetname%>" ></td>
<td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Monitor Sr.No.:<span class="style1">*</span></td><td>
		<input type="text" name="machineno" maxlength="20" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=machineno%>"></td></tr>
<tr><td class="style4">Mac Address:<span class="style1">*</span></td><td>
		<input type="text" name="mac" maxlength="30"  style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=mac%>"></td>
<td class="style4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Model Number:<span class="style1">*</span></td><td>
		<input type="text" name="modelno" maxlength="20" style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=modelno%>"></td>
</tr>
<tr><td class="style4">Vendor Tag No:<span class="style1">*</span></td><td colspan="3"><input type="text" name="vtag" maxlength="16"  style="font-family:Verdana;font-size:xx-small; width: 127px;" value="<%=vtag%>"></td>
</tr>

</table>
<br>
<div align="center">&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;
<input type="button" value="Back" name="back" onclick="document.location.href='preventive_master.jsp'">&nbsp; &nbsp; &nbsp; &nbsp; 
<input type="submit" value="Submit Details" name="submit1"> 
</div>
<%
	
}
catch(Exception e)
{
out.println(e);
}
%>
<br>
</form>
</body>
</html>
