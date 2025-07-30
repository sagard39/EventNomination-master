<%@ include file = "header1.jsp"%>
<link href="css/select2.min.css" rel="stylesheet" />
<script type="text/javascript" src="js/select2.min.js"></script>
<link rel="stylesheet" href="css/datepicker.css">
<script src="js/bootstrap-datepicker.js"></script>

<style>
.tdLbl{
	 color:#18568e;
	font-size :13px;
	font-weight:bold;
	font-face:Times New Roman;	
}
</style>
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



function boardingPnt(){
		var bPoints=$("#pickPnts").val();
		if(bPoints==''){
			alert("Please Select the Borading Points for the Event");
			return false;
		}else{
			$("#newDiv").show();
			$("#bpAddit").hide();
			$("#bPval2").val(bPoints);
			$("#newDiv").append('<span name="bPnt" id="bPnt">'+bPoints+'</div>');
			$( ".mfp-close" ).trigger( "click" );
				return false;
		}	
}

</script>
<script>
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	var row = $("#tr").html();
	//console.log(row);
	var index = $("#ti_table tbody:first > tr").length;
	/*if(index>3){
		alert("maximum 3 Rows are Allowed");
		return false;
	}*/
	row = row.replaceAll("#id#", index);
	//alert(row);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	recalculate()

	

}
function removeRow(id,aid) {
	var row = $("#tr").html();
	$("#tr"+id).remove();
	var index = $("#ti_table tbody:first > tr").length;
	 row = row.replaceAll("#id#", index-1);
	
	$("#leg_count").val(index-1);

}
function recalculate() {
    var i = 1;

    $(".numberRow").each(function() {
        $(this).find("strong").text(i++); 
	
    });
	
}function toggleHist(obj) {
	if(obj.src.indexOf("expand") > -1) {
		obj.src = obj.src.replace("expand","collapse");
	} else {
		obj.src = obj.src.replace("collapse","expand");
	}
	$("#hist_table").toggle("blind", {}, 500);
}

/*jQuery(function(){
	
$("#adminEmp").autocomplete("List.jsp");

});
jQuery(function(){
	
$("#adminEmp1").autocomplete("List.jsp");


});*/
function delrec(r,a){
	location.replace('editevent1.jsp?del='+r+'&twn='+a);
}
function editrec(evtnme,evtplace,cutofdte,priceevt,nooftickts,indi_tickets) {
      $('#evtnme').val(evtnme);
	  $('#hidevtnme').val(evtnme);
	  $('#hidevtplace').val(evtplace);
	  var dataarray=evtplace.split(",");
	  $("#evtplace").val(dataarray);
	  $('#cutofdte').val(cutofdte);
	  $('#priceevt').val(priceevt);
	  $('#nooftickts').val(nooftickts);
	  $('#maxtickemp').val(indi_tickets);
	  $('#showupdate').show();
	  $('#submit2').hide();
}


