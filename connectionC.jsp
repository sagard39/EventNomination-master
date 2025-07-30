 <%@ page import="java.sql.*,java.text.*,java.io.*,javax.servlet.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
<%@ page import="java.sql.*,java.text.*,java.util.*,java.math.*,java.lang.String.*" %>
<%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource,javax.servlet.*,javax.servlet.http.* "  %>
<%@ page import="java.io.*, java.lang.*, java.net.*,java.text.NumberFormat" %>
<%@ page import="java.sql.Connection" %>
 
<%
Connection con=null;
Connection conjde=null;
//String dbURL = "jdbc:oracle:thin:@//*****.hpcl.co.in:1551/*****";
String dbURL = "jdbc:oracle:thin:@*****.hpcl.co.in:1521:*****";
String dbDriver = "oracle.jdbc.driver.OracleDriver"; 


Class.forName(dbDriver); 


con=DriverManager.getConnection(dbURL,"*****","*****"); 
//con=DriverManager.getConnection(dbURL,"*****","*****"); 

%>