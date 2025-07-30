<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="connection.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cricket Coaching Camp</title>
<style type="text/css">
.style1 {
	border-collapse: collapse;
	
}
td,select,input[type="text"]{font-family:Verdana;
font-size:small;
}
th
{font-family:Verdana;
font-size:x-small;
}

.style2 {
	font-size: x-large;
	font-family: "Arial Rounded MT Bold";
}
.style3 {
	font-family: Verdana;
	font-size: medium;
	padding-bottom:40%;
	}
.style4 {
	font-family: Verdana;
}
.style5 {
	font-size: small;
}
body{
background-image:url('background.jpg');
/*opacity: 0.4;
filter: alpha(opacity=40);*/
}
.style6 {
	border-style: solid;
	border-width: 1px;
	border-collapse:collapse;
	border-color:#F2F2F2;
}
.style7 {
	border-width: 0px;
}
</style>
<script>
function validate()
{
var chek=false;
var loctn=document.forms["form1"]["loc"].value;
var checkboxes = document.getElementsByName("chk");

for(var i=0;i<checkboxes.length;i++)
{
if(checkboxes[i].checked==true)
	{
	chek=true;
     }
}
if(chek==false)
	{
alert("Select atleast one checkbox");
return false;
	}
if(loctn==null || loctn=="" || loctn=="Select")
{
alert("Enter your Location");
return false;
}

return true;
}
</script>
</head>

<body>
<%
String sempno="";
/*String emp_no=request.getParameter("emp_no");
session.putValue("sempno",emp_no);
String sempno=(String)session.getAttribute("sempno");*/
sempno=(String)session.getValue("empno");

String emp_no=sempno;
%>
<form action="cricket.jsp" method="post" name="form1" onsubmit="return validate();">
<% 

String empno="3"+sempno+"0";
 %>
<% 
int j=0;
Statement st=con.createStatement();
PreparedStatement pmst=null;
String chkquery="select * from cricket_camp where emp_no=? and CHILD_NAME=?";
pmst=con.prepareStatement(chkquery);
ResultSet rs1=null;
String query="",empn="",empnme="",budesc="",telphone="",emailid="",loc="",readonly="";
query="select e.emp_no,upper(e.emp_name),upper(e.budesc),j.emailid from empmaster e left outer join jde_emailid j on e.emp_no=j.emp_no where e.emp_no='"+empno+"' and e.town in ('VASHI','MUMBAI')";
ResultSet rs=null;

rs=st.executeQuery(query);
if(rs.next())
{
empn=rs.getString(1);
empnme=rs.getString(2);
budesc=rs.getString(3);
emailid=rs.getString(4);
}
else
{
	response.sendRedirect("index.jsp");
}
rs=null;
String telquery="SELECT DIR_OFF_TELNO1,DIR_MOBILE FROM portal.emp_tel_dir_details WHERE dir_emp_no='"+sempno+"'";
rs=st.executeQuery(telquery);
if(rs.next())
{
telphone=rs.getString(1)+" / "+rs.getString(2);
}
rs=null;

String locquery="select * from cricket_camp where emp_no='"+empno+"'";
rs=st.executeQuery(locquery);
if(rs.next())
{
loc=rs.getString("LOCTN");
if(loc==null)
{
loc="";
}
else
{
readonly="readonly";
}
}
else
{
loc="";
}
rs=null;


String childquery="select to_char(person_dob,'dd/MM/YYYY'),trunc(months_between('31-MAR-15',person_dob)/12) relage,person_name from jdep where emp_no='"+empno+"' and relation_code ='CH' and person_status_code ='AC' and trunc(months_between('31-MAR-15',person_dob)/12) between '8' and '15'";
rs=st.executeQuery(childquery);

%>

<div>
<div style="width:20%;float:left;overflow:hidden"><img src="erplogo.GIF" alt=""/></div>
<div style="float:left;width:55%;position:relative;overflow:hidden"><center><span class="style2">CRICKET COACHING CAMP
</span>
<br/><span class="style4"><span class="style5"><strong>APRIL 27 TO MAY 16,2015</strong> <br/>
<br/>
HP NAGAR WEST CRICKET GROUND
<br/>
CHEMBUR,MUMBAI
</span></span>
<br/>
<br/>