function chkVals(Obj){
	var chk1ValChange=Obj.value;
	if(chk1ValChange=="Y"){
		if(!confirm("Do You want to Add Addition Fields for This Event?"))
			return false;
		
	else{
		if(chk1ValChange=="Y"){
			$(".chkValDiv").show();
		}else{
			$(".chkValDiv").hide();
		}
	}
	}else if(chk1ValChange=="N"){
		$(".chkValDiv").hide();
	}	
}
function getFldName(Obj){
	var val1=Obj.value;
	if(val1=='misc1'){
		$(".miscShow1").toggle();
	}if(val1=='misc2'){
		$(".miscShow2").toggle();
	}if(val1=='misc3'){
		$(".miscShow3").toggle();
	}
	
}
</script>
<script type="text/javascript">
$( document ).ready(function() {
  $('.selectNew').select2();
});
function getLocnBy(Obj){
	var locnBy=Obj.value;
	if(locnBy=='t'){
		$('#evtplace').select2({
    tags: true,
    multiple: true,
    tokenSeparators: [',', ' '],
    minimumInputLength: 3,
    //minimumResultsForSearch: 10,
    ajax: {
        url: "townLocnName.jsp",
        //dataType: "json",
        type: "Post",
        data: function (params) {
            var queryParameters = {
                term: params.term
            }
            return queryParameters;
        }, 
		processResults: function (data) {
            var myResults = [];
            jsonObj = JSON.parse(data);
						for(var i = 0; i < jsonObj.length; i++) {
                myResults.push({
                    'id': jsonObj[i].id,
                    'text': jsonObj[i].text
                });
            }
            return {
                results: myResults
            };
        }
  }
});
		$("#divTown").show();
		$("#divBu").hide();
	}
	if(locnBy=='b'){
		$('#buDesc').select2({
    tags: true,
    multiple: true,
    tokenSeparators: [',', ' '],
    minimumInputLength: 3,
    //minimumResultsForSearch: 10,
    ajax: {
        url: "townLocn.jsp",
        //dataType: "json",
        type: "Post",
        data: function (params) {
            var queryParameters = {
                term: params.term
            }
            return queryParameters;
        }, 
		processResults: function (data) {
            var myResults = [];
            jsonObj = JSON.parse(data);
						for(var i = 0; i < jsonObj.length; i++) {
                myResults.push({
                    'id': jsonObj[i].id,
                    'text': jsonObj[i].text
                });
            }
            return {
                results: myResults
            };
        }
  }
});
		$("#divBu").show();
		$("#divTown").hide();
	}
}
</script>
<script>
function validation(){
	//val bus_req=$('input[name="bus_req"]:checked').length;

	var evtnme = document.getElementById("evtnme").value;
	if("" == evtnme){
		alert("Enter Event Name");
		return false;
	} 
		var evt_gen=$('input[name="evt_gen"]:checked').length;
	if(evt_gen<1){
		alert("Please Select the Event Category(Gender)");
		return false;
	}

	var evtplace = document.getElementById("evtplace").value;
	var evtBu = document.getElementById("buDesc").value;
	if("" == evtplace && "" == evtBu){
		alert("Select Event Place");
		return false;
	}
	var minAge=document.getElementById("minAge").value;
	if(minAge=='-1'){
		alert("Please select the Minimum Age for Event");
		return false;
	}
	var maxAge=document.getElementById("maxAge").value;
	if(maxAge=='-1'){
		alert("Please select the Maximum Age for Event");
		return false;
	}

	var evt_date = document.getElementById("evt_date").value;
	if("" == evt_date){
		alert("Please select the Event Date ");
		return false;
	}
	var cutofdte = document.getElementById("cutofdte").value;
	if("" == cutofdte){
		alert("Select last Date ");
		return false;
	}
	
	var priceevt = document.getElementById("priceevt").value;
	if("" == priceevt || "0" == priceevt ||"0.0" == priceevt){
		alert("Total Payment cannot be 0");
		return false;
	}
	var nooftickts = document.getElementById("nooftickts").value;
	if("" == nooftickts || "0" == nooftickts ||"0.0" == nooftickts){
		alert("No. of Tickets cannot be 0");
		return false;
	}
	var maxtickemp=document.getElementById("maxtickemp").value;
	if("" == maxtickemp || "0" == maxtickemp ||"0.0" == maxtickemp){
		alert("Total Tickets Can not Be Zero");
		return false;
	}	
	var evt_for=$('input[name="evt_for"]:checked').length;
	if(evt_for<1 ){
		alert("Please Check one checkbox");
		return false;
	}
	var bus_req=$('input[name="bus_req"]:checked').length;
	if(bus_req<1){
		alert("Please choose the Bus Required");
		return false;
	}
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
	var evt_cat=$('input[name="evt_cat"]:checked').length;
	if(evt_Cat<1){
		alert("Please Select the Event Category");
		return false;
	}
	if(!confirm("Do you really want to submit the Event ??"))	
		return false;
	else
		return true;
	
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
		String id  = nullVal(request.getParameter("id"));
					//String pickPoints="";
		//String eventDate="",evt_date_to="",field2="",field3="",field1="",evt_cat="",evt_gen="",evtFilter="";				
		PreparedStatement psdet = null,psEvtId=null,psBusReq=null;
		ResultSet rsdet = null,rsEvtId=null,rsBusReq=null;
		HashMap <String,String> hmsbu = new HashMap <String,String>();
		List<String> typeList=new ArrayList<String>();
		typeList.add("-1");
		typeList.add("text");
		typeList.add("file");
		typeList.add("Dropdown");
		typeList.add("Number");
		
		String key = "", value = "";
		DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
		Date today = Calendar.getInstance().getTime();
		String createdDt = df.format(today);
		List<String> fieldList=new ArrayList<String>();
		String evt_id="";
		int evt_id1=0;
		Statement st=con.createStatement();
		ResultSet rsId=null;
		Map<String,String> buMap=new HashMap<String,String>();
		//List<String> buNameList=new ArrayList<String>();
	/*try{*/
		if("".equals(id)){
		  rsId=st.executeQuery("select max(cast (substr(evt_id,6,3) as int)) maxId from nomination_admin");
		  if(rsId.next() && rsId.getString("maxId")!=null){
		  	evt_id1=rsId.getInt("maxId")+1;
		  	evt_id=1900+today.getYear()+"_"+evt_id1+"_event";
		  }	
		  else
		  	evt_id=1900+today.getYear()+"_101_event";
		} else {
			evt_id = id;
		}	
		String cutoffdt1="",maxTicksTotal = "",maxPrz= "",perTicks="",evtNameEvt="",addFields1 = "",adminEmpTab = "",evtType= "",busReq= "",evtDateFrom= "",isEvtBU = "",statusCurr = "",evtCatName = "",evtGen = "" , evtDateTo =  "",admin1 = "",admin2 = "",evtRefine = "",evtTypeEmp = "" ,evtGender = "",evtFor = "",evtPlace = "";		
		String[] adminName = null;
		PreparedStatement pmstsel = null;
		String towncode = "",adminEmp="";
		String mainQuery  = "select to_char(CUTOFDTE,'dd-Mon-yyyy') CUTOFDTE,MAXTICK,MAXPRICE,INDIV_TICK,EVTNME,EVTPLACE,ADDFIELD,adminEmp,evt_id,NOOFMAXTICK,evt_for,bus_facility,to_char(evt_date,'dd-Mon-yyyy') evt_date,nvl(evt_BU,'T') evt_BU,status,evt_cat,age_criteria,BOARDINGPNT1,evt_gen,to_char(evt_date_to,'dd-Mon-yyyy') evt_date_to from nomination_admin where evt_id=?";
		PreparedStatement psMain = con.prepareStatement(mainQuery);
		psMain.setString(1,evt_id);
		ResultSet rsMain = psMain.executeQuery();
		if(rsMain.next()){
			cutoffdt1 =rsMain.getString("CUTOFDTE");
			evtPlace =nullVal(rsMain.getString("evtPlace"));
			maxTicksTotal =rsMain.getString("MAXTICK");
			maxPrz =rsMain.getString("MAXPRICE");
			perTicks =rsMain.getString("INDIV_TICK");
			adminEmpTab =rsMain.getString("adminEmp");
			evtNameEvt =rsMain.getString("EVTNME");
			addFields1 =rsMain.getString("ADDFIELD");
			evtDateFrom =rsMain.getString("evt_date");
			evtDateTo =rsMain.getString("evt_date_to");
			adminName = adminEmpTab.split(",");
			evtRefine = nullVal(rsMain.getString("boardingPnt1"));
			evtTypeEmp = nullVal(rsMain.getString("evt_cat"));
			evtGender = nullVal(rsMain.getString("evt_gen"));
			evtFor = nullVal(rsMain.getString("evt_for"));
			isEvtBU = nullVal(rsMain.getString("evt_BU"));
		}
		if(!"".equals(adminEmpTab)){
			psMain = con.prepareStatement("select trim(emp_name) emp_name,emp_no from empmaster where emp_no =  ?");
			for(int i=0;i<adminName.length;i++){
				psMain.setString(1,adminName[i]);
				rsMain = psMain.executeQuery();
				if(rsMain.next())
					if(i==0)
						admin1 = nullVal(rsMain.getString("emp_name")+"("+rsMain.getString("emp_no")+")");
					else if(i==1)
						admin2 =nullVal(rsMain.getString("emp_name")+"("+rsMain.getString("emp_no")+")"); 
			}	
		}
		boolean isAddFields = false;
		psMain = con.prepareStatement("select evt_id,lbl_name lblName,lbl_type,id,isMandate,DEF_VALUE from NOMINATION_ADDITION where evt_id=?");
		psMain.setString(1,evt_id);
		rsMain = psMain.executeQuery();
		if(rsMain.next())
			isAddFields = true;
		psMain = con.prepareStatement("select '' as evt_id,'' as lblName,'' as lbl_type,'0' as id,'' as isMandate,'' as DEF_VALUE from dual union all select evt_id,lbl_name lblName,lbl_type,id,isMandate,DEF_VALUE from NOMINATION_ADDITION where evt_id=?");
		psMain.setString(1,evt_id);
		ResultSet rsAddFields = null;
		%>


<div class ="container">
<form name ="form1" action="" method ="post" class="needs-validation" novalidate>
<div class="well">
  <div class ="row form-group">
	<div class ="col-md-4">
		<label for="evtnme" class ="tdLbl">Event ID<br/></label>
		<input type="text"	class ="form-control" readonly name ="evtid"	id ="evtid" value ="<%=evt_id%>"/>
	</div>
	<div class = "col-md-4">
		<label for ="evt_date_from">Event Date(From)</label>
		<input type ="text" readonly="readonly" class ="form-control datepicker"  id ="evt_date" name ="evt_date" value="<%=evtDateFrom%>" data-provide="datepicker">
	</div>
	<div class = "col-md-4">
		<label for ="evt_date_to">Event Date(To)</label>
		<input type ="text" readonly="readonly" class ="form-control datepicker" id ="evt_date_to" name ="evt_date_to" value="<%=evtDateTo%>" data-provide="datepicker"> 
	</div>
	</div>
	<div class= "row form-group">
		<div class ="col-md-4">
			<label for ="cutofdte" class ="tdLbl">Last Date for Online Application</label>
			<input type="text" name="cutofdte" class="form-control datepicker" id ="cutofdte" value = "<%=cutoffdt1%>" readonly ="readonly" data-provide="datepicker" required>
		</div>
		<div class ="col-md-4">
			<label for="priceevt" class="tdLbl">Price per ticket</label>
			<input type="text" class="form-control" name="priceevt" id ="priceevt" maxlength="5" onkeypress="return isNumeric(event)" value="<%=maxPrz%>" onkeydown="return isNumeric(event)"/>
		</div>
		<div class ="col-md-4">
			<label for = "nooftickts" class="tdLbl">Total Tickets for Event</label>
			<input type="number" class="form-control" name="nooftickts" value = "<%=maxTicksTotal%>" id ="nooftickts" maxlength="20" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)">
		</div>
	</div>
	<div class ="row form-group">
		<div class ="col-md-8">
			<label for ="evtName" class ="tdLbl">Event Name</label>
			<input type ="text" class = "form-control" id ="evtName" value= "<%=evtNameEvt%>" name = "evtnme"/ required>
		</div>
		<div class ="col-md-4">
			<label for="maxtickemp" class="tdLbl">Max Tickets per employee</label>
			<input type="number" class="form-control" name="maxtickemp" id ="maxtickemp" maxlength="20" onkeypress="return isNumeric(event)" value = "<%=perTicks%>" onkeydown="return isNumeric(event)">
		</div>
  </div>
	<div class ="row form-group">
		<div class ="col-md-6">
			<label class="tdLbl" for >Choose First Admin for Event</label><input type="text" name="adminEmp" id="adminEmp" class="form-control" value="<%=admin1%>" /></td>
		</div>
		<div class = "col-md-6">
			<label for="" class="tdLbl">Choose Second Admin for Event</label><input type="text" name="adminEmp1" id="adminEmp1" class="form-control" value="<%=admin2%>" /></td>
		</div>
	</div> 
  <div class ="row form-group">
	<div class ="col-md-6">
		<label for= "" class ="tdLbl">Select specific location , if the event does not pertain to all Employees</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div class ="form-check">
			<input type ="checkbox" class ="" id ="evtFilter1" value="-1" <%=evtRefine.equals("-1")?"checked":""%> >
			<label class="form-check-label" for="evtFilter1">All</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type ="checkbox" class ="" id ="evtFilter4" <%=evtRefine.equals("MKTG")?"checked":""%> value="MKTG">
			<label class="form-check-label" for="evtFilter4">Marketing Locations</label>
		</div>	
		<div class ="form-check">
			<input type ="checkbox" class ="" id ="evtFilter2" <%=evtRefine.equals("MR")?"checked":""%> value="MR">
			<label class="form-check-label" for="evtFilter2">Mumbai Refinery</label>
			<input type ="checkbox" class ="" id ="evtFilter3" <%=evtRefine.equals("VR")?"checked":""%> value="VR">
			<label class="form-check-label" for="evtFilter3">Visakh Refinery</label>
		</div>
	</div>
	<div class ="col-md-6">
		<div><label for="" class ="tdLbl">Age Criteria</label></div>
		<div style="float:left;width:40%;"  class="tdLbl col-md-12">Select the Minimum Age <select class="form-control" name="minAge" id="minAge">
			<option value="-1">Select</option>
			<%
			for(int i=4;i<=60;i++){%>
			<option value="<%=i/10==0?"0"+i:i%>"><%=i/10==0?"0"+i:i%> Years</option>	
			<%}
			%>
		</select></div>		
		<div style="float:left;width:40%;" class="tdLbl  col-md-12">Select the Maximum Age <select class="form-control" name="minAge" id="minAge">
			<option value="-1">Select</option>
			<%
			for(int i=4;i<=60;i++){%>
			<option value="<%=i/10==0?"0"+i:i%>"><%=i/10==0?"0"+i:i%> Years</option>	
			<%}
			%>
		</select></div>		
	</div>
	</div>
	
  <div class= "row form-group">
	<div class ="col-md-4">
		<span class ="tdLbl">Event Category</span><br/>
		<div class = "form-check">
		<input type="radio" name="evt_cat" id="cat1" value="M" class="evt_cat" <%=evtTypeEmp.equals("M")?"checked":""%> />
		<label for="cat1" class="form-check-label">Management</label>
		<!--</div>
		<div class = "form-check">-->
		<input type="radio" name="evt_cat" value="N" id="cat2" class="evt_cat" <%=evtTypeEmp.equals("N")?"checked":""%>/><label for="cat2" class="form-check-label">Non Management</label>
		<!--</div>
		<div class ="form-check">-->
		<input id="cat3" type="radio" name="evt_cat" value="B" class="evt_cat" <%=evtTypeEmp.equals("B")?"checked":""%>/><label for="cat3" class="form-check-label">Both </label>
		</div>
	</div>
	<div class ="col-md-4">
		<label for ="" class="tdLbl">Event Category(Gender)</label>
		<div class ="form-check">
			<input type="radio" name="evt_gen" value="M" id="male" class="evt_gen" <%=evtGender.equals("M")?"checked":""%>><label for="male" class="form-check-label">Male</label>

			<input type="radio" name="evt_gen" value="F" id="female" class="evt_gen" <%=evtGender.equals("F")?"checked":""%>><label for="female" class="form-check-label">Female</label>
	
			<input type="radio" id="both" name="evt_gen" value="B" class="evt_gen" <%=evtGender.equals("B")?"checked":""%>><label for="both" class="form-check-label" >Both </label>
		</div>	
	</div>
	<div class ="col-md-4">
		<label for ="" class="tdLbl">Event Available for</label>
		<div class ="form-check">
		<input type="checkbox" name="evt_for" class="evt_for_for" id="E" value="E" <%=evtFor.indexOf("E")!=-1?"checked":""%> /><label class="form-check-label" for="E">Employees</label>
		
		<input type="checkbox" name="evt_for" class="evt_for_for" id="D" value="D" <%=evtFor.indexOf("D")!=-1?"checked":""%> /><label class="form-check-label" for="D">For Dependents</label>
		
		<input type="checkbox" name="evt_for" class="evt_for_for" id="O" value="O" <%=evtFor.indexOf("O")!=-1?"checked":""%> /><label class="form-check-label" for="O">Others</label> 
		</div>
  </div>

  </div>
   <div class = "row form-group">
	<div class ="col-md-6">
		<label for="" class="tdLbl">Addition Fields Required to get Data</label>
		<div class= "form-check" >
		<input type="radio" name="addField" Value="Y" id="Y" <%=isAddFields?"checked":""%> onClick="return chkVals(this)" >
		<label class ="form-check-label" for="Y"> Yes &nbsp;</label>
		<input type="radio" name="addField" Value="N" id="N" onclick="return chkVals(this)">
		<label  class ="form-check-label" for="N"> No &nbsp;</label>
		</div>
		</div>
		  	<div class = "col-md-6">
		<label for="" class="tdLbl">Bus Facility Required</label>
		<div class = "form-check">
			<input type="radio" name="bus_req" class="bus_req"  value="Y" id="bt" >
			<label class = "form-check-label" for="bt">Yes &nbsp;</label>

			<input type="radio" name="bus_req" class="bus_req" value="N"  id="bt1"><label for="bt1">No &nbsp;</label>
		</div>	
		<a href="#showBoard" class="inline_popup" id="bpAddit" ></a>
			<div id="newDiv"  style="display:none"></div>
			<input type="hidden" name="boardPnts" id="bPval2" value=""/>
		
	</div>
		
	</div>
	<div class ="row form-group">
	<div class ="col-md-12">
		<label for="" class ="tdLbl">Event Allowed for the Employees of</label><br/>
		<div class ="form-check form-check-inline">
		<input type ="radio" <%="T".equals(isEvtBU)?"checked":""%> class ="form-check-input" name="radAllowed" id="radAllowed1" value="t" onclick="return getLocnBy(this)"/>
		<label class="form-check-label tdLbl" for ="radAllowed1">Town</label>
		</div>
		<div class="form-check form-check-inline"> 
		<input <%="Y".equals(isEvtBU)?"checked":""%> type ="radio" class ="form-check-input" name="radAllowed" id="radAllowed2" value="b" onclick="return getLocnBy(this)"/>
		</div>
		<label class="form-check-label tdLbl" for ="radAllowed2">BU</label>
		<div <%="T".equals(isEvtBU)?"":"style='display:none'"%> id="divTown"> 	
		<select class="form-control  selectNew" multiple="multiple" name="evtplace" id="evtplace">
		<%if("T".equals(isEvtBU)){
			String[]evtArr = evtPlace.split(",");
			for(int i = 0 ;i<evtArr.length;i++){%>
			<option selected = "selected" value = "<%=evtArr[i]%>"><%=evtArr[i]%></option>
			<%}%>
		<%}%>
		</select>
		</div>
		<div <%="Y".equals(isEvtBU)?"":"style='display:none'"%> id="divBu">
		<select multiple="multiple" class ="form-control  selectNew" name="evtplaceBu" id="buDesc" >
		<%if("Y".equals(isEvtBU)){
			String[]evtArr = evtPlace.split(",");
			PreparedStatement psBuDesc = con.prepareStatement("select distinct bu,budesc from bu where bu =?");
			ResultSet rsBuDesc  = null;
			for(int i = 0 ;i<evtArr.length;i++){
				psBuDesc.setString(1,evtArr[i]);
				rsBuDesc = psBuDesc.executeQuery();
				if(rsBuDesc.next()){%>
				<option selected = "selected" value = "<%=rsBuDesc.getString("bu")%>"><%=rsBuDesc.getString("budesc")%></option>
				<%}%>
			<%}%>
		<%}%>			
		</select>
		</div>
	 </div>
  </div>  

  <!--Boarding Point for Event Popups-->
  <div id="showBoard" class="target_popup mfp-hide">
	<div class="brdrB pb5 mb10"></div>
		<center>	
	<div class="mb10 f14" style="font-family:Times New Roman;color:#37002d;font-weight:bold;font-size:18px">
		Enter the Borading points seperated by Comma
		<textarea  name="pickPnts" id="pickPnts" rows="2",cols="100%" style="margin: 0px; width: 800px; height: 50px;"></textarea><br/>
		<input type="button" name="bpBtn" value="Submit" onclick="return boardingPnt()">
		</center>
	</div>
  </div>
