<%@include file="connection_sap.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

<%
PreparedStatement ps=null;
ResultSet rs=null;

String query = "";
%>	

<div class="container">
	<div class="">
		
	</div>
</div>

</body>


<%

query = "select * from "+sap_schema+".ZHRCV_DEPENDENT zd where EMPLOYEE_NUMBER ='31982600' ";
ps = con_sap.prepareStatement(query);
rs = ps.executeQuery();

while(rs.next()){%>
<tr>
	<td><%=rs.getString("dependent_id")%></td>
</tr>
<%}

%>

<%

try{
	if(ps!=null){ps.close();}
	if(rs!=null){rs.close();}
	if(con_sap!=null){con_sap.close();}
}catch(Exception ex){}

%>

</html>