<span class="style3"><strong>Application Form
</strong></span>
</center>
</div>
<a href="logout.jsp">Logout</a> || <a href="cricketrpt.jsp?emp_no=<%=emp_no%>">Report</a> || <a href="cricket_reports.jsp" target="_blank">Overview Report</a></div>

<table style="width: 60%" cellspacing="1" class="style1" align="center">
        <tr>
		<td  colspan="3"><u>LAST DATE FOR SUBMITTING THE APPLICATION FORMS : MARCH 31,2015</u><br/><br/></td>
	   </tr>

	<tr>
		<td style="width: 210px">EMPLOYEE&#39;S NAME</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="empname" type="text" value="<%=empnme%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	<tr>
		<td style="width: 210px">EMPLOYEE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="empnum" type="text" value="<%=empn%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	<tr>
		<td style="width: 210px" >LOCATION</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<select name="loc" style="width: 209px" />
		<% if(loc!=null)
		{
			out.println("<option value='"+loc+"' selected>"+loc+"</option>");
		}
		if(loc.equals(""))
		{
			out.println("<option value='Select' selected>Select</option>");
		}
	%>
		<option value="PH">PH</option>
		<option value="HB">HB</option>
		<option value="WZ">WZ</option>
		<option value="MR">MR</option>
		<option value="WZTC">WZTC</option>
		<option value="Mazgaon Terminal">Mazgaon Terminal</option>
		<option value="Sewree Wadala Complex">Sewree Wadala Complex</option>
		<option value="Mahul Terminal">Mahul Terminal</option>
		<option value="Vashi Terminal">Vashi Terminal</option>
		<option value="Others">Others</option>
		</select></td>
	</tr>
	<tr>
		<td style="width: 210px">DEPARTMENT</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="dept" type="text" value="<%=budesc%>" style="width: 203px" readonly="readonly" /></td>
	</tr>
	<tr>
		<td style="width: 210px">TELEPHONE /MOBILE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="telp" type="text" value="<%=telphone%>" style="width: 203px" readonly="readonly" /></td>
	</tr>
	<tr>
		<td style="width: 210px">EMAIL ID</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="email" type="text" value="<%=emailid%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	</table>
	<br/>
	<table style="width: 72%" border="1" cellpadding="0" cellspacing="0" align="center" class="style7">
	<tr>
        <th style="width: 100px" class="style6">&nbsp;</th>
		<th style="width: 210px" class="style6">NAME OF THE CHILD</th>
		<th style="width: 136px" class="style6">DATE OF BIRTH</th>
		<th style="width: 121px" class="style6">AGE<br />
		(AS ON 31-3-2015)</th>
		<th style="width: 100px" class="style6">T-SHIRT SIZE</th>
		<th style="width: 180px" class="style6">AGE GROUP</th>
	</tr>	
	<% 
	int dbflag=0;
	String childnme="",childb="",childage="";
	String dbage="",dbshrtsize="",dbagegrp="";

	while(rs.next())
	{
	childnme=rs.getString(3);
	childb=rs.getString(1);
	childage=rs.getString(2);

	pmst.setString(1,empno);
	pmst.setString(2,childnme);
	rs1=pmst.executeQuery();
	if(rs1.next())
		{
		dbflag=1;
        dbage=rs1.getString("AGE");
		dbshrtsize=rs1.getString("SHIRT_SIZE");
		dbagegrp=rs1.getString("AGE_GTP");	
		%>
		<tr>
<td style="width: 100px" class="style6"><strong>Submitted</strong></td>
<td style="width: 136px" class="style6"><%=childnme%></td>
<td style="width: 136px" class="style6"><%=childb%></td>
<td style="width: 136px" class="style6"><%=dbage%></td>
<td style="width: 136px" class="style6"><%=dbshrtsize%></td>
<td style="width: 136px" class="style6"><%=dbagegrp%></td>
</tr>
		<%
			} 
		else
		{
			
			dbflag=0;
			%>
	<tr>
	    <td style="width: 100px" class="style6"><input type="checkbox" name="chk" id="chk" value="<%=j%>"/></td>
	    <td class="style6"><input name="chldnme" type="text" value="<%=childnme%>" readonly="readonly" style="width: 203px" /></td>
	    <td style="width: 136px" class="style6">
		<input name="chldbrth" type="text" value="<%=childb%>" readonly="readonly" style="width: 145px" /></td>
        <td style="width: 121px" class="style6">
		<input name="chldage" type="text" readonly="readonly" value="<%=childage%>" style="width: 130px" /></td>
		<td style="width: 100px" class="style6"><select name="shirtsize" style="width: 93px">
	<option value="24">24</option>
	<option value="26">26</option>
	<option value="28">28</option>
	<option value="30">30</option>
	<option value="32">32</option>
	<option value="34">34</option>
	<option value="36">36</option>
	<option value="38">38</option>
	<option value="38">40</option>
	<option value="38">42</option>
	<option value="38">44</option>
	</select></td>
<td style="width: 180px" class="style6" >
	<select name="agegrp" style="width: 83px">
		<% if(Integer.parseInt(childage) >= 8 && Integer.parseInt(childage) < 9 )
	{
	%>
	<option value="8 to 9" selected="selected">8 to 9</option>

	<%}
	%>
	<% if(Integer.parseInt(childage) >= 9 && Integer.parseInt(childage) < 12 )
	{
	%>
	<option value="9 to 12" selected="selected">9 to 12</option>

	<%}
	%>
  <% if(Integer.parseInt(childage) >= 12 && Integer.parseInt(childage) <= 15 )
	{
	%>
    <option value="12 to 15">12 to 15</option>
    <%}
	%>

	</select>		
			</td>

	</tr>
		<% 	j++;} //else end
              } // while end
	   %>
	</table>
