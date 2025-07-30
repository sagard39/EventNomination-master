<%@include file="connection1.jsp" %>

<%
String empno = (String) session.getAttribute("USRID");
String fyear = (String) session.getAttribute("fyear");

String emp = request.getParameter("q");
String grade = request.getParameter("grade");
String nominee = request.getParameter("nominee");
String empList="",query="";

query = "select distinct TRIM(emp_name) emp_name from empmaster where upper(emp_name) like '"+emp+"%'  or lower(emp_name) like '"+emp+"%' ";
//out.println(query);

PreparedStatement ps = con.prepareStatement(query);
/*ps.setString(1,"%"+emp+"%");
ps.setString(2,"%"+emp+"%");
ps.setString(3,empno);
ps.setString(4,nominee);*
out.println(query+"<br>");
out.println(emp+"<br>");
out.println(empno+"<br>");
out.println(nominee+"<br>");*/
ResultSet rs = ps.executeQuery();
while(rs.next()) {
	/*if("null".equals(grade) || grade.compareTo(rs.getString("GRADE")) <= 0)
	empList+=",{'emp_no':'"+rs.getString("EMP_NO")+"','emp_name':'"+rs.getString("emp_name")+"','emp_grade':'"+rs.getString("GRADE")+"','emp_designation':'"+rs.getString("EMP_DESIGNATION")+"'}";*/
	empList+=",{'emp_name':'"+rs.getString("emp_name")+"'}";
}
if(!empList.equals(""))
	empList = empList.substring(1);
empList ="[" +empList+"]";
empList = empList.replaceAll("'","\"");

out.println(empList);
out.flush();

if(rs != null)
	rs.close();
if(ps != null)
	ps.close();
if(con != null)
	con.close();
%>