<%@ include file="header.jsp"%>

<%
String query="",queryAdmin="";
PreparedStatement ps=null;
ResultSet rs=null;
String attr=request.getParameter("rep");
List<String> evtList=new ArrayList<String>();
List<String> evtPlcList=new ArrayList<String>();
boolean isAdmin=false;
String adminEmp=(String)session.getAttribute("login");
queryAdmin="select distinct evtnme,evtPlace from nomination_admin where adminEmp=?";
ps=con.prepareStatement(queryAdmin);
ps.setString(1,adminEmp);
rs=ps.executeQuery();
while(rs.next()){
	isAdmin=true;
	evtList.add(rs.getString("evtnme"));
	evtPlcList.add(rs.getString("evtPlace"));
}
if(isAdmin){
	query="";
}
%>
