<html>
<%@ include file="header.jsp"%>
<head>
<link rel="stylesheet" href="css/magnific-popup.css">
<script type="text/javascript" src="js/jquery.magnific-popup.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>

<style>
.lst{
	background-color:#98B1CD;
	 border-spacing: 1px;
    border-collapse: separate;
	text-align:center;
	}
	.target_popup {position: relative; background: whiteSmoke; padding: 20px; width: auto; max-width: 800px; margin: 20px auto; box-shadow: 0 0 12px #fff; border-radius: 5px;}
</style>
<script>
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	var row = $("#tr").html();
	//console.log(row);
	var index = $("#ti_table tbody:first > tr").length;
	row = row.replaceAll("#id#", index);
	//alert(row);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	//alert($("#leg_count").val());
	recalculate()
}
function recalculate() {
    var i = 1;

    $(".numberRow").each(function() {
        $(this).find("strong").text(i++); 
	
    });
	
}
function validateNum(id1){
	var val1=parseInt((document.getElementById("age_rel"+id1)).value);
	//alert(val1);
	var select=document.getElementById("evtname_rel"+id1);
	
	//var val2=$("#evtname_rel"+id1);
	if(val1>=35){
	
		if(select.options.length>=1 && select.options.length<3){
		select.options[select.options.length] = new Option('Walkathon', 'W');
		}
	}else{
		//alert("bbbb");
			for (i=0;i<select.length;  i++) {
				if (select.options[i].value=='W') {
					select.remove(i);
				}
			}
	}
		
}
function proceedSave(){
	alert("aaad");
	document.form1.action_type.value="submit";
	document.form1.submit();
}
function guidelineFun(pcd){
	
	$(".pcd"+pcd).show();
}
function proceedAgree(eno){
	var val1=$('input[name="checkValue"]:checked').val();
	//alert(val1);
	if(val1=='Y'){
	$.ajax({
		type: "post",
		url: "declarationTime.jsp",
		data: {eno:eno},
		success: function(jsonData){
			location.href="mr1.jsp";
		},
		error: function(jsonData, status, error){
			alert("Some error occured.");
			
		}
	});
	}else{
		alert("Please check the Checkbox");
		return false;
	}
}
</script>

</head>
<body>
<form name="form1" action="mr1.jsp" method="post">

<br/>
<%
int count=0;
String action_type=request.getParameter("action_type");
out.println("test"+action_type);
PreparedStatement ps=null,ps1=null;
ResultSet rs1=null;
String emp_no = (String)session.getAttribute("login");
String ch1=request.getParameter("sh");
String ch2=request.getParameter("pcd");
String query="",query1="";
/*try{*/
	query="select person_code,person_name,decode(relation_code,'SL','Self','SP','Spouse','CH','Child',relation_code) relation_code,decode(gender,'M','Male','F','Female') gender,trunc((sysdate-person_dob)/365) age from jdep where emp_no='"+emp_no+"' and trunc((sysdate-person_dob)/365)>9 and trunc((sysdate-person_dob)/365)<60 order by person_code asc ";
	//out.println(query);
	ps=con.prepareStatement(query);
	//ps.setString(1,emp_no);
	rs1=ps.executeQuery();%>
	<center>
	<h3>Dependent Family Members</h3>
	<table border="1" style="border-collapse:collapse;width:70%;">
		<thead class="lst">
			<tr>
				<th>&sect;</th>
				<th>Person Name</th>
				<th>Relationship</th>
				<th>Age</th>
				<th>Gender</th>
				<th >#</th>
				<th >Event</th>
				<th >Running distance</th>
				<th >Medical Conditions</th>
				<th >Allergies</th>
				<th >First time Runner</th>
			</tr>
		</thead>
		<tbody>
			<%while(rs1.next()){count++;
			
			%>
			<tr>
				<td><%=count%><input type="checkbox" name="chkbox" id="chk<%=count%>" onclick="return guidelineFun(<%=rs1.getString("person_code")%>);" >
				</td>
				<input type="hidden" name="prCode" value="<%=rs1.getString("person_code")%>" >
				<td><%=rs1.getString("person_name")%></td>
				<td><%=rs1.getString("relation_code")%></td>
				<td><%=rs1.getInt("age")%>
				<input type="hidden" name="age" value="<%=rs1.getInt("age")%>">
				</td>
				<td><%=rs1.getString("gender")%>
				<input type="hidden" name="gender" value="<%=rs1.getString("gender")%>">
				</td>
				<td ><div><a href="addToMarathon.jsp?pcd=<%=rs1.getString("person_code")%>"  class="ajax_popup_link"><img src="images/edit.png" width="18"></a></div></td>
				
				<td >
					<select name="evtname" >
						<option value="-1">Select</option>
						<option value="M">Marathon</option>
						<%if(rs1.getInt("age")>=35){%>
						<option value="W">Walkaton</option>
						<%}%>	
					</select>
				</td>
				<td >
					<input type="radio" name="distance" value="2" class="dist">2 Kms. <br/>
					<input type="radio" name="distance" value="5" class="dist">5Kms. <br/>
					<input type="radio" name="distance" value="10" class="dist">10 Kms. <br/>
				</td>
				<td >
					<input type="text" name="med_cond" id="med_cond" value="">	
				</td>
				<td >
					<input type="text" name="allergies" id="Allergies" value="">
				</td>
				<td >
					<input type="radio" name="ftr" value="Y">Yes<br/>	
						
				</td>
				
				<%			
				
				%>
			</tr>
			<%}%>
		</tbody>
		</table>
		<br/>
		<h3>Other Family Members</h3>
		<div class="mb5">
