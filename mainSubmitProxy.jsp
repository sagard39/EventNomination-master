<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
<%@ include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<style>
.listTable{
--background-color:green;
border-spacing: 1px;
border-collapse: separate;
border-collapse:collapse;
width:100%;
}
.listTable tr > th{
--border: px solid #FFFFFF;
box-shadow:0 0 10px #5D6D7E;
background-color: #3092c0;
color:#FFF;
background: -webkit-linear-gradient(top ,#3092c0, #1A5276);
background: -o-linear-gradient(top ,#3092c0, #1A5276);
background: -moz-linear-gradient(top ,#3092c0, #1A5276);
background: -ms-linear-gradient(top ,#3092c0, #1A5276);
background: linear-gradient(top ,#3092c0, #1A5276);
}	
.listTable tr:nth-child(even){
	background:#FDEDEC;
}
.listTable tr:nth-child(odd){
	background:#ebf1fa ;
}
.listTable td{
	padding:1% 0%;
}
.tdLbl1{
    padding: 2px 10px;
    color:#18568e;
    font-weight: bold;
    font-size: 12px;
   }
 h2,h3,h4{
    padding: 2px 10px;
    color:#18568e;
    font-weight: bold;
    font-size: 14px;
	 
 }  
</style>
<script>

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
	if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
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
			var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
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
	if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
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
	var val2=	(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
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
    document.form1.action="mainSubmitProxy.jsp";
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
	var items = document.getElementsByClassName('isMandate');
    for (var i = 0; i < items.length; i++){
			
			if(items[i].value==''){
				if(items[i].name.startsWith("fileFields")){
					if(document.getElementById("addition"+items[i].name.substring(10)).value==''){
					alert("Please fill all the Mandetory fields");
					return false;
					}
				} else {		
					alert("Please fill the Mandetory fields");
					return false;
				}
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
<div>
<%
String query="",eventId="",eventEndDate="",maxTicks="",maxPrize="",noOfTicks="",bPoints="",evtName="",action_type="",bPointEmp="",pAmount="";
String btnnme="",btnclkd = "",title="",ttitle="",status="",empBudesc="",style="",additionalFields="",additionList1="", additionList2="",additionList3="",emp_contact="",emp_bu="",loginEmpGrade = "";
int evtIns=0,count=0;    
String empMail="",ccEmps="",ccMail="",buLocn="";                                                                                          
String fileFields0="",fileFields1="",fileFields2="",Contact_count="";
eventId=nullVal(request.getParameter("eventId"));
Map<String,String> evtMap=new LinkedHashMap<String,String>();
List<String> relCode=new ArrayList<String>();
List<String> othName=new ArrayList<String>();
List<String> othRel=new ArrayList<String>();
List<String> othAge=new ArrayList<String>();
List<String> othGen=new ArrayList<String>();
List<String> othContact=new ArrayList<String>();
List<String> dep_contact=new ArrayList<String>();
List<String> empEntry=new ArrayList<String>();
Map<String,String> addMap=new HashMap<String,String>();
List<String> empContactList=new ArrayList<String>();
List<String> nominationList=new ArrayList<String>();
Map<String,String> othContactMap=new HashMap<String,String>();
Map<String,String> depContactMap=new HashMap<String,String>();
Map<String,String> nominationMap=new HashMap<String,String>();
PreparedStatement psMain=null;

ResultSet rsMain=null;
String evt_cat="";
query="select distinct EVTNME,evt_id from NOMINATION_ADMIN where  (regexp_like(EVTPLACE, trim(?), 'i') or EVTPLACE ='ALL') and to_date(CUTOFDTE+3,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and status='P' order by evt_id";
psMain=con.prepareStatement(query);
psMain.setString(1,town);
rsMain=psMain.executeQuery();
while(rsMain.next()){
	evtMap.put(rsMain.getString("evt_id"),rsMain.getString("EVTNME"));
}
query="select bu,email,grade from empmaster where emp_no=?";
psMain=con.prepareStatement(query);
psMain.setString(1,emp);
rsMain=psMain.executeQuery();
if(rsMain.next()){
	emp_bu=rsMain.getString("bu");
	empMail=rsMain.getString("email");
	loginEmpGrade = rsMain.getString("grade");
}
query="select distinct EVTNME,evt_id,adminemp from NOMINATION_ADMIN where  regexp_like(EVTPLACE, trim('"+emp_bu+"'), 'i') and to_date(CUTOFDTE+3,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and evt_bu='Y' and status='P' order by evt_id";
psMain=con.prepareStatement(query);
rsMain=psMain.executeQuery();
while(rsMain.next()){
	evtMap.put(rsMain.getString("evt_id"),rsMain.getString("EVTNME"));
	ccEmps=nullVal(rsMain.getString("adminemp"));
}
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
if(isMultipart){
	int cn=0;
	ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
	List fileItemsList = servletFileUpload.parseRequest(request);
	Iterator it = fileItemsList.iterator();
	File tempDir = null;
	File tempDir1 = null;
	File tempDir2 = null;
	while (it.hasNext()){
		FileItem fileItem = (FileItem)it.next();{
			String name = fileItem.getFieldName();					
			String value = fileItem.getString();
			if (fileItem.isFormField() ){
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
				if(name.startsWith("addition")){
					addMap.put(name.substring(8,name.length()),value);
					
				}

				if("emp_contact".equals(name)){
						emp_contact=value;
				}
			} else {
			value = fileItem.getName();
			int ind=0;
			String attError="",filePath="",a="",filePath1="",filePath2="";
			boolean checkattach=name.contains("file");
			if(checkattach){ //if attach
				if(!"".equals(value)){
					long fileSize = fileItem.getSize();
					if(fileSize > 0){                           
						int dotPos= value.lastIndexOf(".");
						if(dotPos == -1){
							attError = "Please select the attachment file format to upload with extension";
							out.println("<br><br><br><h4 align=center><font color=red>"+attError+"</h4>");
							return;
						}else{
							String extension = value.substring(dotPos+1);                
							if((extension.equalsIgnoreCase("zip")) && (extension.equalsIgnoreCase("pdf"))){
								attError = "Please  select the attachment in pdf file format or in zip format to upload";
								out.println("<br><br><br><h4 align=center><font color=red>"+attError+"</h4>");
								return;
							}else{
								ServletContext sc = session.getServletContext();
								
								filePath = storepath +"/useruploads1/";
								
								
								tempDir = new File(filePath);
								if(tempDir.exists() == false){
									tempDir.mkdir();
								}
								DateFormat df = new SimpleDateFormat("yyyyMMddhhmmSSS");        
								Date today = Calendar.getInstance().getTime();       
								String reportDate = df.format(today);
								File fileToCreate = null;
								if(name.contains("fileFields")){
									title=emp+"_"+eventId+name.substring(10,name.length())+"."+extension;
									fileFields0=title;
									fileToCreate=new File(filePath, fileFields0);	
								}
										try{
											if(fileToCreate.exists() == false){
												fileItem.write(fileToCreate);
												if(name.contains("fileFields")){
													ttitle = fileFields0.toString();
													fileFields0=ttitle;
													if(	fileFields0==null){
														fileFields0 = "";
													}
													addMap.put(name.substring(10,name.length()),fileFields0);
												}																			
											}else{													
												fileItem.write(fileToCreate);
												if(name.contains("fileFields")){
													ttitle = fileFields0.toString();
													fileFields0=ttitle;
													if(	fileFields0==null){
														fileFields0 = "";
													}
													addMap.put(name.substring(10,name.length()),fileFields0);
												}
											}
											}catch (Exception e){
												attError = "ERROR IN ATTACHMENT UPLOAD";
												e.getMessage();
												out.println("<br><br><br><h4 align=center><font color=red>"+e+"..</h4>");
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
String [] addFieldArr=null;	
String noOfTicksEmp="",evt_for="",evt_date="",miscVal1="",miscVal2="",miscVal3="",ticktRemaind="",ageCriteria="",evt_gen="",tempDep = "",tempDep1="";
int maxTicksNo=0,tickRemNo=0;
boolean isEmp=false,isDep=false,isOther=false,isAllowed=false;
boolean isExclusiveEvt = false;
String flg="";
if(!"".equals(eventId)){
	query="select to_char(CUTOFDTE,'dd-Mon-YYYY') cutOffDate,cast (MAXTICK as int) MAXTICK,MAXPRICE,EVTNME,NOOFMAXTICK,INDIV_TICK,BOARDINGPNT1 bpoints,ADDFIELD,ADMINEMP,EVT_ID,evt_for,bus_facility,to_char(evt_date ,'dd-Mon-yyyy') evt_date,evt_cat,age_criteria,evt_gen from workflow.nomination_admin where evt_id=? and cutofdte+3>=sysdate-1";
	psMain=con.prepareStatement(query);
	psMain.setString(1,eventId);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){
		eventEndDate=nullVal(rsMain.getString("cutOffDate"));
		maxTicksNo=rsMain.getInt("MAXTICK");
		maxPrize=nullVal(rsMain.getString("MAXPRICE"));
		noOfTicksEmp=nullVal(rsMain.getString("NOOFMAXTICK"));
		bPoints=nullVal(rsMain.getString("bpoints"));
		evtName=nullVal(rsMain.getString("EVTNME"));
		additionalFields=nullVal(rsMain.getString("addfield"));
		evt_for=rsMain.getString("evt_for");	
		evt_date=nullVal(rsMain.getString("evt_date"));
		evt_cat=nullVal(rsMain.getString("evt_cat"));	
		evt_gen=nullVal(rsMain.getString("evt_gen"));	
		ageCriteria=nullVal(rsMain.getString("age_criteria"));	
		ccEmps=nullVal(rsMain.getString("ADMINEMP"));	
	}
	if(!"".equals(ccEmps)){
	String[] ccEmpsMembers=ccEmps.split("\\,");
	
	ResultSet rsMail=null;
	String queryMail="select email from empmaster where emp_no=?";
	PreparedStatement psMail=con.prepareStatement(queryMail);
	for(int i=0;i<ccEmpsMembers.length;i++){
		psMail.setString(1,ccEmpsMembers[i]);
		rsMail=psMail.executeQuery();
		if(rsMail.next())
			ccMail +=","+nullVal(rsMail.getString("email"));
	}
	if(rsMail!=null)
		rsMail.close();
	if(psMail!=null)
		psMail.close();
	if(!"".equals(ccMail))	
		ccMail=ccMail.substring(1);
}
	if(!"".equals(additionalFields)){
		addFieldArr=additionalFields.split("-");
		//out.println(addFieldArr.length);
	}
	String [] evt_forArr=evt_for.split(",");
	for(int i=0;i<evt_forArr.length;i++){
		if(evt_forArr[i].equals("E"))
			isEmp=true;
		if(evt_forArr[i].contains("C") || evt_forArr[i].contains("S") || evt_forArr[i].contains("P")){
			isDep=true;
			tempDep = "and relation_code in (";
			if(evt_forArr[i].contains("C")){
				tempDep1+= ",'CH'";
			}if(evt_forArr[i].contains("S")){
				tempDep1 += ",'SP'";
			}if(evt_forArr[i].contains("P")){
				tempDep1 += ",'FA','MO'";
			}

		}
		if(evt_forArr[i].equals("O"))
			isOther=true;
	}	
	if(!"".equals(nullVal(tempDep1))){
		tempDep1 = tempDep1.substring(1);
		tempDep= tempDep+tempDep1+")";
	}
	query="select count(ticktscnt) numVCl,sum(ticktscnt) tickCount from nomination where evtnme=? and flag in('A','S')";
	psMain=con.prepareStatement(query);
	psMain.setString(1,eventId);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){
		
		if(rsMain.getInt("numVCl")>0){
			tickRemNo=maxTicksNo-rsMain.getInt("tickCount");
		}else{
			tickRemNo=maxTicksNo;
		}
	}
	/*********************************Checking the Exclusive Events**********************/
	List<String> exclEvt =new ArrayList<String>();
	String keyExcl = "",valStr = "";
	//boolean isExclusiveEvt = false;
	query = "select key,EVENT_ID from nomination_exclusive where EVENT_ID = ?  or EVENT_ID  in(select EVENT_ID from nomination_exclusive where key = (select key from nomination_exclusive where EVENT_ID = ? ))";
	psMain = con.prepareStatement(query);
	psMain.setString(1,eventId);
	psMain.setString(2,eventId);
	rsMain = psMain.executeQuery();
	while(rsMain.next()){
		exclEvt.add(nullVal(rsMain.getString("EVENT_ID")));
		keyExcl = nullVal(rsMain.getString("key"));
	}
	if(exclEvt.size()>0){
		for(int i =0;i<exclEvt.size();i++){
			valStr += ",'"+exclEvt.get(i)+"'";
		}
		valStr = valStr.substring(1);		
	}
	if(!"".equals(keyExcl)){
		query = "select evtnme,flag from nomination where emp_no=? and evtnme in("+valStr+")";
		
	} else {
		query="select evtnme,flag from nomination where evtnme='"+eventId+"' and emp_no=? ";
	}
	psMain=con.prepareStatement(query);
	psMain.setString(1,emp);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){
		flg=nullVal(rsMain.getString("flag"));
	}if("S".equals(flg)){%>
		<% if(!"".equals(keyExcl)) { %>
		<script>
			alert("You have already Submitted your Nomination for the Same Event in one of the Show Timings available");
			window.location.href="mynomination1.jsp";
		</script>
		<% } else { %>
		<script>
			alert("You have already Submitted your Nomination for this Event");
			window.location.href="mynomination1.jsp";
		</script>
		<% } %>
	<%}if(("".equals(flg) || "X".equals(flg)) && tickRemNo<=0){%>
		<script>
			alert("Sorry, No more tickets available!!!!");
			window.location.href="home.jsp";
		</script>
	<%}
}
String additional_empList = "";
if(!"".equals(eventId)){
	if(bPoints.contains("MR"))
		buLocn=" and (bu like '48%' or bu like '47%' or bu ='10157026')";
	else if(bPoints.contains("VR"))
		buLocn=" and bu like '46%'";
	else if(bPoints.contains("MKTG"))
		buLocn=" and (bu not like '4%')";
	else 
		buLocn=" and bu is not null";	
}
if("2018_156_event".equals(eventId) || "2018_157_event".equals(eventId) || "2018_158_event".equals(eventId)){   // for HPNE Employee Christmas and new Year Event
	//additional_empList = " and emp_no in ('31919150','31918180','39822720','31907930') ";
	//additional_empList = " and emp_no in ('31901030','30065790','31903530','30037530','31917580','30032340','31914960','30037210','31906550','31904980','31982600','31904340','30029950','38030790','31927940','38030810','31908900','31913400','38024860','38026600','31919870','31918720','31928710','30044260','31914710','31901480','31919930','31915500','31919150','31912730','39829290','31918250','31909780','31925770','31918180','38027200','38024000','31919910','31911750','31902810','31918700','30044430','39830480','38023770','31904200','39829130','31910330','38023980','31904230','31918980','31901310','31929130','31905960','30067670','31910920','31901420','38029620','38025160','38028320','31903850','38022160','31908000','31918150','30048010','30047450','31929460','31902120','30066210','38027180','31919430','31909440','38028240','31924030',' 31928380','38024220','31918910','31929580','31914910','31919830','31911920','31919820','31919040','31904510','31918920','31919030','30037880','31925740','30029690','39831570','30067600','30066480','30041660','30041880','30031480','30031760','30030500','31902940','30047630','30048500','30030490','38029280','30031680','30037710','39824670','38023840','38026200','31975970','31909910','30050010','31963050','38024170','31919230','31905230','31975390','31975330','31914520','39831610','30065680','31917460','38025390','30037830','30031670','30039000','31903250','31910840','31910250','31902060','30066120','30047850','39830830','39829140','38026970','30047870','30046150','31900730','31960730','30039990','38025140','39822720','30036840','31909080','38027220','31918450','30028400','31000000','30027370','31923190','38015050','38029300','31921530','31920930','30027990','30068070','30050170','30046770','30035690','30035740','30037380','31903600','30041110','30036480','39828070','31901410','30063670','30039580','30043270','31903980','35315490','31907160','30038890','31905690','39830580','38026190','38025440','31907910','30040950','38029340','30065530','31922480','38027170','31923920','31905360','31904390','31905750','31900450','38024950','31911460','30041930','31915620','31960670','31909680','38027710','30067930','30032790','31973320','30061710','31907810','30042000','31902080','38025370','31907490','31900220','31907090','31912820','39823910','31903900','31900690','39827000','31913810','31907930','31918500','31927910','31905170','30061310','31925820','39829160','31908290','30037840','30043200','31983180','31977930','31937580','31967480','31919180','31960080','38026920','31961700','30062830','30043290','30065200','31918190','30041690','31900950','30030830','31961310','30067730','31962530','31924810','39820010','30030050','31956080','31905730','31961410','30048910','31917240','31960630','30029700','31921420','31920600','31906410','30041090','30067550','39830570','31902170','31926310','31904900','31904310','30066020','31909640','31923940','30067750','31901080','31916000','31925590','31966750','31910340','31905680','31923080','30047670','30041570','31916960','38026170','31913460','30049240','31912880','31902140','31906630','31928380','31905390','31911500','31905580','31968370','30049430','31926780','30041140','31901870','31917830','31956530','31930450','31901670','31960150','31909460','39828200','30038620','31923370','38029260','31903340','31904450','31903110','31975070','38026330','30066350','30041780','31958790','31902840','31900650','31919630','31955890','38028100','30040300','31901770','31909340','31962740','31969310','30041120','31905640','30049340','31909490','30031530','30067920','30041730','31906920','31904700','30065970','31915600','31919400','31966770','31904630','30041860','31903950','30037810','31916110','31924790','31908490','31927220','31904910','31907560','30045370','38027250','31969130','31918640','30041670','30038900','30061290','38026930','31906740','30066380','31950040','31912040','38029250','31920020','30067700','31904760','30065360','31908570','31901920','31963190','31906380','31960930','30038990','31904780','38026610','30044390','31909390','30038920')";
}

String qry="select emp_no from empmaster where emp_no=? "+buLocn;
PreparedStatement psLocn=con.prepareStatement(qry);
psLocn.setString(1,emp);
ResultSet rsLocn=psLocn.executeQuery();
if(!rsLocn.next()){%>
	<script>
		alert("You are Not Allowed to access this Event");
		window.location.href="home.jsp";
	</script>
<%}
if("".equals(ageCriteria))
	ageCriteria="is not null";
else
	ageCriteria="between "+ageCriteria;
if("M".equals(evt_cat) && !"M".equals(empCategory)){%>
	<script>
		alert("This Event is only for Management Employees");
		window.location.href="mainSubmitProxy.jsp";
	</script>
<%}
if("N".equals(evt_cat) && "M".equals(empCategory)){%>
	<script>
		alert("This Event is only for Non-Management Employees");
		window.location.href="mainSubmitProxy.jsp";
	</script>
<%}

if("M".equals(evt_gen) && !"M".equals(empGender)){%>
	<script>
		alert("Only Men are Allowed for this Event");
		window.location.href="mainSubmitProxy.jsp";
	</script>
<%}if("F".equals(evt_gen) && !"F".equals(empGender)){%>
	<script>
		alert("Only Women are Allowed for this Event");
		window.location.href="mainSubmitProxy.jsp";
	</script>
<%}
qry = "select emp_no from workflow.empmaster where emp_no =? "+additional_empList;
psLocn = con.prepareStatement(qry);
psLocn.setString(1,emp);
rsLocn = psLocn.executeQuery();
if(!rsLocn.next()){%>
	<script>
		alert("This Event is Allowed only for HPNE Employees");
		window.location.href = "mainSubmitProxy.jsp";
	</script>
<%}
String FlagUpdate="",tempFlag = "";

if("submitted".equals(btnclkd) || "saved".equals(btnclkd)){
	if("submitted".equals(btnclkd))	
		FlagUpdate="S";
	else if("saved".equals(btnclkd))
		FlagUpdate="A";
	con.setAutoCommit(false);
	
								//*******Entry in master table*******/////
query = "select flag from nomination where evtnme =? and emp_no =?";
psMain = con.prepareStatement(query);
psMain.setString(1,eventId);
psMain.setString(2,emp);
rsMain = psMain.executeQuery();
if(rsMain.next()){
	tempFlag = nullVal(rsMain.getString("flag"));	
}
		if("".equals(tempFlag)){
			query="insert into nomination (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,MODIFYDTE,FLAG,EMP_NO,EVTNME) values(?,?,?,sysdate,?,sysdate,'"+FlagUpdate+"',?,?)";
		}else{
			if("A".equals(tempFlag) || "X".equals(tempFlag)){
			query="update nomination set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,ENTERBY=?,MODIFYDTE=sysdate,FLAG='"+FlagUpdate+"' where emp_no=? and evtnme=? ";
		} else
			return;
		}
		
		psMain=con.prepareStatement(query);
		psMain.setString(1,noOfTicks);
		psMain.setString(2,bPointEmp);
		psMain.setString(3,pAmount);
		psMain.setString(4,emp);
		psMain.setString(5,emp);
		psMain.setString(6,eventId);
		evtIns=psMain.executeUpdate();
		
							/*******Entry For Additional Columns*////////////
		
		query="delete from nomination_emp_add where id in(select id from nomination_addition where evt_id=?) and emp_no=?";
		psMain=con.prepareStatement(query);
		psMain.setString(1,eventId);
		psMain.setString(2,emp);
		psMain.executeUpdate();
		
		query="insert into nomination_emp_add (id,value,emp_no) values(?,?,?)";
		psMain=con.prepareStatement(query);
		for(Map.Entry<String,String> entry:addMap.entrySet()){
			psMain.setString(1,entry.getKey());		
			psMain.setString(2,entry.getValue());		
			psMain.setString(3,emp);		
			psMain.executeUpdate();
		}
		
				/*******delete Entries in Dependent Table to Update Entries*////////
		String delQry="delete from nomination_dependents where emp_no=? and event_name=?";
		PreparedStatement psDel=con.prepareStatement(delQry);
		psDel.setString(1,emp);
		psDel.setString(2,eventId);
		psDel.executeUpdate();
												/////*********To Enter the entry of Employee*******/////
		query="insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate,?)";
		psMain=con.prepareStatement(query);
			
		if(isEmp && empEntry.size()>0){
			String [] arrName=empEntry.get(0).split("#");
			for(int i=0;i<arrName.length;i++){count++;
				psMain.setString(count,arrName[i]);
			}
					psMain.setString(6,eventId);
					psMain.setString(7,emp);
					psMain.setString(8,emp_contact);
					psMain.addBatch();	
		}count=0;

								/****To Enter the JDE Dependents Entry ****/
		if(isDep && relCode.size()>0){
			for(int i=0;i<relCode.size();i++){
				String [] arrName=relCode.get(i).split("#");
				for(int j=0;j<arrName.length-1;j++){count++;
					psMain.setString(count,arrName[j]);
					
				}count=0;	
					psMain.setString(6,eventId);
					psMain.setString(7,emp);
					for(Map.Entry<String,String> entry:depContactMap.entrySet()){
						if(arrName[arrName.length-1].equals(entry.getKey()))
							psMain.setString(8,entry.getValue());
					}	
					psMain.addBatch();	
			}
		}
									//********TO Enter the entry out of JDE Dependents*************************//
		if(isOther && othName.size()>0){
			for(int i=0;i<othName.size();i++){
				if(!"".equals(othName.get(i))){
					psMain.setString(1,othName.get(i));
					psMain.setString(2,othRel.get(i));
					psMain.setString(3,othGen.get(i));
					psMain.setString(4,othAge.get(i));
					psMain.setString(5,"");
					psMain.setString(6,eventId);
					psMain.setString(7,emp);
					psMain.setString(8,othContact.get(i));
					psMain.addBatch();
				}
			}
		}
		boolean isRollBack=false;
		int [] dataArr=psMain.executeBatch();
		if(dataArr.length==0){
			con.rollback();
			isRollBack=true;
		}else{
			con.commit();
		}
		if(isRollBack){%>
			<script>
				alert("Something went Wrong");
				window.location.href="mynomination1.jsp";
			</script>
		<%}else{
			if("S".equals(FlagUpdate)){
				
				String message = "",subject = "";
				subject = devMsgSub+"Event Nomination - ";
				if("2018_133_event".equals(eventId)){
					message = "You have successfully nominated for your team for the Event CORPORATE RANNEETI 6.0<br/><br/>Thank You, <br/><br/>CORPORATE RANNEETI 6.0 Team";

				} else {
					//message = devMsgBody+" You have successfully nominated for participation of <b>"+noOfTicks+"</b> members for the Event <b>" +evtName+" .</b> <br/>Your request is for <b>"+noOfTicks+"</b> participants and the confirmatory amount is Rs. <b>"+pAmount+"</b> .<br/> <br/> Thank You, <br/>"+"<br/>"+ "\""+evtName+"\""+" Team";
					message = devMsgBody+" Your  request for <b>"+noOfTicks+"</b> coupons for <b>" +evtName+" </b> has been successfully registered. <br/> <br/> Thank You, <br/>"+"<br/>"+ "\""+evtName+"\""+" Team";
				}				
				
				if(!"2018_126_event".equals(eventId) && evtIns>0){
					String email_str = email.gen_email_call("APP208","D", " ",message,empMail,ccMail,"",subject+evtName+" ",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());				
				}

			}
			%>
			<script>
			alert("Data Inserted Successfully");
			window.location.href="mynomination1.jsp";
			</script>
		<%}
}count=0;
if(!"".equals(flg) || "A".equals(flg)){
	PreparedStatement psEntry=null;
	ResultSet rsEntry=null;
	String DispQry="select na.evtnme Event_Name,n.EMP_NO,n.TICKTSCNT,n.BOARDPNT,n.PAYMENTCNT,n.EVTNME from nomination_admin na left join nomination n on na.evt_id=n.evtnme where na.evt_id=? and n.emp_no=? and flag <> 'X'";	
	psEntry=con.prepareStatement(DispQry);
	psEntry.setString(1,eventId);
	psEntry.setString(2,emp);
	rsEntry=psEntry.executeQuery();
	if(rsEntry.next()){
		noOfTicks=rsEntry.getString("TICKTSCNT");
		bPointEmp=rsEntry.getString("BOARDPNT");
		pAmount=rsEntry.getString("PAYMENTCNT");
		
	}
	DispQry="select child_name,contact_no from nomination_dependents where event_name=? and emp_no=?";
	psEntry=con.prepareStatement(DispQry);
	psEntry.setString(1,eventId);
	psEntry.setString(2,emp);
	rsEntry=psEntry.executeQuery();
	while(rsEntry.next()){
		nominationList.add(rsEntry.getString("child_name"));
		nominationMap.put(rsEntry.getString("child_name"),rsEntry.getString("contact_no"));
	}	
}
%><br/>
<div class="container">
<form name="form1" method="post"  action="mainSubmitProxy.jsp" enctype="multipart/form-data">
	<input type="hidden" name="age_criteria" id="age_criteria" value="<%=ageCriteria%>">
	<div class="card md-12 box-shadow">
		<div class="card-header alert alert-primary"><h3>New Event Nomination</h3></div>
	<div class="card-body table-responsive">	
<table  class="table table-hover table-bordered listTable"  style="">
		<tr><td width="20%" class="tdLbl1" style="padding:10px;" >Select the Event</td><td style="padding:10px;">
			<select name="eventId" id="eventId" class="form-control" onchange="return sfresh()">
				<option value="-1" >Select</option>
				<%for(Map.Entry<String,String> entry:evtMap.entrySet()){%>
				<option value="<%=entry.getKey()%>" <%=entry.getKey().equals(eventId)?"selected":""%>><%=entry.getValue()%></option>	
				<%}%>
			</select>
		</td>
		<td style="padding:10px;" class="tdLbl1">Date of Event</td>
		<%if("2018_156_event".equals(eventId)){%>
		<td style="padding:10px;">
		<input type="hidden" name="evt_date" class="form-control" value="<%=evt_date%>" readonly>
		<span>25-Dec-2018 & 26-Dec-2018</span>
		</td>
		<%} else {%>
			<td style="padding:10px;"><input type="text" name="evt_date" class="form-control" value="<%=evt_date%>" readonly></td>
		<%}%>	
		</tr>
		<tr><td class="tdLbl1" style="padding:10px;">No of Coupons Required</td>
			<td style="padding:10px;">
			<input type="number" readonly name="noOfTicks" id="tickReq" class="form-control" value="<%=noOfTicks%>" >
			</td>
		<td class="tdLbl1" style="padding:10px;"> Enter the Boarding Point</td>
			<td style="padding:10px;">
				<select name="bPointName" class="form-control" id="bPointName">
					<option value="-1">Select</option>
					<%
					boolean isBoarding = false;
					query="select boarding_point,bus_facility from nomination_bp where evt_id=?";
					PreparedStatement psRow=con.prepareStatement(query);
					psRow.setString(1,eventId);
					ResultSet rsRow=psRow.executeQuery();
					if(rsRow.next()){
						
						if("Y".equals(nullVal(rsRow.getString("bus_facility")))){
								isBoarding =true;
							if(!"".equals(nullVal(rsRow.getString("boarding_point")))){
							String []boardPt=nullVal(rsRow.getString("boarding_point")).split("\\,");
								for(int i=0;i<boardPt.length;i++){%>
									<option value="<%=boardPt[i]%>" <%=boardPt[i].equals(bPointEmp)?"selected":""%>><%=boardPt[i]%></option>
								<%}
							}
						}		
					}%>
					<option value="2" <%=!isBoarding?"selected":""%>>Not Applicable</option>
				</select>
			</td>
		</tr>
	
<%
int countRow=0;
String addQry="";
addQry="select a.evt_id,a.id,b.value,a.lbl_name,a.lbl_type,a.def_value,a.ISMANDATE from nomination_addition a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where  a.evt_id=? order by a.id";
psRow=con.prepareStatement(addQry);
psRow.setString(1,emp);
psRow.setString(2,eventId);
 rsRow=psRow.executeQuery();
while(rsRow.next()){countRow++;%>
		<tr>
			<td class="tdLbl1"><%=rsRow.getString("lbl_Name")%><%=rsRow.getString("ISMANDATE").equals("Y")?"<span style='color:red'>*</span>":""%><input type="hidden" name="isMandate" class="form-control"  value="<%=rsRow.getString("ISMANDATE")%>" ></td>
			<td colspan="3">
	<%if("file".equals(rsRow.getString("lbl_type"))){%>
				<input type="hidden" name="addition<%=rsRow.getString("id")%>" id="addition<%=rsRow.getString("id")%>"  value="<%=nullVal(rsRow.getString("value"))%>" />
				<input type="<%=rsRow.getString("lbl_Type")%>" class="form-control" class="<%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>" name="fileFields<%=rsRow.getString("id")%>" />
			
				<%if(!"".equals(nullVal(rsRow.getString("value")))){%>
					<a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>" target="_blank"><%=nullVal(rsRow.getString("value"))%></a>
				<%}%>
	<%} else if("textarea".equals(rsRow.getString("lbl_type"))){%>

				<textarea class="form-control" cols="100%" rows="2" class="<%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>" name="addition<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
					
	<%} else if("drop down".equals(rsRow.getString("lbl_Type"))){%>
				
				<select name="addition<%=rsRow.getString("id")%>" class="<%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>">
					<option value="">Select</option>
		<%if(!"".equals(nullVal(rsRow.getString("def_value")))){
			String []defValues=nullVal(rsRow.getString("def_value")).split("\\,");
			for(int i=0;i<defValues.length;i++){%>
					<option value="<%=nullVal(defValues[i])%>" <%=defValues[i].equals(rsRow.getString("value"))?"selected":""%> ><%=nullVal(defValues[i])%></option>
			<%}	
		}%>		
				</select>
	<%}else {
		%>
				
			<input type="text" class="form-control" class="<%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>" name="addition<%=rsRow.getString("id")%>" value="<%=nullVal(rsRow.getString("value"))%>" >
	
	<%}%>
			</td>
		</tr>		
<%} float percentVal=0.0f;%>
	<tr><td class="tdLbl1" style="padding:10px;">Total Confirmatory Amount</td><td style="padding:10px;"><input class="form-control" type="number" readonly name="pAmount" id="pAmount" value="<%=pAmount%>"  /></td>
			<td class="tdLbl1" style="padding:10px;">Remaining Tickets</td>
			<center><span id="remTicks" style="display:none"><%=tickRemNo%></span><b></b><span style="display:none"><%=maxTicksNo%></span></center>
			<td style="padding:10px;"><div class="progress">
			<%
			percentVal=((float)tickRemNo/(float)maxTicksNo)*100;
			
			%>
  <div class="progress-bar progress-bar-striped bg-danger" style="width:<%=100.0f-percentVal%>%"><%=maxTicksNo-tickRemNo%></div>
  <div class="progress-bar progress-bar-striped bg-success" style="width:<%=percentVal%>%"><%=tickRemNo%></div>
</div></td>
		</tr>
	</table>
	</div></div>
	</center><br/>
<%if(isEmp){%>
	<!--<center><font size="4" class="tdLbl1"><b>Employee Details</b></font>-->
	<div class="card md-12 box-shadow">
	<div class="card-header alert alert-primary">
		<h2>Employee Details</b></h2></div>
	<div class="card-body table-responsive">
		<table class="table table-hover table-bordered" >	
		<thead class ="alert alert-success"> 
			<tr><th>#</th>
			<th>&sect;</th>
			<th>Employee Name</th>
			<th>Age</th>
			<th>Date of Birth</th>
			<th>Gender</th>
			<th width="15%">Contact No.</th>
		</thead>
		<tbody>
<%
										//**Entry of Employee**//
query="select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,contact_no from "+tempJdep+"jdep join empmaster using(emp_no) where emp_no=? and person_code =? and TRUNC((sysdate-(PERSON_DOB))/365) "+ageCriteria;
if("2018_129_event".equals(eventId)) query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
psMain=con.prepareStatement(query);
psMain.setString(1,emp);
psMain.setString(2,emp);
rsMain=psMain.executeQuery();
while(rsMain.next()){count++;
String relation_string=rsMain.getString("person_code")+"#"+rsMain.getString("relation_code")+"#"+rsMain.getString("gender")+"#"+rsMain.getString("age")+"#"+rsMain.getString("rel_dob");
%>
		<tr>
			<td><%=count%></td>
			<td><input type="checkbox" name="chkBoxEmp" value="<%=relation_string%>" <%=(nominationList.contains(rsMain.getString("person_code")) && ("2018_126_event".equals(eventId)))?"checked":""%> <%="2018_126_event".equals(eventId)?"style = 'display:none'":""%> id="chkEmp<%=count%>" onclick="return guidelineFun1(<%=count%>)"></td>
			<td><%=rsMain.getString("person_name")%></td>
			<!--<td><%=rsMain.getString("RELATION_CODE1")%></td>-->
			<td><%=rsMain.getString("AGE")%></td>
			<td><%=rsMain.getString("rel_dob")%></td>
			<td><%=rsMain.getString("gender1")%></td>
			<td><input type="text" name="emp_contact" class="form-control" id="emp_contact" value="<%=nullVal(rsMain.getString("contact_no"))%>" maxlength="13"></td>
		</tr>
<%}%>	
		</tbody>
	</table></div>
	</div><br/>
								<!--Entry for Employee Details Close-->
								<!--Entry of JDE Dependents Open-->
<%}if(isDep){%>

	<div class="card md-12 box shadow">
	<div class="card-header alert alert-primary">
	<h2>Dependents Details</h2></div>
	<div class="card-body table-responsive">
	<table class="table table-hover table-bordered " border="1">	
		<thead class ="alert alert-success">
			<tr><th>#</th>
			<th>&sect;</th>
			<th>Dependent Name</th>
			<th>Relation</th>
			<th>Age</th>
			<th>Date of Birth</th>
			<th>Gender</th>
			<th width="15%">Contact No.</th>
		</tr></thead>
		<tbody>
<%count=0;

query="select person_code,event_name,person_name,decode(j.gender,'M','Male','F','Female',j.gender)gender1,j.gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,nvl2(nd.contact_no,nd.contact_no,e.contact_no) contact_no from  "+tempJdep+"jdep j left join empmaster e on j.emp_no=e.emp_no left join nomination_dependents nd on j.emp_no=nd.emp_no and j.person_code=nd.child_name and event_name=?  where j.emp_no=? and j.person_code<> ? "+tempDep+"  and person_status_code ='AC' and TRUNC((sysdate-(PERSON_DOB))/365) "+ ageCriteria+" ";
if("2018_129_event".equals(eventId)) query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
query += " order by person_code ";
psMain=con.prepareStatement(query);
psMain.setString(1,eventId);
psMain.setString(2,emp);
psMain.setString(3,emp);
rsMain=psMain.executeQuery();
 while(rsMain.next()){count++;
String relation_string=rsMain.getString("person_code")+"#"+rsMain.getString("relation_code")+"#"+rsMain.getString("gender")+"#"+rsMain.getString("age")+"#"+rsMain.getString("rel_dob")+"#"+count;
%>
		<tr>
			<td><%=count%></td>
			<td><input type="checkbox" name="chkBox" value="<%=relation_string%>" <%=(nominationList.contains(rsMain.getString("person_code")) && ("2018_126_event".equals(eventId)))?"checked":""%> <%="2018_126_event".equals(eventId)?"style = 'display:none'":""%>  id="chk<%=count%>" onclick="return guidelineFun(<%=count%>)"></td>
			<td><%=rsMain.getString("person_name")%></td>
			<td><%=rsMain.getString("RELATION_CODE1")%></td>
			<td><%=rsMain.getString("AGE")%></td>
			<td><%=rsMain.getString("rel_dob")%></td>
			<td><%=rsMain.getString("gender1")%></td>
			<td><input type="text" class="form-control" name="dep_contact<%=count%>" id="dep_contact<%=count%>" value="<%=nullVal(rsMain.getString("contact_no"))%>" maxlength="13" ></td>
			
		</tr>
<%} %>
		<input type="hidden" name="hidCountDep" id="hidCountDep" value="<%=count%>" />

		</tbody>	
	</table></div></div><br/>
<%}%>
					<!--Entry of JDE Entries Close-->
					<!--Entry of Out of JDE Entries Open-->
<%if(isOther){
String temp="",PERSON_CD="";
int counttt=-1;
	%>
        <div class="card md-12 box shadow">
		<div class="card-header alert alert-primary">
		<h2>Guest coupons requests</h2></div>
		<div class="card-body table-responsive">
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div class="datagrid">
			<table class="table table-hover table-bordered" style="border-collapse:collapse;" id="ti_table" >
				<thead class ="alert alert-success">
				<tr class="lst">
				<th><center>&sect;</center></th>
				<th><center>Person Name</center></th>
				<th><center>Relationship</center></th>
				<th><center>Age</center></th>
				<th >Gender</th>
				<th>Contact No</th>
				</tr></thead>
			
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
	if (("").equals(PERSON_CD)){
		 temp="#id#";
	}
/* 	else{
		 temp = ""+counttt;		 
     } */
%>		
	<tbody>		
			<tr id="tr<%="#id#".equals(temp)?"":temp%>" class="tbodytr" style='<%="#id#".equals(temp)?"display: none":""%>'>
					<td align="center">
					<a onclick="removeRow(<%=temp%>,this)" href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
					<td><center><input type="text" name="person_name_add" id="person_name_add<%=temp%>" value=""></center></td>
					<td><center><input type="text" name="rel_add"  id="rel_add<%=temp%>" value="" /><center></td>
					<td><center><input type="number" name="age_rel" maxlength="2"   id="age_rel<%=temp%>" value="" onblur="return ageValid(this)"></center></td>
					<td>
					<select name="gender_rel" id="gender_rel<%=temp%>">
						<option value="M" >Male</option>
						<option value="F" >Female</option>
					</select>
					</td>
				<td >
					<input type="text" name="contact_rel" id="contact_rel<%=temp%>"  maxlength="13"  value=""  >
				</td>
				</tr>
	</tbody>	
<%//}%>
</table></div></div></div>
<input type=hidden id="leg_count" name="leg_count">
<%}%>	
						<!--Entry for Out of JDE entry close-->
<%if(!("".equals(eventId) || "-1".equals(eventId))){%>
<div style="margin:5%">	
	<p <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"style ='display:none'":""%>>
	<input type="checkbox" id="checkval" name="checkval" value="" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":""%> onclick="return chkAllow()" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"style='display:none'":""%>>

	I hereby authorize recovery of (Rs. <b><u><span id="ttt"><%=pAmount%></span></u></b>)through payroll towards confirmatory amount for <b><u><%=evtName%></u></b>. In case of drop out, there shall be no refund.

	<br/>I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or injury occurring during the trip.<br/><br/>
	<div <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"style ='display:none'":""%> id="pay_disclaimer"><marquee behavior="alternate"><span style = "display:none"><b>Note:</b></span><span class="req" style = "display:none">	Payment will be deducted from your salary through automated PTA. However you may edit your requirement of tickets till cut of date <%=eventEndDate%>.</span></marquee><br/><br/></div></p>
	<center>
	<!--<input type="submit" name="submitEvt" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":"style='display:none'"%>  id="submitEvt" value="Save" onclick="return submitEvtForm();">-->
	<input type="submit" name="SubmitConfirm" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":"style='display:none'"%> id="submitEvt1" value="Confirm" onclick="return submitEvtForm1();">
	</center>
	<input type="hidden" name="eventId" id="eventId" value="<%=eventId%>"/>
	<input type="hidden" name="maxTicks" id="maxTicks" value="<%=maxTicks%>" />
	<input type="hidden" name="maxPrize" id="maxPrize" value="<%=maxPrize%>" />
	<input type="hidden" name="noTicks" id="noMaxTicks" value="<%=noOfTicksEmp%>" />
	<input type="hidden" name="ta" id="ta" value="<%=noOfTicks%>" />
	<input type = "hidden" name = "otherTotEntry" id = "otherTotEntry" />
	<input type="hidden" name="bPoints" id="bPoints" value="<%=bPoints%>" />
	<input type="hidden" name="evtName"  value="<%=evtName%>" />
	<input type="hidden" name="remTicks" id="tickCnt" value="<%=tickRemNo%>">
	<input type="hidden" name="action_type"  value="" />
</div>
<%}%>
</form>
<!--<div style="text-align: center; font-weight: bold; font-size: 20px;">
<span style="color: red;">For HP Marathon </span><a href="Marathon/" style="">Click Here</a>
</div>-->