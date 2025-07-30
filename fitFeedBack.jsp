<%@ include file = "header1.jsp"%>
<%@ include file = "storepath.jsp"%>
<style>
.QName{
	color:#2980B9;
}
.qType{
	font-size:20px;
	font-family:bold;
	color:#D35400;
}
label{
	font-family:Times new roman;
}
</style>
<script>
function goSubmit(){
	if(validateFb()){
		document.form1.action_type.value="submit12";
		document.form1.submit();
	}else{
		return false;
	}	
}

function validateFb(){
	/*var isEntry=$("#entryEmp").val();
	if(isEntry!=''){
		alert("You have already submitted the Feedback Form");
		return false;
	}*/
	/*if($('[type=radio]:checked').length==0){
		alert("Please fill the form before Sumbit");
		return false;
	}*/

	if($("#feedPerson").val()=='-1'){
		alert("Please Choose the person for whom you want to give the feedback");
		return false;
	}
	if($("#q7").val() == ""){
		alert("Please provide the feedback");
		return false;
	}	
	if(!confirm("Do You really want to submit your Feedback?")){
		return false;
	}

	return true;
}

function sfresh(){
	document.form1.submit();
}
function goUpdate(){
	document.form1.action_type.value="update12";
	document.form1.submit();
}
</script>
<div class = "container">
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

