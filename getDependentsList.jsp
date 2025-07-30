<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" />
<%@ include file="connection.jsp"%>

<%

String empno=request.getParameter("eno");
PreparedStatement ps=null;
ResultSet rs=null;
String person_code="",person_name="",emprow="",output="";
int count=0;
ps=con.prepareStatement("Select person_code,person_name,TRUNC((sysdate-(PERSON_DOB))/365) AGE from portal.jdep where emp_no=? and person_status_code='AC' and TRUNC((sysdate-(PERSON_DOB))/365)> 15");
// use portal.jdep for live
ps.setString(1,empno);

rs=ps.executeQuery();

while(rs.next()){
	count++;
	person_code=rs.getString("person_code");
	person_name=rs.getString("person_name");
	
	emprow=emprow+"<div> <input type='hidden' id='person_code"+count+"' value='"+person_code+"'><input type='checkbox' name='empDetails' id='chk"+count+"' value='"+person_code+"_"+person_name+"' onclick='addList("+count+");' >"+count+"."+person_name+".</div>";
	
	output=emprow;
}


//output = output.replaceAll("'","\"");
out.println(output);
out.flush();

if(con!=null) {
	con.close();
}

%>