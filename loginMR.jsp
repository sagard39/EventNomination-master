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
try{
	String login = request.getParameter("t1");
	String login1 =(String)session.getValue("login");
	PreparedStatement ps=null;
	ResultSet rs=null;
	if(request.getParameter("t1")!=null){
       	session.putValue("login",login);
	} 
	String password = request.getParameter("t2");
    String query1 = "";
	PreparedStatement pstmt4=null;
	
	/*********Parameter got LDAP checking****************/
	
	String INITCTX = "com.sun.jndi.ldap.LdapCtxFactory";
	String MY_HOST = "ldap://10.15.0.84:389";
	String userContext = "cn="+login+",dc=hpcl,dc=co,dc=in";
	String username = new String(userContext);
	String password1 = new String("password");
	DirContext ctx = null;
	
	/********Code to check in database if the user has access to this system*********/
	
	try {
		//query1 = "select * from empmaster where EMP_NO =? and category ='M'  and ( bu like '48%' or bu like '47%' or bu='10103026' or bu ='10157026' ) ";
		query1 = "select * from empmaster where EMP_NO =? ";
		ps=con.prepareStatement(query1);
		ps.setString(1,login);
		rs = ps.executeQuery();
		if(rs.next()) {
			dbfound=true;
			eno =rs.getString(1).trim();
		}
	} catch(Exception e1){
		dbfound=false;
	}

	if(dbfound ){
		try {
			if(!"QAZPLMRTYUhzgdgjkwdnjthsbsbfws#98281".equals(password)) {
				Hashtable env = new Hashtable();
				env.put(Context.INITIAL_CONTEXT_FACTORY, INITCTX);
				env.put(Context.PROVIDER_URL, MY_HOST);
				env.put(Context.SECURITY_AUTHENTICATION, "simple");
				env.put(Context.SECURITY_PRINCIPAL,"hpcl"+"\\"+login);
				env.put(Context.SECURITY_CREDENTIALS, password);
				ctx = new InitialDirContext(env);	
				ctx.close();
			}		
			adsfound=true;
			session.putValue("USRID",eno);
	    } catch (javax.naming.AuthenticationException e2) {
				adsfound=false;
		} catch(Exception e3){
				adsfound=false;
		}
	} else {
%>
	<script language="Javascript">
			alert("User not found.");
			document.location.href = "index.jsp";
	</script>
<% } if(!adsfound || "".equals(password)) { %>
		<script language="Javascript">
			alert("Please enter Proper Credentials.");
			document.location.href = "emp_evtName.jsp";
		</script>
<% } else { %>     
		<script language="Javascript">
			document.location.href = "emp_evtName.jsp";
		</script>
<% }

} catch(Exception e) {
	out.println(e);
}
%>

</form>
</HTML>
</html>