<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t">Add</span>
		<div clas="datagrid">
			<table class="listTable" style="border-collapse:collapse;width:70%;" id="ti_table" border="1">
				<tr>
				<th><center>&sect;</center></th>
				<th><center>Person Name</center></th>
				<th><center>Relationship</center></th>
				<th><center>Age</center></th>
				<th >Gender</th>
				<th>Event</th>
				<th>Running distance
				<th>Medical Conditions
				<th>Allergies</th>
				<th>First time Runner</th></tr>
				<tbody>
<%

%>				
				<tr id="tr" style="display:none">
					<td align="center"><span class="numberRow"><strong></strong></span></td>
					<!--<td align="center">
					<a onclick="removeEntry(<%="#id#"%>)" href="javascript:;"><img src="images/delete1.png" width="18" /></a></td>-->
					<td><center><input type="text" name="person_name_add" id="person_name_add<%="#id#"%>"></center></td>
					<td><center><input type="text" name="rel_add"  id="rel_add<%="#id#"%>" /><center></td>
					<td><center><input type="number" name="age_rel" onblur="return validateNum(<%="#id#"%>)"  id="age_rel<%="#id#"%>"></center></td>
					<td>
					<select name="gender_rel">
						<option value="m">Male</option>
						<option value="f">Female</option>
					</select>
					</td>
					<td>
					<select name="evtname_rel" id="evtname_rel<%="#id#"%>">
						<option value="-1">Select</option>
						<option value="M">Marathon</option>
						<!--<option value="W">Walkathon</option>-->
						
					</select>
				</td>
				<td>
					<input type="radio" name="distance_rel" value="2" class="dist_rel">2 Kms. <br/>
					<input type="radio" name="distance_rel" value="5" class="dist_rel">5 Kms. <br/>
					<input type="radio" name="distance_rel" value="10" class="dist_rel">10 Kms. <br/>
				</td>
				<td >
					<input type="text" name="med_cond_rel" id="med_cond_rel<%="#id#"%>" value="">	
				</td>
				<td >
					<input type="text" name="allergies_rel" id="Allergies_rel<%="#id#"%>" value="">
				</td>
				<td >
					<input type="radio" name="ftr_rel" class="ftr_rel<%="#id#"%>" value="Y">Yes<br/>	
					<!--<input type="radio" name="ftr_rel" class="ftr_rel<%="#id#"%>" value="N">No--><br/>	
				</td>	
				</tr>
</tbody>	
			
			</table><br/>
			
			
		</div>
		
