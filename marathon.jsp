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
	var val1=parseInt(id1)
		
}

function guidelineFun(pcd){
	var alert="success";
	$(".pcd"+pcd).show();
}
function openpopup(){
	var emp_no=document.getElementById("emp_no").value;
	//alert(emp_no);
	location.href="popup.jsp?emp_no="+emp_no+"";
}
$(document).ready(function() {
	var sts=document.getElementById("sts").value;
	var id=document.getElementById("id").value;
	//alert(sts);
	if(sts=='Y'){
		document.getElementById("type"+id).disabled=false;
		document.getElementById("distance"+id).disabled=false;
		document.getElementById("med_cond"+id).disabled=false;
		document.getElementById("Allergies"+id).disabled=false;
		document.getElementById("ftr"+id).disabled=false;
	}
});
</script>
</head>
<body>
<div id="page">
<form name="form1" action="marathon.jsp" method="post">
<input type="hidden" name="action_type" value=""/>
<br/>
<%
int count=0;
PreparedStatement ps=null,ps1=null;
ResultSet rs1=null;
String sts=request.getParameter("sts");
String id=request.getParameter("id");
String emp_no = (String)session.getAttribute("login");
String query="",query1="";
try{
	query="select person_code,person_name,decode(relation_code,'SL','Self','SP','Spouse','CH','Child',relation_code) relation_code,decode(gender,'M','Male','F','Female') gender,trunc((sysdate-person_dob)/365) age from jdep where emp_no='"+emp_no+"' and trunc((sysdate-person_dob)/365)>9 and trunc((sysdate-person_dob)/365)<60 order by person_code asc ";
	//out.println(query);
	ps=con.prepareStatement(query);
	//ps.setString(1,emp_no);
	rs1=ps.executeQuery();%>
	<center>
	<h3>Dependents List	</h3>
	<table border="1" style="border-collapse:collapse;width:70%;">
		<thead class="lst">
			<tr>
				<th>&sect;</th>
				<th>Person Name</th>
				<th>Relation </th>
				<th>Age</th>
				<th>Gender</th>
				<th>Participation In</th>
				<th>Distance</th>
				<th>Medical Conditions</th>
				<th>Allergies</th>
				<th>First time Runner</th>
			</tr>
		</thead>
		<tbody>
			<%while(rs1.next()){count++;%>
			<tr>
				<!--<td><%=count%><input type="checkbox" name="chkbox" id="chk<%=count%>" onclick="return guidelineFun(<%=rs1.getString("person_code")%>);" value="<%=rs1.getString("person_code")%>"></td>-->
				<td ><div><a href="addToMarathon.jsp?pcd=<%=rs1.getString("person_code")%>&id=<%=count%>"  class="ajax_popup_link"><!--<img src="images/checked.png" width="18"></a>-->Nominate</div></td>
				<td><%=rs1.getString("person_name")%></td>
				<td><%=rs1.getString("relation_code")%></td>
				<td><%=rs1.getInt("age")%></td>
				<td><%=rs1.getString("gender")%></td>
				<td class="pcd<%=rs1.getString("person_code")%>">
					<select name="type" id="type<%=count%>" disabled>
						<option value="-1">Select</option>
						<option value="M">Marathon</option>
						<%if(rs1.getInt("age")>=35){%>
						<option value="W">Walkathon</option>
						<%}%>	
					</select>
				</td>
				<td class="pcd<%=rs1.getString("person_code")%>">
					<input type="radio" id="distance<%=count%>" name="distance" value="3" class="dist" disabled>3 Kms. <br/>
					<input type="radio" id="distance<%=count%>" name="distance" value="7" class="dist" disabled>7Kms. <br/>
					<input type="radio" id="distance<%=count%>" name="distance" value="10" class="dist" disabled>10 Kms. <br/>
				</td>
				<td  class="pcd<%=rs1.getString("person_code")%>">
					<textarea name="med_cond" id="med_cond<%=count%>" cols="15" rows="3" disabled></textarea>	
				</td>
				<td  class="pcd<%=rs1.getString("person_code")%>">
					<textarea name="allergies" id="Allergies<%=count%>" cols="15" rows="3" disabled></textarea>
				</td>
				<td  class="pcd<%=rs1.getString("person_code")%>">
					<input type="radio" name="ftr" id="ftr<%=count%>" value="Y" disabled>Yes&nbsp;&nbsp;<input type="radio" name="ftr" id="ftr<%=count%>" value="N" disabled>No<br/>	
				</td>
				
				
			</tr>
			<%}%>
		</tbody>
		</table>
		<br/>
		
		<br/>
		<h3>For Addition Members</h3>
		<div class="mb5">
<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/edit.png" /></a>
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
					<td><center><input type="number" name="age_rel" onkeyup="return validateNum(<%="#id#"%>)"  id="age_rel<%="#id#"%>"></center></td>
					<td><center><input type="text" name="gender_add"  id="gender_add<%="#id#"%>" /></center></td>
					<td>
					<select name="evtname_rel" id="evtname_rel<%="#id#"%>">
						<option value="-1">Select</option>
						<option value="M">Marathon</option>
						<option value="W">Walkaton</option>
						
					</select>
				</td>
				<td>
					<input type="radio" name="distance_rel" value="3" class="dist_rel">3 Kms. <br/>
					<input type="radio" name="distance_rel" value="7" class="dist_rel">7Kms. <br/>
					<input type="radio" name="distance_rel" value="10" class="dist_rel">10 Kms. <br/>
				</td>
				<td >
					<input type="text" name="med_cond_rel" id="med_cond_rel<%="#id#"%>" value="">	
				</td>
				<td >
					<input type="text" name="allergies_rel" id="Allergies_rel<%="#id#"%>" value="">
				</td>
				<td >
					<input type="radio" name="ftr" class="ftr_rel<%="#id#"%>" value="Y">Yes<br/>	
					<input type="radio" name="ftr" class="ftr_rel<%="#id#"%>" value="N">No<br/>	
				</td>	
				</tr>
</tbody>	
			
			</table><br/>
			
			
		</div>
		
<%

}catch(Exception e){
	e.printStackTrace();
}
%>
<input type="hidden" name="emp_no" id="emp_no" value="<%=emp_no%>">
<input type="hidden" name="sts" id="sts" value="<%=sts%>">
<input type="hidden" name="id" id="id" value="<%=id%>">
<center><input type="submit" name="submit" value="Proceed"  class="ajax_popup_link" onclick="openpopup();"/></center>
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
