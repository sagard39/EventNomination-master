<%@ include file="connection.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

 <%@ page language="java" import="java.sql.*,java.text.*,java.util.*,java.math.*" %>
    <%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource " %>
    <%@ page import="java.io.*, java.lang.*, java.net.*" %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.util.Hashtable,javax.naming.ldap.*,javax.naming.directory.*,javax.naming.*,java.util.Calendar,java.sql.Date.*,java.text.SimpleDateFormat" %>

<HTML>        

<form method="POST" action="" name="FrontPage_Form1">
<%
boolean adsfound=false,dbfound=false;
String eno="";

boolean islogin=false;

	String login = request.getParameter("empno");
	//out.println("1="+login);
	login = decrypt(login);
	//out.println("2="+login);
	String login1 =(String)session.getValue("login");
	PreparedStatement ps=null;
	ResultSet rs=null;
	if(login!=null){
       	session.putValue("login",login);
	} 
	//String password = request.getParameter("t2");
    String query1 = "";
	PreparedStatement pstmt4=null;
	
	/*********Parameter got LDAP checking****************/
	
	/*String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";
	String MY_HOST = "ldap://10.15.0.84:389";
	String userContext = "cn="+login+",dc=hpcl,dc=co,dc=in";
	String username = new String(userContext);
	String password1 = new String("password");
	DirContext ctx = null;*/
	
	/********Code to check in database if the user has access to this system*********/
	

		query1 = "select * from empmaster where EMP_NO =?";
		ps=con.prepareStatement(query1);
		ps.setString(1,login);
		rs = ps.executeQuery();
		if(rs.next()) {
			dbfound=true;
			islogin=true;
			eno =rs.getString(1).trim();
		}
	

session.putValue("USRID",eno);

 if (islogin) { %>
<script>document.location.href = "home.jsp"</script>
<% } else {
	%>
	<script>
		alert("User not found");
		document.location.href = "http://my.hpcl.co.in/j2ee/portal/index_intra.jsp?source=myhpcl";
	</script>
	<%
}

%>

<%!
public static String decrypt(String empno) {
	String key = "2yZJFt"+new SimpleDateFormat("ddMMyy").format(new java.util.Date())+"INiIRdD2wQ==";
	//String APP_KEY = "i2SXsPVRc8LbMTY8vm8ooA=="; //dev
	String APP_KEY = "wy6WQfvKj1E4XGuKvwpeIw=="; //prod
	try {
		//empno  = java.net.URLDecoder.decode(empno ,"UTF-8");
		empno  = com.toml.dp.util.AES128Bit.decrypt(empno, APP_KEY);
		//String time_salt = request.getParameter("salt");
       // time_salt = com.toml.dp.util.AES128Bit.decrypt(time_salt, APP_KEY);
	} catch(Exception e) {
		empno = null;
	}
	return empno;
}
%>

</form>
</HTML>
</html>
