<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="connection.jsp"%>
<%
try {
String q = request.getParameter("term");
PreparedStatement ps=con.prepareStatement("select trim(emp_name) emp_name, emp_no from workflow.empmaster where emp_no like ? or lower(emp_name) like ?");
ps.setString(1, "%"+q+"%");
ps.setString(2, "%"+q+"%");
ResultSet rs = ps.executeQuery();
String emp_name="", emp_no="", output = "";
while(rs.next()) {
	emp_no = rs.getString("emp_no");
	emp_name = rs.getString("emp_name") + " ("+emp_no+")";
	output += ",{'id':'"+emp_no+"','label':'"+emp_name+"','value':'"+emp_name+"'}";
}
if(!"".equals(output))
	output = output.substring(1);

output = "["+output+"]";
output = output.replaceAll("'","\"");
out.println(output);
out.flush();

rs.close();
ps.close();
con.close(); 
}
catch(Exception e){
	e.printStackTrace();
}
%>