<%@include file="header1.jsp"%>

    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.target_popup {position: relative; background: white; padding: 20px; width: auto; max-width: 800px; margin: 20px auto; box-shadow: 0 0 12px #fff; border-radius: 5px;}
.tdLbl1{
    padding: 2px 10px;
    color:#18568e;
    font-weight: bold;
    font-size: 11px;
   }
  h2,h3,h4{
    padding: 2px 10px;
    color:#18568e;
    font-weight: bold;
    font-size: 14px;
   }

</style>
<link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" />
 <link href="css/select2.min.css" rel="stylesheet" />
  <script type="text/javascript" src="js/calendar.js"></script>
  <script type="text/javascript" src="js/calendar-en.js"></script>
 <script  src="js/calendar-setup.js"></script>
 <script type="text/javascript" src="js/select2.min.js"></script>
<!--<script type="text/javascript" src="js/jquery.autocomplete.js"></script>-->
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
function boardingPnt(){
		var bPoints=$("#pickPnts").val();
		if(bPoints==''){
			alert("Please Select the Borading Points for the Event");
			return false;
		}else{
			$("#newDiv").show();
			$("#bpAddit").hide();
			$("#bPval2").val(bPoints);
			$("#newDiv").html('<span name="bPnt" id="bPnt">'+bPoints+'</div>');
			$( ".mfp-close" ).trigger( "click" );
				return false;
		}	
}
function isMand(vl){
	//alert(document.getElementById("isMand"+vl).value);
	document.getElementById("isMand"+vl).value="Y";
	//alert(document.getElementById("isMand"+vl).value);

}
</script>
<style>
.listTable tr > th{
	border: 1px solid #FFFFFF;
	box-shadow:0 0 10px #5D6D7E;
	background-color: #CB4E46;
	color:#FFF;
	background: -webkit-linear-gradient(top ,#CB4E46, #1472C5);
	background: -o-linear-gradient(top ,#CB4E46, #1472C5);
	background: -moz-linear-gradient(top ,#CB4E46, #1472C5);
	background: -ms-linear-gradient(top ,#CB4E46, #1472C5);
	background: linear-gradient(top ,#CB4E46, #1472C5);
}
.listTable td{
	padding:1% 0%;
}
.tab2{
	--margin:5%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width: 70%;
}
.tab2 td{
	padding:1% 0%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#FDEDEC;
}
.tab2 tr:nth-child(odd){
	background:#ebf1fa ;
}
#tab1{
	border-collapse: collapse;
}
#tab1 th{
	border:1px solid #000;
}

.ac_results {
	padding: 0px;
	border: 1px solid #84a10b;
	background-color: #84a10b;
	overflow: hidden;
}
.ac_results ul {
	width: 100%;
	list-style-position: outside;
	list-style: none;
	padding: 0;
	margin: 0;
}
.ac_results li {
	margin: 0px;
	padding: 2px 5px;
	cursor: default;
	display: block;
	color: #fff;
	font-family:verdana;
	/*
	if width will be 100% horizontal scrollbar will apear
	when scroll mode will be used
	*/
	/*width: 100%;*/
	font-size: 12px;
	/*
	it is very important, if line-height not setted or setted
	in relative units scroll will be broken in firefox
	*/
	line-height: 16px;
	overflow: hidden;
}
.ac_loading {
	background: white url('../images/indicator.gif') right center no-repeat;
}
.ac_odd {
	background-color: #84a10b;
	color: #ffffff;
}
.ac_over {
	background-color: #5a6b13;
	color: #ffffff;
}
.input_text{
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	border:1px solid #84a10b;
	padding:2px;
	width:150px;
	color:#000;
	background:white url(../images/search.png) no-repeat 3px 2px;
	padding-left:17px;
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
String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	alert("aaa");
	var row = $("#tr").html();
	var index = $("#ti_table tbody:first> tr").length;
	row = row.replaceAll("#id#", index);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	recalculate()
}

/*function addEntry() {	
	var row = $("#t").html();				//to add a row in Ti or Tes
	var index = $("#ti_table tbody > tr").length;
	row = row.replaceAll("#id#", index);
	$("#leg_count").val(index);

	}*/

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
function validation(){
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
<script language="Javascript">
  function formsubmit(frmname) {
	  $("form[name='"+frmname+"']").submit();
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
}%>

<%
String evt_name ="",adminEmp="",adminEmp1="",query = "";
String eventName="",cutOffDate="",totalTickets="",ticketPrize="",maxTicketsEmp="",eventBU="",eventAdmins="",evt_id="",eventAllowedFor="",busRequirement="",eventFromDate="",isEventBU="",eventCatMgNmt="",ageRange="",eventGender="",eventToDate="",eventLocation="",admin1="",admin2 ="",tempEvtPlace="",tempEvtBU = "",minAge="",maxAge="",pickPoints="",bus_req="",pickPointsModel="",addFields ="",lblName="",lblType="",defValues="",isMandate="";;
String editPara = nullVal(request.getParameter("editId"));
PreparedStatement psdet = null,psEvtId=null,psBusReq=null,psEdit = null,psAddFields = null;
ResultSet rsdet = null,rsEvtId=null,rsBusReq=null,rsEdit = null,rsAddFields = null;
String editQry = "";
int tempMinAge = 0,tempMaxAge=0,sber=0;
boolean isTown =false,isBU =false,isAddFields=false;
HashMap <String,String> hmsbu = new HashMap <String,String>();
HashMap <String,String> newLocnMap = new HashMap <String,String>();
List<String> typeList=new ArrayList<String>();
String[] newLocnArr = null;
List<String> newLocnList = new ArrayList<String>();
typeList.add("-1");
typeList.add("text");
typeList.add("file");
typeList.add("Dropdown");
typeList.add("Number");
String key ="", value = "";
DateFormat df = new SimpleDateFormat("dd-MMM-yyyy");
Date today = Calendar.getInstance().getTime();
String createdDt = df.format(today);
List<String> fieldList=new ArrayList<String>();
int evt_id1=0;
Statement st=con.createStatement();
ResultSet rsId=null;
String [] lblName1=request.getParameterValues("fieldName");
String [] lblType1=request.getParameterValues("lblType");
String [] def_type1=request.getParameterValues("def_type");
String [] isMandate1=request.getParameterValues("isMand1");
	rsId=st.executeQuery("select max(cast (substr(evt_id,6,3) as int)) maxId from nomination_admin");
	if("".equals(editPara)){
		if(rsId.next() && rsId.getString("maxId")!=null){
			evt_id1=rsId.getInt("maxId")+1;
			evt_id=1900+today.getYear()+"_"+evt_id1+"_event";
		} else{
			evt_id=1900+today.getYear()+"_101_event";
		}		
	} else {
		evt_id = editPara;
	}
	editQry  = "select EVTPLACE,to_char(CUTOFDTE,'dd-Mon-YYYY') cutoffDate,MAXTICK,MAXPRICE,EVTNME,NOOFMAXTICK,INDIV_TICK,BOARDINGPNT1,ADDFIELD,ADMINEMP,EVT_ID,EVT_FOR,BUS_FACILITY,to_char(EVT_DATE,'dd-Mon-YYYY') EVT_DATE,EVT_BU,STATUS,EVT_CAT,AGE_CRITERIA,EVT_GEN,to_char(EVT_DATE_TO,'dd-Mon-YYYY') evt_date_to from Nomination_admin where evt_id=?";
	PreparedStatement psExistEvt = con.prepareStatement(editQry);
	psExistEvt.setString(1,evt_id);
	ResultSet rsExistEvt = psExistEvt.executeQuery();
	if(rsExistEvt.next()){
		eventName = nullVal(rsExistEvt.getString("EVTNME"));
		cutOffDate =  nullVal(rsExistEvt.getString("cutoffDate"));
		totalTickets =  nullVal(rsExistEvt.getString("MAXTICK"));
		ticketPrize =  nullVal(rsExistEvt.getString("MAXPRICE"));
		maxTicketsEmp =  nullVal(rsExistEvt.getString("NOOFMAXTICK"));
		eventBU =  nullVal(rsExistEvt.getString("BOARDINGPNT1"));
		eventAdmins =  nullVal(rsExistEvt.getString("ADMINEMP"));
		evt_id =  nullVal(rsExistEvt.getString("EVT_ID"));
		eventAllowedFor =  nullVal(rsExistEvt.getString("EVT_FOR"));
		busRequirement =  nullVal(rsExistEvt.getString("BUS_FACILITY"));
		eventFromDate =  nullVal(rsExistEvt.getString("EVT_DATE"));
		isEventBU =  nullVal(rsExistEvt.getString("EVT_BU"));
		eventCatMgNmt =  nullVal(rsExistEvt.getString("EVT_CAT"));
		ageRange =  nullVal(rsExistEvt.getString("AGE_CRITERIA"));
		eventGender =  nullVal(rsExistEvt.getString("EVT_GEN"));
		eventToDate =  nullVal(rsExistEvt.getString("evt_date_to"));
		eventLocation = rsExistEvt.getString("EVTPLACE");
		if(!"".equals(eventAdmins)){
			String [] adminArr = eventAdmins.split(",");
			PreparedStatement psEmpName = con.prepareStatement("select trim(emp_name) emp_name,emp_no from empmaster where emp_no=?");
			ResultSet rsEmpName = null;
			for(int i=0;i<adminArr.length;i++){
				psEmpName.setString(1,adminArr[i]);
				rsEmpName = psEmpName.executeQuery();
				if(rsEmpName.next()){
					if(i==0){
						admin1 = rsEmpName.getString("emp_name")+"("+rsEmpName.getString("emp_no")+")";
					}else if(i==1){
						admin2 = rsEmpName.getString("emp_name")+"("+rsEmpName.getString("emp_no")+")";
					}
				}	
			}
		}
		if("t".equals(isEventBU) || "".equals(isEventBU)){
			isTown = true;
			newLocnArr = eventLocation.split(",");
			if(newLocnArr!=null){
				for(int i=0;i<newLocnArr.length;i++){
					newLocnList.add(newLocnArr[i]);
				}
			}else
				newLocnList.add(eventLocation);
		}else if("Y".equals(isEventBU)){
			isBU =  true;
			newLocnArr = eventLocation.split(",");
			PreparedStatement psBuNames = con.prepareStatement("select budesc,bu from empmaster where bu=?");
			ResultSet rsBuNames = null;
			if(newLocnArr!=null){
				for(int i=0;i<newLocnArr.length;i++){
					psBuNames.setString(1,newLocnArr[i]);
					rsBuNames = psBuNames.executeQuery();
					if(rsBuNames.next())
						newLocnMap.put(rsBuNames.getString("BU"),rsBuNames.getString("budesc"));
				}
			}else{
				psBuNames.setString(1,eventLocation);
				rsBuNames = psBuNames.executeQuery();
				if(rsBuNames.next())
					newLocnMap.put(rsBuNames.getString("BU"),rsBuNames.getString("budesc"));
			}		
			if(psBuNames!= null)
				psBuNames.close();
			if(rsBuNames!= null)
				rsBuNames.close();
		}
		if(!"".equals(ageRange)){
			minAge = ageRange.substring(0,2);
			maxAge = ageRange.substring(ageRange.length()-2,ageRange.length());
		}
		try{tempMinAge = (Integer.parseInt(minAge));}catch(NumberFormatException nf1){out.println("Some Error Occured"+nf1);}	
		try{tempMaxAge = (Integer.parseInt(maxAge));}catch(NumberFormatException nf2){out.println("Some Error Occured"+nf2);}	
		
		if("Y".equals(busRequirement)){
			psBusReq = con.prepareStatement("select evt_id,boarding_point from nomination_bp where evt_id =? and bus_facility='Y'");
			psBusReq.setString(1,evt_id);
			rsBusReq = psBusReq.executeQuery();
			if(rsBusReq.next()){
				pickPoints = "<span name='bPnt' id='bPnt'>"+rsBusReq.getString("boarding_point")+"</span>";
				pickPointsModel =rsBusReq.getString("boarding_point");
			}	
		}
		if(rsBusReq!=null)
			rsBusReq.close();
		if(psBusReq!=null)
			psBusReq.close();
			psAddFields = con.prepareStatement("select evt_id from nomination_addition where evt_id=?");
			psAddFields.setString(1,evt_id);
			rsAddFields = psAddFields.executeQuery();
			if(rsAddFields.next()){
				isAddFields =true;
			}
			if(psAddFields!=null)
				psAddFields.close();
			if(rsAddFields!=null)
				rsAddFields.close();	
	}
	if(!"".equals(nullVal(request.getParameter("submit1")))){
		
		String tempEvtFor = "",splitAdminNo1= "",splitAdminNo2 = "",tempLocnationFilter= "";
		
									/*********** For Admin Selection **********************/
		
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
			String allAdmin=splitAdminNo1+","+splitAdminNo2;		
	
									/*********** For The Locations ***********************/
		
		String [] arrevtplace =new String[]{};
		arrevtplace = request.getParameterValues("evtplace");
		if(arrevtplace!=null && arrevtplace.length!=0){
			for(int i = 0; i<arrevtplace.length; i++ ){
				tempEvtPlace += ","+arrevtplace[i];
			}
		}
		String [] arrEvtBU=new String[]{};
		arrEvtBU=request.getParameterValues("evtplaceBu");
		if(arrEvtBU!=null && arrEvtBU.length!=0){
			for(int i=0;i<arrEvtBU.length;i++){
				tempEvtBU +=","+arrEvtBU[i];
			}
			tempEvtPlace = tempEvtBU;	
		}
		if(!"".equals(tempEvtBU))
			tempEvtBU = "Y";
			tempEvtPlace = tempEvtPlace.substring(1);
		
							/************* For Event Available(Emp,Dependents and Others) ******/
		
		String[] evt_forArr=request.getParameterValues("evt_for");
		for(int i=0;i<evt_forArr.length;i++){
			tempEvtFor+=evt_forArr[i]+",";	
		}
							/************* For the Event Filter for Locations *******************/
		String[] evtLocnationFilter = request.getParameterValues("evtFilter");
		if(evtLocnationFilter!=null){
			for(int i =0;i<evtLocnationFilter.length;i++){
				tempLocnationFilter +=evtLocnationFilter[i]+",";  	
			}
			tempLocnationFilter = tempLocnationFilter.substring(0);
		}
		
			/************************************** For the Boarding Points ****************************/
			
			bus_req=request.getParameter("bus_req");
			if("Y".equals(bus_req)){
				pickPoints=request.getParameter("boardPnts");
			}
			
			/*************************** for The Information o Additional Fields***********************/
				String [] addsVal=request.getParameterValues("addField");
				if(addsVal!=null &&addsVal.length>0){
					addFields=addsVal[0];
				}
			
		if("Add Event".equals(nullVal(request.getParameter("submit1"))) || "Add Event and Publish".equals(nullVal(request.getParameter("submit1")))){

			String sts="";
			if("Add Event".equals(request.getParameter("submit1")))
				sts="S";
			else if("Add Event and Publish".equals(request.getParameter("submit1")))
				sts="P";
			
			psBusReq = con.prepareStatement("delete from nomination_BP where evt_id = ?");
			psBusReq.setString(1,evt_id);
			psBusReq.executeUpdate();
			
			psBusReq=con.prepareStatement("insert into nomination_BP values(?,?,?)");
			psBusReq.setString(1,evt_id);
			psBusReq.setString(2,bus_req);
			psBusReq.setString(3,pickPoints);
			psBusReq.executeUpdate();

			if("Y".equals(addFields)){
				psEvtId=con.prepareStatement("insert into nomination_addition(evt_id,lbl_name,lbl_type,def_value,ISMANDATE) values(?,?,?,?,?)");
				for(int i=0;i<lblName1.length;i++){
					if(!"".equals(nullVal(lblName1[i]))){
						lblName=lblName1[i];
						lblType=lblType1 [i];
						defValues=def_type1[i];
						isMandate=isMandate1[i];
						psEvtId.setString(1,evt_id);
						psEvtId.setString(2,lblName);
						psEvtId.setString(3,lblType);
						psEvtId.setString(4,defValues);
						psEvtId.setString(5,isMandate);
						sber=psEvtId.executeUpdate();
					}
				}
			}
			
			query = "insert into nomination_admin (CUTOFDTE,MAXTICK,MAXPRICE,NOOFMAXTICK,INDIV_TICK,EVTNME,EVTPLACE,adminEmp,evt_id,evt_for,bus_facility,evt_BU,status,evt_cat,age_criteria,BOARDINGPNT1,evt_gen,evt_date,evt_date_to) values (to_date(?,'dd-Mon-YYYY'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,to_date(?,'dd-Mon-YYYY'),to_date(?,'dd-Mon-YYYY'))";
			PreparedStatement psInsert = con.prepareStatement(query);
			psInsert.setString(1,request.getParameter("cutofdte"));
			psInsert.setString(2,request.getParameter("nooftickts"));
			psInsert.setString(3,request.getParameter("priceevt"));
			psInsert.setString(4,request.getParameter("maxtickemp"));
			psInsert.setString(5,request.getParameter("maxtickemp"));
			psInsert.setString(6,request.getParameter("evtnme"));
			psInsert.setString(7,tempEvtPlace);
			psInsert.setString(8,allAdmin);
			psInsert.setString(9,evt_id);
			psInsert.setString(10,tempEvtFor);
			psInsert.setString(11,bus_req);
			psInsert.setString(12,request.getParameter("tempEvtBU"));
			psInsert.setString(13,sts);
			psInsert.setString(14,request.getParameter("evt_cat"));
			psInsert.setString(15,request.getParameter("minAge")+" and "+request.getParameter("maxAge"));
			psInsert.setString(16,tempLocnationFilter);
			psInsert.setString(17,request.getParameter("evt_gen"));
			psInsert.setString(18,request.getParameter("evt_date"));
			psInsert.setString(19,request.getParameter("evt_date_to"));
			int cnt = psInsert.executeUpdate();
			if(cnt>0){%>
				<script>
					alert("Event Created Successfully");
					
				</script>
			<%}
		} else if("Update".equals(nullVal(request.getParameter("submit1")))){
			/************************ For Addition of New Fields ****************************/
				
				String[]  newLocnArrTemp =request.getParameterValues("fieldName");
				String[]  lblTypeArrTemp =request.getParameterValues("lblType");
				String[]  def_typeArrTemp =request.getParameterValues("def_type");
				String[]  ismandetoryArrTemp =request.getParameterValues("isMand1");
				if(newLocnArrTemp.length!=0){
					for(int i=0;i<newLocnArrTemp.length;i++){
						psAddFields = con.prepareStatement("insert into nomination_addition (evt_id,lbl_name,lbl_type,def_value,ismandate) values (?,?,?,?,?)");
						if(!"".equals(nullVal(newLocnArrTemp[i]))){
							psAddFields.setString(1,evt_id);
							psAddFields.setString(2,newLocnArrTemp[i]);
							psAddFields.setString(3,lblTypeArrTemp[i]);
							psAddFields.setString(4,def_typeArrTemp[i]);
							psAddFields.setString(5,ismandetoryArrTemp[i]);
							psAddFields.executeUpdate();
						}	
					}
				}
				
			query = "update nomination_admin set EVTPLACE = ?,CUTOFDTE = to_date(?,'dd-Mon-YYYY'),MAXTICK = ?,MAXPRICE = ?,EVTNME = ?,NOOFMAXTICK = ?, INDIV_TICK = ?,BOARDINGPNT1=?,ADMINEMP= ?,EVT_FOR = ?,BUS_FACILITY=?,EVT_DATE=to_date(?,'dd-Mon-YYYY'),EVT_BU=?,EVT_CAT=?,EVT_GEN=?,EVT_DATE_TO=to_date(?,'dd-Mon-YYYY'),AGE_CRITERIA=? where evt_id = ?";
			if("Y".equals(bus_req)){
				psBusReq = con.prepareStatement("delete from nomination_bp where evt_id=?");
				psBusReq.setString(1,evt_id);
				int delCnt=psBusReq.executeUpdate();
				if(delCnt>0){
					String tempQry ="insert into nomination_bp values(?,?,?)";
					psBusReq = con.prepareStatement(tempQry);
					psBusReq.setString(1,evt_id);	
					psBusReq.setString(2,bus_req);	
					psBusReq.setString(3,pickPoints);
					psBusReq.executeUpdate();	
				}
			}
			PreparedStatement psUpdate = con.prepareStatement(query);
			psUpdate.setString(1,tempEvtPlace);	
			psUpdate.setString(2,request.getParameter("cutofdte"));	
			psUpdate.setString(3,request.getParameter("nooftickts"));	
			psUpdate.setString(4,request.getParameter("priceevt"));	
			psUpdate.setString(5,request.getParameter("evtnme"));	
			psUpdate.setString(6,request.getParameter("maxtickemp"));	
			psUpdate.setString(7,request.getParameter("maxtickemp"));	
			psUpdate.setString(8,tempLocnationFilter);	
			psUpdate.setString(9,allAdmin);	
			psUpdate.setString(10,tempEvtFor);	
			psUpdate.setString(11,bus_req);	
			psUpdate.setString(12,request.getParameter("evt_date"));	
			psUpdate.setString(13,tempEvtBU);	
			psUpdate.setString(14,request.getParameter("evt_cat"));	
			psUpdate.setString(15,request.getParameter("evt_gen"));	
			psUpdate.setString(16,request.getParameter("evt_date_to"));	
			psUpdate.setString(17,request.getParameter("minAge")+" and "+request.getParameter("maxAge"));	
			psUpdate.setString(18,evt_id);
			int cnt = psUpdate.executeUpdate();
			if(cnt>0){%>
				<script>
					alert("Updated Successfully");
				</script>	
			<%}	
		}
	}
%>
<form name="form"  id ="form" method="post">

	<div class="container">
	<div class="row">
	<div class="card md-10 box shadow">
		<div class="card-header alert alert-primary"><h2>Add Event</h2></div>
		<div class="card-body table-responsive">
			<table  class="table table-hover table-bordered listTable1" >
				<tr>
					<td width="15%" class="tdLbl1">Event ID</td>
					<td width="35%"><center><span><%=evt_id%></span></center></td>
					<td class="tdLbl1">Event Name</td>
					<td><input type="text" value = "<%=eventName%>" class="form-control" name="evtnme" id ="evtnme" maxlength="100" >
					<input type="hidden" name="hidevtnme" id ="hidevtnme"></td>
				</tr>
				<tr>
					<td class="tdLbl1">Select specific location, if the event does not pertain to all Employees.</td>
					<td>
						<input type="checkbox" name="evtFilter" class="evtFilter" <%=eventBU.indexOf("-1")!=-1?"checked":""%> value="-1" id="evtFilter1">&nbsp;<label for="evtFilter1" ><font size="2"   >All</label>&nbsp;&nbsp;
						<input type="checkbox" name="evtFilter" class="evtFilter" value="MR" id="evtFilter2" <%=eventBU.indexOf("MR")!=-1?"checked":""%> >&nbsp;<label for="evtFilter2" ><font size="2">Mumbai Refinery</font></label>&nbsp;&nbsp;
						<input type="checkbox" name="evtFilter" class="evtFilter" value="VR" id="evtFilter3" <%=eventBU.indexOf("VR")!=-1?"checked":""%>>&nbsp;<label for="evtFilter3" ><font size="2">Visakh Refinery</label>&nbsp;&nbsp;<br/>
						<input type="checkbox" name="evtFilter" class="evtFilter" value="MKTG" id="evtFilter4" <%=eventBU.indexOf("MKTG")!=-1?"checked":""%>>&nbsp;<label for="evtFilter4" ><font size="2">Marketing Locations</label>&nbsp;&nbsp;
					</td>
					<td width="15%" class="tdLbl1" >Event Allowed for Employees of <br/>
						<div class ="form-check form-check-inline">
							<input type ="radio" class ="form-check-input" name="radAllowed" id="radAllowed1" value="t" onclick="return getLocnBy(this)" <%=isTown?"checked":""%>/>
							<label class="form-check-label tdLbl" for ="radAllowed1">Town</label>
						</div>		
						<div class="form-check form-check-inline"> 
							<input  type ="radio" class ="form-check-input" name="radAllowed" id="radAllowed2" value="b" onclick="return getLocnBy(this)" <%=isBU?"checked":""%>/>
							<label class="form-check-label tdLbl" for ="radAllowed2">BU</label>
						</div>
					</td>
					<td width="35%">
						<div <%=isTown?"":"style='display:none'"%> id="divTown"> 	
							<select class="form-control  selectNew" multiple="multiple" name="evtplace" id="evtplace">
							<%if(isTown){
								for(int i = 0;i<newLocnList.size();i++){%>
									<option selected="selected" value = "<%=newLocnList.get(i)%>"><%=newLocnList.get(i)%></option>
								<%}
							}%>
							</select>
						</div>
						<div <%=isBU?"":"style='display:none'"%> id="divBu">
							<select multiple="multiple" class ="form-control  selectNew" name="evtplaceBu" id="buDesc" >
							<%if(isBU){
								for(Map.Entry<String,String> entry : newLocnMap.entrySet()){%>
									<option value = "<%=entry.getKey()%>" selected = "selected"><%=entry.getValue()%></option>
								<%}
							}%>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLbl1">Event Date</td>
					<td>
						<span class ="tdLbl1">From </span> <input type="text" name="evt_date" class="form-control datepicker" id="evt_date" readonly value ="<%=eventFromDate%>">&nbsp;<span class ="tdLbl1">To</span><input type ="text" name ="evt_date_to" class ="form-control datepicker" id ="evt_date_to" readonly value ="<%=eventToDate%>">
					</td>
					<td class="tdLbl1">Last date of Online Application</td>
					<td>
						<input type="text" name="cutofdte" value ="<%=cutOffDate%>" class="form-control datepicker" id ="cutofdte" readonly>
					</td>
				</tr>
				<tr>
					<td class="tdLbl1">Price per ticket</td>
					<td>
						<input type="text" class="form-control" name="priceevt" id ="priceevt" maxlength="5" onkeypress="return isNumeric(event)" value ="<%=ticketPrize%>" onkeydown="return isNumeric(event)">
					</td>
	
					<td class="tdLbl1">Total Tickets for Event</td>
					<td>
						<input type="number" class="form-control" name="nooftickts" id ="nooftickts" maxlength="20" onkeypress="return isNumeric(event)" value ="<%=totalTickets%>" onkeydown="return isNumeric(event)">
					</td>
				</tr>
				<tr>
				<td class="tdLbl1">Max Tickets per employee</td>
				<td>
					<input type="number" class="form-control" name="maxtickemp" id ="maxtickemp" maxlength="20" onkeypress="return isNumeric(event)" value ="<%=maxTicketsEmp%>" onkeydown="return isNumeric(event)">
				</td>
				<td class="tdLbl1">Event Category</td>
				<td>
					<input type="radio" name="evt_cat" id="cat1" value="M" <%=eventCatMgNmt.equals("M")?"checked":""%> class="evt_cat" />&nbsp;<font size="2">
					<label for="cat1">Management&nbsp;&nbsp;&nbsp; </label>
					<input type="radio" name="evt_cat" value="N" <%=eventCatMgNmt.equals("N")?"checked":""%> id="cat2" class="evt_cat"/>&nbsp; <font size="2"><label for="cat2">Non Management&nbsp;&nbsp;&nbsp;</label>
					<input id="cat3" type="radio" name="evt_cat" <%=eventCatMgNmt.equals("B")?"checked":""%> value="B" class="evt_cat"/>&nbsp; <font size="2"><label for="cat3">Both </label>
				</td>
			</tr>
			<tr>
				<td class="tdLbl1">Event Category(Gender)</td>
			<td>
				<input type="radio" name="evt_gen" value="M" <%=eventGender.equals("M")?"checked":""%> id="male" class="evt_gen">&nbsp; <font size="2"><label for="male">Male &nbsp;&nbsp;&nbsp;</label>
				<input type="radio" name="evt_gen" value="F" <%=eventGender.equals("F")?"checked":""%> id="female" class="evt_gen">&nbsp; <font size="2"><label for="female">Female &nbsp;&nbsp;&nbsp;</label>
				<input type="radio" id="both" name="evt_gen" <%=eventGender.equals("B")?"checked":""%> value="B" class="evt_gen">&nbsp; <font size="2"><label for="both">Both &nbsp;&nbsp;&nbsp;</label>
			</td>
			<td class="tdLbl1">Event Available for</td>
			<td>
				<input type="checkbox" name="evt_for" class="evt_for_for" id="E" value="E" <%=eventAllowedFor.indexOf("E")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="E">Employees &nbsp;&nbsp;&nbsp;&nbsp;</label>
				<!--<input type="checkbox" name="evt_for" class="evt_for_for" id="D"  value="D" <%=eventAllowedFor.indexOf("D")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="D">For Dependents&nbsp;&nbsp;&nbsp;&nbsp;</label>-->
				<input type="checkbox" name="evt_for" class="evt_for_for" id="S"  value="S" <%=eventAllowedFor.indexOf("S")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="S">Spouse&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="checkbox" name="evt_for" class="evt_for_for" id="C"  value="C" <%=eventAllowedFor.indexOf("C")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="C">Children&nbsp;&nbsp;&nbsp;&nbsp;</label><br/>
				<input type="checkbox" name="evt_for" class="evt_for_for" id="P"  value="P" <%=eventAllowedFor.indexOf("P")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="P">Parents&nbsp;&nbsp;&nbsp;&nbsp;</label>
				<input type="checkbox" name="evt_for" class="evt_for_for" id="O" value="O" <%=eventAllowedFor.indexOf("O")==-1?"":"checked"%> />&nbsp;<font size="2"><label for="O">Others</label> 
			</td>
		</tr>
		<tr>
			<td class="tdLbl1">Bus Facility Required</td>
			<td>
				<input type="radio" name="bus_req" class="bus_req" data-toggle="modal" data-html="true" data-target="#Modal1"  value="Y" id="bt" <%=busRequirement.equals("Y")?"checked":""%> ><font size="2"> <label for="bt">Yes &nbsp;</label>
				<input type="radio" name="bus_req" class="bus_req" value="N"  id="bt1" <%=busRequirement.equals("N")?"checked":""%>> <font size="2"><label for="bt1">No &nbsp;</label></div>
				<div id="newDiv" <%=!"Y".equals(busRequirement)?"style='display:none'":""%> ><%=nullVal(pickPoints)%></div>
				<input type="hidden" name="boardPnts" id="bPval2" value="<%=nullVal(pickPoints)%>"/>
			</td>
			<td class="tdLbl1">Age Criteria</td>
			<td>
				<div>
				<div style="float:left;width:40%;" class="tdLbl1">Select the Minimum Age &nbsp;
					<select class="form-control" name="minAge" id="minAge">
						<option value="-1">Select</option>
						<% for(int i=4;i<=60;i++){%>
							<option value="<%=i/10==0?"0"+i:i%>" <%=i==tempMinAge?"selected":""%>><%=i/10==0?"0"+i:i%> Years</option>	
						<%}%>
					</select>
				</div>
				<div style="float:right;width:40%;" class="tdLbl1">Select the Maximum Age
					<select class="form-control" name="maxAge" id="maxAge">
						<option value="-1">Select</option>
						<%for(int i=4;i<=80;i++){%>
							<option value="<%=i/10==0?"0"+i:i%>" <%=i==tempMaxAge?"selected":""%>><%=i/10==0?"0"+i:i%> Years</option>	
						<%}%>			
					</select>
				</div>
				</div>
			</td>
		</tr>	
		<tr>
			<td class="tdLbl1">Choose First Admin for Event</td>
			<td>
				<input type="text" name="adminEmp" id="adminEmp" class="form-control" value="<%=admin1%>" />
			</td>
			<td class="tdLbl1">Choose Second Admin for Event</td>
			<td>
				<input type="text" name="adminEmp1" id="adminEmp1" class="form-control" value="<%=admin2%>" />
			</td>
		</tr>
		<tr>
			<td class="tdLbl1">Addition Fields Required to get Data</td>
			<td colspan="3">
				<input type="radio" <%=isAddFields?"checked":""%> name="addField" Value="Y" id="Y" onClick="return chkVals(this)" <%=!isAddFields?"checked":""%> ><label for="Y"> Yes &nbsp;</label>
				<input type="radio" name="addField" Value="N" id="N" onclick="return chkVals(this)"> <label for="N"> No &nbsp;</label>
			</td>
		</tr>		
</table>
<br/>

<div <%=!isAddFields?"style='display:none'":""%> class="chkValDiv">
<%
boolean isRowsExist =false;
query = "select  evt_id,lbl_name,lbl_type,def_value,id,isMandate from nomination_addition where evt_id=?";
psAddFields = con.prepareStatement(query);
psAddFields.setString(1,evt_id);
rsAddFields = psAddFields.executeQuery();
if(rsAddFields.next())
	isRowsExist = true;
%>
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div class="datagrid">
			<table class="table table-bordered" id="ti_table" border="1">
				<thead class ="alert alert-success">
				<tr class ="alert alert-success">
					<th><center>&sect;</center></th>
					<th><center>Label Name</center></th>
					<th><center>Label Type</center></th>
					<th><center>Default values</center></th>
					<th><center>Mandatory</center></th>
				</tr>
				<tbody>
<%
int cntAddRows = 0;
if(isRowsExist){
	rsAddFields = psAddFields.executeQuery();
	while(rsAddFields.next()){cntAddRows++;%>				
				<tr>
					<td><%=cntAddRows%></td>
					<td><%=rsAddFields.getString("lbl_name")%></td>
					<td><%=rsAddFields.getString("lbl_type")%></td>
					<td><%=nullVal(rsAddFields.getString("def_value"))%></td>
					<td><%=nullVal(rsAddFields.getString("isMandate"))%></td>

				</tr>	
	<%}
}%>				
				<tr id="tr" style="display:none" class="tbodytr">
					<td align="center">
					<a onclick="removeRow(<%="#id#"%>,this)" href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
					<td><center><input type="text" name="fieldName" id="fieldName<%="#id#"%>" placeholder="Enter the Name of Label"></center></td>
					<td>
						<select name="lblType" id="lblType<%="#id#"%>">
							<option value="file">File</option>
							<option value="text">Text</option>
							<option value="drop down">Dropdown</option>
							<option value="textarea">Textarea</option>
						</select>
					</td>
					<td><center>
						<input type="text" name="def_type" id="def_type<%="#id#"%>" placeholder="Add the values seperated by commas">
					</center></td>
					<td><center>
						<input type="checkbox" name="ismandetory" id="ismandetory<%="#id#"%>" class="ismandetory<%="#id#"%>" onclick="return isMand('<%="#id#"%>')" value="Y"/>Yes
						<input type="hidden" name="isMand1" id="isMand<%="#id#"%>" class="isMand1" value="N" />
					</center></td>
				</tr>
				</tbody>	
			</table>
		</div>
</div>
<div class="modal fade" id="Modal1" tabindex="-1" role="dialog" aria-labelledby="Modal1" aria-hidden="true">
  <div class="modal-dialog  modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header alert alert-primary">
        <h3 class="modal-title" id="ModalLabel">Insert the Locations seperated by Comma(eg:-Locn1,Locn2)</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<textarea class = "form-control"  name="pickPnts" id="pickPnts" cols="99%" rows="2"><%=pickPointsModel%></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary btn-md" data-dismiss="modal" aria-label="Close" onclick="return boardingPnt()">Proceed</button>
        <!--<button type="button" class="btn btn-info btn-md">Save</button>-->
      </div>
    </div>
  </div>
</div>			
<center>
<%if("".equals(editPara)){%> 
	<button class="btn btn-primary" type="submit" name="submit1" id="submit2" value="Add Event" onclick="return validation();" >Add Event</button>	
	<button type="submit" name="submit1" class="btn btn-primary" id="submit3" id="submit2" value="Add Event and Publish" onclick="return validation();" >Add Event and Publish</button>
<%}else {%>
	<button type = "submit" name = "submit1" value = "Update" class = "btn btn-danger" >Update</button>
<%}%>	
</center>
		</div>
	</div>
	</form>
</body>
<script>
$(".datepicker").datepicker({
			changeMonth: true, 
			changeYear: true,
			dateFormat: "dd-M-yy",
			minDate: new Date(),
			
			
		});
</script>

<script>
	$(function() {
		$('.ajax_popup_link').magnificPopup({ type: 'ajax', });
		$('.inline_popup').magnificPopup({ type: 'inline', });
	});
</script>
<script type="text/javascript">
  $('#bt').click(function() {
	  //alert("aaa");
       $('#bpAddit').click();
  });
</script>
<script type="text/javascript">
  $('#bt1').click(function() {
	 	$("#bPnt").remove();
		$("#bPval2").val();
	});
</script>
<script>
function get(){
	var q=document.getElementById("evtplace").value;
	alert(q)
	if(q != "") {
		$.ajax({
			type: "post",
			url: "List1.jsp",
			data: {q:q},
			success: function(jsonData){
				alert(jsonData);
			jsonObj = JSON.parse(jsonData);
			for(var i = 0; i < jsonObj.length; i++) {
				$("#list").append("<option value='"+jsonObj[i].emp_name+"' Selected>"+jsonObj[i].emp_name+"</option>");
			
			}
			
		},
		error: function(jsonData, status, error){
			alert("Some Error occured");
		}
		});
	} else {
		$("#srp"+id+"").not(':first').remove();
	}
}	  
    </script>

<%@include file="footer.jsp"%>