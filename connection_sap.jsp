<%@ page import="java.sql.*,java.text.*,java.io.*,javax.servlet.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
 
<%
Connection con_sap = null;

try{
	Class.forName("net.sourceforge.jtds.jdbc.Driver");
	con_sap =DriverManager.getConnection("jdbc:jtds:sqlserver://*****.hpcl.co.in:17243/*****","*****","*****");  /////dev_sap
	//con_sap =DriverManager.getConnection("jdbc:jtds:sqlserver://*****.hpcl.in:16080/*****","*****","*****");  /////prod_sap
}catch(Exception ex){out.println("hey="+ex);}


String sap_schema = "*****";///dev
//String sap_schema = "*****";///prod

%>