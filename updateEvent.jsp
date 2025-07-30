<%@ include file="connection.jsp"%>

<div class="target_popup">
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
String evtnme="",cutofdte="",evtdte="",maxTickEmp="",priceTick="",totalTick="",evtfor="",evtcat="";
String adminEmp1="",adminEmp2="";
String id=request.getParameter("id");
String[] admins=new String[2];
String admin1="",admin2="";
Map<String,String> evtCatList=new HashMap<String,String>();
Map<String,String> evtForList=new HashMap<String,String>();
String query="select evtnme,to_char(cutofdte,'dd-Mon-yyyy') cutOffDate,to_char(evt_date,'dd-Mon-yyyy')evt_date,maxtick,maxprice,noofmaxtick,evt_for,evt_cat,substr(adminEmp,0,8) admin1,substr(adminEmp,10,18) admin2 from nomination_admin where evt_id=?";
PreparedStatement psEvt=con.prepareStatement(query);
psEvt.setString(1,id);
ResultSet rsEvt=psEvt.executeQuery();
if(rsEvt.next()){
	evtnme=nullVal(rsEvt.getString("evtnme"));
	cutofdte=nullVal(rsEvt.getString("cutOffDate"));
	maxTickEmp=nullVal(rsEvt.getString("noofmaxtick"));
	priceTick=nullVal(rsEvt.getString("maxprice"));
	evtfor=nullVal(rsEvt.getString("evt_for"));
	evtcat=nullVal(rsEvt.getString("evt_cat"));
	totalTick=nullVal(rsEvt.getString("maxtick"));
	evtdte=nullVal(rsEvt.getString("evt_date"));
	admins[0]=nullVal(rsEvt.getString("admin1"));
	admins[1]=nullVal(rsEvt.getString("admin2"));
	
}
query="select trim(emp_name) emp_name,emp_no from empmaster where emp_no=?";
psEvt=con.prepareStatement(query);
for(int i=0;i<admins.length;i++){
psEvt.setString(1,admins[i]);
rsEvt=psEvt.executeQuery();
	if(rsEvt.next()){
		if(i==0){
			adminEmp1=nullVal(rsEvt.getString("emp_name"))+"("+nullVal(rsEvt.getString("emp_no"))+")"  ;
		}else if(i==1){
			adminEmp2=nullVal(rsEvt.getString("emp_name"))+"("+nullVal(rsEvt.getString("emp_no"))+")";
		}	
	}
}
%>

<div>
<form name="form1" id="form1" > 	
	<center><table  class="listTable1" style="width:100%;border-collapse:collapse;">
		<tr><td class="tdLbl1">Event Name</td><td><input type="text" name="evtnme" id="evtnme" value="<%=evtnme%>"></td></tr>	
		<tr><td class="tdLbl1">Last Date to Apply</td><td><input type="text" name="cutofdte" class="datepicker" id="cutofdte" value="<%=cutofdte%>"></td></tr>
		<tr><td class="tdLbl1">Event Date</td><td><input type="text" name="evtdte" class="datepicker" id="evtdte" value="<%=evtdte%>"></td></tr>
		<tr>
			<td class="tdLbl1">Price per ticket</td><td><input type="text" name="priceevt" id ="priceevt" maxlength="5" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" value=<%=priceTick%>></td>
		</tr>
		<tr>	
			<td class="tdLbl1">Total Tickets for Event</td><td><input type="number" name="nooftickts" id ="nooftickts" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" value="<%=totalTick%>"></td>
		</tr>
		<tr>
			<td class="tdLbl1">Max Tickets per employee</td><td><input type="number" name="maxtickemp" id ="maxtickemp" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" value="<%=maxTickEmp%>"></td>
		</tr>
		<tr>
		<td class="tdLbl1">Event Category</td>
		<td>
		<input type="radio" name="evt_cat" class="evt_cat" value="M" <%=evtcat.indexOf("M") != -1?"checked":""%> />&nbsp; For Management Employees &nbsp;&nbsp;&nbsp;
		<input type="radio" name="evt_cat" class="evt_cat" value="N" <%=evtcat.indexOf("N") != -1?"checked":""%>   />&nbsp; For Non Management Employees &nbsp;&nbsp;&nbsp;
		<input type="radio" name="evt_cat" class="evt_cat" value="B" <%=evtcat.indexOf("B") != -1?"checked":""%> />&nbsp; Both 
		</td>
		</tr>
		<tr>
		<td class="tdLbl1">Event Available For</td>
		<td>
		<input type="checkbox" name="evt_for" class="evt_for" id="evt_for_E"   value="E" <%=evtfor.indexOf("E") != -1?"checked":""%>  />&nbsp;For Employees &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" name="evt_for" class="evt_for" id="evt_for_D"  value="D" <%=evtfor.indexOf("D") != -1?"checked":""%> />&nbsp;For Dependants &nbsp;&nbsp;&nbsp;&nbsp;
		<input type="checkbox" name="evt_for" class="evt_for" id="evt_for_O"  value="O" <%=evtfor.indexOf("O") != -1?"checked":""%> />&nbsp;Others 
		<input type="hidden" name="dummy">
		</td></tr>
		<tr>
			<td class="tdLbl1">First Admin For Event</td>
			<td>
				<input type="text" id="adminEmp" name="adminEmp" value="<%=adminEmp1%>" /></td>
		</tr>
		<tr>
			<td class="tdLbl1">Second Admin For Event</td>
			<td>
				<input type="text" id="adminEmp1" name="adminEmp1" value="<%=adminEmp2%>" />
			</td>
		</tr>		
		<tr>
			<td colspan="2"><center><input type="button" name="sbmt" id="sbmt" value="Submit" onclick="return SaveFun()" ></center></td>
		</tr>	
	</table></center>
	<input type="hidden" name="id" id="id" value="<%=id%>">
