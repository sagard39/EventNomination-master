<%@ include file = "connection.jsp"%>

<%!
public String nullVal(String str){
	String valStr=str;
	if(str==null){
		valStr="";
	}else if((str.trim()).equals("null")){
		valStr="";
	}else if("".equals(str)){
		valStr="";
	}
	return valStr;
}
%>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition","attachment;filename =Employee Connect Feedback Report.xls");
String q= request.getParameter("q");
PreparedStatement psNew  = con.prepareStatement("select a.emp_no as \" Employee No.\",b.emp_name \"Employee Name\",b.grade as \"Grade\",b.email as \"Employee Email\",nvl(b.contact_no,'-') as \"Contact No\" ,ans1 as \"Answer 1\",ans2 as \"Answer 2\",ans3 as \"Answer 3\",ans4 as  \"Answer 4\",ans5 as\"Answer 5\",ans6 as \"Answer 6\",a.comments as \"Feedback Comments\",to_char(a.update_date,'dd-Mon-yyyy')  as \"Feedback Date\" from nomination_feedback a left join empmaster b on a.emp_no = b.emp_no where event =?");
psNew.setString(1,q);
ResultSet rsNew = psNew.executeQuery();
ResultSetMetaData rsmd1 =rsNew.getMetaData();
int count = rsmd1.getColumnCount();
out.println("<table  style='border:1;border-collapse:collapse;' border='2'>");
out.println("<tr>");
for(int i=1;i<=count;i++){
	out.println("<th>");
	out.println(rsmd1.getColumnName(i));	
}
out.println("</tr>");
while(rsNew.next()){
		out.println("<tr>");
		for(int i=1;i<=count;i++){
			out.println("<td>");
			out.println(rsNew.getString(i));
			out.println("</td>");
		}
		out.println("</tr>");
}
out.println("</table>");
%>
