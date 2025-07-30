<%@include file="header1.jsp"%>
<%@include file="sap_api.jsp"%>

<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

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

<div class="container" style="min-height: 480px">
	<%

 HashMap<String,String> map=new HashMap<String,String>();

	String query = "", query1="", query_insert="", query_fetch="";
	PreparedStatement ps=null, ps1=null, ps_insert=null;
	rs = null;
	ResultSet rs1=null;

	String evt_id = "";
	evt_id = nullVal(request.getParameter("evtnme"));

	out.println(evt_id);

	String Event_Name="", evt_date=""; 
	query_fetch = "select evt_id, evtnme, to_char(to_date(evt_date,'DD-MON-YY'),'YYYYMMDD') AS evt_date from nomination_admin where evt_id=? ";
	ps = con.prepareStatement(query_fetch);
	ps.setString(1,evt_id);
	rs = ps.executeQuery();
	if(rs.next()){
		Event_Name = nullVal(rs.getString("evtnme"));
		evt_date = nullVal(rs.getString("evt_date"));
	}

	

	Boolean sent = false;
	String temp_emp_no="";

	String para1 = "{\"Request\":";
	String para_final = "", para="";
	String para_end = "}";

	query1 = "select * from nomination_sap where event_id=? and status='S' and emp_no=? ";
	ps1 = con.prepareStatement(query1);

	query = "select * from nomination where evtnme=? and flag <>'X' ";
	ps = con.prepareStatement(query);
	ps.setString(1,evt_id);
	rs = ps.executeQuery();

	while(rs.next()){
		temp_emp_no = "";
		temp_emp_no = nullVal(rs.getString("emp_no"));

		////to check if employee data already sent
		ps1.setString(1,evt_id);
		ps1.setString(2,temp_emp_no);
		rs1 = ps1.executeQuery();
		if(rs1.next()){

		}else{ /////if data is not sent to sap
			out.println(temp_emp_no+",");
			map.put(temp_emp_no, rs.getString("PAYMENTCNT"));
			para += "{\"Personnel_Number\": \""+rs.getString("emp_no")+"\",\"Wage_Type\": \"2245\",\"Amount\": \""+rs.getString("PAYMENTCNT")+"\",\"Start_Date\": \""+evt_date+"\",\"Assignment_Number\": \""+evt_id+"\",\"Event_Name\": \""+Event_Name+"\"},";
		}

	}

String finaljson="";
StringBuffer sb= new StringBuffer(para);  
if(para.length()>0)
{sb.deleteCharAt(sb.length()-1);  }
			
finaljson = "["+sb+"]";
	     

para_final = para1+finaljson+para_end;

String str = sendData(para_final);
//out.println(str);

JSONObject obj = new JSONObject(str);
JSONArray arr = obj.getJSONArray("Response");

///out.println("========================"+arr);

String status ="";
String message = "", Personnel_Number="",amnt="";

int cnt=0;

	query_insert = "insert into nomination_sap(event_id, emp_no, amount, sent_by, sent_on, status, message) values (?,?,?,?,sysdate,?,?) ";
	ps_insert = con.prepareStatement(query_insert);

for (int i = 0; i < arr.length(); i++) {
    status = arr.getJSONObject(i).getString("Status");
    message = arr.getJSONObject(i).getString("Message");
    Personnel_Number = arr.getJSONObject(i).getString("Personnel_Number");
    amnt = map.get(Personnel_Number);
    
    ps_insert.setString(1,evt_id);
    ps_insert.setString(2,Personnel_Number);
    ps_insert.setString(3,amnt);
    ps_insert.setString(4,emp);
    ps_insert.setString(5,status);
    ps_insert.setString(6,message);

    cnt = ps_insert.executeUpdate();
}

out.println("cnt="+cnt);

if(cnt>0){%>
	<script>
		alert("Data sent to SAP");
		window.location.href = "viewReports1.jsp?evtName=<%=evt_id%>&action_type=submitVal&submitRept=Submit";
	</script>
<%}

	try{
	if(ps!=null){ps.close();}
	if(rs!=null){rs.close();}
	if(ps1!=null){ps1.close();}
	if(rs1!=null){rs1.close();}
	if(con!=null){con.close();}
}catch(Exception ex){}

	%>
</div>

</body>

<%@include file="footer.jsp"%>

</html>