</div>	
<%int cnt=0,sau=0;
if("submit".equals(action_type)){
	String []chkbox=request.getParameterValues("chkbox");
	String []prCode=request.getParameterValues("person_name_add");
	String []age=request.getParameterValues("age_rel");
	String []gender=request.getParameterValues("gender_rel");
	String []evtname=request.getParameterValues("evtname_rel");
	String []distance=request.getParameterValues("distance_rel");
	String []med_cond=request.getParameterValues("med_cond_rel");
	String []allergies=request.getParameterValues("allergies_rel");
	String []ftr=request.getParameterValues("ftr_rel");
	for(int i=0;i<prCode.length;i++){
		out.println("saurabh "+prCode[i]);
	}
	String query2="insert into nm_marathon (PERSON_CODE,GENDER,AGE,UPDATED_DATE,RUNNING_MODE,MED_CONDITION,ALLERGIES,FIRST_TIME_RUNNER,DECLARATION_DATE,DECLARATION_STATUS,UPDAETD_BY) values(?,?,?,sysdate,?,?,?,'Y',sysdate,'Y',?)";
	PreparedStatement psIns=con.prepareStatement(query2);
	for(int i=0;i<prCode.length-1;i++){
		sau++;
		out.println("aaa"+prCode[i]);
		out.println("bb"+sau);
		psIns.setString(1,prCode[i]);
		psIns.setString(3,age[i]);
		psIns.setString(2,gender[i]);
		psIns.setString(4,evtname[i]);
		//psIns.setString(5,distance[i]);
		psIns.setString(5,med_cond[i]);
		psIns.setString(6,allergies[i]);
		//psIns.setString(7,ftr[i]);
		psIns.setString(7,emp_no);
		cnt=psIns.executeUpdate();
	}
	if(cnt>0){%>
		<script>
			alert("Data Inserted Successfully");
		</script>
	<%}
}
%>
		<!--<a href="#guideline"  class="inline_popup" >View Declaration</a>

		<div id="guideline" class="target_popup mfp-hide">
<center><h3>Declaration</h3></center>

I/my Ward hereby declare, confirm and agree as below..
<ol>
<li> The information given by me/my ward in this entry form is true and I am solely responsible for the accuracy of this information;</li>

<li>I have fully understood the risk and responsibility of participating in the HPCL Reboot Marathon 2017 event and will be participating entirely at my risk and responsibility for Self and each of my participants.</li>

<li>I understand the risk of participating in a Marathon.</li>

<li> I understand that I/my ward must be trained to an appropriate level of fitness to participate in such a physically demanding event and I/my ward have obtained a medical clearance from a registered medical practitioner, allowing me to participate in the event.</li>

<li> For myself/ourselves and our legal representatives, waive all claim of whatsoever nature against any and all sponsors of the event, HPCL and all other person and entities associated with the event and the directors. Employees, agent and respective of all or any of the aforementioned including, but not limited to, any claims that might result from me/my ward participating in the event and whether on account of illness, injury, death or otherwise.</li>

<li>Agree that if I am/my ward is injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to at my/our risk and cost, transport me/my ward to a medical facility and or to administer emergency medical treatment and I/my ward waive all claim that might result from such transport and or treatment or delay or deficiency therein. I shall pay or reimburse to you my/my ward's medical and emergency expenses and I/my ward hereby authorizes you to incur the same.</li>

<li> Shall provide to race official such medical data relating to me/my ward as they may request, I agree that nothing herein shall oblige the event official or organizers or any other person to incur any expense to provide any transport or treatment.</li>

<li> In case of any illness or injury caused to me or my ward or death suffered by me or my ward due to any force majeure event including but not limited to fire, riots or other civil disturbances, earthquake, storms, typhoons or any terrorist, none of the sponsors of the event or any political entity or authorities and official or any contractor or construction firm working on or near the course, or any person or entities associated with event or the directors, employee, agents or representative of all or any of the aforementioned shall be held liable by me/my ward or me/my ward's representative.</li>

<li>Understand, agree and irrevocably permit HPCL to share the information given me/my ward's in this application, with all/any entities associated with the HPCL Reboot Marathon 2017, at its own discretion.</li>

<li>Understand, agree and irrevocably permit HPCL Reboot Marathon 2017 to use my/my ward's photograph which may be photographed on the day of the event, for the sole purpose of promoting the HPCL Reboot Marathon 2017, at its own discretion;</li>

<li>Shall not hold the Organizers and all/any of the event sponsors responsible for loss of my/his/her entry form and</li>

<li>I/my ward understand and agree to the event terms and guidelines.</li>

<li> Race timing certificates / Link to the same would be displayed on the HPCL Event Nomination portal.</li>

<li>Winner will be decided based on Gun Time and Race Marshall's decision will be final.</li>
</ol>

<div><input type="checkbox" name="checkValue" value="Y" id="cls" class="cls" ><b>I Agree the Terms and Conditions.</b>
<br>
<center><input type="button" onclick="return proceedAgree(<%=emp_no%>)" value="Proceed" /></center>
</div>
</div>-->
<%

/*}catch(Exception e){
	e.printStackTrace();
}*/
%>

<input type="text" name="action_type" value=""/>
<center><input type="submit" name="submit" value="Submit" onclick="return proceedSave();"   /></center>
</form>
</div>
</body>
<script>
  $(function() {
	$('.ajax_popup_link').magnificPopup({ type: 'ajax', });
	$('.inline_popup').magnificPopup({ type: 'inline', });
  });
</script>
</html>
