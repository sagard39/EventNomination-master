<%@include file="connection.jsp"%>
<script>
function  goPrint(){
	window.print();
}
</script>
<%
String query="SELECT 'Table Tennis'camp ,a.emp_no,a.child_name,a.age,a.shirt_size,a.telphone,b.emp_name FROM CRICKET_CAMP a left join empmaster b on a.emp_no=b.emp_no WHERE COACHING_CAMP LIKE '%Tenis%' UNION ALL  SELECT 'Swimming' camp,a.emp_no,a.child_name,a.age,a.shirt_size,a.telphone,b.emp_name FROM CRICKET_CAMP a left join empmaster b ON A.EMP_NO=B.EMP_NO WHERE COACHING_CAMP LIKE '%Swimming%' UNION ALL SELECT 'Cricket' CAMP,A.EMP_NO,A.CHILD_NAME,A.AGE,A.SHIRT_SIZE,A.TELPHONE,B.EMP_NAME FROM CRICKET_CAMP A LEFT JOIN EMPMASTER B ON A.EMP_NO=B.EMP_NO WHERE COACHING_CAMP LIKE '%Cricket%'";
PreparedStatement ps=conCricket.prepareStatement(query);
ResultSet rs=ps.executeQuery();
int cnt=1;
%>
<div><Center>
<h2>Cricket Camp</h2>
<table style="border-collapse:collapse; width:100%;" border="1">
	<tr>
	<th>Sr.No</th>
	<th>Employee</th>
	<th>Applicant Name</th>
	<th>Age</th>
	<th>T-Shirt Size</th>
	<th>Contact No</th>
	<th>Applied For</th>
	</tr>
	<%while(rs.next()){%>
	<tr>
		<td><%=(cnt++)%></td>
		<td><%=rs.getString("emp_name")%>(<%=rs.getString("emp_no")%>)</td>
		<td><%=rs.getString("CHILD_NAME")%></td>
		<td><%=rs.getString("age")%></td>
		<td><%=rs.getString("SHIRT_SIZE")%></td>
		<td><%=rs.getString("TELPHONE")%></td>
		<td><%=rs.getString("camp")%></td>
	</tr>	
	<%}%>
</table>
	<input type="button" name="printBtn" onclick="goPrint();" value="Print">
</center>
</div>