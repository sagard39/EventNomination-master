<%@ page import="javax.activation.DataHandler, javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>
<%@ include file = "header1.jsp"%>
<%@ include file = "storepath.jsp"%>

<script type="text/javascript">
function checkSubmit(ele, id) {
    x = document.getElementById(id);
    if (ele.checked == true) x.disabled = false;
    else x.disabled = true;
}
function getSubmit(){
	
	if(!confirm("Do you really want to submit?"))
		return false;
	else {
		document.form1.actionName.value = "goSubmit";
		document.form1.submit();
	}	
}
</script>
<%
String query ="",emp_name = "",action_btn ="",empCount = "",nominations = "";
Statement stmt1 = null;
ResultSet rs1 = null;
int cnt = 0;

action_btn = request.getParameter("actionName");
stmt1 = con.createStatement();
PreparedStatement ps12 = con.prepareStatement("select sum(ticktscnt) countTickets,count(distinct emp_no) empCount,'Submitted' as flag from nomination where evtnme = '2018_126_event' and flag <>'X' GROUP BY 'Submitted'");
ResultSet rsStmt2 = ps12.executeQuery();
ResultSet rsStmt = stmt1.executeQuery("select a.emp_no emp_no,trim(b.emp_name) emp_name,ticktscnt,to_char(modifyDte,'dd-Mon-YYYY HH:MI:SS') update_date,decode(a.flag,'A','Saved','S','Submitted',a.flag) status from nomination a left join empmas b on a.emp_no =b.emp_no where evtnme ='2018_126_event'  and flag <> 'X' order by modifyDte desc");

%>
<form name = "form1" action = "" method = "post">
<input type = "hidden" name = "actionName" value = "" >
<div class = "container">
<div class = "card mb-10 box shadow">
<div class = "card-header alert-primary"><h4>Event : Hum Fit toh HP Fit</h4></div>
<div class = "card-body">
	<%if(rsStmt2.next()){
		nominations = rsStmt2.getString("countTickets");
		empCount = rsStmt2.getString("empCount");
		%>
	<div class = "form-group"><div class = "w-100 row " style = "align-items: center;">
	
		<center><font color='red' size='5'>Total <font size='5' color='blue'> <%=nominations%> </font>  Nominations recieved by <%=empCount%>  Employees for the Event <font face ="bold"><font color = "#2975B5">#</font><font color = "#C60000">Hum</font><font  color = "#2975B5">Fit</font><font color ="#C60000">Toh</font><font color = "#2975B5">HP</font><font color = "#C60000">Fit </font></font></font><br/></center>
	</div><br/>
	<div class = "row"><span><input type = "checkbox" disabled checked class = "form-inline-check" id = "check" name = "chkDeclare" onclick="checkSubmit(this, 'del_event')"> &nbsp;&nbsp;&nbsp;I , as an Independent Event Auditor of <font face ="bold"><font color = "#2975B5">#</font><font color = "#C60000">Hum</font><font  color = "#2975B5">Fit</font><font color ="#C60000">Toh</font><font color = "#2975B5">HP</font><font color = "#C60000">Fit </font></font>Challenge 2018, hereby certify that the nomination process which constitutes the closing of Phase I for the <font face ="bold"><font color = "#2975B5">#</font><font color = "#C60000">Hum</font><font  color = "#2975B5">Fit</font><font color ="#C60000">Toh</font><font color = "#2975B5">HP</font><font color = "#C60000">Fit </font></font> has been fair and unbiased.</span>
	</div><br/>
	<div class = "row" style = "margin-left:45%" >
		<div ><!--<button class = "btn btn-md btn-danger" name = "submitAct" id = "del_event" onclick = "return getSubmit();" type = "submit" disabled="disabled">Confirm</button>--></div>&nbsp;&nbsp;
	</div>
	<div class = "row" style = "padding-left:1%;"><a href = "viewReport_excel.jsp?q=2018_126_event">Download Excel Report</a></div>
	</div><br/>
	<%}%>
	<div class = "table-responsive">
		<table class = "table table-bordered table-hover">
			<thead>
				<tr class = "alert-primary">
					<th>#</th>
					<th>Employee</th>
					<th>Participant count</th>
					<th>Enter Date</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
			<%while(rsStmt.next()){cnt++;%>
				<tr>
					<td><%=cnt%></td>
					<td><%=rsStmt.getString("emp_name")%>(<%=rsStmt.getString("emp_no")%>)</td>
					<td><%=rsStmt.getString("ticktscnt")%></td>
					<td><%=rsStmt.getString("update_date")%></td>
					<td><%=rsStmt.getString("status")%></td>
				</tr>
			<%}%>	
			</tbody>
		</table>		
	</div>
</div>
<%
if("goSubmit".equals(action_btn)){
	
	String pageTemp = "",mailBody = "",upload_file = "HumFitTohHPFit.xls";
	javax.activation.DataSource source = null;	
	   try {
			 mailBody = "I , as an Independent Event Auditor of #Hum Fit Toh HP Fit Challenge 2018, hereby certify that the nomination process which constitutes the closing of Phase I for the #HUM FIT TOH HP FIT has been fair and unbiased.<br><br> Total "+nominations+" Nominations recieved by "+empCount+" Employees for the Event #Hum Fit Toh HP Fit.";
			//String email_str = email.gen_email_call("APP208","D", " ",message,"satya@hpcl.in","ksshetty@hpcl.in","mohammadfaizan@hpcl.in","Hum Fit Toh HP Fit",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
			
				//String toMail = "satya@hpcl.in"; //"arun.panda@hpcl.in";
				//String ccMail = "ksshetty@hpcl.in"; //"sunny.yadav@hpcl.in";
				//String bccMail = "mohammadfaizan@hpcl.in"; //"mohan.lal@hpcl.in";
/* 				Properties props = new Properties();
				props.put("mail.smtp.host", "smtp.hpcl.co.in");
				props.put("mail.transport.protocol","smtp");
				Session msession = Session.getInstance(props, null);
				msession.setDebug(false);
				Message message = new MimeMessage(msession);
				message.setFrom(new InternetAddress("EmployeeConnect@hpcl.in"));
				message.addRecipients(Message.RecipientType.TO, InternetAddress.parse(toMail));
				message.addRecipients(Message.RecipientType.CC, InternetAddress.parse(ccMail));
				message.addRecipients(Message.RecipientType.BCC, InternetAddress.parse(bccMail));
				message.setSubject("Hum Fit Toh HP Fit");
				BodyPart messageBodyPart = new MimeBodyPart();
				messageBodyPart.setContent(mailBody, "text/html");
				Multipart multipart = new MimeMultipart();
				multipart.addBodyPart(messageBodyPart);
				String filename = storepath+"\\Test.xls";
				source = new FileDataSource(filename);
				messageBodyPart = new MimeBodyPart();
				messageBodyPart.setDataHandler(new DataHandler(source));
				messageBodyPart.setFileName(upload_file);
				multipart.addBodyPart(messageBodyPart);				
				message.setContent(multipart);
				Transport.send(message); */
			
			
			
			
			//String email_str = email.gen_email_call("APP208","D", " ",message,"saurabhtripathi395@gmail.com","saurabhtripathi395@gmail.com","sunny.yadav@hpcl.in","Hum Fit Toh HP Fit",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
		} catch (Exception e) {} 
		finally {
			pageTemp = "home.jsp";%>
			<script>
				alert("Declared Successfully");
				location.href = "<%=pageTemp%>"
			</script>
			//response.sendRedirect(pageTemp);
		<%}

	}%>
</div>	
</div>
</form>