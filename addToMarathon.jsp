<%@ include file="connection.jsp"%>
<%String pcd=request.getParameter("pcd");
String id=request.getParameter("id");
PreparedStatement ps=null;
ResultSet rs=null;
String personName="",age="",pcode="",gender="",gend_desc="";
String query="select gender,trunc((sysdate-person_dob)/365) age,person_name from jdep where person_code=?";
ps=con.prepareStatement(query);
ps.setString(1,pcd);
rs=ps.executeQuery();
if(rs.next()){
	personName=rs.getString("person_name");
	age=rs.getString("age");
	gender=rs.getString("gender");
	if("F".equals(gender)){
		gend_desc="Female";
	}else if("M".equals(gender)){
		gend_desc="Male";
	}
}
%>
<div  class="target_popup">
<form name="frm">
<center>
	<table class="listTable" >
		<tr><th>Person Name:</th><td><%=personName%></td><th>Age:</th><td><%=age%></td><th>Gender:</th><td><%=gend_desc%></td></tr>
	</table>
</center>	
	<input type="hidden" name="personNo" id="pcd" class="pcd" value="<%=pcd%>" />
	<input type="hidden" name="age" id="age" class="age" value="<%=age%>" />
	<input type="hidden" name="gender" id="gender" class="gender" value="<%=gender%>" />
	
	<h3><font size="3px;">Please respond to the following questions before submitting your Application </font></h3>
	<div>
		<h5>Q. Has your Doctor ever said that you have a heart condition and that you should only do physical activity recommended  by Doctor ?<br/>
		<input type="radio" name="q1" value="Y" class="q1"> Yes &nbsp;
		<input type="radio" name="q1" value="N" class="q1"> No &nbsp;</h5>
	</div>
	<div>
		<h5>Q. Do you feel pain in your chest when you do physical activity ?<br/>
		<input type="radio" name="q2" value="Y" class="q2"> Yes &nbsp;
		<input type="radio" name="q2" value="N" class="q2"> No &nbsp;</h5>
	</div>
		<div>
		<h5>Q. In the past month, have you had chest pain when you were not doing any physical activity ?<br/>
		<input type="radio" name="q3" value="Y" class="q3"> Yes &nbsp;
		<input type="radio" name="q3" value="N" class="q3"> No &nbsp;</h5>
	</div>
	<div>
		<h5>Q. Do you lose your balance because of dizziness or do you ever lose consciousness ?<br/>
		<input type="radio" name="q4" value="Y" class="q4"> Yes &nbsp;
		<input type="radio" name="q4" value="N" class="q4"> No &nbsp;</h5>
	</div>
	<div>
		<h5>Q. Do you know of any other reason why you should not do physical activity ?<br/>
		<input type="radio" name="q5" value="Y" class="q5" > Yes &nbsp;
		<input type="radio" name="q5" value="N" class="q5" > No &nbsp;</h5>
	</div>
	<div>
		<h5>Q. Are you Diabetic ?<br/>
		<input type="radio" name="q6" value="Y" class="q6"> Yes &nbsp;
		<input type="radio" name="q6" value="N" class="q6"> No &nbsp;</h5>
	</div>
	<%if("F".equals(gender)){%>
	<div>
		<h5>Q. Are you Pregnant ?<br/>
		<input type="radio" name="q7" value="Y" class="q7"> Yes &nbsp;
		<input type="radio" name="q7" value="N" class="q7"> No &nbsp;</h5>
	</div>
	<%}%>
	<div>
		<h5>Q. Is your Doctor currently prescribing drugs for your blood pressure or heart condition?<br/>
		<input type="radio" name="q8" value="Y" class="q8"> Yes &nbsp;
		<input type="radio" name="q8" value="N" class="q8"> No &nbsp;</h5>
	</div>
	<div>
		<h5>Q. Do you have bone or joint problem that could be made worse by a chance in your physical activity?<br/>
		<input type="radio" name="q9" value="Y" class="q9"> Yes &nbsp;
		<input type="radio" name="q9" value="N" class="q9"> No &nbsp;</h5>
	</div>
	<center><input type="submit" name="saveEntry" value="Save" onclick="addEntry('Approve')"/></center>
	<input type="hidden" name="id" id="id" value="<%=id%>">
	</form>
</div>
<script>
function addEntry(action){
	//alert(action);
	var val1=$('input[name="q1"]:checked').val();
	var val2=$('input[name="q2"]:checked').val();
	var val3=$('input[name="q3"]:checked').val();
	var val4=$('input[name="q4"]:checked').val();
	var val5=$('input[name="q5"]:checked').val();
	var val6=$('input[name="q6"]:checked').val();
	var val7=$('input[name="q7"]:checked').val();
	var val8=$('input[name="q8"]:checked').val();
	var val9=$('input[name="q9"]:checked').val();
	var pcd=$(".pcd").val();
	//alert("submitted");
	var age=$(".age").val();
	var id=$("#id").val();
	var gender=$(".gender").val();
		$.ajax({
		type: "post",
		url: "addToMarathonPage.jsp",
		data: {val1:val1,val2:val2,val3:val3,val4:val4,val5:val5,val6:val6,val7:val7,val8:val8,val9:val9,pcd:pcd,age:age,gender:gender,action:action},		
		success: function(jsonData) {
			//alert(jsonData);
			location.href="marathon.jsp?personNo="+pcd+"&age="+age+"&gender="+gender+"&sts=Y&id="+id+"";
			$(".pcd"+pcd).show();			
			
		},
		error: function(jsonData, status, error){
			alert("Some error occured.");
			//ajaxindicatorstop();
		}
	});
		
}
</script>
