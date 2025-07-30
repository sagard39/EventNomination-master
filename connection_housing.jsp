<%@ page import="java.sql.*,java.text.*,java.io.*,javax.servlet.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
<%@ page import="java.sql.*,java.text.*,java.util.*,java.math.*,java.lang.String.*" %>
<%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource,javax.servlet.*,javax.servlet.http.* "  %>
<%@ page import="java.io.*, java.lang.*, java.net.*,java.text.DecimalFormat,java.text.NumberFormat" %>
<%@ page import="java.sql.*" %>


 <%

Connection conHousing1=null; 
Class.forName("oracle.jdbc.driver.OracleDriver");
//conHousing1 = DriverManager.getConnection("jdbc:oracle:thin:@*****.hpcl.co.in:1521:*****","*****","*****");
conHousing1=DriverManager.getConnection("jdbc:oracle:thin:*****/*****@//*****.hpcl.co.in:1550/*****");
%>