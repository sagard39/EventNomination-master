<%@ include file="connection.jsp"%>
<%@ include file = "connection_housing.jsp"%>

<%!
public String nullVal(String str){
	String valStr=str;
	if(str==null){
		valStr="";
	}else if((str.trim()).equals("null")){
		valStr="";
	}else if("".equals(str)){
		valStr="";
	}
	return valStr;
}
%>

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment;filename=Event Report Employee.xls");
PreparedStatement psRept=null;
ResultSet rsRept=null;
int srNo=0;
PreparedStatement psHousing = null;
ResultSet rsHousing = null;

boolean isHPNELocn = false;
String evt_id=nullVal(request.getParameter("evt_id"));
String locn=nullVal(request.getParameter("locn"));
String dept=nullVal(request.getParameter("dept"));
String qryAdd1="",qryAdd2="",qryAdd3="",finalQry="";
if(!"".equals(evt_id))
	qryAdd1=" and  n.evtnme='"+evt_id+"'";
if(!"".equals(locn))
	qryAdd2="  and e.town='"+locn+"'";
if(!"".equals(dept))
	qryAdd3=" and e.bu='"+dept+"'";
finalQry=qryAdd1+qryAdd2+qryAdd3;
List<String>  additionalList = new ArrayList <String>();
String query="select n.evtnme as \"Event ID\",na.evtnme as \"Event Name\",decode(boardpnt,'-1','Not Selected','2','Not Applicable',boardpnt) as \"Boarding Point\",n.emp_no as \"Employee No\",(select emp_name from empmaster where emp_no=n.emp_no) as  \"Employee Name\",e.emp_designation as \"Employee Designation\",n.TICKTSCNT as \"Tickets\",n.paymentcnt as \"Payable Amount\",to_char(enterdte,'dd-Mon-YYYY HH:MI:SS') as \"Enter Date\",e.town as \"Town\", e.budesc as \"BU Description\", (select STREAMDESC from STREAM where STREANCODE=e.stream) Stream,e.email as \"EMAIL ID\" , e.contact_no as \"Contact No.\" ,decode(n.flag,'A','Saved','S','Submitted',n.flag) status from nomination n left join nomination_admin na on n.evtnme=na.evt_id left join empmaster e on n.emp_no=e.emp_no where n.flag in('A','S') "+qryAdd1;
boolean isAdditional = false;
String query3  ="select lbl_name as Value from nomination_addition where evt_id = ? and level_type='E' order by id";
PreparedStatement ps3 = con.prepareStatement(query3);
ps3.setString(1,evt_id);
ResultSet rs3 = ps3.executeQuery();
while(rs3.next()){
	additionalList.add(rs3.getString("Value"));
	isAdditional = true;
}

String query2 = "select value from nomination_emp_add where id in(select id from nomination_addition where evt_id ='"+evt_id+"' and level_type='E') and emp_no = ? order by id";
PreparedStatement psadditionValue = con.prepareStatement(query2);
ResultSet rsAdditionalValue = null;
if("2018_156_event".equals(evt_id) || "2018_158_event".equals(evt_id)){
	isHPNELocn = true;
	String queryHousing = "select Flat_no from HOUSING_ALLOTED where complex_code ='MUM04' and emp_no =?";
	psHousing = conHousing1.prepareStatement(queryHousing);
}
psRept=con.prepareStatement(query);
rsRept=psRept.executeQuery();
ResultSetMetaData rsmd=rsRept.getMetaData();

int count=rsmd.getColumnCount();
out.println("<table style='border:1;border-collapse:collapse;' border='2'>");
	out.println("<tr>");
	out.println("<th>#</th>");
if(isHPNELocn){
	out.println("<th>Building / FLAT No.</th>");
}	
for(int i=1;i<=count;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
if(isAdditional){
	for(int s =0;s<additionalList.size();s++){
		out.println("<th>"+additionalList.get(s)+"</th>");
	}
}

	out.println("</tr>");
 while(rsRept.next()){
	 out.println("<tr>");
	 out.println("<td>");
	 out.println(++srNo);
	 out.println("</td>");
if(isHPNELocn){
	
	psHousing.setString(1,rsRept.getString("Employee No"));
	rsHousing = psHousing.executeQuery();
out.println("<td align=center>");	
	if(rsHousing.next()){
		out.println(rsHousing.getString("Flat_no"));
	}
out.println("</td>");	
}	 
for(int i=1;i<=count;i++){
		out.print("<td align=center>");
		if(rsRept.getString(i)==null || "".equals(rsRept.getString(i))) {
			out.println("-");
		}else{
			out.println(rsRept.getString(i));
		}
		out.println("</td>");
}
if(isAdditional){
	psadditionValue.setString(1,rsRept.getString("Employee No"));
	rsAdditionalValue = psadditionValue.executeQuery();
	while(rsAdditionalValue.next()){
		out.println("<td>"+rsAdditionalValue.getString("value")+"</td>");
	}	
}


out.println("</tr>");
 } 
 out.println("</table>");
%>