</div>

</div>
<script>
function SaveFun(){
		var adminVal=document.getElementById("adminEmp").value;
		if(""==adminVal){
			alert("Please Choose the Admin for the Event");	
			return false;
		}if(adminVal.indexOf("(")=='-1' || adminVal.indexOf("(")=='-1' ){
			alert("Please Enter the admin Name from the List Properly");
			return false;
		}
		if(!((adminVal.includes("3")) && (adminVal.includes("0")))){
			alert("Please Select admin From the List Properly");
			return false;
		}
		var adminVal1=document.getElementById("adminEmp1").value;
		if(""==adminVal1){
			alert("Please Choose Second Admin for the Event");	
			return false;
		}
		if(adminVal1.indexOf("(")=='-1' || adminVal1.indexOf("(")=='-1' ){
			alert("Please Enter the Second Admin Name from the List Properly");
			return false;
		}	
		if(!((adminVal1.includes("3")) && (adminVal1.includes("0")))){
			alert("Please Select admin From the List Properly");
			return false;
		}
		var dummy=null;
		var evtnme=$("#evtnme").val();
		var cutofdte=$("#cutofdte").val();
		var evtdte=$("#evtdte").val();
		var priceevt=$("#priceevt").val();
		var nooftickts=$("#nooftickts").val();
		var maxtickemp=$("#maxtickemp").val();
		var id_n=$("#id").val();
		var favorite = [];
        $.each($("input[name='evt_for']:checked"), function(){            
            favorite.push($(this).val());
        });
		var evt_for=favorite.join(",");
		var favorite1 = [];
        $.each($("input[name='evt_cat']:checked"), function(){            
            favorite1.push($(this).val());
        });
		var evt_cat=favorite1.join(",");
		//alert(evt_cat);
		var adminEmp=$('#adminEmp').val();
		adminEmp=(adminEmp.split("\("));
		adminEmp=adminEmp[1].substring(0,8);
		var adminEmp1=$('#adminEmp1').val();
		adminEmp1=(adminEmp1.split("\("));
		adminEmp1=adminEmp1[1].substring(0,8);
		admin=adminEmp+","+adminEmp1;
			/*type:"post",
			url:"updateEvent_save.jsp",
			data:{evtnme:evtnme,cutofdte:cutofdte,evtdte:evtdte,priceevt:priceevt,nooftickts:nooftickts,maxtickemp:maxtickemp,id:id},*/

	$.ajax({
	
	type:"post",
	url:"updateEvent_save.jsp",
	data:{evtnme:evtnme,cutofdte:cutofdte,evtdte:evtdte,priceevt:priceevt,nooftickts:nooftickts,maxtickemp:maxtickemp,id_n:id_n,admin:admin,evt_for:evt_for,evt_cat:evt_cat},
	
	success: function(jsonData) {
			//alert("111");
			
			jsonObj = JSON.parse(jsonData);
			if(jsonObj.status=="error") {
				alert(jsonObj.message);
			} else{
				alert("Data Updated Successfully");
				//window.location.href="editExistEvt.jsp";
			}
			
			window.setTimeout(function(){$( ".mfp-close" ).trigger( "click" );}, 2000);
		},
		error: function(jsonData, status, error){
			alert("Some error occured.");
			ajaxindicatorstop();
		}
	
	
	});
	}	
</script>
<script>
$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			dateFormat: "dd-M-yy",
			minDate: new Date(),
			
			
		});
</script>
<script>
jQuery(function(){
	$("#adminEmp").autocomplete( {
		source : "List.jsp",
		minLength: 3,
		
	});
});

jQuery(function(){
	$("#adminEmp1").autocomplete( {
		source : "List.jsp",
		minLength: 3,
		
	});
});

</script>