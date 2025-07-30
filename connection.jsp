<%@ page import="java.sql.*,java.text.*,java.io.*,javax.servlet.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
<%@ page import="java.sql.*,java.text.*,java.util.*,java.math.*,java.lang.String.*" %>
<%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource,javax.servlet.*,javax.servlet.http.* "  %>
<%@ page import="java.io.*, java.lang.*, java.net.*,java.text.DecimalFormat,java.text.NumberFormat" %>
<%@ page import="java.sql.*" %>


<%
Connection con=null; 
Connection conCricket=null; 
Connection conerp=null; 
Connection conHousing=null; 
Class.forName("oracle.jdbc.driver.OracleDriver");
con = DriverManager.getConnection("jdbc:oracle:thin:@//*****.hpcl.co.in:1551/*****","*****","*****");

//conCricket=DriverManager.getConnection("jdbc:oracle:thin:@//orasid.hpcl.co.in:1521/*****","*****","*****");
conCricket=DriverManager.getConnection("jdbc:oracle:thin:@//*****.hpcl.co.in:1551/*****","*****","*****");
//con = DriverManager.getConnection("jdbc:oracle:thin:@//orasid.hpcl.co.in:1521/*****","*****","*****");
Connection con1=null,con2=null;
//Class.forName("com.ibm.as400.access.AS400JDBCDriver");
//con2 = DriverManager.getConnection("jdbc:oracle:thin:@//orasid.hpcl.co.in:1521/*****","*****","*****");
Class.forName("com.ibm.as400.access.AS400JDBCDriver");

//con1 =DriverManager.getConnection("jdbc:as400://*****.HPCL.CO.IN;naming=system;errors=full","*****","*****");

//conHousing = DriverManager.getConnection("jdbc:oracle:thin:@*****.hpcl.co.in:1521:*****","*****","*****");

%>

<%@include file="common_val.jsp" %>
