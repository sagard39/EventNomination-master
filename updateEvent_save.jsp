<%@ include file="connection.jsp"%>
<%
String output="";
String id=request.getParameter("id_n");
String evtnme=request.getParameter("evtnme");
String cutofdte=request.getParameter("cutofdte");
String evtdte=request.getParameter("evtdte");
String priceevt=request.getParameter("priceevt");
String nooftickts=request.getParameter("nooftickts");
String maxtickemp=request.getParameter("maxtickemp");
String admin=request.getParameter("admin");
String evt_for=request.getParameter("evt_for");
String evt_cat=request.getParameter("evt_cat");
//String adminEmp2=request.getParameter("adminEmp1");

String query="update nomination_admin set evtnme=?,cutofdte=to_date(?,'dd-Mon-yyyy'),evt_date=to_date(?,'dd-Mon-yyyy'),maxtick=?,maxprice=?,noofmaxtick=?,indiv_tick=?,adminEmp=?,evt_for=?,evt_cat=? where evt_id=?";
PreparedStatement psUpdt=con.prepareStatement(query);
psUpdt.setString(1,evtnme);
psUpdt.setString(2,cutofdte);
psUpdt.setString(3,evtdte);
psUpdt.setString(4,nooftickts);
psUpdt.setString(5,priceevt);
psUpdt.setString(6,maxtickemp);
psUpdt.setString(7,maxtickemp);
psUpdt.setString(8,admin);
psUpdt.setString(9,evt_for);
psUpdt.setString(10,evt_cat);
psUpdt.setString(11,id);
int cnt=psUpdt.executeUpdate();
if(cnt>0)
	output = "'status':'success'";
else
	output = "'status':'error','message':'Session expired. Please login again.'";

output = "{"+output+"}";
output = output.replaceAll("'","\"");
out.println(output);
out.flush();

if(psUpdt != null)
	psUpdt.close();
if(con != null)
	con.close();
%>