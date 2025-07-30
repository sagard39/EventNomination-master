<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" />
<%@ include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page
	import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<style>
.listTable { -
	-background-color: green;
	border-spacing: 1px;
	border-collapse: separate;
	border-collapse: collapse;
	width: 100%;
}

.listTable tr>th { -
	-border: px solid #FFFFFF;
	box-shadow: 0 0 10px #5D6D7E;
	background-color: #3092c0;
	color: #FFF;
	background: -webkit-linear-gradient(top, #3092c0, #1A5276);
	background: -o-linear-gradient(top, #3092c0, #1A5276);
	background: -moz-linear-gradient(top, #3092c0, #1A5276);
	background: -ms-linear-gradient(top, #3092c0, #1A5276);
	background: linear-gradient(top, #3092c0, #1A5276);
}

.listTable tr:nth-child(even) {
	background: #FDEDEC;
}

.listTable tr:nth-child(odd) {
	background: #ebf1fa;
}

.listTable td {
	padding: 1% 0%;
}

.tdLbl1 {
	padding: 2px 10px;
	color: #18568e;
	font-weight: bold;
	font-size: 12px;
}

body {
	font-family: cambria;
}
.target_popup {position: relative; background: white; padding: 20px; width: auto; max-width: 1000px; margin: 20px auto; box-shadow: 0 0 12px #fff; border-radius: 5px;}


.listTable tr>th {
background-color: #000d39;
background: -webkit-linear-gradient(top ,#000d39, #004085);
background: -o-linear-gradient(top ,#000d39, #004085);
background: -moz-linear-gradient(top ,#000d39, #004085);
background: -ms-linear-gradient(top ,#000d39, #004085);
background: linear-gradient(top ,#000d39, #004085);}
}

</style>
<script>

$(function() {
		$('.inline_popup').magnificPopup({ type: 'inline', });
		if($('#eventId').val()=="2019_285_event") {
			if($("#winner_count").val()!="0") {
				$("#popup_link").click();
			}
			$("#chkEmp1").click();
		}
			//$("#guideline_link").click();
});

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var val1=(document.getElementById("ta").value);
	var evtId = $("#eventId").val();
	var otherTotEntry = 0;
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
	otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
	var tot_amt=parseInt(document.getElementById("pAmount").value);
	val1++;
	otherTotEntry++;
	remTicks--;
	if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
	} else {
		if(val1<=noOfTicks){
			document.form1.ta.value=val1;
			var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz);
			document.getElementById("ttt").innerHTML = val2;
			if(evtId=="2018_156_event")
				val1 = val1*2;
			document.getElementById("tickReq").value = val1;
			document.getElementById("otherTotEntry").value = otherTotEntry;
			document.getElementById("pAmount").value = val2;
			document.getElementById("remTicks").innerHTML = remTicks;
			document.getElementById("tickCnt").value=remTicks;		
		}else{
			alert("Max Ticket capacity exceeded");
			return false;
		}
	}
	var row = $("#tr").html();
	var index = $("#ti_table tbody:first > tr").length;
	row = row.replaceAll("#id#", index);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	recalculate()


}
function ageValid(obj){
		var enteredAge=parseInt(obj.value);
		var ageCriteria=document.getElementById("age_criteria").value;
		var  ageGroup=ageCriteria.split(" ");
		var minAge=parseInt(ageGroup[1]);
		var maxAge=parseInt(ageGroup[3]);
		if(enteredAge<minAge || enteredAge>maxAge){
				alert("Enter the Age "+ageCriteria);
		}else{
		//	alert("Entereed properly");
		}
}
function removeRow(id,aid) {
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var evtId = $("#eventId").val();
	var otherTotEntry = 0;
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;	
	var row = $("#tr").html();
	$("#tr"+id).remove();
	var index = $("#ti_table tbody:first > tr").length;
	 row = row.replaceAll("#id#", index-1);
	$("#leg_count").val(index-1);
	 var val1=(document.getElementById("ta").value);
	val1--;
	otherTotEntry--;    //suspicious
	document.form1.ta.value=val1;
	$("#otherTotEntry").val(otherTotEntry);
	var val2=	(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz);
	remTicks++;	
	if(evtId=="2018_156_event")
		val1 = val1*2;
	document.getElementById("tickReq").value = val1;
	document.getElementById("ttt").innerHTML = val2;
	document.getElementById("pAmount").value = val2;
	document.getElementById("remTicks").innerHTML = remTicks;	
	document.getElementById("tickCnt").value=remTicks;		

}
function recalculate() {
    var i = 1;

    $(".numberRow").each(function() {
        $(this).find("strong").text(i++); 
	
    });
	
}
function sfresh() {
    document.form1.action="mainSubmit.jsp";
	var event=document.getElementById("eventId").value;
	//alert(event);
	document.form1.submit();
}
function guidelineFun(id){
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var otherTotEntry = 0;
	var evtId = $("#eventId").val();
	if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
	if(document.getElementById("chk"+id).checked ==true){
		remTicks--;
		if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}else {
			var val1=(document.getElementById("ta").value);
			if(val1<noOfTicks){
				val1++;
				document.form1.ta.value=val1;
				var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
				if(evtId == "2018_156_event")
					val1 = val1*2;
				console.log(val1+"*"+maxPrz);
				console.log(otherTotEntry+"*"+maxPrz);
				document.getElementById("ttt").innerHTML = val2;
				document.getElementById("tickReq").value = val1;
				document.getElementById("pAmount").value = val2;
				document.getElementById("remTicks").innerHTML = remTicks;
				document.getElementById("tickCnt").value=remTicks;		
				//console.log(val1);
			}else{
				alert("Max Ticket capacity exceeded");
				return false;
			}
		}
	
	}else{
		var val1=(document.getElementById("ta").value);
		val1--;
		remTicks++;
		document.form1.ta.value=val1;
		var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
		if(evtId == "2018_156_event")
			val1 = val1*2;
	
		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("pAmount").value= val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		
	}	
}
function guidelineFun1(id){
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var otherTotEntry = 0;
	var evtId = $("#eventId").val();
	if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
	
	if(document.getElementById("chkEmp"+id).checked ==true){
		remTicks--;
		if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}		
		else {
			var val1=(document.getElementById("ta").value);
			val1++;
			if(val1<=noOfTicks){
				document.form1.ta.value=val1;
				var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
				if(evtId == "2018_156_event")
					val1 = val1*2;
				document.getElementById("ttt").innerHTML = val2;
				document.getElementById("tickReq").value = val1;
				document.getElementById("tickReq").value = val1;
				document.getElementById("pAmount").value = val2;
				document.getElementById("remTicks").innerHTML = remTicks;
				document.getElementById("tickCnt").value=remTicks;		
			}else{
				alert("Max Ticket capacity exceeded");
				return false;
			}
		}
	} else {
		var val1=(document.getElementById("ta").value);
		val1--;
		remTicks++;
		document.form1.ta.value=val1;
		var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
		if(evtId == "2018_156_event")
			val1 = val1*2;
		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("pAmount").value= val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		
	}	
}
function submitEvtForm(){
	var x = document.getElementById("bPointName").length;
	if(x>2){
		var bpName=document.getElementById("bPointName").value;
		if(bpName=='-1'){
			alert("Please Select the Boarding Point");
			return false;
		}
	}
	var evtId = $("#eventId").val();
	var isValid=document.getElementById("tickReq").value;
	var isVal1="";
	if(isValid<=0){
		alert("Please Select the Entries before Submission");
		return false;
	}
	if ($("input[type='checkbox'][name='chkBoxEmp']:checked").length>0){
		var emp_contact=document.getElementById("emp_contact").value;
		if(emp_contact==''){
			alert("Enter the Contact No before Submission");
			return false;
		}
	}
	if(evtId=='2019_166_event'){
		if(($("input[id='chkEmp1']:checked").length!=1)&&($("input[id='chk1']:checked").length!=1)){
			alert("Please Select your entry and spouse entry in order to submit ");
			return false;
		}
	}
	if(evtId=='2019_285_event') {
		var contact_no = document.getElementsByClassName("contact_no");
		var contact_no_arr = [];
		for(var i = 0; i < contact_no.length; i++) {
			if(contact_no[i].value.trim()!='')
				contact_no_arr.push(contact_no[i].value);
		}
		if(checkDup(contact_no_arr)) {
			alert("Please enter unique contact number for each member");
			return false;
		}
	}
	var hidCountDep=parseInt($("#hidCountDep").val());
	for(var i=2;i<hidCountDep;i++){
		if($("input[id='chk"+i+"']:checked").length!=0){
			var dep_contact=$("#dep_contact"+i).val();
			if(dep_contact==''){
				alert("Enter the Contact No. in Dependents Table row");
				return false;
			}
		}		
	}
	var leg_count=$("#leg_count").val();
	for(var i=1;i<=leg_count;i++){
		var rel_per=$("#person_name_add"+i).val();
		if(rel_per==''){
			alert("Please fill the name in Additonal table Row "+i);
			return false;
		}
		var rel_rl=$("#rel_add"+i).val()
		if(rel_rl==''){
			alert("Please Enter the Relation in Additonal table row no"+i);
			return false;
		}
		var age_rel=$("#age_rel"+i).val()
		if(age_rel==''){
			alert("Please Enter  the age in Additonal table row no"+i);
			return false;
		}
		var contact_rel=$("#contact_rel"+i).val()
		if(contact_rel==''){
			alert("Please Enter  the Contact No. in Additonal table row no"+i);
			return false;
		}		
	}
}

var checkDup = function(a) {
    var counts = [];
    for(var i = 0; i <= a.length; i++) {
        if(counts[a[i]] === undefined) {
            counts[a[i]] = 1;
        } else {
            return true;
        }
    }
    return false;
}

function submitEvtForm1(){
	var isValid=document.getElementById("tickReq").value;
	var isVal1="";
	if(isValid<=0){
		alert("Please Select the Entries before Submission");
		return false;
	}
	var x = document.getElementById("bPointName").length;
	if(x>2){
		var bpName=document.getElementById("bPointName").value;
		if(bpName=='-1'){
			alert("Please Select the Boarding Point");
			return false;
		}
	}
	var evtId = $("#eventId").val();
	if(evtId=='2019_166_event'){
		var amountDed=$("#pAmount").val();
		if(amountDed!='200'){
			alert("Check your entry along with spouse in order to submit");
			return false;
		}
	}
	
	$('input[type=file]').each(function(){
		file = this.files[0]
		if(file != undefined && file.size/1024/1024 > 25) {
			alert("file size can not be more than 25MB");
			return false;
		}
	});
	
	var items = document.getElementsByClassName('isMandate');
	for (var i = 0; i < items.length; i++){
		
		if(((items[i].name.startsWith("addition_Emp") || items[i].name.startsWith("fileaddition_Emp")) &&
			$('#chkEmp1').is(':checked') && items[i].value=='')
			|| ((items[i].name.startsWith("addition_dep_") || items[i].name.startsWith("fileaddition_dep_")) && $(items[i]).parent().parent().find('input[type=checkbox]')[0].checked && items[i].value=='')) {
				alert("Please fill the Mandetory fields");
				return false;
		}
	}
	var emp_contact=document.getElementById("emp_contact").value;
	if ($("input[type='checkbox'][name='chkBoxEmp']:checked").length>0){
		if(emp_contact==''){
			alert("Enter the Contact No before Submission");
			return false;
		}
	}
	var evtidTemp = $("#eventId").val();
	var hidCountDep=parseInt($("#hidCountDep").val());
	for(var i=1;i<=hidCountDep;i++){
		if($("input[id='chk"+i+"']:checked").length!=0){
			var dep_contact=$("#dep_contact"+i).val();
			if(dep_contact==''){
				alert("Enter the Contact No. in Dependents Table row");
				return false;
			}
			if(evtidTemp == "2018_126_event"){
				if(i ==1 && (parseInt(emp_contact) == parseInt(dep_contact))){
					alert("Please enter different contact no.for your Spouse");
					return false;
				}
			}
		}		
	}	
	var leg_count=$("#leg_count").val();
	for(var i=1;i<=leg_count;i++){
		var rel_per=$("#person_name_add"+i).val();
		if(rel_per==''){
			alert("Please fill the name in Additonal table Row "+i);
			return false;
		}
		var rel_rl=$("#rel_add"+i).val()
		if(rel_rl==''){
			alert("Please Enter the Relation in Additonal table row no"+i);
			return false;
		}
		var age_rel=$("#age_rel"+i).val()
		if(age_rel==''){
			alert("Please Enter  the age in Additonal table row no"+i);
			return false;
		}
		var contact_rel=$("#contact_rel"+i).val()
		if(contact_rel==''){
			alert("Please Enter  the Contact No. in Additonal table row no"+i);
			return false;
		}		
	}
	
	if(evtId=='2019_285_event') {
		var contact_no = document.getElementsByClassName("contact_no");
		var contact_no_arr = [];
		for(var i = 0; i < contact_no.length; i++) {
			var c1 = contact_no[i].value.trim();
			if(c1!='' && c1.length>=10) {
				c1 = c1.substring(c1.length-10,c1.length);
				//console.log(c1);
				contact_no_arr.push(c1);
			}
		}
		if(checkDup(contact_no_arr)) {
			alert("Please enter unique contact number for each member")
			return false;
		}
	}
	

	if(!confirm("Do you really want to submit the Entry ? After submission ,you won't be able to modify the data"))
		return false;
	else 
		return true;
}
function chkAllow(){
	$("#submitEvt").toggle();
	$("#submitEvt1").toggle();
}
</script>

<a id="popup_link" class="inline_popup" href="#popup_div" style="display:none;">PopUp</a>
<div id="popup_div" class="target_popup mfp-hide">
<div><h3>Congratulations. Basis your stupendous performance in #Hum Fit Toh HP Fit Challenge 2018, you have been elevated to "League of the Champions" for the  #Hum Fit Toh HP Fit Challenge 2019, where the mightier will compete for the top 5 slots. All The Best for #Hum Fit Toh HP Fit Challenge 2019.</h3></div>
<br/>
<div><h4>Elevation to "League of the Champions" :</h4></div>
<%
PreparedStatement psMain = null;
ResultSet rsMain = null;
psMain=con.prepareStatement("select b.emp_no, b.person_code, b.person_name from nomination_winner a left join "+tempJdep+"jdep b on a.person_code=b.person_code where a.emp_no=?");
psMain.setString(1,emp);
rsMain=psMain.executeQuery();
int winner_count=0;
while(rsMain.next()) { winner_count++;
%>
	<div><h4><%=rsMain.getString("person_name")%><h4></div>
<% } %>
</div>
<input type='hidden' id='winner_count' name='winner_count' value='<%=winner_count%>'/>

<a id="guideline_link" class="inline_popup" href="#guideline" style="display:none;">GuideLine</a>
<div id="guideline" class="target_popup mfp-hide">
<div>
	<div><h3>Declarations - Trek to Sandakphu - Sikkim </h3></div>
	<div>
		<ul>
			<li>The information submitted by me about myself and my family members in this entry form is true. I am solely responsible for the accuracy of this information.</li>
			<li>That I and my family members are participating out of our own free will and that there is no pressure nor requirement or is it a condition of my service to participate in the above event from HPCL.</li>
			<li>I understand that for a physical endurance event like the 'Trek to Sandakphu', myself and my family members must be trained to an appropriate level of fitness to participate in the same.</li>
			<li>I am aware of the inherent risk of participating in a physical endurance event like the 'Trek to Sandakphu' and take full responsibility for the overall health and safety of myself and my family to participate in the same.</li>
			<li>That neither me or any member of my family suffer from any medical or physical condition which otherwise is a risk for their participation in the 'Trek to Sandakphu'.</li>
			<li>That HPCL will not be held responsible for any eventuality arising out of such participation by me or my family members and that me or my legal representatives shall waive all claim of whatsoever nature against HPCL for any untoward incident.</li>
			<li>That if me or any of my family members are injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to transport me/my ward to a medical facility and or to administer emergency medical treatment. I and my family members also agree to waive all claim that might result from such transport and or treatment or delay or deficiency therein.</li>
			<li>That I am not hiding or suppressing any such medical data relating to me and my family members from that may either put me or my family to risk by participating in the 'Trek to Sandakphu'.</li>
			<li>I understand, agree and irrevocably permit 'Trek to Sandakphu' to share the information given me & my family members in this application, with all/any entities associated with the 'Trek to Sandakphu' at its own discretion.</li>
			<li>I understand, agree and irrevocably permit  'Trek to Sandakphu' to use me & my family members photograph which may be photographed on the day of the event, for the sole purpose of promoting the 'Trek to Sandakphu', at its own discretion.</li>
		</ul>
	</div>
	<div style="color:red">I and my family members hereby declare, confirm and agree as above.</div>
</div>
<div style="text-align: center"><button onclick='$( ".mfp-close" ).trigger( "click" );return false;'>Submit</button></div>
</div>

<%!public String nullVal(String str) {
		String valStr = str;
		if (str == null) {
			valStr = "";
		} else if ((str.trim()).equals("null")) {
			valStr = "";
		} else if ("".equals(str)) {
			valStr = "";
		}
		return valStr;
	}%>
<div>
	<%
		String query = "", eventId = "", eventEndDate = "", maxTicks = "", maxPrize = "", noOfTicks = "",
				bPoints = "", evtName = "", action_type = "", bPointEmp = "", pAmount = "";
		String btnnme = "", btnclkd = "", title = "", ttitle = "", status = "", empBudesc = "", style = "",
				additionalFields = "", additionList1 = "", additionList2 = "", additionList3 = "", emp_contact = "",
				emp_bu = "", loginEmpGrade = "";
		int evtIns = 0, count = 0,empAge=0;
		String empMail = "", ccEmps = "", ccMail = "", buLocn = "";
		String fileFields0 = "", fileFields1 = "", fileFields2 = "", Contact_count = "";
		eventId = nullVal(request.getParameter("eventId"));
		Map<String, String> evtMap = new LinkedHashMap<String, String>();
		List<String> relCode = new ArrayList<String>();
		List<String> othName = new ArrayList<String>();
		List<String> othRel = new ArrayList<String>();
		List<String> othAge = new ArrayList<String>();
		List<String> othGen = new ArrayList<String>();
		List<String> othContact = new ArrayList<String>();
		List<String> dep_contact = new ArrayList<String>();
		List<String> empMisc1 = new ArrayList<String>();
		List<String> depMisc1 = new ArrayList<String>();
		List<String> empEntry = new ArrayList<String>();
		Map<String, String> addMap = new HashMap<String, String>();
		Map<String, String> addMapEmp = new HashMap<String, String>();
		Map<String, String> addMapDep = new HashMap<String, String>();
		List<String> empContactList = new ArrayList<String>();
		List<String> nominationList = new ArrayList<String>();
		Map<String, String> othContactMap = new HashMap<String, String>();
		Map<String, String> depContactMap = new HashMap<String, String>();
		Map<String, String> nominationMap = new HashMap<String, String>();
		Map<String, String> depMiscMap = new HashMap<String, String>();
		
		query = "select trunc((sysdate-person_dob)/365) empAge from "+tempJdep+"jdep where relation_code='SL' and  emp_no=?";
		psMain=con.prepareStatement(query);
		psMain.setString(1,emp);
		rsMain=psMain.executeQuery();
		if(rsMain.next()){
			empAge=rsMain.getInt("empAge");
		}
		String evt_cat = "";
		query = "select distinct EVTNME,evt_id from NOMINATION_ADMIN where  (regexp_like(EVTPLACE, trim(?), 'i') or EVTPLACE ='ALL') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and status='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"' order by evt_id";
		psMain = con.prepareStatement(query);
		psMain.setString(1, town);
		rsMain = psMain.executeQuery();
		while (rsMain.next()) {
			evtMap.put(rsMain.getString("evt_id"), rsMain.getString("EVTNME"));
		}
		query = "select bu,email,grade from empmaster where emp_no=?";
		psMain = con.prepareStatement(query);
		psMain.setString(1, emp);
		rsMain = psMain.executeQuery();
		if (rsMain.next()) {
			emp_bu = rsMain.getString("bu");
			empMail = rsMain.getString("email");
			loginEmpGrade = rsMain.getString("grade");
		}
		query = "select distinct EVTNME,evt_id,adminemp from NOMINATION_ADMIN where  regexp_like(EVTPLACE, trim('"
				+ emp_bu
				+ "'), 'i') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and evt_bu='Y' and status='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"' order by evt_id";
		psMain = con.prepareStatement(query);
		rsMain = psMain.executeQuery();
		while (rsMain.next()) {
			evtMap.put(rsMain.getString("evt_id"), rsMain.getString("EVTNME"));
			ccEmps = nullVal(rsMain.getString("adminemp"));
		}
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if (isMultipart) {
			int cn = 0;
			ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
			List fileItemsList = servletFileUpload.parseRequest(request);
			Iterator it = fileItemsList.iterator();
			File tempDir = null;
			File tempDir1 = null;
			File tempDir2 = null;
			while (it.hasNext()) {
				FileItem fileItem = (FileItem) it.next();
				{
					String name = fileItem.getFieldName();
					String value = fileItem.getString();
					if (fileItem.isFormField()) {
						if(name.equals("submitEvt")){
							btnclkd="saved";
						}
						if(name.equals("SubmitConfirm")){
							btnclkd="submitted";
						}
						if("evtName".equals(name)){
								evtName=value;
						}				
						if("eventId".equals(name)){
								eventId=value;
						}
						if("noOfTicks".equals(name)){
								noOfTicks=value;
						}
						if("bPointName".equals(name)){
								bPointEmp=value;
						}
						if("pAmount".equals(name)){
								pAmount=value;
						}
						if("chkBoxEmp".equals(name)){
								empEntry.add(value);
						}			
						if("chkBox".equals(name)){
							relCode.add(value);
							String[] conCount=value.split("\\#");
							for(int i=0;i<conCount.length;i++){
								Contact_count=conCount[i];
							}
							Contact_count="dep_contact"+Contact_count;	
						}
						if(name.startsWith("dep_contact")){
							depContactMap.put(name.substring(11),value);
						}	
						if(name.startsWith("depTimeSlot")){
							depMiscMap.put(name.substring(11),value);
						}
						if(Contact_count.equals(name)){
								empContactList.add(value);
						}				
						if("person_name_add".equals(name)){
								othName.add(value);
						}
						if("rel_add".equals(name)){
								othRel.add(value);
						}
						if("age_rel".equals(name)){
								othAge.add(value);
						}
						if("gender_rel".equals(name)){
								othGen.add(value);
						}
						if("contact_rel".equals(name)){
								othContact.add(value);
						}
						if("dep_contact".equals(name)){
							dep_contact.add(value);
						}
						if(name.startsWith("addition_Emp_")){//12
							addMapEmp.put(name.substring(13,name.length()),value);
						}
						if(name.startsWith("addition_dep_")){//12
							if(!"".equals(value))
								addMapDep.put(name.substring(13,name.length()),value);
						}
						if(name.equals("empTimeSlot")){
							empMisc1.add(value);					
						}
						if(name.equals("depTimeSlot")){
							depMisc1.add(value);
						}
						if("emp_contact".equals(name)){
								emp_contact=value;
						}
					} else {
						value = fileItem.getName();
						int ind = 0;
						String attError = "", filePath = "", a = "", filePath1 = "", filePath2 = "";
						boolean checkattach = name.contains("file");
						if (checkattach) { //if attach
							if (!"".equals(value)) {
								long fileSize = fileItem.getSize();
								if (fileSize > 0) {
									int dotPos = value.lastIndexOf(".");
									if (dotPos == -1) {
										attError = "Please select the attachment file format to upload with extension";
										out.println("<br><br><br><h4 align=center><font color=red>" + attError
												+ "</h4>");
										return;
									} else {
										String extension = value.substring(dotPos + 1);
										if (!(extension.equalsIgnoreCase("zip")
												|| extension.equalsIgnoreCase("pdf")
												|| extension.equalsIgnoreCase("doc")
												|| extension.equalsIgnoreCase("docx")
												|| extension.equalsIgnoreCase("jpg")
												|| extension.equalsIgnoreCase("jpeg")
												|| extension.equalsIgnoreCase("mp4")
												|| extension.equalsIgnoreCase("mov")
												|| extension.equalsIgnoreCase("webm")
												|| extension.equalsIgnoreCase("png"))) {
											attError = "Please select the attachment in following format - pdf, zip, jpg, jpeg, png,mp4,mov,webm,doc,docx";
											out.println("<br><br><br><h4 align=center><font color=red>" + attError
													+ "</h4>");
											return;
										} else {
											ServletContext sc = session.getServletContext();

											filePath = storepath + "/useruploads1/";

											tempDir = new File(filePath);
											if (tempDir.exists() == false) {
												tempDir.mkdir();
											}
											DateFormat df = new SimpleDateFormat("yyyyMMddhhmmSSS");
											Date today = Calendar.getInstance().getTime();
											String reportDate = df.format(today);
											File fileToCreate = null;
											if (name.startsWith("fileaddition_dep_")) {
												title = eventId+"_"+ name.substring(17, name.length()) + "." + extension;
												addMapDep.put(name.substring(17,name.length()),title);
											} else if (name.startsWith("fileaddition_Emp_")) {
												title = eventId+"_"+emp+"_"+ name.substring(17, name.length()) + "." + extension;
												addMapEmp.put(name.substring(17,name.length()),title);
											}
											
											fileToCreate = new File(filePath, title);
											try {
												fileItem.write(fileToCreate);
											} catch (Exception e) {
												attError = "ERROR IN ATTACHMENT UPLOAD";
												e.getMessage();
												out.println("<br><br><br><h4 align=center><font color=red>" + e
														+ "..</h4>");
												return;
											}
										}
									}
								}

							}
						}
					}
				}
			}
		}
		String[] addFieldArr = null;
		String noOfTicksEmp = "", evt_for = "", evt_date = "", miscVal1 = "", miscVal2 = "", miscVal3 = "",
				ticktRemaind = "", ageCriteria = "", evt_gen = "", tempDep = "", tempDep1 = "",participentCriteria="";
		int maxTicksNo = 0, tickRemNo = 0;
		boolean isEmp = false, isDep = false, isOther = false, isAllowed = false;
		boolean isExclusiveEvt = false;
		String flg = "", emailBody = "";
		if (!"".equals(eventId)) {
			
			if(eventId.equals("2019_300_event")) {
			%>
			<script>window.location.href="TeamNomination.jsp";;</script>
			<%
			}
			String[] empnos1 = {"30031670","31923190","31975070","31977930","30066120","38029300","31921530","31917240","31920930","31982620","31975390","31966770","31961410","31956080","31967480","31962530","31903600","31909640","30041140","39828070","31909460","31901410","31919830","31913260","30043270","31902500","31907160","38026920","31926780","31905690","39830580","38026190","31905160","30066020","30040950","31919230","31908490","38029340","30065530","31922480","31906380","31923920","31905360","31904390","30041690","31905750","31902840","31900450","38023810","31911460","38026680","31915620","31960670","31960630","38027710","30067930","31903110","31905680","31910860","31910840","38025370","31916960","30037830","31907490","31911960","31904910","31904780","38025140","31950040","30065970","31907090","31905230","31906920","31912820","31909490","39823910","31903900","31910340","31913460","39827000","31913810","39830570","31916000","31902060","30041750","31918500","31927910","31905730","31900950","31905170","31925820","31976450","31975330","31983070","39829160","31908290","31983180","31969130","31914470","31919180","31901030","31903340","30037530","31917580","30067700","31905390","30031530","31920940","31903950","31912040","31907810","30067940","31914960","30038920","30037210","31919400","31907560","31955890","30049240","31919220","31904980","31954220","31985750","31904340","31906550","38030790","31927940","31903270","38030810","31905580","31905970","38024860","31918640","31927220","31919630","31911570","38026600","31919870","31906740","31909080","31918720","31937580","31909390","31901920","30065200","31928710","30041730","31904630","30044260","31914710","31901480","30039000","31919930","31926310","31915500","30047670","31919150","31973320","31920600","38026170","31912730","31923080","39829290","31902140","31918250","31923370","31909780","31902170","31911500","31925770","39828200","31918180","38027200","30043460","31900650","39831610","38026610","31919910","31911750","31902810","38027220","31918700","30044430","39830480","38023770","31904200","39829130","31910330","38023980","31924790","30066350","38024170","31904230","31918980","31914520","31910250","31929130","31905960","30067670","31916760","31920020","31916110","39829310","38029620","31921420","38025160","38028320","31903850","31917500","38022160","31908000","31918150","31906630","31975970","31982600","31985120","31910470","39826340","31918450","31909910","31929460","31902120","30066210","38027180","31914460","30040300","31919430","31908570","31930450","31909440","38028100","30067660","31917970","38028240","30041860","31909340","31924030","31928380","38024220","31912880","31929530","31929580","31917830","31914910","30066180","31930650","31911920","30065680","31925590","31928140","31901000","31919820","31919040","39822720","31930490","31904510","31919030","31905640","30037880","30030050","38026930","38029260","30066380","31925740","30041120","30037690","38026200","30065790","39831570","30042670","38023840","31915600","31918190","30032340","38024000","30066480","31901110","31962740","31963050","31901080","31900730","31972660","30041880","38029250","30041570","30064960","38026330","31910370","31901870","30065360","31907570","30031760","30030500","31904700","30043290","31909950","31918920","30047870","31901770","38025390","31902940","31904760","30047630","31901700","31913370","31910820","30048500","30038900","31911070","38029280","30031680","30067750","30061290","39829140","31918910","30061310","31945770","31932470","31924300","31929650","38033500","31932660","31942350","31932780","38033520","31922350","31932480","31919900","31943930","31924410","31922750","31932970","38030280","31924980","31932730","31932790","31944060","31944220","31943990","31940020","31922380","31930060","38022850","31928500","31929090","31943820","38032410","31963190","38032530","38032190","38032040","38032400","38031690","31932090","38032540","31970150","38032170","38032730","38032510","31956160","31955690","31941490","31960080","31961310","31958790","31944860","31955560","31953820","31960730","31948560","31946320","31943360","31941480","31986440","31986530","31985500","31985480","38032240","31985530","38032330","31943970","31943830","38028590","31939330","31963380","31962070","30063250","38032680","31968940","31939530","31959870","31967950","38020320","31943870","31932560","31942480","31967810","31932840","38031930","31967990","31955810","31967850","38032070","31967920","31943840","31960250","31967820","31939850","31932230","38033420","31967710","31967890","31943910","31967720","31944030","31969980","31967740","31956740","31945790","31945810","31985550","31955540","31968780","31953470","31925480","38024560","31913630","31928450","38032760","38023640","32103580","31928160","38033570","39832780","38033490","38033620","30078620","31932380","31941620","31925210","38024110","31929230","38029860","31943980","38028550","31932710","31932630","31932430","31928910","38017310","31928810","31932300","31932530","31943900","39825390","31940680","31943940", "31954700","31927020","31931060","31931900","31953820","31942160","38033110","31938160","31943880","31939610","38029010","31928640","31940610","31946470","31960500","31946310","31941800","31944870","31945030","31956850","31941770","31967870","38019430","31924060","38031840","31941540","38017280","38018380","31930600","31959360","31949840","31955550","31947800","31955510","31950050","31952240","31953610","31950030","31938740","38026000","31926730","31926320","31945750","38032010","38022020","31955570","31932940","38032780","31932030","31938300","31932670","31937600","31967960","31939830","38026500","31932400","31953180","31956460","31932860","31967880","31950470","31942880","31937800","31954470","31956900","31950590","31947480","31951140","31942910","31964120","31939220","31959290","31964320","31938960","31954820","31956150","31940130","31953530","31953840","31941610","31937950","31946270","31937980","31944770","31953780","31937820","31943780","31943380","31948100","31954610","31963960","31973930","31976590","31980480","31984670","31966240","31966370","31985440","31967420","31967230","31972290","31980970","31984830","31984790","31927290","31928780","31900540","31938270","31931310","31926270","31929570","31955920","31928940","31931370","31924410","31929170","31930950","31924050","31959210","31942750","31920570","31906410","31959240","31955620","31956700","31913780","31913070","31937560","30071110","31959920","31953020","30075080","31981740","31958500","31969240","31969340","31939900","31978540","31948570","31962040","31956990","31969260","30076250","31908580","31923650","31918970","31931280","31929660","31911710","31914150","30035890","30038780","31903810","31911980","35412600","31916150","31900420","31912080","31905100","30077950","30047320","30064000","31902880","31900580","31939870","30045880","31931110","30045050","31910360","31937590","31903570","31911730","31920000","31901900","31912370","31922490","31904710","30031800","31900760","31909580","31929250","30035450","35315500","31911910","31908830","31906480","31908720","30031150","31903130","31902950","31905830","31938560","30035290","31906910","31927390","31905850","38019090","35415370","31902990","31900500","31947510","35418660","31911720","30060990","31930930","31910690","35293010","31949040","31909430","31920430","31944570","31925300","31923510","31953570","38030440","31900290","31915470","31907220","31931170","31931260","3192970 ","31931320","35418830","31924940","31900160","31944980","31953840","31920200","31930670","31931100","31951050","31950570","31986750","31984060","31986690","31955110","31973070","31967160","31968550","31975520","31959020","31955200","31957500","31969080","31954150","31984050","31967090","31954660","31970620","31986760","31986710","31958770","31970100","31985400","31905350","31915530","31942410"};
			if(("2019_303_event".equals(eventId)) && !Arrays.asList(empnos1).contains(emp)) { %>
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}
			query = "select to_char(CUTOFDTE,'dd-Mon-YYYY') cutOffDate,cast (MAXTICK as int) MAXTICK,MAXPRICE,EVTNME,NOOFMAXTICK,INDIV_TICK,BOARDINGPNT1 bpoints,ADDFIELD,ADMINEMP,EVT_ID,evt_for,bus_facility,to_char(evt_date ,'dd-Mon-yyyy') evt_date,evt_cat,age_criteria,evt_gen,email_body,PARTICIPENT_CRITERIA from workflow.nomination_admin where evt_id=? and cutofdte>=sysdate-1";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				eventEndDate = nullVal(rsMain.getString("cutOffDate"));
				maxTicksNo = rsMain.getInt("MAXTICK");
				maxPrize = nullVal(rsMain.getString("MAXPRICE"));
				noOfTicksEmp = nullVal(rsMain.getString("NOOFMAXTICK"));
				bPoints = nullVal(rsMain.getString("bpoints"));
				evtName = nullVal(rsMain.getString("EVTNME"));
				additionalFields = nullVal(rsMain.getString("addfield"));
				evt_for = rsMain.getString("evt_for");
				evt_date = nullVal(rsMain.getString("evt_date"));
				evt_cat = nullVal(rsMain.getString("evt_cat"));
				evt_gen = nullVal(rsMain.getString("evt_gen"));
				ageCriteria = nullVal(rsMain.getString("age_criteria"));
				ccEmps = nullVal(rsMain.getString("ADMINEMP"));
				emailBody = nullVal(rsMain.getString("email_body"));
				participentCriteria=nullVal(rsMain.getString("participent_criteria"));
			}
			if (!"".equals(emailBody))
				emailBody = emailBody.replaceAll("\n", "<br>");
			if (!"".equals(ccEmps)) {
				String[] ccEmpsMembers = ccEmps.split("\\,");

				ResultSet rsMail = null;
				String queryMail = "select email from empmaster where emp_no=?";
				PreparedStatement psMail = con.prepareStatement(queryMail);
				for (int i = 0; i < ccEmpsMembers.length; i++) {
					psMail.setString(1, ccEmpsMembers[i]);
					rsMail = psMail.executeQuery();
					if (rsMail.next())
						ccMail += "," + nullVal(rsMail.getString("email"));
				}
				if (rsMail != null)
					rsMail.close();
				if (psMail != null)
					psMail.close();
				if (!"".equals(ccMail))
					ccMail = ccMail.substring(1);
			}
			if (!"".equals(additionalFields)) {
				addFieldArr = additionalFields.split("-");
				//out.println(addFieldArr.length);
			}
			String[] evt_forArr = evt_for.split(",");
			for (int i = 0; i < evt_forArr.length; i++) {
				if (evt_forArr[i].equals("E"))
					isEmp = true;
				if (evt_forArr[i].contains("C") || evt_forArr[i].contains("S") || evt_forArr[i].contains("P")) {
					isDep = true;
					tempDep = "and relation_code in (";
					if (evt_forArr[i].contains("C")) {
						tempDep1 += ",'CH'";
					}
					if (evt_forArr[i].contains("S")) {
						tempDep1 += ",'SP'";
					}
					if (evt_forArr[i].contains("P")) {
						tempDep1 += ",'FA','MO'";
					}

				}
				if (evt_forArr[i].equals("O"))
					isOther = true;
			}
			if (!"".equals(nullVal(tempDep1))) {
				tempDep1 = tempDep1.substring(1);
				tempDep = tempDep + tempDep1 + ")";
			}
			query = "select count(ticktscnt) numVCl,sum(ticktscnt) tickCount from nomination where evtnme=? and flag in('A','S')";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {

				if (rsMain.getInt("numVCl") > 0) {
					tickRemNo = maxTicksNo - rsMain.getInt("tickCount");
				} else {
					tickRemNo = maxTicksNo;
				}
			}
			/*********************************Checking the Exclusive Events**********************/
			List<String> exclEvt = new ArrayList<String>();
			String keyExcl = "", valStr = "";
			//boolean isExclusiveEvt = false;
			query = "select key,EVENT_ID from nomination_exclusive where EVENT_ID = ?  or EVENT_ID  in(select EVENT_ID from nomination_exclusive where key = (select key from nomination_exclusive where EVENT_ID = ? ))";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, eventId);
			rsMain = psMain.executeQuery();
			while (rsMain.next()) {
				exclEvt.add(nullVal(rsMain.getString("EVENT_ID")));
				keyExcl = nullVal(rsMain.getString("key"));
			}
			if (exclEvt.size() > 0) {
				for (int i = 0; i < exclEvt.size(); i++) {
					valStr += ",'" + exclEvt.get(i) + "'";
				}
				valStr = valStr.substring(1);
			}
			if (!"".equals(keyExcl)) {
				query = "select evtnme,flag from nomination where emp_no=? and evtnme in(" + valStr + ")";

			} else {
				query = "select evtnme,flag from nomination where evtnme='" + eventId + "' and emp_no=? ";
			}
			psMain = con.prepareStatement(query);
			psMain.setString(1, emp);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				flg = nullVal(rsMain.getString("flag"));
			}
			if ("S".equals(flg)) {
	%>
	<%
		if (!"".equals(keyExcl)) {
	%>
	<script>
			alert("You have already Submitted your Nomination for the Same Event in one of the Show Timings available");
			window.location.href="mynomination1.jsp";
		</script>
	<%
		} else {
	%>
	<script>
			alert("You have already Submitted your Nomination for this Event");
			window.location.href="mynomination1.jsp";
		</script>
	<%
		}
	%>
	<%
		}
			if (("".equals(flg) || "X".equals(flg)) && tickRemNo <= 0) {
	%>
	<script>
			alert("Sorry, No more tickets available!!!!");
			window.location.href="home.jsp";
		</script>
	<%
		}
		}
		String additional_empList = "";
		if (!"".equals(eventId)) {
			if (bPoints.contains("MR"))
				buLocn = " and (bu like '48%' or bu like '47%' or bu ='10157026')";
			else if (bPoints.contains("VR"))
				buLocn = " and bu like '46%'";
			else if (bPoints.contains("MKTG"))
				buLocn = " and (bu not like '4%')";
			else
				buLocn = " and bu is not null";
		}
		if ("2019_166_event".equals(eventId)) { // for Employees and  having spouse
			//additional_empList = " and emp_no in ('31919150','31918180','39822720','31907930') ";
			additional_empList = " and relation_code='SP' and relation_code<>'SL'";
		}

		String qry = "select emp_no from empmaster where emp_no=? " + buLocn;
		PreparedStatement psLocn = con.prepareStatement(qry);
		psLocn.setString(1, emp);
		ResultSet rsLocn = psLocn.executeQuery();
		if (!rsLocn.next()) {
	%>
	<script>
		alert("You are Not Allowed to access this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}
		if ("".equals(ageCriteria))
			ageCriteria = "is not null";
		else
			ageCriteria = "between " + ageCriteria;
		if ("M".equals(evt_cat) && !"M".equals(empCategory)) {
	%>
	<script>
		alert("This Event is only for Management Employees");
		window.location.href="mainSubmit.jsp";
	</script>
	<%
		}
		if ("N".equals(evt_cat) && "M".equals(empCategory)) {
	%>
	<script>
		alert("This Event is only for Non-Management Employees");
		window.location.href="home.jsp";
	</script>
	<%
		}

		if ("M".equals(evt_gen) && !"M".equals(empGender)) {
	%>
	<script>
		alert("Only Men are Allowed for this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}
		if ("F".equals(evt_gen) && !"F".equals(empGender)) {
	%>
	<script>
		alert("Only Women are Allowed for this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}
		/*
		qry = "select emp_no from " + tempJdep + "jdep where emp_no =? " + additional_empList;
		psLocn = con.prepareStatement(qry);
		psLocn.setString(1, emp);
		rsLocn = psLocn.executeQuery();
		if (!rsLocn.next()) {
	%>
	<script>
		alert("This Event is Allowed only for Married Employees");
		window.location.href = "home.jsp";
	</script>
	<%
		} */
		String FlagUpdate = "", tempFlag = "";

		if ("submitted".equals(btnclkd) || "saved".equals(btnclkd)) {
			if ("submitted".equals(btnclkd))
				FlagUpdate = "S";
			else if ("saved".equals(btnclkd))
				FlagUpdate = "A";
			con.setAutoCommit(false);

			//*******Entry in master table*******/////
			query = "select flag from nomination where evtnme =? and emp_no =?";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, emp);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				tempFlag = nullVal(rsMain.getString("flag"));
			}
			if ("".equals(tempFlag)) {
				query = "insert into nomination (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,MODIFYDTE,FLAG,EMP_NO,EVTNME) values(?,?,?,sysdate,?,sysdate,'"
						+ FlagUpdate + "',?,?)";
			} else {
				if ("A".equals(tempFlag) || "X".equals(tempFlag)) {
					query = "update nomination set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,ENTERBY=?,MODIFYDTE=sysdate,FLAG='"
							+ FlagUpdate + "' where emp_no=? and evtnme=? ";
				} else
					return;
			}

			psMain = con.prepareStatement(query);
			psMain.setString(1, noOfTicks);
			psMain.setString(2, bPointEmp);
			psMain.setString(3, pAmount);
			psMain.setString(4, emp);
			psMain.setString(5, emp);
			psMain.setString(6, eventId);
			evtIns = psMain.executeUpdate();

			/*******Entry For Additional Columns*////////////

			query = "delete from nomination_emp_add where id in(select id from nomination_addition where evt_id=?) and emp_no=?";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, emp);
			psMain.executeUpdate();

			query = "insert into nomination_emp_add (id,value,emp_no,person_code) values(?,?,?,?)";
			psMain = con.prepareStatement(query);
			/* 		for(Map.Entry<String,String> entry:addMap.entrySet()){
						psMain.setString(1,entry.getKey());		
						psMain.setString(2,entry.getValue());		
						psMain.setString(3,emp);		
						psMain.executeUpdate();
					}
			 */ /*****To Insert Employee Additional Entry**********/

			for (Map.Entry<String, String> entry : addMapEmp.entrySet()) {
				psMain.setString(1, entry.getKey());
				psMain.setString(2, entry.getValue());
				psMain.setString(3, emp);
				psMain.setString(4, emp);
				psMain.executeUpdate();
			}

			/******To Insert Dependents Additional Entry*********/
			//out.println(addMapDep.toString());
			for (Map.Entry<String, String> entry : addMapDep.entrySet()) {
				String[] splitArr = (entry.getKey()).split("_");
				psMain.setString(1, splitArr[1]);
				psMain.setString(2, entry.getValue());
				psMain.setString(3, emp);
				psMain.setString(4, splitArr[0]);
				psMain.executeUpdate();
			}
			//int aa = 10; if(aa==10) return;

			/*******delete Entries in Dependent Table to Update Entries*////////
			String delQry = "delete from nomination_dependents where emp_no=? and event_name=?";
			PreparedStatement psDel = con.prepareStatement(delQry);
			psDel.setString(1, emp);
			psDel.setString(2, eventId);
			psDel.executeUpdate();
			
			// to check already applied and count for marathon event
			boolean errorEvent = false;
			if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
			psDel = con.prepareStatement("select count(*) from nomination_dependents where emp_no=? and event_name in (select evtnme from nomination where evtnme in ('2019_233_event','2019_234_event','2019_235_event') and flag='S' and emp_no=?)");
			psDel.setString(1, emp);
			psDel.setString(2, emp);
			rsMain = psDel.executeQuery();
			if(rsMain.next())
				count = rsMain.getInt(1);
			count += empEntry.size() + relCode.size();
			if(count > 4)
				errorEvent = true;
			
			psDel = con.prepareStatement("select * from nomination_dependents where event_name in (select evtnme from nomination where evtnme in ('2019_233_event','2019_234_event','2019_235_event') and flag='S' and emp_no=?) and child_name=?");
			psDel.setString(1, emp);
			}
			
			/////*********To Enter the entry of Employee*******/////
			query = "insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no,misc1) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate,?,?)";
			psMain = con.prepareStatement(query);

			count = 0;
			if (isEmp && empEntry.size() > 0) {
				String[] arrName = empEntry.get(0).split("#");
				if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
				psDel.setString(2, arrName[0]);
				rsMain = psDel.executeQuery();
				if(rsMain.next())
					errorEvent = true;
				}
				
				for (int i = 0; i < arrName.length; i++) {
					count++;
					psMain.setString(count, arrName[i]);
				}
				psMain.setString(6, eventId);
				psMain.setString(7, emp);
				psMain.setString(8, emp_contact);
				if ("2019_180_event".equals(eventId)) {
					psMain.setString(9, nullVal(empMisc1.get(0)));
				} else {
					psMain.setString(9, "");
				}

				psMain.addBatch();
			}
			count = 0;

			/****To Enter the JDE Dependents Entry ****/
			if (isDep && relCode.size() > 0) {
				for (int i = 0; i < relCode.size(); i++) {
					String[] arrName = relCode.get(i).split("#");
					if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
					psDel.setString(2, arrName[0]);
					rsMain = psDel.executeQuery();
					if(rsMain.next())
						errorEvent = true;
					}
					
					for (int j = 0; j < arrName.length - 1; j++) {
						count++;
						psMain.setString(count, arrName[j]);

					}
					count = 0;
					psMain.setString(6, eventId);
					psMain.setString(7, emp);
					for (Map.Entry<String, String> entry : depContactMap.entrySet()) {
						if (arrName[arrName.length - 1].equals(entry.getKey()))
							psMain.setString(8, entry.getValue());
					}
					if ("2019_180_event".equals(eventId)) {
						for (Map.Entry<String, String> entry1 : depMiscMap.entrySet()) {
							if (arrName[arrName.length - 1].equals(entry1.getKey()))
								psMain.setString(9, entry1.getValue());
						}
					} else {
						psMain.setString(9, "");
					}

					psMain.addBatch();
				}
			}
			boolean isRollBack = false;
			if(errorEvent) {
%>
		<script>alert("You have already applied for same event in other category");</script>
		<script> window.location.href="mynomination1.jsp"; </script>
<%
				con.rollback();
				isRollBack = true;
				return;
			}
			
			//********TO Enter the entry out of JDE Dependents*************************//
			if (isOther && othName.size() > 0) {
				for (int i = 0; i < othName.size(); i++) {
					if (!"".equals(othName.get(i))) {
						psMain.setString(1, othName.get(i));
						psMain.setString(2, othRel.get(i));
						psMain.setString(3, othGen.get(i));
						psMain.setString(4, othAge.get(i));
						psMain.setString(5, "");
						psMain.setString(6, eventId);
						psMain.setString(7, emp);
						psMain.setString(8, othContact.get(i));
						if ("2019_180_event".equals(eventId)) {
							psMain.setString(9, nullVal(depMisc1.get(i)));
						} else {
							psMain.setString(9, "");
						}

						psMain.addBatch();
					}
				}
			}
			int[] dataArr = psMain.executeBatch();
			if (dataArr.length == 0) {
				con.rollback();
				isRollBack = true;
			} else {
				con.commit();
				//con.rollback();
			}
			if (isRollBack) {
	%>
	<script>
				alert("Something went Wrong");
			//	window.location.href="mynomination1.jsp";
			</script>
	<%
		} else {
				if ("S".equals(FlagUpdate)) {

					String message = "", subject = "";
					subject = devMsgSub + "Event Nomination - ";
					if ("2018_133_event".equals(eventId)) {
						message = "You have successfully nominated for your team for the Event CORPORATE RANNEETI 6.0<br/><br/>Thank You, <br/><br/>CORPORATE RANNEETI 6.0 Team";

					} else {
						String newQryMail = "SELECT A.CHILD_NAME,B.PERSON_NAME,A.AGE,a.relatation,a.contact_no FROM NOMINATION_DEPENDENTS A LEFT JOIN "+tempJdep+"JDEP B ON A.EMP_NO=B.EMP_NO AND A.CHILD_NAME=B.PERSON_CODE where event_name=? and a.emp_no =?";
						PreparedStatement psMailBody = con.prepareStatement(newQryMail);
						psMailBody.setString(1, eventId);
						psMailBody.setString(2, emp);
						ResultSet rsMailBody = psMailBody.executeQuery();
						int newMailCount = 0;
						String tableMsg = "<table border=1><tr><th>Sr.No</th><th>Person Name</th><th>Age</th><th>Relation</th><th>Contact No</th></tr>";
						while (rsMailBody.next()) {
							newMailCount++;
							tableMsg += "<tr><td>" + newMailCount + "</td><td>"
									+ rsMailBody.getString("person_name") + "</td><td>"
									+ rsMailBody.getString("AGE") + "</td><td>" + rsMailBody.getString("relatation")
									+ "</td><td>" + rsMailBody.getString("contact_no") + "</td></tr>";
						}
						tableMsg += "</table>";
						message = "Your  request for <b>" + noOfTicks
								+ "</b> nominations for <b>" + evtName
								+ " </b> has been successfully registered, as per details given below-<br><br/> "+tableMsg+"<br/>"+emailBody+"<br/><br>Thank You ,<br/>" + "<br/>"
								+ "\"" + evtName + "\"" + " Team";
						
					}

					if (!"2018_126_event".equals(eventId) && evtIns > 0) {
						//String email_str = email.gen_email_call("APP208","D", " ",message,empMail,ccMail,"",subject+evtName+" ",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());				
						String email_str = email.gen_email_call("APP208", "D", " ", message,
								empMail,ccMail, "",
								subject + evtName + " ", request.getServerName(), "003", "EmployeeConnect@hpcl.in",
								request.getRemoteHost());
					}

				}
	%>
	<script>
			alert("Data Inserted Successfully");
			window.location.href="mynomination1.jsp";
			</script>
	<%
		}
		}
		count = 0;
		if (!"".equals(flg) || "A".equals(flg)) {
			PreparedStatement psEntry = null;
			ResultSet rsEntry = null;
			String DispQry = "select na.evtnme Event_Name,n.EMP_NO,n.TICKTSCNT,n.BOARDPNT,n.PAYMENTCNT,n.EVTNME from nomination_admin na left join nomination n on na.evt_id=n.evtnme where na.evt_id=? and n.emp_no=? and flag <> 'X'";
			psEntry = con.prepareStatement(DispQry);
			psEntry.setString(1, eventId);
			psEntry.setString(2, emp);
			rsEntry = psEntry.executeQuery();
			if (rsEntry.next()) {
				noOfTicks = rsEntry.getString("TICKTSCNT");
				bPointEmp = rsEntry.getString("BOARDPNT");
				pAmount = rsEntry.getString("PAYMENTCNT");

			}
			DispQry = "select child_name,contact_no from nomination_dependents where event_name=? and emp_no=?";
			psEntry = con.prepareStatement(DispQry);
			psEntry.setString(1, eventId);
			psEntry.setString(2, emp);
			rsEntry = psEntry.executeQuery();
			while (rsEntry.next()) {
				nominationList.add(rsEntry.getString("child_name"));
				nominationMap.put(rsEntry.getString("child_name"), rsEntry.getString("contact_no"));
			}
		}
	%>

	<div class="container" style="min-height: 465px;">
	<div class="row">
	<div class="col-sm-12 ">
		<form name="form1" method="post" action="mainSubmit.jsp"
			enctype="multipart/form-data">
			<input type="hidden" name="age_criteria" id="age_criteria"
				value="<%=ageCriteria%>">
			<div class="card md10 box-shadow border-success">
				<div class="card-header style-app-name" >
					<h5 class="text-white">
						New Event Nomination
						</h3>
				</div>
				<div class="card-body table-responsive">
					<table class="listTable" style="">
						<tr>
							<td width="20%" class="tdLbl1" style="padding: 10px;">Select
								the Event</td>
							<td style="padding: 10px;"><select name="eventId"
								id="eventId" class="form-control" onchange="return sfresh()"
								<%=!"".equals(eventId) ? "disabled" : ""%>>
									<option value="-1">Select</option>
									<%
										for (Map.Entry<String, String> entry : evtMap.entrySet()) {
									%>
									<option value="<%=entry.getKey()%>"
										<%=entry.getKey().equals(eventId) ? "selected" : ""%>><%=entry.getValue()%></option>
									<%
										}
									%>
							</select>
							
						<% if (!("".equals(eventId) || "-1".equals(eventId))) { %>
						<input type="hidden" class="select-field" name="eventId" id="eventId" value="<%=eventId%>" />
						<% } %>
							
							</td>
							<td style="padding: 10px;" class="tdLbl1">Date of Event</td>
							<%
								if ("2018_156_event".equals(eventId)) {
							%>
							<td style="padding: 10px;"><input type="hidden"
								name="evt_date" class="form-control" value="<%=evt_date%>"
								readonly> <span>25-Dec-2018 & 26-Dec-2018</span></td>
							<%
								} else {
							%>
							<td style="padding: 10px;">
								<%
									if (!("2019_172_event".equals(eventId) || "2019_173_event".equals(eventId)
												|| "2019_176_event".equals(eventId) || "2019_171_event".equals(eventId)
												|| "2019_175_event".equals(eventId) || "2019_174_event".equals(eventId))) {
								%> <input type="text" name="evt_date" class="select-field"
								value="<%=evt_date%>" readonly> <%
 	}
 %>
							</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td class="tdLbl1" style="padding: 10px;">No of Entries
								Required</td>
							<td style="padding: 10px;"><input type="number" readonly
								name="noOfTicks" id="tickReq" class="select-field"
								value="<%=noOfTicks%>"></td>
							<td class="tdLbl1" style="padding: 10px;">Enter the Boarding
								Point</td>
							<td style="padding: 10px;"><select name="bPointName"
								class="form-control" id="bPointName">
									<option value="-1">Select</option>
									<%
										boolean isBoarding = false;
										query = "select boarding_point,bus_facility from nomination_bp where evt_id=?";
										PreparedStatement psRow = con.prepareStatement(query);
										psRow.setString(1, eventId);
										ResultSet rsRow = psRow.executeQuery();
										if (rsRow.next()) {

											if ("Y".equals(nullVal(rsRow.getString("bus_facility")))) {
												isBoarding = true;
												if (!"".equals(nullVal(rsRow.getString("boarding_point")))) {
													String[] boardPt = nullVal(rsRow.getString("boarding_point")).split("\\,");
													for (int i = 0; i < boardPt.length; i++) {
									%>
									<option value="<%=boardPt[i]%>"
										<%=boardPt[i].equals(bPointEmp) ? "selected" : ""%>><%=boardPt[i]%></option>
									<%
										}
												}
											}
										}
									%>
									<option value="2" <%=!isBoarding ? "selected" : ""%>>Not
										Applicable</option>
							</select></td>
						</tr>

						<%
							int countRow = 0;
							String addQry = "";
							addQry = "select distinct a.evt_id, a.id, b.value, a.lbl_name, a.lbl_type, a.def_value, a.ISMANDATE from nomination_addition a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where  a.evt_id=? and a.level_type=? order by a.id";
							psRow = con.prepareStatement(addQry);
							psRow.setString(1, emp);
							psRow.setString(2, eventId);
							psRow.setString(3, "E");
							rsRow = psRow.executeQuery();
							while (rsRow.next()) {
								countRow++;
						%>
						<tr>
							<td class="tdLbl1"><%=rsRow.getString("lbl_Name")%><%=rsRow.getString("ISMANDATE").equals("Y") ? "<span style='color:red'>*</span>" : ""%><input
								type="hidden" name="isMandate" class="form-control"
								value="<%=rsRow.getString("ISMANDATE")%>"></td>
							<td colspan="3">
								<%
									if ("file".equals(rsRow.getString("lbl_type"))) {
								%> <input type="hidden"
								name="addition_Emp_<%=rsRow.getString("id")%>"
								id="addition_Emp_<%=rsRow.getString("id")%>"
								value="<%=nullVal(rsRow.getString("value"))%>" /> <input
								type="<%=rsRow.getString("lbl_Type")%>" class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
								name="fileaddition_Emp_<%=rsRow.getString("id")%>" /> <%
 	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
								target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
 	}
 %> <%
 	} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
 %> <textarea cols="100%" rows="2"
									class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="addition_Emp_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>

								<%
									} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
								%> <select name="addition_Emp_<%=rsRow.getString("id")%>"
								class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
									<option value="">Select</option>
									<%
										if (!"".equals(nullVal(rsRow.getString("def_value")))) {
													String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
													for (int i = 0; i < defValues.length; i++) {
									%>
									<option value="<%=nullVal(defValues[i])%>"
										<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
									<%
										}
												}
									%>
							</select> <%
 	} else {
 %> <input type="text"
								class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
								name="addition_Emp_<%=rsRow.getString("id")%>"
								value="<%=nullVal(rsRow.getString("value"))%>"> <%
 	}
 %>
							</td>
						</tr>
						<%
							}
							float percentVal = 0.0f;
						%>
						<tr>
							<td class="tdLbl1" style="padding: 10px;">
								<%
									if (!"2019_193_event".equals(eventId)) {
								%>Total Confirmatory Amount<%
									}
								%>
							</td>
							<td style="padding: 10px;"><input class="select-field"
								type="number" readonly name="pAmount" id="pAmount"
								value="<%=pAmount%>" /></td>
							<td class="tdLbl1" style="padding: 10px;">Remaining Tickets</td>
							<center>
								<span id="remTicks" style="display: none"><%=tickRemNo%></span><b></b><span
									style="display: none"><%=maxTicksNo%></span>
							</center>
							<td style="padding: 10px;"><div class="progress">
									<%
										percentVal = ((float) tickRemNo / (float) maxTicksNo) * 100;
									%>
									<div class="progress-bar progress-bar-striped bg-danger"
										style="width:<%=100.0f - percentVal%>%"><%=maxTicksNo - tickRemNo%></div>
									<div class="progress-bar progress-bar-striped bg-success"
										style="width:<%=percentVal%>%"><%=tickRemNo%></div>
								</div></td>
						</tr>
					</table>
				</div>
			</div>
			</center>
			<br />
			
			
			<%
				if (isEmp) {
			%>
			<!--<center><font size="4" class="tdLbl1"><b>Employee Details</b></font>-->
			<div class="card md-12 box-shadow border-success">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h5 class="text-white">
						Employee Details</b>
					</h2>
				</div>
				<div class="card-body table-responsive">
					<table class="table table-hover table-bordered listTable">
						<thead class="bg-default alert-primary ">
							<tr>
								<th>#</th>
								<th>&sect;</th>
								<th>Employee Name</th>
								<th>Age</th>
								<th>Date of Birth</th>
								<th>Gender</th>
								<th width="15%">Contact No.</th>
								<%
									psRow = con.prepareStatement(addQry);
										psRow.setString(1, emp);
										psRow.setString(2, eventId);
										psRow.setString(3, "A");
										rsRow = psRow.executeQuery();
										while (rsRow.next()) {
								%>
								<th><%=rsRow.getString("lbl_name")%></th>

								<%
									}
								%>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<th>Preferred Time Slot</th>
								<!--<th>Misc Col2</th>-->
								<%
									}
								%>
							
						</thead>
						<tbody>
							<%
								//**Entry of Employee**//
									query = "select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,contact_no from "
											+ tempJdep
											+ "jdep join empmaster using(emp_no) where emp_no=? and person_code =? and TRUNC((sysdate-(PERSON_DOB))/365) "
											+ ageCriteria;
									if ("2018_129_event".equals(eventId))
										query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
									if("M".equals(participentCriteria)){
										query +=" and gender ='M'";
									}if("F".equals(participentCriteria)){
										query +=" and gender ='F'";
									}
									psMain = con.prepareStatement(query);
									psMain.setString(1, emp);
									psMain.setString(2, emp);
									rsMain = psMain.executeQuery();
									while (rsMain.next()) {
										count++;
										String relation_string = rsMain.getString("person_code") + "#" + rsMain.getString("relation_code")
												+ "#" + rsMain.getString("gender") + "#" + rsMain.getString("age") + "#"
												+ rsMain.getString("rel_dob");
							%>
							<tr>
								<td><%=count%></td>
								<td><input type="checkbox" name="chkBoxEmp"
									value="<%=relation_string%>"
									<%="2019_285_event".equals(eventId) ? "style='display:none'" : ""%>
									id="chkEmp<%=count%>"
									onclick="return guidelineFun1(<%=count%>)"></td>
								<td><%=rsMain.getString("person_name")%></td>
								<!--<td><%=rsMain.getString("RELATION_CODE1")%></td>-->
								<td><%=rsMain.getString("AGE")%></td>
								<td><%=rsMain.getString("rel_dob")%></td>
								<td><%=rsMain.getString("gender1")%></td>
								<td><input type="text" name="emp_contact"
									class="select-field contact_no" id="emp_contact"
									value="<%=nullVal(rsMain.getString("contact_no"))%>"
									maxlength="13"></td>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<td><select name="empTimeSlot">
										<option value="07:30AM-04:00PM">07:30AM-04:00PM</option>
										<option value="07:30AM-01:00PM">07:30AM-01:00PM</option>
										<option value="07:30AM-10:30PM">07:30AM-10:30PM</option>
										<option value="01:00PM-04:00PM">01:00PM-04:00PM</option>
								</select></td>
								<%
									}
											psRow = con.prepareStatement(addQry);
											psRow.setString(1, emp);
											psRow.setString(2, eventId);
											psRow.setString(3, "A");
											rsRow = psRow.executeQuery();
											while (rsRow.next()) {
								%>
								<td>
									<%
										if ("file".equals(rsRow.getString("lbl_type"))) {
									%> <input type="hidden"
									name="addition_Emp_<%=rsRow.getString("id")%>"
									id="addition_Emp_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>" /> <input
									type="<%=rsRow.getString("lbl_Type")%>"
									class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="fileaddition_Emp_<%=rsRow.getString("id")%>" /> <%
 	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
									target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
 	}
 %> <%
										} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
									%> <textarea cols="100%" rows="2"
										class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
										name="addition_Emp_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
									<%
										} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
									%> <select name="addition_Emp_<%=rsRow.getString("id")%>"
									class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
										<option value="">Select</option>
										<%
											if (!"".equals(nullVal(rsRow.getString("def_value")))) {
																String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
																for (int i = 0; i < defValues.length; i++) {
										%>
										<option value="<%=nullVal(defValues[i])%>"
											<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
										<%
											}
															}
										%>
								</select> <%
 	} else {
 %> <input type="text"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>"
									name="addition_Emp_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>"> <%
 	}
 %>
								</td>
								<%
									}
								%>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<br />
			<!--Entry for Employee Details Close-->
			<!--Entry of JDE Dependents Open-->
			<%
				}
				if (isDep) {
			%>

			<div class="card mb10 box-shadow  border-success">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h5 class="text-white">Dependents Details</h5>
				</div>
				<div class="card-body">
					<div class="table-responsive">
					<table class="table table-hover table-bordered listTable " border="1">
						<!--<thead class="alert alert-primary">-->
							<tr>
								<th>#</th>
								<th>&sect;</th>
								<th>Dependent Name</th>
								<th>Relation</th>
								<th>Age</th>
								<th>Date of Birth</th>
								<th>Gender</th>
								<th width="15%">Contact No.</th>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<th>Preferred Time Slot</th>
								<%
									}
										psRow = con.prepareStatement(addQry);
										psRow.setString(1, emp);
										psRow.setString(2, eventId);
										psRow.setString(3,"A");
										
										rsRow = psRow.executeQuery();
										while (rsRow.next()) {
								%>
								<th><%=rsRow.getString("lbl_name")%></th>
								<%
									}
								%>
							</tr>
						<!--</thead>-->
						<tbody>
							<%
								count = 0;

									query = "select person_code,event_name,person_name,decode(j.gender,'M','Male','F','Female',j.gender)gender1,j.gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,nvl(nd.contact_no,' ') contact_no from  "
											+ tempJdep
											+ "jdep j left join empmaster e on j.emp_no=e.emp_no left join nomination_dependents nd on j.emp_no=nd.emp_no and j.person_code=nd.child_name and event_name=?  where j.emp_no=? and j.person_code<> ? "
											+ tempDep + "  and person_status_code ='AC' and TRUNC((sysdate-(PERSON_DOB))/365) "
											+ ageCriteria + " ";
									if ("2018_129_event".equals(eventId))
										query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
									
									
									if("M".equals(participentCriteria)){
										query +=" and j.gender ='M'";
									}if("F".equals(participentCriteria)){
										query +=" and j.gender ='F'";
									}	
									query += " order by person_code ";									
									psMain = con.prepareStatement(query);
									psMain.setString(1, eventId);
									psMain.setString(2, emp);
									psMain.setString(3, emp);
									rsMain = psMain.executeQuery();
									while (rsMain.next()) {
										count++;
										String relation_string = rsMain.getString("person_code") + "#" + rsMain.getString("relation_code")
												+ "#" + rsMain.getString("gender") + "#" + rsMain.getString("age") + "#"
												+ rsMain.getString("rel_dob") + "#" + count;
							%>
							<tr>
								<td><%=count%></td>
								<td><input type="checkbox" name="chkBox"
									value="<%=relation_string%>"
									<%=(nominationList.contains(rsMain.getString("person_code"))
							&& ("2018_126_event".equals(eventId))) ? "checked" : ""%>
									<%="2018_126_event".equals(eventId) ? "style = 'display:none'" : ""%>
									id="chk<%=count%>" onclick="return guidelineFun(<%=count%>)"></td>
								<td><%=rsMain.getString("person_name")%></td>
								<td><%=rsMain.getString("RELATION_CODE1")%></td>
								<td><%=rsMain.getString("AGE")%></td>
								<td><%=rsMain.getString("rel_dob")%></td>
								<td><%=rsMain.getString("gender1")%></td>
								<td><input type="text" class="select-field contact_no"
									name="dep_contact<%=count%>" id="dep_contact<%=count%>"
									value="<%=nullVal(rsMain.getString("contact_no"))%>"
									maxlength="13"></td>

								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<td><select name="depTimeSlot<%=count%>">
										<option value="07:30AM-04:00PM">07:30AM-04:00PM</option>
										<option value="07:30AM-01:00PM">07:30AM-01:00PM</option>
										<option value="07:30AM-10:30PM">07:30AM-10:30PM</option>
										<option value="01:00PM-04:00PM">01:00PM-04:00PM</option>
								</select></td>
								<%
									}
											psRow = con.prepareStatement(addQry);
											psRow.setString(1, emp);
											psRow.setString(2, eventId);
											psRow.setString(3,"A");
											rsRow = psRow.executeQuery();
											while (rsRow.next()) {
								%>
								<td>
									<%
										if ("file".equals(rsRow.getString("lbl_type"))) {
									%> <input type="hidden"
									name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									id="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>" /> <input
									type="<%=rsRow.getString("lbl_Type")%>"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="fileaddition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>" /> <%
 	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
									target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
 	}
 %> <%
										} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
									%> <textarea cols="100%" rows="2"
										class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
										name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
									<%
										} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
									%> <select name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
										<option value="">Select</option>
										<%
											if (!"".equals(nullVal(rsRow.getString("def_value")))) {
																String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
																for (int i = 0; i < defValues.length; i++) {
										%>
										<option value="<%=nullVal(defValues[i])%>"
											<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
										<%
											}
															}
										%>
								</select> <%
 	} else {
 %> <input type="text"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>"> <%
 	}
 %>
								</td>
								<%
									}
								%>


							</tr>
							<%
								}
							%>
							<input type="hidden" name="hidCountDep" id="hidCountDep"
								value="<%=count%>" />

						</tbody>
					</table>
					</div>
				</div>
			</div>
			<br />
			<%
				}
			%>
			<!--Entry of JDE Entries Close-->
			<!--Entry of Out of JDE Entries Open-->
			<%
				if (isOther) {
					String temp = "", PERSON_CD = "";
					int counttt = -1;
			%>
			<div class="card md-12 box shadow">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h2>Additional Requests</h2>
				</div>
				<div class="card-body table-responsive">
					<a title="Add" href="javascript:;" onclick="addEntry()"><img
						width="18" src="images/add1.png" /></a> <span class="v_t"
						style="margin-right: 100px">Add</span>
					<div class="datagrid">
						<table class="table table-hover table-bordered listTable"
							style="border-collapse: collapse;" id="ti_table">
							<thead class="alert alert-success">
								<tr class="lst">
									<th><center>&sect;</center></th>
									<th><center>Person Name</center></th>
									<th><center>Relationship</center></th>
									<th><center>Age</center></th>
									<th>Gender</th>
									<th>Contact No</th>
								</tr>
							</thead>

							<%
								/*query="select '' as child_name,'' as relatation,'' as age, '' as gender,'' as contact_no from dual union all select child_name,relatation,age,gender ,contact_no  from nomination_dependents  where emp_no=? and event_name=? and child_name not in (select person_code from "+tempJdep+"jdep)";
									psMain=con.prepareStatement(query);
									psMain.setString(1,emp);
									psMain.setString(2,eventId);
									rsMain=psMain.executeQuery();
									 while(rsMain.next()){
										counttt++;
									 	PERSON_CD=nullVal(rsMain.getString("child_name"));
									*/
									if (("").equals(PERSON_CD)) {
										temp = "#id#";
									}
									/* 	else{
											 temp = ""+counttt;		 
									     } */
							%>
							<tbody>
								<tr id="tr<%="#id#".equals(temp) ? "" : temp%>" class="tbodytr"
									style='<%="#id#".equals(temp) ? "display: none" : ""%>'>
									<td align="center"><a onclick="removeRow(<%=temp%>,this)"
										href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
									<td><center>
											<input type="text" name="person_name_add"
												id="person_name_add<%=temp%>" value="">
										</center></td>
									<td><center>
											<input type="text" name="rel_add" id="rel_add<%=temp%>"
												value="" />
											<center></td>
									<td><center>
											<input type="number" name="age_rel" maxlength="2"
												id="age_rel<%=temp%>" value=""
												onblur="return ageValid(this)">
										</center></td>
									<td><select name="gender_rel" id="gender_rel<%=temp%>">
											<option value="M">Male</option>
											<option value="F">Female</option>
									</select></td>
									<td><input type="text" name="contact_rel"
										id="contact_rel<%=temp%>" maxlength="13" value=""></td>
								</tr>
							</tbody>
							<%
								//}
							%>
						</table>
					</div>
				</div>
			</div>
			<input type=hidden id="leg_count" name="leg_count">
			<%
				}
			%>
			<!--Entry for Out of JDE entry close-->
			<% if (!("".equals(eventId) || "-1".equals(eventId))) { %>
			<div style="margin: 5%">
				<p
					<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))
						? "style ='display:none'"
						: ""%>>
					<input type="checkbox" id="checkval" name="checkval" value=""
						<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize)) ? "" : ""%>
						onclick="return chkAllow()"
						<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize)) ? "style='display:none'"
								: ""%>>
					<%
						if ("2019_193_event".equals(eventId)) {
					%>
					I hereby authorize recovery of amount selected through payroll
					towards confirmatory amount for PATHSHAALA LIBRARY & RESOURCE CENTRE.<b
						style=""><u><span id="ttt"><%=pAmount%></span></u></b>
					<%
						} else if (!"2019_180_event".equals(eventId)) {
					%>
					I hereby authorize recovery of (Rs. <b><u><span id="ttt"><%=pAmount%></span></u></b>)through
					payroll towards confirmatory amount for <b><u><%=evtName%></u></b>.
					In case of drop out, there shall be no refund.
					<%
						}
					%>
					<br />
					<%
						if ("2019_178_event".equals(eventId) || "2019_177_event".equals(eventId)) {
					%>
					Please ensure that the timing certficates is available with you as
					you will be required to submit the same.<br /> You would recieve a
					seperate email asking for the same at an appropriate time.
					<%
						} else if ("2019_180_event".equals(eventId)) {
					%>
					I hereby confirm my participation as volunteer at HP SAMPARK Inter
					Orphanage Sports on 13.4.2019.<b style="display: none"><u><span
							id="ttt"><%=pAmount%></span></u></b>
					<%
						}
					%>
					<br /> <br />
				<div
					<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"style ='display:none'":""%>
					id="pay_disclaimer">
					<marquee behavior="alternate">
						<span style="display: none"><b>Note:</b></span><span class="req"
							style="display: none"> Payment will be deducted from your
							salary through automated PTA. However you may edit your
							requirement of tickets till cut of date <%=eventEndDate%>.
						</span>
					</marquee>
					<br /> <br />
				</div>
				</p>
				<center>
					<!--<input type="submit" name="submitEvt" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":"style='display:none'"%>  id="submitEvt" value="Save" onclick="return submitEvtForm();">-->
					<input type="submit" name="SubmitConfirm"
						<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":"style='display:none'"%>
						id="submitEvt1" value="Confirm" class="style-right-button" onclick="return submitEvtForm1();">
				</center>
				
					<input type="hidden" name="maxTicks"
					id="maxTicks" value="<%=maxTicks%>" /> <input type="hidden"
					name="maxPrize" id="maxPrize" value="<%=maxPrize%>" /> <input
					type="hidden" name="noTicks" id="noMaxTicks"
					value="<%=noOfTicksEmp%>" /> <input type="hidden" name="ta"
					id="ta" value="<%=noOfTicks%>" /> <input type="hidden"
					name="otherTotEntry" id="otherTotEntry" /> <input type="hidden"
					name="bPoints" id="bPoints" value="<%=bPoints%>" /> <input
					type="hidden" name="evtName" value="<%=evtName%>" /> <input
					type="hidden" name="remTicks" id="tickCnt" value="<%=tickRemNo%>">
				<input type="hidden" name="action_type" value="" />
			</div>
			<%}%>
		</form>
		</div></div></div></br>
		
		<%@include file="footer.jsp"%>
		
		<!--<img src="images/p1.jpg" />-->
		<!--<a href="Marathon/index.jsp">For YPC Marathon-2019 ,Click here(Visakh Refinary,Non Management Employees)</a>-->
		<!--<div style="text-align: center; font-weight: bold; font-size: 20px;">
<span style="color: red;">For HP Marathon </span><a href="Marathon/" style="">Click Here</a>
</div>-->