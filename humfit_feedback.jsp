<%@ include file = "connection.jsp"%>
<%@ include file = "storepath.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Employee Connect</title>
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">
</head>
<body>

<div class = "container-fluid">
	<div class = "card md-10 box shadow">
		<div class = "card-header alert alert-primary"><h4>Some Feedback on #Hum Fit Toh HP Fit Challenge 2018</div>
		<div class = "card-body">
			<div class = "table-responsive">
				<table class = "table table-bordered table-stripped">
					<thead>
						<tr class = "alert-danger">
							<th width = "5%">#</th>
							<th width = "30%">Employee Details</th>
							<!--<th>Grade</th>
							<th>Designation</th>
							<th>BU</th>
							<th>Feedback for</th>-->							
							<th width = "65%" align = "center">Feedback</th>
						</tr>
					</thead>
					<tbody>
<%
String query1 = "select distinct a.emp_no, a.person_code prCode,nvl(c.person_name,a.person_code) emp_name,case substr(a.person_code,8,8) when '0' then b.emp_designation else '-' end Designation,case substr(a.person_code,8,8) when '0' then b.grade else '-' end Grade,case substr(a.person_code,8,8) when '0' then b.budesc else '-' end budesc,case substr(a.person_code,8,8) when '0' then 'Self' else 'Spouse ('||(trim(b.emp_name))||')' end Relation from nomination_fit_feedback a left join  empmaster b on substr(a.emp_no,0,7) = substr(b.emp_no,0,7) left join "+tempJdep+"jdep c on a.person_code = c.person_code where publish = 'Y' order by a.person_code";
int cnt = 0;
String query2 = "select emp_no,person_code,ANS7 FROM nomination_fit_feedback WHERE PERSON_CODE =? ";
PreparedStatement psDetails = con.prepareStatement(query2);
ResultSet rsDetails = null;
PreparedStatement psEvtEmp = con.prepareStatement(query1);
ResultSet rsEvtEmp  = psEvtEmp.executeQuery();
while(rsEvtEmp.next()){cnt++;%>
					<tr >
						<td><%=cnt%></td>
						<td><%=rsEvtEmp.getString("emp_name")%>(<%=rsEvtEmp.getString("emp_no")%>)<br>
						<%if((rsEvtEmp.getString("Relation")).contains("Self")){%>
							<%=rsEvtEmp.getString("grade")%> - <%=rsEvtEmp.getString("Designation")%> @ <%=rsEvtEmp.getString("budesc")%>
						<%}else {%>
							 <%=rsEvtEmp.getString("Relation")%>
						<%}%>	
						</td>
						<!--<td><%=rsEvtEmp.getString("grade")%></td>
						<td><%=rsEvtEmp.getString("Designation")%></td>
						<td><%=rsEvtEmp.getString("budesc")%></td>
						<td><%=rsEvtEmp.getString("Relation")%></td>-->
						<td>						<%
						psDetails.setString(1,rsEvtEmp.getString("prCode"));
						rsDetails = psDetails.executeQuery();
						if(rsDetails.next()){%>
							<font><%=rsDetails.getString("ans7")%></font>
						<%}%>
						</td>
					<!--</tr>
					<tr id = "collapse<%=cnt%>" class='collapse' aria-labelledby="heading<%=cnt%>">
					<td colspan = "6">
						<%
						psDetails.setString(1,rsEvtEmp.getString("prCode"));
						rsDetails = psDetails.executeQuery();
						if(rsDetails.next()){%>
							<textarea readonly class = "form-control" cols = "99"><%=rsDetails.getString("ans7")%></textarea>
						<%}%>
					</td>
					</tr>-->
<%}
if(rsDetails != null)
	rsDetails.close();
if(rsEvtEmp!=null)
	rsEvtEmp.close();
if(psDetails!=null)
	psDetails.close();
if(psEvtEmp!=null)
	psEvtEmp.close();
if(con!=null)
	con.close();
%>					
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>