<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="connection.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="filtergrid.css"/>
<title>Cricket Coaching Camp</title>
<script language="javascript" src="tablefilter.js">
</script>
<script language="javascript" src="actb.js">
</script>
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
<!--<ul><li ><a href="cricket_reports.jsp?opt=1">Report sort by AGE GROUP</a></li>
<li><a href="cricket_reports.jsp?opt=2">Report sort by T-SHIRT SIZE</a></li>
</ul>-->



<table id="table1"><tr><th>Emp.No</th><th>Emp Name</th><th>Location</th><th>Coaching Camp</th><th>Department</th><th>Email</th><th>Telephone</th><th>Child Name</th><th>Child Dob</th><th>Age</th><th>Shirt Size</th><th>Age Group</th></tr>

<% 
Statement st=con.createStatement();
ResultSet rs=null;
String query="select EMP_NO,EMP_NAME,LOCTN,COACHING_CAMP,DEPARTMENT,EMAIL,TELPHONE,CHILD_NAME,to_char(CHIL_DOB,'dd-MON-YYYY'),AGE,SHIRT_SIZE,AGE_GTP from cricket_camp order by ENTER_DATE";
rs=st.executeQuery(query);
while(rs.next())
{
out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td><td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td><td>"+rs.getString(7)+"</td><td>"+rs.getString(8)+"</td><td>"+rs.getString(9)+"</td><td>"+rs.getString(10)+"</td><td>"+rs.getString(11)+"</td><td>"+rs.getString(12)+"</td></tr>");
}
%>
</table>
<script language="javascript" type="text/javascript">
var table1_Props = 	{
					
					alternate_rows: true,
					//col_width: ["30px","55px","220px","37px","38px","40px","100px","30px","30px","40px","65px","65px","55px","45px","55px","55px"],//prevents column width variations
					rows_counter: true,
					rows_counter_text: "Total rows: ",
					btn_reset: true,
					bnt_reset_text: "Clear all "
				};
	setFilterGrid( "table1",table1_Props );

</script>
<%
/*if (request.getParameter("opt")!=null )
{
	if(request.getParameter("opt").equals("1"))
	{
	out.println("<table><tr><th>Age Group</th><th>Count</th></tr>");
	String query="select age_gtp, count(age_gtp) from cricket_camp group by  age_gtp";
	rs=st.executeQuery(query);
	while(rs.next())
	{
out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td></tr>");
	}
out.println("<table>");
	}

		if(request.getParameter("opt").equals("2"))
	{
	out.println("<table><tr><th>Shirt Size</th><th>Count</th></tr>");
	String query="select SHIRT_SIZE, count(SHIRT_SIZE) from cricket_camp group by  SHIRT_SIZE";
	rs=st.executeQuery(query);
	while(rs.next())
	{
out.println("<tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td></tr>");
	}
out.println("<table>");
	}
}*/
%>
</body>

</html>