String empno = (String)session.getAttribute("login");
boolean isAdminFeed = false;
String ans1 = "",ans2 = "" ,ans3 = "",ans4 = "",ans5 = "",ans6 = "",ans4Text = "",ans5Text = "",ans6Text = "",ans7Text = "",tempPerson = "",forEmp  = "";
String tempSelected = nullVal(request.getParameter("feedPerson"));
String action_type = nullVal(request.getParameter("action_type"));
String adminFeedback = nullVal(request.getParameter("isAdminFeed"));
if(!"".equals(tempSelected)){
	tempPerson = tempSelected;
}else {
	tempPerson = empno;
}
Map<String,String> fitMap = new LinkedHashMap <String,String>();
String queryFit = "select distinct a.child_name ch_name,nvl(b.person_name,a.child_name) pr_name from nomination_dependents a left join "+tempJdep+"jdep b on a.child_name = b.person_code where a.emp_no =? and event_name = '2018_126_event' order by child_name";
PreparedStatement psFit = con.prepareStatement(queryFit);
psFit.setString(1,empno);
ResultSet rsFit = psFit.executeQuery();
while(rsFit.next()){
	fitMap.put(rsFit.getString("ch_name"),rsFit.getString("pr_name"));
}
boolean isExist = false;
if("Y".equals(adminFeedback)){
	String queryAdmin = "select distinct a.child_name ch_name,nvl(b.person_name,a.child_name) pr_name,b.relation_code,trim(c.emp_name) emp_name,c.emp_no from nomination_dependents a left join "+tempJdep+"jdep b on a.child_name = b.person_code left join empmaster c on a.emp_no =c.emp_no where a.child_name =?";
	PreparedStatement psAdminTemp = con.prepareStatement(queryAdmin);
	psAdminTemp.setString(1,tempSelected);
	ResultSet rsAdminTemp = psAdminTemp.executeQuery();
	if(rsAdminTemp.next()){
		if(!"SL".equals(rsAdminTemp.getString("relation_code")))
			forEmp = rsAdminTemp.getString("pr_name")+ "(Spouse of <b>"+rsAdminTemp.getString("emp_name") +"-"+rsAdminTemp.getString("emp_no")+"</b>)";
		else 
			forEmp = rsAdminTemp.getString(("pr_name"))+" (Self <b>"+rsAdminTemp.getString("emp_no")+"</b>)";
	}
	
}
String query1 = "select ANS1,ANS2,ANS3,ANS4,ANS4_TEXT,ANS5,ANS5_TEXT,ANS6,ANS7,ANS6_TEXT from nomination_fit_feedback where person_code= ?";
PreparedStatement psFeed = con.prepareStatement(query1);
psFeed.setString(1,tempSelected);
ResultSet rsFeed = psFeed.executeQuery();
if(rsFeed.next()){
	isExist = true;
	/*ans1 = nullVal(rsFeed.getString("ANS1"));
	ans2 = nullVal(rsFeed.getString("ANS2"));
	ans3 = nullVal(rsFeed.getString("ANS3"));
	ans4 = nullVal(rsFeed.getString("ANS4"));
	ans5 = nullVal(rsFeed.getString("ANS5"));
	ans6 = nullVal(rsFeed.getString("ANS6"));
	ans4Text = nullVal(rsFeed.getString("ANS4_Text"));
	ans5Text = nullVal(rsFeed.getString("ANS5_TEXT"));
	ans6Text = nullVal(rsFeed.getString("ANS6_TEXT"));*/
	ans7Text = nullVal(rsFeed.getString("ANS7"));
}
int cnt = 0;
String query = "insert into nomination_fit_feedback (EMP_NO,PERSON_CODE,ANS7,UPDATE_BY,UPDATE_DATE) values (?,?,?,?,sysdate)";
PreparedStatement ps = con.prepareStatement(query);
if("submit12".equals(action_type)){
	/*String[] ans2Temp = request.getParameterValues("q2");
	String ans2Val = "",ans4Val = "",ans6Val=  "";
	if(ans2!=null){
		for(int i=0;i<ans2Temp.length;i++){
			ans2Val += ","+ans2Temp[i];
		}
		ans2Val = ans2Val.substring(1);
	} 
	String[] ans4Temp = request.getParameterValues("q4");
	if(ans4Temp!=null){
		for(int i=0;i<ans4Temp.length;i++){
			ans4Val += ","+ans4Temp[i];
		}
		ans4Val = ans4Val.substring(1);
	}
	String[] ans6Temp = request.getParameterValues("q6");
	if(ans6!=null){
		for(int i=0;i<ans6Temp.length;i++){
			ans6Val += ","+ans6Temp[i];
		}
		ans6Val = ans6Val.substring(1);
	}*/
	ps.setString(1,empno);
	ps.setString(2,tempSelected);
	ps.setString(3,request.getParameter("q7"));	
	ps.setString(4,empno);
	try{	
		cnt = ps.executeUpdate();
	}catch(Exception e){%>
			<script>
				alert("You have already submitted feedback for the Same Person");
				location.href = "fitFeedBack.jsp";
			</script>
	<%}
}
if("update12".equals(action_type)){
	query = "update nomination_fit_feedback set PUBLISH = 'Y' where person_code = ?";
	ps = con.prepareStatement(query);
	ps.setString(1,tempSelected);
	cnt = ps.executeUpdate();
}
if(cnt>0){%>
	<script>
		alert("Data submitted successfully");
		location.href = "mynomination1.jsp";
	</script>
	
<%}
%>

	<form name = "form1" action = "" method = "POST">
	<input type = "hidden" name = "action_type" id = "" value = "">
		<div class = "card">
			<div class = "card-header alert alert-primary style-hp-navyBlue"> <h4>Feedback for Hum Fit Toh HP FIT </h4><a style = "float:right;" href = "othersFeedbackFit.jsp" target="_blank">Click here to view Feedbacks submitted</a></div>
			<div class = "card-body">
				<div class= "alert alert-success">Thank you for participating in #HumFitTohHPFit Challenge 2018. Request you to kindly spare 2mins of your time to fill in your valuable feedback to help us to improve the future events. </div>
				<div class = "row form-check">
					<div class = "col-md-6"><label class = "QName" for = "perName">FEEDBACK GIVEN ON BEHALF OF :</label></div>
				</div>
				<%if(!"Y".equals(adminFeedback)){%>
					<select name = "feedPerson" class = "form-control col-md-6" id = "feedPerson" onchange = "return sfresh();" <%="Y".equals(adminFeedback)?"readonly":""%>>
					<option value = "-1">Select</option>
					<%
					for(Map.Entry<String,String> entry:fitMap.entrySet()){%>
					<option value =  "<%=entry.getKey()%>" <%=tempSelected.equals(entry.getKey())?"selected":""%>><%=entry.getValue()%></option>
					<%}%>
					</select>
				<%}else {%>
					<span><%=forEmp%></span>
				<%}%>
					<hr>
				<!--<div class = "row form-check">
					<label class = "qType" for = "q1" ><span class = "QName">1.</span>	Are you happy with this event?</label>
				</div>	
				<div class = "row form-check">
						<input style = "margin-left:20px" type = "radio" name = "q1" id = "q1_1" <%="1".equals(ans1)?"checked":""%>  value = "1"> <label for = "q1_1"> Yes</label>
						<input style = "margin-left:20px" type = "radio" name = "q1" id = "q1_2" <%="2".equals(ans1)?"checked":""%>  value = "2"> <label for = "q1_2"> No</label>
						<input style = "margin-left:20px" type = "radio" name = "q1" id = "q1_3" <%="3".equals(ans1)?"checked":""%>  value = "3"> <label for = "q1_3">  Maybe</label>
				</div>	
				<div class = "row form-check">
					<label class = "qType" for = "q2" ><span class = "QName">2.</span>	What was your main motivation to take part in this challenge?</label>
				</div>	
				<div class = "row form-check">
						<input style = "margin-left:20px"  type = "checkbox" name = "q2" <%=ans2.contains("1")?"checked":""%>  id = "q2_1"  value = "1"> <label for = "q2_1">Feel better</label>
						<input style = "margin-left:20px"  type = "checkbox" name = "q2" <%=ans2.contains("2")?"checked":""%>  id = "q2_2"  value = "2"> <label for = "q2_2">Get healthier</label>
						<input style = "margin-left:20px"  type = "checkbox" name = "q2" <%=ans2.contains("3")?"checked":""%>  id = "q2_3"  value = "3"> <label for = "q2_3">Lose weight</label>
						<input style = "margin-left:20px"  type = "checkbox" name = "q2" <%=ans2.contains("4")?"checked":""%>  id = "q2_4"  value = "4"> <label for = "q2_4">Sleep better</label>
						<input style = "margin-left:20px"  type = "checkbox" name = "q2" <%=ans2.contains("5")?"checked":""%>  id = "q2_5"  value = "5"> <label for = "q2_5">Break a bad habit</label>
				</div>	
				<div class = "row form-check">
					<label class = "qType" for = "q3" ><span class = "QName">3.</span>	Have you achieved the event goal of 150,000 steps in 30 days?</label>
				</div>	
				<div class = "row form-check">
						<input style = "margin-left:20px"  type = "radio" name = "q3" id = "q3_1" <%="1".equals(ans3)?"checked":""%>   value = "1"> <label for = "q3_1">Yes</label>
						<input style = "margin-left:20px"  type = "radio" name = "q3" id = "q3_2" <%="2".equals(ans3)?"checked":""%>  value = "2"> <label for = "q3_2">No</label>
				</div>	
				<div class = "row form-check">
					<label class = "qType" for = "q4" ><span class = "QName">4.</span>	What all activities you performed to reach the goal? </label>
				</div>	
				<div class = "row form-check">
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_1" <%=ans4.contains("1")?"checked":""%>  value = "1"> <label for = "q4_1">Walk</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_2" <%=ans4.contains("2")?"checked":""%>  value = "2"> <label for = "q4_2">Jog</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_3" <%=ans4.contains("3")?"checked":""%>  value = "3"> <label for = "q4_3">Cycling</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_4" <%=ans4.contains("4")?"checked":""%>  value = "4"> <label for = "q4_4">Treadmill</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_5" <%=ans4.contains("5")?"checked":""%>  value = "5"> <label for = "q4_5">Aerobics</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q4" id = "q4_6" <%=ans4.contains("6")?"checked":""%> value = "6" onclick = "goQuestion('Q4');"> <label for = "q4_6">Any Others</label><br>
					<textarea <%=ans4.contains("6")?"":"style='display:none'"%> placeholder = "Enter the brief Details" name = "Q4Text" id = "Q4Text" class = "form-control" cols = "99" rows = "1"><%=ans4Text%></textarea>
				</div>	
				<div class = "row form-check">
					<label class = "qType" for = "q5" class = "qName" ><span class = "QName">5.</span>	Has the event helped you in making conscious developments to become fit and healthy? </label>
				</div>	
				<div class = "row form-check">
					<input style = "margin-left:20px"  type = "radio" name = "q5" id = "q5_1" <%="1".equals(ans5)?"checked":""%>  value = "1" onclick = "goQuestion('Q5');"> <label for = "q5_1">Yes</label>
					<input style = "margin-left:20px"  type = "radio" name = "q5" id = "q5_2" <%="2".equals(ans5)?"checked":""%>  value = "2"> <label for = "q5_2" >No</label><br/>
					
					<textarea <%=ans5.equals("1")?"":"style='display:none'"%>  placeholder = "Enter the brief Details" name = "Q5Text" id = "Q5Text" class = "form-control" cols = "99" rows = "1"><%=ans5Text%></textarea>
				</div>
				<div class = "row form-check">
					<label class = "qType" for = "q6" ><span class = "QName">6.</span>	What benefits do you think you gained from this event? </label>
				</div>	
				<div class = "row form-check">
					<input style = "margin-left:20px"  type = "checkbox" name = "q6" id = "q6_1" <%=ans6.contains("1")?"checked":""%>  value = "1"> <label for = "q6_1">Good sleep</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q6" id = "q6_2" <%=ans6.contains("2")?"checked":""%>  value = "2"> <label for = "q6_2">Good heart fitness</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q6" id = "q6_3" <%=ans6.contains("3")?"checked":""%>  value = "3"> <label for = "q6_3">Improved management of conditions such as hypertension, cholesterol, muscular pain and stiffness</label><br>
					<input style = "margin-left:20px"  type = "checkbox" name = "q6" id = "q6_4" <%=ans6.contains("4")?"checked":""%>  value = "4"> <label for = "q6_4">Reduce body fat</label>
					<input style = "margin-left:20px"  type = "checkbox" name = "q6" id = "q6_5" <%=ans6.contains("5")?"checked":""%>  value = "5" onclick = "goQuestion('Q6');"> <label for = "q6_5">Any Other</label><br>
					<textarea <%=ans6.contains("5")?"":"style='display:none'"%>  placeholder = "Enter the brief Details" name = "Q6Text"  id = "Q6Text" class = "form-control" cols = "99" rows = "1"><%=ans6Text%></textarea>
				</div>-->
				<div class = "row form-check">
					<label class = "qType" for = "q7" ><span class = "QName"></span>	Any suggestions for us to improve if similar event is organized in future: </label>
				</div>
				<div class = "row form-check">
					<textarea placeholder = "Maximum 512 characters" name = "q7" id = "q7" maxlength = "513" class = "select-field" cols = "99" rows = "3" <%=isExist?"readonly":""%>><%=ans7Text%></textarea>
				</div><br>	
				<div class = "row form-check" align = "center">
					<%if("Y".equals(adminFeedback)){%>
						<center><button type= "submit" onclick = "return goUpdate();" name = "updateBtn" class = "btn btn-md btn-success">Publish for Public View</button></center>
					<%} if(!isExist) {%>
						<center><button type= "submit" onclick = "return goSubmit();" name = "submitBtn" class = "btn btn-md btn-primary">Submit Feedback</button></center>
					<%}%>
				</div>
			</div>
		</div>
	</form>
</div>
<%@include file="footer.jsp"%>
<!--
CREATE TABLE NOMINATION_FIT_FEEDBACK (EMP_NO VARCHAR2(20) NOT NULL , PERSON_CODE VARCHAR2(200) NOT NULL , ANS1 VARCHAR2(100) , ANS2 VARCHAR2(100) , ANS3 VARCHAR2(100) , ANS4 VARCHAR2(100) , ANS4_TEXT VARCHAR2(500) , ANS5 VARCHAR2(100) , ANS5_TEXT VARCHAR2(500) , ANS6 VARCHAR2(500),ANS6_TEXT VARCHAR2(500) , ANS7 VARCHAR2(2000) , UPDATE_BY VARCHAR2(20) , UPDATE_DATE DATE,PUBLISH VARCHAR2(20) , CONSTRAINT NOMINATION_FIT_FEEDBACK_PK PRIMARY KEY (EMP_NO , PERSON_CODE ));

-->