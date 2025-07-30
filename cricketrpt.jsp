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
th
{font-family:Verdana;
font-size:x-small;
}
.style6 {
	border-width: 1px;
	border-collapse:collapse;
	border-color:#000000;
}



</style>
</head>

<body>
<% 
String emp_no=request.getParameter("emp_no");

String sempno=emp_no;
//out.println("HH"+sempno);
%>
<form action="cricket.jsp" method="post" name="form1">
<% 
SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy");
Date dNow = new Date( ); 
String today=sdf.format(dNow);
String empno="3"+sempno+"0";

%>
<% 
int j=0;
Statement st=con.createStatement();
PreparedStatement pmst=null;
String query="",empn="",empnme="",budesc="",telphone="",emailid="",loctn="",camp="",telemp="";
query="select e.emp_no,upper(e.emp_name),upper(e.budesc),j.emailid from empmaster e left outer join jde_emailid j on e.emp_no=j.emp_no where e.emp_no='"+emp_no+"'";
ResultSet rs=null;
rs=st.executeQuery(query);
if(rs.next())
{
empn=rs.getString(1);
empnme=rs.getString(2);
budesc=rs.getString(3);
emailid=rs.getString(4);
}
rs=null;
sempno=sempno.substring(1);
telemp=sempno.substring(0,sempno.length()-1);
String telquery="SELECT DIR_OFF_TELNO1,DIR_MOBILE FROM portal.emp_tel_dir_details WHERE dir_emp_no='"+telemp+"'";
rs=st.executeQuery(telquery);
if(rs.next())
{
telphone=rs.getString(1)+" / "+rs.getString(2);
}
rs=null;
//select to_char(person_dob,'dd/MM/YYYY'),trunc(months_between('31-MAR-15',person_dob)/12) relage,person_name from jdep where emp_no='"+empno+"' and relation_code ='CH' and person_status_code ='AC' and trunc(months_between('31-MAR-15',person_dob)/12) between '7' and '15'";
String childquery="select child_name,to_char(chil_dob,'dd/MM/YYYY'),age,shirt_size,age_gtp,loctn,coaching_camp,nvl(locn_other,' ') otherLocnName  from cricket_camp where emp_no='"+emp_no+"'";
pmst=con.prepareStatement(childquery);
//out.println(childquery);
rs=pmst.executeQuery();
if(rs.next())
{
	String otherLocn = rs.getString("otherLocnName");
loctn=rs.getString(6);
if(!" ".equals(otherLocn)){
 	loctn=loctn+"("+otherLocn+")";
}
camp=rs.getString(7);
}

%>

<div>
<div style="width:20%;float:left;overflow:hidden"><img src="erplogo.GIF" alt=""/></div>
<div style="float:left;width:55%;position:relative;overflow:hidden"><center><span class="style2"> COACHING CAMP
</span>
<br/><span class="style4"><span class="style5"><strong>May 10, 2022 - May 28, 2022</strong> <br/>
<br/>
HPCL Summer Coaching Camp
</span></span>
<br/>
<br/>

<span class="style3"><strong>Application Form 
</strong></span>
</center>
</div>
<a href="logout.jsp">Logout</a></div>

<table style="width: 60%" cellspacing="1" class="style1" align="center">
        <tr>
		<td  colspan="3"><u>LAST DATE FOR SUBMITTING THE APPLICATION FORMS : 04th May,2022</u><br/><br/></td>
	   </tr>

	<tr>
		<td style="width: 175px">EMPLOYEE&#39;S NAME</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=empnme%></td>
	</tr>
	<tr>
		<td style="width: 175px">EMPLOYEE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=empn%></td>
	</tr>
	<tr>
		<td style="width: 175px">LOCATION</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=loctn%></td>
	</tr>
	<tr>
		<td style="width: 175px">COACHING CAMP</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=camp%></td>
	</tr>
	<tr>
		<td style="width: 175px">DEPARTMENT</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=budesc%></td>
	</tr>
	<tr>
		<td style="width: 175px">TELEPHONE /MOBILE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=telphone%></td>
	</tr>
	<tr>
		<td style="width: 175px">EMAIL ID</td>
		<td style="width: 17px">:</td>
		<td style="width: 171px"><%=emailid%></td>
	</tr>
	</table>
	<br/>
	<table style="width: 68%" border="1" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<th style="width: 210px" class="style6">NAME OF THE CHILD</th>
		<th style="width: 136px" class="style6">DATE OF BIRTH</th>
		<th style="width: 121px" class="style6">AGE<br />
		(AS ON 31-3-2022)</th>
		<th style="width: 100px" class="style6">T-SHIRT SIZE</th>
		<!--<th style="width: 147px" class="style6">AGE GROUP</th>-->
		<th style="width: 147px" class="style6">COACHING CAMP</th>
	</tr>	
	<% 
	rs=pmst.executeQuery();
	String childnme="",childb="",childage="",shrt_size="",age_grp="";
	while(rs.next())
	{
	childnme=rs.getString(1);
	childb=rs.getString(2);
	childage=rs.getString(3);
	shrt_size=rs.getString(4);
	age_grp=rs.getString(5);
	camp=rs.getString(7);
	j++;%>
	<tr>
	    <td class="style6"><%=j%>:<%=childnme%></td>
	    <td style="width: 136px" class="style6"><%=childb%></td>
        <td style="width: 121px" class="style6"><%=childage%></td>
		<td style="width: 100px" class="style6"><%=shrt_size%></td>
        <!--<td style="width: 147px" class="style6"><%=age_grp%></td>-->
        <td style="width: 147px" class="style6"><%=camp%></td>

	</tr>
	<%}%>
	</table>
	<br/><br/>
	<!--<table style="width: 68%"  cellpadding="0" cellspacing="0" align="center">
	<tr><td colspan="3">Date: </td><td>Signature of Employee</td></tr>
   </table>-->
	<center><input type="button" value ="Back" onclick="location.href='cricket.jsp?emp_no=<%=emp_no%>'">
	</center>
</form>
</body>

</html>
