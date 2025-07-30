<%@ include file = "connection.jsp"%>


<%
String query = "",output = "";
PreparedStatement ps = null;
ResultSet rs = null;
String row = request.getParameter("rowNumber");
String evtid = request.getParameter("eventId");

if(row!=null){
	query = "select row_number,seat_number from nomination_venue1 where row_number = ? minus select row_number,cast(seat_number as int) from nomination_venue1_transaction where row_number = ? ";
	ps = con.prepareStatement (query);
	ps.setString(1,row);
	ps.setString(2,row);
	rs = ps.executeQuery();
	while(rs.next()){
		//output += "'status':'success','message':'<option value ="+rs.getString("seat_number")+">"+rs.getString("seat_number")+"</option>'" + ",";
	output += ",{'id':'"+rs.getString("seat_number")+"','option':'"+rs.getString("seat_number")+"'}";
	}
}
output = output.substring(1);
output = "["+output+"]";
output = output.replaceAll("'","\"");
out.println(output);
out.flush();
%>