<div <%=isAddFields?"":"style='display:none'"%>  class="chkValDiv">
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div class="table-responsive">
			<table class="table table-bordered" id="ti_table" border="1">
				<tr class ="alert alert-success">
				<th><center>&sect;</center></th>
				<th><center>Label Name</center></th>
				<th><center>Label Type</center></th>
				<th><center>Default values</center></th>
				<th><center>Mandetory</center></th>
				</tr>
				<tbody>
<%
int counttt = 0,addId = 0;
String temp = "";
rsAddFields = psMain.executeQuery();
while(rsAddFields.next()){
	counttt++;
	addId =rsAddFields.getInt("id");
	if(addId == 0){
		temp="#id#";
	}else{
		temp = ""+counttt;
	}
	
%>				
		<tr id="tr<%="#id#".equals(temp)?"":temp%>" class="tbodytr" style='<%="#id#".equals(temp)?"display: none":""%>'>
					<!--<td align="center"><span class="numberRow"><strong></strong></span>
					<input type="checkbox" name="chkboxx" id="chkB<%="#id#"%>" onclick="return guideLine1(<%="#id#"%>)">
					</td>-->
					<td align="center">
					<a onclick="removeRow(<%=temp%>,this)" href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
					<td><center><input type="text" value= "<%=nullVal(rsAddFields.getString("lblName"))%>" name="fieldName" id="fieldName<%=temp%>" placeholder="Enter the Name of Label"></center></td>
					<td>

						<select name="lblType" id="lblType<%=temp%>">
							<option value="file" "<%=nullVal(rsAddFields.getString("lbl_type")).equals("file")?"selected":""%>" >File</option>
							<option value="text" "<%=nullVal(rsAddFields.getString("lbl_type")).equals("text")?"selected":""%>">Text</option>
							<option value="drop down" "<%=nullVal(rsAddFields.getString("lbl_type")).equals("drop down")?"selected":""%>">Dropdown</option>
							<option value="textarea" "<%=nullVal(rsAddFields.getString("lbl_type")).equals("textarea")?"selected":""%>">Textarea</option>
						</select>
					</td>
					<td><center><input type="text" name="def_type" id="def_type<%=temp%>" placeholder="Add the values seperated by commas"></center></td>
					<td><center><input type="checkbox" name="ismandetory" id="ismandetory<%=temp%>" class="ismandetory<%=temp%>" onclick="return isMand('<%=temp%>')" <%=nullVal(rsAddFields.getString("isMandate")).equals("Y")?"checked":""%> value="Y"/>Yes
					<input type="hidden" name="isMand1" id="isMand<%=temp%>" class="isMand1" value="N" />
					</td>
			</tr>
<%}%>			
		</tbody>	
	</table></div></div>
	<div class  ="row form-group">	
		<center>
		<%if("".equals(id)){%>
			<button class="btn  btn-primary"  type="submit" name="submit1" id="submit2" value="Add Event"   onclick="return validation();">Add Event</button>
			<button type="submit" name="submit1" class="btn btn-primary" id="submit3" id="submit2"  onclick="return validation();">Add Event and Publish</button>
		<%} else {%>
			<button type= "submit" class ="btn btn-primary" name = "submit1" value = "Update" id = "submit3" onclick = "return validation();">UPDATE</button>
		<%}%></center>
	</div>
	
		<%
		String adminEmp1="",allAdmin="",splitAdminNo1="",splitAdminNo2="",addFields="",lblName="",lblType="",defValues="",isMandate="";
		String [] lblName1=request.getParameterValues("fieldName");
		String [] lblType1=request.getParameterValues("lblType");
		String [] def_type1=request.getParameterValues("def_type");
		String [] isMandate1=request.getParameterValues("isMand1");
		if(request.getParameter("submit1")!=null){
			con.setAutoCommit(false);
			String []splitAdmin=null;
			String []splitAdmin1=null;
			adminEmp=nullVal(request.getParameter("adminEmp"));
			adminEmp1=nullVal(request.getParameter("adminEmp1"));
			if(!"".equals(adminEmp)){
				splitAdmin=(adminEmp.split("\\("));
				splitAdminNo1=splitAdmin[1].substring(0,8);
			}
			if(!"".equals(adminEmp1)){
				splitAdmin1=adminEmp1.split("\\(");
				splitAdminNo2=splitAdmin1[1].substring(0,8);
			}
			allAdmin=splitAdminNo1+","+splitAdminNo2;
			String evtnme="",evtplace="",cutofdte="",priceevt="",nooftickts="",maxtickemp ="",evt_for="",bus_req="",evtBU="";
			int flag = 0,sber=0;
			evtnme = request.getParameter("evtnme");
			String [] arrevtplace =new String[]{};
			evtnme = request.getParameter("evtnme");
			arrevtplace = request.getParameterValues("evtplace");
			if(arrevtplace!=null && arrevtplace.length!=0){
			  for(int i = 0; i<arrevtplace.length; i++ ){
				evtplace += ","+arrevtplace[i];
			  }
			}
			String [] arrEvtBU=new String[]{};
			arrEvtBU=request.getParameterValues("evtplaceBu");
			if(arrEvtBU!=null && arrEvtBU.length!=0){
			for(int i=0;i<arrEvtBU.length;i++){
				evtBU +=","+arrEvtBU[i];
			}}
			if(!"".equals(evtBU)){
				evtplace=evtBU;
				evtBU="Y";
			}
			String pickPoints="";
			String eventDate=request.getParameter("evt_date");
			String evt_date_to=request.getParameter("evt_date_to");
			String field2=nullVal(request.getParameter("field3"));
			String field3=nullVal(request.getParameter("field2"));
			String field1=nullVal(request.getParameter("field1"));
			String evt_cat=nullVal(request.getParameter("evt_cat"));
			String evt_gen=nullVal(request.getParameter("evt_gen"));
			String evtFilter=nullVal(request.getParameter("evtFilter"));
			String age_criteria=nullVal(request.getParameter("minAge"))+" and "+ nullVal(request.getParameter("maxAge"));
			String builder=field1+"-"+field3+"-"+field2;
			evtplace = evtplace.substring(1);
			cutofdte = request.getParameter("cutofdte");
			priceevt = request.getParameter("priceevt");
			nooftickts = request.getParameter("nooftickts");
			maxtickemp = request.getParameter("maxtickemp");
			String [] evt_forArr=request.getParameterValues("evt_for");
			bus_req=request.getParameter("bus_req");
			if("Y".equals(bus_req)){
				pickPoints=request.getParameter("boardPnts");
			}
			for(int i=0;i<evt_forArr.length;i++){
				evt_for+=evt_forArr[i]+",";	
			}
			rs = null;
			pmstsel = null;
			String already_exist="select EVTNME from nomination_admin where regexp_like(EVTNME, ?, 'i')";
			if(!"Update".equals(request.getParameter("submit1"))){
			pmstsel=con.prepareStatement(already_exist);
			pmstsel.setString(1,evtnme);
			rs=pmstsel.executeQuery();
			if(rs.next()){
				%>
				<script>
				alert("Event Already Exist..");
				location.href="home.jsp";
				</script>
			<%}
			}
			String sts="";
			if("Add Event".equals(request.getParameter("submit1")) || "Add Event and Publish".equals(request.getParameter("submit1")) || "Update".equals(request.getParameter("submit1"))){
				
				if("Add Event".equals(request.getParameter("submit1")))
					sts="S";
				else if("Add Event and Publish".equals(request.getParameter("submit1")))
					sts="P";
				String [] addsVal=request.getParameterValues("addField");
				if(addsVal!=null &&addsVal.length>0){
					addFields=addsVal[0];
				}
				pmstsel = con.prepareStatement("insert into nomination_admin (CUTOFDTE,MAXTICK,MAXPRICE,INDIV_TICK,EVTNME,EVTPLACE,ADDFIELD,adminEmp,evt_id,NOOFMAXTICK,evt_for,bus_facility,evt_date,evt_BU,status,evt_cat,age_criteria,BOARDINGPNT1,evt_gen,evt_date_to) values(to_date(?,'dd-Mon-yyyy'),?,?,?,?,?,'"+builder+"','"+allAdmin+"','"+evt_id+"','"+maxtickemp+"','"+evt_for+"','"+bus_req+"',to_date('"+eventDate+"','dd-Mon-yyyy'),'"+evtBU+"','"+sts+"','"+evt_cat+"','"+age_criteria+"','"+evtFilter+"','"+evt_gen+"',to_date('"+evt_date_to+"','dd-Mon-yyyy'))");

				psBusReq=con.prepareStatement("insert into nomination_BP values(?,?,?)");
				psBusReq.setString(1,evt_id);
				psBusReq.setString(2,bus_req);
				psBusReq.setString(3,pickPoints);
				psBusReq.executeUpdate();
				if("Y".equals(addFields)){
					psEvtId=con.prepareStatement("insert into nomination_addition(evt_id,lbl_name,lbl_type,def_value,ISMANDATE) values(?,?,?,?,?)");
					for(int i=0;i<lblName1.length-1;i++){
						lblName=lblName1[i];
						lblType=lblType1[i];
						defValues=def_type1[i];
						isMandate=isMandate1[i];
						//out.println(lblName);
						psEvtId.setString(1,evt_id);
						psEvtId.setString(2,lblName);
						psEvtId.setString(3,lblType);
						psEvtId.setString(4,defValues);
						psEvtId.setString(5,isMandate);
						sber=psEvtId.executeUpdate();
						//out.println("aaa"+sber);
					}
				}				
			}				
			pmstsel.setString(1,cutofdte);
			pmstsel.setString(2,nooftickts);
			pmstsel.setString(3,priceevt);
			pmstsel.setString(4,maxtickemp);
			pmstsel.setString(5,evtnme);
			pmstsel.setString(6,evtplace);
			
			if("Update".equals(request.getParameter("submit1"))){
				String hidevtnme = request.getParameter("hidevtnme");
				String hidevtplace = request.getParameter("hidevtplace");
				pmstsel.setString(7,hidevtnme);
				pmstsel.setString(8,hidevtplace);	
			}

			flag=pmstsel.executeUpdate();
			if( flag == 1 ){
				con.commit();
				%>
				<script>
					alert("Details Submitted");
					location.href="editevent1.jsp";
				</script>
				<%} else{
				con.rollback();	
				%>
					<script>
						alert("Error Occured....");
						//location.href="editevent1.jsp";
					</script>
				<%}
			
		}
%>	
</div>
</form> 
</div>  
	<script>
    
	$(function() {
		$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			//dateFormat: "dd-mon-yy",
			autoclose : true,
			format :"dd-M-yyyy",
			todayHighlight : true,
		});
		
	});
</script>
<script>
	$(function() {
		$('.ajax_popup_link').magnificPopup({ type: 'ajax', });
		$('.inline_popup').magnificPopup({ type: 'inline', });
	});
</script>
<%@include file = "footer.jsp"%>