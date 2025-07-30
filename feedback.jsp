<%@ include file="header1.jsp"%>
<%@ include file = "storepath.jsp"%>

<link href="css/style12.css" rel="stylesheet" type="text/css"/>

<style>

label > input{ /* HIDE RADIO */
  visibility: hidden; /* Makes input not-clickable */
  position: absolute; /* Remove input from document flow */
}
label > input + img{ /* IMAGE STYLES */
  cursFeedor:pointer;
  border:2px solid transparent;
}
label > input:checked + img{ /* (RADIO CHECKED) IMAGE STYLES */
  border:3px solid #2980B9;
}
.QName{
	color:#2980B9;
}

.green-button{
    background: -webkit-linear-gradient(top ,#14a503,#0e7502)!important;
}
.button_link, button, input[type="submit"] {border-radius: 4px; border: 1px solid #004085; font-size: 13px !important; cursor: pointer; padding: 2px 10px;}

</style>
<script>

function submitForm1(){
	if(validateFb()){
		document.form1.action_type.value="submit12";
		document.form1.submit();
	}else{
		return false;
	}	
}

function validateFb(){
	var isEntry=$("#entryEmp").val();
	if(isEntry!=''){
		alert("You have already submitted the Feedback Form");
		return false;
	}
	if($('[type=radio]:checked').length==0){
		alert("Please fill the form before Sumbit");
		return false;
	}
	if($("#feedPerson").val()=='-1'){
		alert("Please Choose the person for whom you want to give the feedback");
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


<%
String emp_no=(String)session.getAttribute("login");
if(emp_no==null){%>
	<script>
		alert("Invalid User");
	</script>	
<%}
PreparedStatement psFeed=null;
ResultSet rsFeed=null;
String eventName=request.getParameter("evtnme");
String feedComments=request.getParameter("my_comments");
String query1="",entryEmp="",eventValue="";
query1="select * from workflow.nomination_feedback where emp_no=? and event=?";
boolean isEntry=false;
String action_type=request.getParameter("action_type");
String tempSelcted = nullVal(request.getParameter("feedPerson"));
String isAdminFeed = nullVal(request.getParameter("isAdminFeed"));
String query="insert into nomination_feedback (EMP_NO,ANS1,ANS2,ANS3,ANS4,ANS5,ANS6,UPDATE_DATE,EVENT,comments) values(?,?,?,?,?,?,?,sysdate,?,?)";
String a1="",a2="",a3="",a4="",a5="",a6="";
int ans1=0,ans2=0,ans3=0,ans4=0,ans5=0,ans6=0;
//try{
psFeed=con.prepareStatement(query1);
psFeed.setString(1,tempSelcted);
psFeed.setString(2,eventName);
rsFeed=psFeed.executeQuery();
if(rsFeed.next()){
	isEntry=true;
	entryEmp=nullVal(rsFeed.getString("emp_no"));
	ans1=(rsFeed.getInt("ans1"));
	ans2=(rsFeed.getInt("ans2"));
	ans3=(rsFeed.getInt("ans3"));
	ans4=(rsFeed.getInt("ans4"));
	ans5=(rsFeed.getInt("ans5"));
	ans6=(rsFeed.getInt("ans6"));
	feedComments = nullVal(rsFeed.getString("comments"));
}
if(!isAdmn && isEntry){%>
	<script>
		//alert("You have already submitted the Feedback form for this Event");
			//window.location.href="home.jsp";
	</script>
<%}
Map<String,String> fitMap = new LinkedHashMap <String,String>();
boolean isForHPFIT = false;
String queryFit = "select distinct a.child_name ch_name,b.person_name pr_name from nomination_dependents a left join "+tempJdep+"jdep b on a.child_name = b.person_code where a.emp_no =? and event_name = '2018_126_event' order by child_name";
PreparedStatement psFit = con.prepareStatement(queryFit);
psFit.setString(1,emp_no);
ResultSet rsFit = psFit.executeQuery();
while(rsFit.next()){
	fitMap.put(rsFit.getString("ch_name"),rsFit.getString("pr_name"));
}
query1="select evtnme from workflow.nomination_admin where evt_id=?";
psFeed = con.prepareStatement(query1);
psFeed.setString(1,eventName);
rsFeed = psFeed.executeQuery();
if(rsFeed.next())
	eventValue=rsFeed.getString("evtnme");
if("submit12".equals(action_type)){
	if(!isEntry){
		a1=nullVal(request.getParameter("ans1"));
		a2=nullVal(request.getParameter("ans2"));
		a3=nullVal(request.getParameter("ans3"));
		a4=nullVal(request.getParameter("ans4"));
		a5=nullVal(request.getParameter("ans5"));
		a6=nullVal(request.getParameter("ans6"));
			emp_no = nullVal(request.getParameter("feedPerson"));
		if(!"".equals(a1)){
			try{ans1=Integer.parseInt(a1);}catch(NumberFormatException nf1){}
		}	
		if(!"".equals(a2)){
			try{ans2=Integer.parseInt(a2);}catch(NumberFormatException nf2){}
		}	
		if(!"".equals(a3)){
			try{ans3=Integer.parseInt(a3);}catch(NumberFormatException nf3){}
		}	
		if(!"".equals(a4)){
			try{ans4=Integer.parseInt(a4);}catch(NumberFormatException nf4){}
		}	
		if(!"".equals(a5)){
			try{ans5=Integer.parseInt(a5);}catch(NumberFormatException nf5){}
		}	
		if(!"".equals(a6)){
			try{ans6=Integer.parseInt(a6);}catch(NumberFormatException nf6){}
		}	
	
		psFeed=con.prepareStatement(query);
		psFeed.setString(1,emp_no);
		psFeed.setInt(2,ans1);
		psFeed.setInt(3,ans2);
		psFeed.setInt(4,ans3);
		psFeed.setInt(5,ans4);
		psFeed.setInt(6,ans5);
		psFeed.setInt(7,ans6);
		psFeed.setString(8,eventName);
		psFeed.setString(9,feedComments);
		int val1=psFeed.executeUpdate();
		if(val1>0){%>
			<script>
				alert("Feedback submitted Successfully");
				window.location.href="home.jsp";
			</script>
		<%}
	}else{%>
		<script>
			alert("You have already Completed your Feedback");
			window.location.href="home.jsp";
		</script>
	<%}	
}
%>
<body>
<div class="container">
<div>
<center><form name="form1" style="width:50%" action="feedback.jsp" method="post">
<header class="style-app-name">Feedback For <%=eventValue%></header>
	<%if("2018_126_event".equals(eventName)){%>
	<table class="listTable">
	<tr colspan = "4"><td><b><font class="QName">FEEDBACK GIVEN ON BEHALF OF :</font></b>
		
		<select name = "feedPerson" id = "feedPerson" onchange = "return sfresh();" <%="Y".equals(isAdminFeed)?"disabled":""%>>
		<option value = "-1">Select</option>
		<%for(Map.Entry<String,String> entry:fitMap.entrySet()){%>
		<option value =  "<%=entry.getKey()%>" <%=tempSelcted.equals(entry.getKey())?"selected":""%>><%=entry.getValue()%></option>
		<%}%>
		</select>
		</td>
	</tr>
	</table>
	<%} else{%>
		<input type = "hidden" name = "feedPerson" id = "feedPerson" value = "<%=emp_no%>">
	<%}%>
	<table >
	<td colspan="4"><b><font class="QName">Q1)</font> Activity was fun and enjoyable.</b></td></tr>
	<td><label><input type="radio" name="ans1" <%=ans1==1?"checked":""%> value="1"/>1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans1" <%=ans1==2?"checked":""%>  value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans1" <%=ans1==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans1" <%=ans1==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label></td></tr>
	<tr>
	<td colspan="4">
	<b><font class="QName">Q2)</font> Activity was purposeful and meaningful.</b></td></tr>
		<tr><td><label><input type="radio" name="ans2" <%=ans2==1?"checked":""%> value="1" />1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans2" <%=ans2==2?"checked":""%> value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans2" <%=ans2==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans2" <%=ans2==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label></td></tr>
	<tr>
	<td colspan="4">
	<b><font class="QName">Q3)</font> Activity helped instilling a sense of pride for being part of the HP family.</b> </td></tr>
		<tr><td><label><input type="radio" name="ans3" <%=ans3==1?"checked":""%> value="1" />1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans3" <%=ans3==2?"checked":""%> value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans3" <%=ans3==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans3" <%=ans3==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label></td></tr>
	<tr>
	<td colspan="4">
	<b><font class="QName">Q4)</font> Activity helped create a strong sense of belongingness with the Corporation.</b></td></tr>
		<tr><td><label><input type="radio" name="ans4" <%=ans4==1?"checked":""%> value="1"/>1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans4" <%=ans4==2?"checked":""%> value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans4" <%=ans4==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans4" <%=ans4==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label></td></tr>
	<tr>
	<td colspan="4">
	<b><font class="QName">Q5)</font><font>Activity helped my family and me connect with families and employees from other departments.</b></font></td></tr>
		<tr><td><label><input type="radio" name="ans5" <%=ans5==1?"checked":""%> value="1"/>1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans5" <%=ans5==2?"checked":""%> value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans5" <%=ans5==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans5" <%=ans5==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label></td></tr>
	<tr><td colspan="4">
	<b><font class="QName">Q6)</font> I look forward to my work after participating in an employee connect program.</b></td></tr>
	<tr><td><label><input type="radio" name="ans6" <%=ans6==1?"checked":""%> value="1"/>1.<img src="images/happy1.png" title="Very Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans6" <%=ans6==2?"checked":""%> value="2"/>2.<img src="images/satisfied.png" title="Happy" width="45"></label></td>
		<td><label><input type="radio" name="ans6" <%=ans6==3?"checked":""%> value="3"/>3.<img src="images/sad.png" title="not yet decided" width="60"></label></td>
		<td><label><input type="radio" name="ans6" <%=ans6==4?"checked":""%> value="4"/>4.<img src="images/angry.png" title="Sad" width="45"></label>
	</td></tr>
	<tr>
		<td colspan="4"><b>Give your comments in 500 words </b><span class="QName">(optional)</span></td>
	</tr>
	<tr>
		<td colspan="4">
			<textarea name="my_comments" cols="70" class="select-field" rows="6" id="my_comments" placeholder="Maximum 500 words" class="des"><%=nullVal(feedComments)%></textarea>
			<div>(Characters remaining : <span id="count_my_comments" >500</span>)</div>
		</td>
	</tr>
	<%if(!isEntry){%>
	<tr>
	
	<td colspan="4"><button type="submit" onclick="return submitForm1()" class="green-button" style="background-color:green;" name="submit" data-tooltip="Click to Submit the Data" original-title="">SUBMIT</button></td></tr>
	<%}%>
	</table>
	<input type="hidden" name="action_type"/>
	<input type="hidden" name="entryEmp" id="entryEmp" value="<%=entryEmp%>" />
	<input type="hidden" name="evtnme" id="evtnme" value="<%=eventName%>">
	</form>
