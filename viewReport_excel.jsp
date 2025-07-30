<%@ include file="connection.jsp"%>
<%@ include file="connection_sap.jsp"%>
<%@include file="storepath.jsp"%>
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

<%!
    public String getDependentName(Connection conSap, String dependentId) throws SQLException {
        String value = "", r_value="";
        String query = "";
        //String sapSchema = "MANDT210"; // dev
         String sapSchema = "MANDT300"; // prod
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            query = "SELECT * FROM " + sapSchema + ".ZHRCV_DEPENDENT WHERE med_status = 'AC' AND dependent_id = ?";
            ps = conSap.prepareStatement(query);
            ps.setString(1, dependentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                value = rs.getString("first_name") + " " + rs.getString("last_name");
            }
        } catch (SQLException ex) {
            // Handle or log the exception
            ex.printStackTrace(); // Print stack trace for debugging
            throw ex; // Rethrow the exception to notify caller
        } finally {
            // Close resources in a finally block to ensure they're always closed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Handle or log the exception
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Handle or log the exception
                }
            }
        }
        if(value==null){value="";}
       
        if(value.equals("")){r_value = dependentId;}
        else{r_value = value;}

        return r_value;
    }
%>


<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment;filename=Event Report Applicants.xls");
PreparedStatement psRept=null,psAddition=null;
ResultSet rsRept=null;//38030200
String qrv=request.getParameter("q");
int srNo=0,maxNewCount=0;
boolean isAdditional=false;
String evt_id=nullVal(request.getParameter("evt_id"));
String locn=nullVal(request.getParameter("locn"));
String dept=nullVal(request.getParameter("dept"));
String query="Select Distinct N.Emp_No as \"Emp No\",Nd.child_name \"Person code\",(Select Emp_Name From Empmaster Where Emp_No=N.Emp_No) as \"Employee Name\" ,(Select Budesc From Empmaster Where Emp_No=N.Emp_No) Bu,(Select Emp_Designation From Empmaster Where Emp_No=N.Emp_No) Designation,Nvl(J.Person_Name,Nd.Child_Name) as \"Dependant Name\",Decode(Nd.Gender,'M','Male','F','Female',Nd.Gender) Gender,Nd.Age Age,Decode(Nd.Relatation,'SL','Self','SP','Spouse','CH','Child','MO','Mother','FA','Father',Relatation) Relation,N.Ticktscnt Tickets,N.Paymentcnt Amount,(select evtnme from nomination_admin where evt_id =N.Evtnme ) as \"Event Name\",decode(boardpnt,'-1','Not Selected','2','Not Applicable',boardpnt) as \"Boarding Point\",(Select Email From Empmaster Where Emp_No=N.Emp_No) Email,Nd.Contact_No as \"Contact No\", Enterdte as \"Enter Date\",decode(n.flag,'A','Saved','S','Submitted',n.flag) status From Nomination N Join Nomination_Dependents Nd On N.Emp_No=Nd.Emp_No And N.Evtnme=Nd.Event_Name Left Join "+tempJdep+"Jdep J On Nd.Child_Name=J.Person_Code Where N.Evtnme=? and n.flag in( 'A','S') order by Enterdte desc ";
//out.println(query);
psRept=con.prepareStatement(query);
psRept.setString(1,qrv);
rsRept=psRept.executeQuery();
ResultSetMetaData rsmd=rsRept.getMetaData();

String qry=" SELECT MAX(COUNT(EMP_NO)) maxEmp FROM NOMINATION_EMP_ADD WHERE ID IN(SELECT ID FROM NOMINATION_ADDITION WHERE EVT_ID =? and level_type='A') group by emp_no,id";
psAddition=con.prepareStatement(qry);
psAddition.setString(1,qrv);
ResultSet rsAddition=psAddition.executeQuery();
if(rsAddition.next())
	maxNewCount=rsAddition.getInt("maxEmp");
if(maxNewCount!=0)
	isAdditional=true;
int count=rsmd.getColumnCount();
out.println("<table style='border:1;border-collapse:collapse;' border='2'>");
	out.println("<tr>");
	out.println("<th>#</th>");
for(int i=1;i<=count;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
}
List<String> lbl_type = new ArrayList<String>();
qry="select lbl_name, lbl_type, id from nomination_addition where evt_id=? and level_type='A' order by id";
psAddition=con.prepareStatement(qry);
psAddition.setString(1,qrv);
rsAddition=psAddition.executeQuery();
while(rsAddition.next()){
	out.println("<th>"+rsAddition.getString("lbl_name")+"</th>");
	lbl_type.add(rsAddition.getString("lbl_type"));
}

	out.println("</tr>");
	
qry="SELECT value FROM NOMINATION_EMP_ADD WHERE ID IN (SELECT ID FROM NOMINATION_ADDITION WHERE EVT_ID=? and level_type='A') and person_code = ? order by ID";
psAddition=con.prepareStatement(qry);
psAddition.setString(1,qrv);
String url = request.getRequestURL().toString();
url = url.substring(0, url.lastIndexOf("/"));

 while(rsRept.next()){
	 out.println("<tr>");
	 out.println("<td>");
	 out.println(++srNo);
	 out.println("</td>");
int j=0;
for(int i=1;i<=count;i++){
		out.print("<td align=center>"); 
		if(rsRept.getString(i)==null || "".equals(rsRept.getString(i))) {
			out.println("-");
		}else if(i==6){
			out.println( getDependentName(con_sap,rsRept.getString(i)) );
		}
		else{
			out.println(rsRept.getString(i));
		}
		out.println("</td>");
}
if(isAdditional){

psAddition.setString(2,rsRept.getString("Person code"));
rsAddition=psAddition.executeQuery();
j=0;
while(rsAddition.next()){
	if(lbl_type.get(j++).equals("file")) {
		out.println("<td><a href='"+url+"/useruploads1/"+rsAddition.getString("value")+"'>"+rsAddition.getString("value")+"</a></td>");
	} else {
		out.println("<td>"+rsAddition.getString("value")+"</td>");
	}
}
}
out.println("</tr>");
 } 
 out.println("</table>");
%>