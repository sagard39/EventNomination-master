<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 

<script>
function goSubmitBtn(){
	alert("aaaa");
	document.form1.action_type.value="submitMail";
	document.form1.submit();
}
</script>
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
<div class = "page">
	<form name = "form1" method = "Post" action = "">
	<%String emailStr = "",toMail = "",ccMail = "",bccMail = "",subjectMail = "",bodyMail = "";
	String action = request.getParameter("action_type");
	toMail =nullVal(request.getParameter("toMail"));	
	ccMail =nullVal(request.getParameter("ccMail"));	
	bccMail =nullVal(request.getParameter("bccMail"));	
	subjectMail =nullVal(request.getParameter("mailSubject"));	
	bodyMail =nullVal(request.getParameter("mailBody"));	
	if("submitMail".equals(action)){
		emailStr = email.gen_email_call("APP208","D", " ",bodyMail,toMail,ccMail,bccMail,subjectMail,request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());
		out.println("aa"+emailStr);
	}
	%>
	<input type = "hidden" name = "action_type" value = "">
		<div >
			<table border= "0">
				<tr>
					<td>To </td>
					<td><textarea name = "toMail" id = "toMail" cols= "99" rows = "1"></textarea></td>
				</tr>
				<tr>
					<td>CC</td>
					<td><textarea name = "ccMail" id = "ccMail" cols= "99" rows = "1"></textarea></td>
				</tr>
				<tr>
					<td>BCC</td>
					<td><textarea name = "bccMail" id = "bccMail" cols= "99" rows = "1"></textarea></td>
				</tr>
				<tr>
					<td>Subject</td>
					<td><textarea name = "mailSubject" cols= "99" rows = "2"></textarea></td>
				</tr>
				<tr>
					<td>Body</td>
					<td><textarea name = "mailBody" cols= "99" rows = "5"></textarea></td>
				</tr>
				<tr>
					<td colspan = "2">
						<center><input type = "submit" name = "goSubmit" value = "Send Mail" onclick = "return goSubmitBtn();"></center>
					</td>
				</tr>
			</table>
		
		</div>
	</form>
</div>