</div></center></div></br>
</body>
<%/* } catch(Exception e){
		out.println("Some Error Occured");
} finally{
	if(rsFeed!=null)
		rsFeed.close();
	if(psFeed!=null)
		psFeed.close();
	if(con!=null)
		con.close();
} */
%>


<script>
 $(function() {
	var cnt = 500;
  counter = function(e) {
	  if(this.id=="my_comments"){
		    cnt=500;
	  }
	var value = this.value;
	if (e.which != 8) {
	  var count = value.length;
	  if (count >= cnt) {
		  $("textarea[id='"+this.id+"']").val(value.substring(0,cnt-1));
	      e.preventDefault();
	  }
	  }
	  //console.log(this.id);	
	if (value.length == 0) {
		$('#count_'+this.id).html(cnt);
		return;
	}
	//value = trim(value);
	var wordCount = value.length;
	var remainingCount = cnt-wordCount;
	if(wordCount>=cnt) {
		remainingCount = 0;
	}
	//$('#count_'+this.id).html(remainingCount);
	$(document.getElementById("count_"+this.id)).html(remainingCount);
}
$('.des').change(counter);
	$('.des').keydown(counter);
	$('.des').keypress(counter);
	$('.des').keyup(counter);
	$('.des').blur(counter);
	$('.des').focus(counter);
  });
</script>
<%@include file="footer.jsp"%>