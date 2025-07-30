<%@ include file="connection.jsp"%>

<%
int ins=0;
String eno=(String)session.getAttribute("login");
String age=request.getParameter("age");
String gender=request.getParameter("gender");
String val1=request.getParameter("val1");
String val2=request.getParameter("val2");
String val3=request.getParameter("val3");
String val4=request.getParameter("val4");
String val5=request.getParameter("val5");
String val6=request.getParameter("val6");
String val7=request.getParameter("val7");
String val8=request.getParameter("val8");
String val9=request.getParameter("val9");
String pcd=request.getParameter("pcd");
String output="";
String action =request.getParameter("action");
String query="insert into nm_marathon values(?,?,?,sysdate,'"+eno+"',?,?,?,?,?,?,?,?,?,'','','','','','')";
PreparedStatement ps=con.prepareStatement(query);
if("Approve".equals(action)){
ps.setString(1,pcd);
ps.setString(3,age);
ps.setString(2,gender);
ps.setString(4,val1);
ps.setString(5,val2);
ps.setString(6,val3);
ps.setString(7,val4);
ps.setString(8,val5);
ps.setString(9,val6);
ps.setString(10,val7);
ps.setString(11,val8);
ps.setString(12,val9);
//ins=ps.executeUpdate();

}
output="success";
output = "{"+output+"}";
output = output.replaceAll("'","\"");
out.println(output);
out.flush();

%>