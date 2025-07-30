<%@ include file="connection.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

 <%@ page language="java" import="java.sql.*,java.text.*,java.util.*,java.math.*" %>
    <%@ page import="javax.naming.*, javax.rmi.* , javax.sql.DataSource " %>
    <%@ page import="java.io.*, java.lang.*, java.net.*" %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.util.Hashtable,javax.naming.ldap.*,javax.naming.directory.*,javax.naming.*,java.util.Calendar,java.sql.Date.*,java.text.SimpleDateFormat" %>
   <html>


<HTML>        

<form method="POST" action="" name="FrontPage_Form1">
<%
try
{
String dbfound="no";
String adsfound="no";
String operation = "";
String login = request.getParameter("t1");
String login1 =(String)session.getValue("login");
if(request.getParameter("t1")!=null)
 {
       	session.putValue("login",login);
 } 
String userId="", pwd = "",dpyr="";
ResultSet rs4 = null;
           
String query1 = "";
PreparedStatement pstmt4=null;
String eno = "",ename="",usertyp="",appl="",disabd="",strm="",zone="",sbu="",locfiltr="",grd="",bu="";

//Parameter got LDAP checking
String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";
String MY_HOST = "ldap://10.15.0.84:389";
String userContext = "cn="+login+",dc=hpcl,dc=co,dc=in";
String username = new String(userContext);
DirContext ctx = null;
     
	             
%>

<%
//Code to check in database if the user has access to this system
try{
query1 = "select emp_no,bu from empmaster where EMP_NO =? ";
pstmt4 = con.prepareStatement(query1);
pstmt4.setString(1,login);
rs4 = pstmt4.executeQuery();
while (rs4.next())
{
 dbfound="yes";
 eno =rs4.getString(1).trim();
 bu=rs4.getString(2);
}
if(!(bu.startsWith("47") || bu.startsWith("48") || ((("31919150".equals(eno)) || ("31924800".equals(eno)) || ("30074010".equals(eno)) || ("31960240".equals(eno)) || ("31905730".equals(eno)) || ("31960540".equals(eno)))) )){%>
	<script>
		alert("You are not Allowed for this Event");
		//window.location.href="index.jsp";
	</script>
<%}
}catch(Exception e1){
	dbfound="no";
}
%>

		   
<%

if(dbfound != null && dbfound.trim().length()>0 && dbfound.equalsIgnoreCase("yes")){
       try {
			Hashtable env = new Hashtable();
            env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);
            env.put(Context.PROVIDER_URL, MY_HOST);
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
	        env.put(Context.SECURITY_PRINCIPAL,"hpcl"+"\\"+login);
           ctx = new InitialDirContext(env);	
			ctx.close();
			adsfound="yes";
			session.putValue("USRID",eno);
			/*
			session.putValue("utype",usertyp);
			session.putValue("ename",ename);
			session.putValue("zone",zone);
			session.putValue("grade",grd);
			session.putValue("stream",strm);
			session.putValue("sbu",sbu);
			session.putValue("loc",locfiltr);
			session.putValue("zone",zone);
			*/
			 
            }
catch (javax.naming.AuthenticationException e2) {
adsfound="no";
}
catch(Exception e3){
	adsfound="no";
}
}

%>

<%
 if ((dbfound != null && dbfound.equalsIgnoreCase("yes")) && (adsfound != null && adsfound.equalsIgnoreCase("no"))) {
 %> <script language="Javascript">
	 alert("Please enter Proper Credentials.");
    document.location.href = "home.jsp"
</script>

<%}else if ((dbfound != null && dbfound.equalsIgnoreCase("no")) && (adsfound != null && adsfound.equalsIgnoreCase("no"))) {%>
 <script language="Javascript">
<line sniped>
    document.location.href = "home.jsp"
</script>

<%}else if ((dbfound != null && dbfound.equalsIgnoreCase("yes")) && (adsfound != null && adsfound.equalsIgnoreCase("yes"))) {

%>
 <script language="Javascript">
    document.location.href = "home.jsp"
</script>

<% }

}
catch(Exception e)
{
out.println(e);
}


%>

 </form>
</HTML>

 



 