<br/>
<br/>
<center><input type="submit" value="Submit" name="submit1"/></center>
<%
String insquery="",chldnme2="",chldbrth2="",chldage2="",shrtsize2="",agegrp2="";
try{
if(request.getParameter("submit1")!=null)
{

String valempnme=request.getParameter("empname"); 
String valempno=request.getParameter("empnum");
String sbvalempno=valempno.substring(1,7);
String valloc=request.getParameter("loc");
String valdept=request.getParameter("dept");
String valtelp=request.getParameter("telp");
String valemail=request.getParameter("email");
String valchk[]=request.getParameterValues("chk");
String valchldnme[]=request.getParameterValues("chldnme");
String valchldbrth[]=request.getParameterValues("chldbrth");
String valchldage[]=request.getParameterValues("chldage");
String valshrtsize[]=request.getParameterValues("shirtsize");
String valagegrp[]=request.getParameterValues("agegrp");
int len=valchk.length;
//out.println("GG"+len);
int insflag=0;
for(int k=0;k<len;k++)
{
//out.println(k);
chldnme2= valchldnme[Integer.parseInt(valchk[k])];
chldbrth2= valchldbrth[Integer.parseInt(valchk[k])];
chldage2= valchldage[Integer.parseInt(valchk[k])];
shrtsize2= valshrtsize[Integer.parseInt(valchk[k])];
agegrp2= valagegrp[Integer.parseInt(valchk[k])];

insquery="insert into CRICKET_CAMP(EMP_NO,EMP_NAME,LOCTN,DEPARTMENT,EMAIL,TELPHONE,CHILD_NAME,CHIL_DOB,AGE,SHIRT_SIZE,AGE_GTP,enter_Date)values('"+valempno+"','"+valempnme+"','"+valloc+"','"+valdept+"','"+valemail+"','"+valtelp+"','"+chldnme2+"',to_date('"+chldbrth2+"','dd-mm-YYYY'),'"+chldage2+"','"+shrtsize2+"','"+agegrp2+"',sysdate)";
insflag=st.executeUpdate(insquery);
//out.println(insquery);
if(insflag>=1)
	{
	%>
	<script>alert("Data submitted ");
	location.href="cricketrpt.jsp?emp_no=<%=sbvalempno%>";</script>
	<%}
}


} //if submit end
} //try end


catch(NullPointerException  ex)
{
out.println("Select Checkbox");
}
catch(Exception e)
{
out.println(e);
}

%>

</form>
</body>

</html>
