<%@ include file="header.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<style>
	.listTable{
		--background-color:green;
		border-spacing: 2px;
    border-collapse: separate;
	border-collapse:collapse;width:70%
	}
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
.listTable tr:nth-child(even){
	background:#FDEDEC;
}
.listTable tr:nth-child(odd){
	background:#ebf1fa ;
}
.listTable td{
	padding:1% 0%;
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
	var val1=parseInt(document.getElementById("ta").value);
	var tot_amt=parseInt(document.getElementById("pAmount").value);
	val1++;
	remTicks--;
	if(val1<=noOfTicks){
		document.form1.ta.value=val1;
		var val2=val1*maxPrz;
		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("pAmount").value = val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		
	}else{
		alert("Max Ticket capacity exceeded");
		return false;
	}if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}
	var row = $("#tr").html();
	//console.log(row);
	var index = $("#ti_table tbody:first > tr").length;
	row = row.replaceAll("#id#", index);
	//alert(row);
	$("#ti_table tbody:first").append("<tr id='tr"+index+"'>"+row+"</td>");
	$("#leg_count").val(index);
	recalculate()


}
function removeRow(id,aid) {
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var row = $("#tr").html();
	$("#tr"+id).remove();
	var index = $("#ti_table tbody:first > tr").length;
	 row = row.replaceAll("#id#", index-1);
	$("#leg_count").val(index-1);
	 var val1=parseInt(document.getElementById("ta").value);
	val1--;
	document.form1.ta.value=val1;
	var val2=val1*maxPrz;
	remTicks++;	
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
    document.form1.action="main1.jsp";
	var event=document.getElementById("eventId").value;
	alert(event);
	document.form1.submit();
}
function guidelineFun(id){
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	if(document.getElementById("chk"+id).checked ==true){
		var val1=parseInt(document.getElementById("ta").value);
		val1++;
		remTicks--;
		if(val1<=noOfTicks){
			//alert(noOfTicks);
			document.form1.ta.value=val1;
			var val2=val1*maxPrz;
			document.getElementById("ttt").innerHTML = val2;
			document.getElementById("tickReq").value = val1;
			document.getElementById("pAmount").value = val2;
			document.getElementById("remTicks").innerHTML = remTicks;
			document.getElementById("tickCnt").value=remTicks;		
		}else{
			alert("Max Ticket capacity exceeded");
			return false;
		}
		if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}
	
	}else{
		var val1=parseInt(document.getElementById("ta").value);
		val1--;
		remTicks++;
		document.form1.ta.value=val1;
		var val2=val1*maxPrz;
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
	if(document.getElementById("chkEmp"+id).checked ==true){
		var val1=parseInt(document.getElementById("ta").value);
		val1++;
		remTicks--;
		if(val1<=noOfTicks){
			document.form1.ta.value=val1;
			var val2=val1*maxPrz;
			document.getElementById("ttt").innerHTML = val2;
			document.getElementById("tickReq").value = val1;
			document.getElementById("pAmount").value = val2;
			document.getElementById("remTicks").innerHTML = remTicks;
			document.getElementById("tickCnt").value=remTicks;		
		}else{
			alert("Max Ticket capacity exceeded");
			return false;
		}if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}
	
	}else{
		var val1=parseInt(document.getElementById("ta").value);
		val1--;
		remTicks++;
		document.form1.ta.value=val1;
		var val2=val1*maxPrz;
		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("pAmount").value= val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		
	}	
}

function submitEvtForm(){
	var isValid=document.getElementById("tickReq").value;
	if(isValid<=0){
		alert("Please Select the Entries before Submission");
		return false;
	}
	document.form1.action_type.value="addEvent";
	document.form1.submit();
}
function chkAllow(){
	$("#submitEvt").toggle();
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
String btnnme="",btnclkd = "",title="",ttitle="",status="",empBudesc="",style="",additionalFields="",additionList1="", additionList2="",additionList3="",emp_contact="";
int evtIns=0,count=0;                                                                                              
String fileFields0="",fileFields1="",fileFields2="";
eventId=nullVal(request.getParameter("eventId"));                                                                   
//action_type=nullVal(request.getParameter("action_type"));
Map<String,String> evtMap=new HashMap<String,String>();
List<String> relCode=new ArrayList<String>();
List<String> othName=new ArrayList<String>();
List<String> othRel=new ArrayList<String>();
List<String> othAge=new ArrayList<String>();
List<String> othGen=new ArrayList<String>();
List<String> othContact=new ArrayList<String>();
List<String> dep_contact=new ArrayList<String>();
List<String> empEntry=new ArrayList<String>();
Map<String,String> addMap=new HashMap<String,String>();
PreparedStatement psMain=null;
ResultSet rsMain=null;
query="select distinct EVTNME,evt_id from NOMINATION_ADMIN where  regexp_like(EVTPLACE, trim(?), 'i') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') order by EVTNME";
psMain=con.prepareStatement(query);
psMain.setString(1,town);
rsMain=psMain.executeQuery();
while(rsMain.next()){
	evtMap.put(rsMain.getString("evt_id"),rsMain.getString("EVTNME"));
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
				if("boardpnt".equals(name)){
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
				/*if("addition1".equals(name)){
						additionList1=value;
				}
				if("addition2".equals(name)){
					if(value!=null)
							additionList2=value;
				}
				if("addition3".equals(name)){
						additionList3=value;
				}*/
				if("dep_contact".equals(name)){
					dep_contact.add(value);
				}

				if(name.startsWith("addition")){
					addMap.put(name.substring(8,name.length()),value);
				}
				if("emp_contact".equals(name)){
						emp_contact=value;
				}
				/*if("sts".equals(name)){
						sts=value;
				}if("empn".equals(name)){
						empn=value;
				}if("depName".equals(name)){
					depList.add(value);
				}*/
				
			}else{
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
								/*File fileToCreate1 = null;
								File fileToCreate2 = null;*/
								/*if(name.equals("fileFields1")){
									title = emp+"_"+eventId+"1"+"."+extension;
									fileFields0 = title;
									fileToCreate = new File(filePath, fileFields0);	
								}if(name.equals("fileFields2")){
									title = emp+"_"+eventId+"2"+"."+extension;
									fileFields1 = title;
									fileToCreate = new File(filePath, fileFields1);
								}if(name.equals("fileFields3")){
									title = emp+"_"+eventId+"3"+"."+extension;
									fileFields2 = title;
									fileToCreate = new File(filePath, fileFields2);	
								}*/
								if(name.startsWith("fileFields")){
									title=emp+"_"+eventId+name.substring(10,name.length())+"."+extension;
									fileFields0=title;
									fileToCreate=new File(filePath, fileFields0);	
								}
								try{
									if(fileToCreate.exists() == false){
										fileItem.write(fileToCreate);
										//out.println("file zise"fileItem.getSize());
										ttitle = title.toString();
										/*if(name.equals("fileFields1")){
											ttitle = fileFields0.toString();
											fileFields0=ttitle;
											if(	fileFields0==null){
												fileFields0 = "";
											}
										}if(name.equals("fileFields2")){
											ttitle = fileFields1.toString();
											fileFields1=ttitle;
											if(	fileFields1==null){
												fileFields1 = "";
											}
										}if(name.equals("fileFields3")){
											ttitle = fileFields2.toString();
											fileFields2=ttitle;
											if(	fileFields2==null){
												fileFields2 = "";
											}
										}*/if(name.startsWith("fileFields")){
											ttitle = fileFields0.toString();
											fileFields0=ttitle;
											if(	fileFields0==null){
												fileFields0 = "";
											}
											addMap.put(name.substring(10,name.length()),fileFields0);
										}
									} else{
										out.println("File Already Exist!!");
									}
								}catch (Exception e){
									attError = "ERROR IN ATTACHMENT UPLOAD";
									e.getMessage();
									out.println("<br><br><br><h4 align=center><font color=red>"+e+"</h4>");
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
	out.println("aaaa"+addMap);
String [] addFieldArr=null;	
String noOfTicksEmp="",evt_for="",evt_date="",miscVal1="",miscVal2="",miscVal3="",ticktRemaind="";
int maxTicksNo=0,tickRemNo=0;
boolean isEmp=false,isDep=false,isOther=false,isAllowed=false;
if(!"".equals(eventId)){
	query="select to_char(CUTOFDTE,'dd-Mon-YYYY') cutOffDate,cast (MAXTICK as int) MAXTICK,MAXPRICE,EVTNME,NOOFMAXTICK,INDIV_TICK,BOARDINGPNT,ADDFIELD,ADMINEMP,EVT_ID,evt_for,bus_facility,to_char(evt_date ,'dd-Mon-yyyy') evt_date from nomination_admin where evt_id=? and cutofdte>=sysdate-1";
	psMain=con.prepareStatement(query);
	psMain.setString(1,eventId);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){
		eventEndDate=nullVal(rsMain.getString("cutOffDate"));
		maxTicksNo=rsMain.getInt("MAXTICK");
		maxPrize=nullVal(rsMain.getString("MAXPRICE"));
		noOfTicksEmp=nullVal(rsMain.getString("NOOFMAXTICK"));
		bPoints=nullVal(rsMain.getString("BOARDINGPNT"));
		evtName=nullVal(rsMain.getString("EVTNME"));
		additionalFields=nullVal(rsMain.getString("addfield"));
		evt_for=rsMain.getString("evt_for");	
		evt_date=nullVal(rsMain.getString("evt_date"));	
	}
	if(!"".equals(additionalFields)){
		addFieldArr=additionalFields.split("-");
		//out.println(addFieldArr.length);
	}
	/*query="select * from nomination_BU where evt_id=?";
	psMain=con.prepareStatement(query);
	psMain.setString(1,eventId);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){
		evt_for=rsMain.getString("evt_for");	
	}*/

	String [] evt_forArr=evt_for.split(",");
	for(int i=0;i<evt_forArr.length;i++){
		if(evt_forArr[i].equals("E"))
			isEmp=true;
		if(evt_forArr[i].equals("D"))
			isDep=true;
		if(evt_forArr[i].equals("O"))
			isOther=true;
	}
	query="select count(ticktscnt) numVCl,sum(ticktscnt) tickCount from nomination where evtnme=(select evtnme from nomination_admin where  evt_id=?)";
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
	query="select evtnme from nomination where evtnme=(select evtnme from nomination_admin where evt_id=?) and emp_no=?";
	psMain=con.prepareStatement(query);
	psMain.setString(1,eventId);
	psMain.setString(2,emp);
	rsMain=psMain.executeQuery();
	if(rsMain.next()){%>
		<script>
			alert("You Have already Submitted the Entry for the Same Event");
			window.location.href="mynomination.jsp";
		</script>
	<%}
	if(tickRemNo<=0){%>
		<script>
			alert("Sorry,No more tickets available!!!!");
			//window.location.href="header.jsp";
		</script>
	<%}
}
	

if("".equals(additionList1))
	miscVal1=fileFields0;
else 
	miscVal1=additionList1;

if("".equals(additionList2))
	miscVal2=fileFields1;
else 
	miscVal2=additionList2;

if("".equals(additionList3))
	miscVal3=fileFields2;
else 
	miscVal3=additionList3;

if("submitted".equals(btnclkd)){
	con.setAutoCommit(false);
	query="insert into nomination (EMP_NO,TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,MODIFYDTE,EVTNME,FLAG,misc1,misc2,misc3) values(?,?,?,?,sysdate,?,sysdate,?,'A',?,?,?)";
	psMain=con.prepareStatement(query);
	psMain.setString(1,emp);
	psMain.setString(2,noOfTicks);
	psMain.setString(3,"Dummy");
	psMain.setString(4,pAmount);
	psMain.setString(5,emp);
	psMain.setString(6,evtName);
	psMain.setString(7,miscVal1);
	psMain.setString(8,miscVal2);
	psMain.setString(9,miscVal3);
	evtIns=psMain.executeUpdate();
	query="insert into nomination_emp_add values(?,?,?)";
	psMain=con.prepareStatement(query);
	for(Map.Entry<String,String> entry:addMap.entrySet()){
		psMain.setString(1,entry.getKey());		
		psMain.setString(2,entry.getValue());		
		psMain.setString(3,emp);		
		psMain.executeUpdate();
	}
	
	if(isEmp && empEntry.size()>0){
		String [] arrName=empEntry.get(0).split("#");
		query="insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate,?)";
		psMain=con.prepareStatement(query);
		for(int i=0;i<arrName.length;i++){count++;
			psMain.setString(count,arrName[i]);
		}
				psMain.setString(6,eventId);
				psMain.setString(7,emp);
				psMain.setString(8,emp_contact);
				psMain.executeUpdate();	
	}count=0;
	if(isDep && relCode.size()>0){
		for(int i=0;i<relCode.size();i++){
			String [] arrName=relCode.get(i).split("#");
			query="insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate)";
			psMain=con.prepareStatement(query);
			for(int j=0;j<arrName.length;j++){count++;
				psMain.setString(count,arrName[j]);
			}count=0;	
				psMain.setString(6,eventId);
				psMain.setString(7,emp);
				psMain.executeUpdate();	
		}
	}
	if(isOther && othName.size()>0){
		for(int i=0;i<othRel.size()-1;i++){
			query="insert into  nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no) values(?,?,?,?,?,?,sysdate,?)";
			psMain=con.prepareStatement(query);
			psMain.setString(1,othName.get(i));
			psMain.setString(2,othRel.get(i));
			psMain.setString(3,othGen.get(i));
			psMain.setString(4,othAge.get(i));
			psMain.setString(5,eventId);
			psMain.setString(6,emp);
			psMain.setString(7,othContact.get(i));
			psMain.executeUpdate();
		}
	}
	con.commit();
	if(evtIns>0){%>
		<script>
		alert("Details Submitted Successfully");
		</script>
	<%}

}count=0;
%><br/><br/><br/>
<form name="form1" method="post"  action="main1.jsp" enctype="multipart/form-data">
	<center><table class="listTable" border="1" style="">
		<tr><td>Select the Event</td><td>
			<select name="eventId" id="eventId" onchange="return sfresh()">
				<option value="-1" >Select</option>
				<%for(Map.Entry<String,String> entry:evtMap.entrySet()){%>
				<option value="<%=entry.getKey()%>" <%=entry.getKey().equals(eventId)?"selected":""%>><%=entry.getValue()%></option>	
				<%}%>
			</select>
		</td></tr>
		<tr>
			<td>Date of Event</td><td><input type="text" name="evt_date" value="<%=evt_date%>" readonly></td>
		</tr>
		<tr><td>No of Tickets Required</td>
			<td><input type="number" readonly name="noOfTicks" id="tickReq" value="">
		</td></tr>
		<tr><td>Enter the Boarding Point</td>
			<td><input type="text" name="bPoint" id="bPoint">
		</td></tr>
		<tr><td>Total Payable Amount</td><td><input type="number" readonly name="pAmount" id="pAmount" value="" /></td></tr>
<%
int countRow=0;
PreparedStatement psRow=con.prepareStatement("select * from nomination_addition where evt_id=?");
psRow.setString(1,eventId);
ResultSet rsRow=psRow.executeQuery();
while(rsRow.next()){countRow++;%>
		<tr><td><%=rsRow.getString("lbl_Name")%></td><td>
<%if("file".equals(rsRow.getString("lbl_type"))){%>
		<input type="<%=rsRow.getString("lbl_Type")%>" name="fileFields<%=rsRow.getString("id")%>" >
<%} else if("textarea".equals(rsRow.getString("lbl_type"))){%>
		<textarea cols="100%" rows="2" name="addition<%=rsRow.getString("id")%>"></textarea>
<%} else if("dropdown".equals(rsRow.getString("lbl_Type"))){%>
		<select name="addition<%=rsRow.getString("id")%>">
			<option value="">
			</option>
		</select>
<%}else{%>
		<input type="text" name="addition<%=rsRow.getString("id")%>" >
<%}%>
</td></tr>		
<%}
%>
		<tr><td>Remaining Tickets</td><td><center><span id="remTicks"><%=tickRemNo%></span><b>/</b><%=maxTicksNo%></center></td></tr>
	</table></center><br/>
<%
if(isEmp){%>
	<center><font size="4"><b>Employee Details</b></font>
	<table class="listTable" border="1">	
		<thead>
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
query="select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob from portal.jdep where emp_no=? and person_code =?";
psMain=con2.prepareStatement(query);
psMain.setString(1,emp);
psMain.setString(2,emp);
rsMain=psMain.executeQuery();
while(rsMain.next()){count++;
String relation_string=rsMain.getString("person_code")+"#"+rsMain.getString("relation_code")+"#"+rsMain.getString("gender")+"#"+rsMain.getString("age")+"#"+rsMain.getString("rel_dob");

%>
		<tr>
			<td><%=count%></td>
			<td><input type="checkbox" name="chkBoxEmp" value="<%=relation_string%>" id="chkEmp<%=count%>" onclick="return guidelineFun1(<%=count%>)"></td>
			<td><%=rsMain.getString("person_name")%></td>
			<!--<td><%=rsMain.getString("RELATION_CODE1")%></td>-->
			<td><%=rsMain.getString("AGE")%></td>
			<td><%=rsMain.getString("rel_dob")%></td>
			<td><%=rsMain.getString("gender1")%></td>
			<td><input type="number" name="emp_contact" id="emp_contact"></td>
		</tr>
<%}%>	
		</tbody>
	</table><br/>
	
<%}if(isDep){%>

	<center><font size="4"><b>Dependents Details</b></font>
	<table class="listTable" border="1">	
		<thead>
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
<%
query="select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob from portal.jdep where emp_no=? and person_code <> ? order by person_code";
psMain=con2.prepareStatement(query);
psMain.setString(1,emp);
psMain.setString(2,emp);
rsMain=psMain.executeQuery();
while(rsMain.next()){count++;
String relation_string=rsMain.getString("person_code")+"#"+rsMain.getString("relation_code")+"#"+rsMain.getString("gender")+"#"+rsMain.getString("age")+"#"+rsMain.getString("rel_dob");
%>
		<tr>
			<td><%=count%></td>
			<td><input type="checkbox" name="chkBox" value="<%=relation_string%>" id="chk<%=count%>" onclick="return guidelineFun(<%=count%>)"></td>
			<td><%=rsMain.getString("person_name")%></td>
			<td><%=rsMain.getString("RELATION_CODE1")%></td>
			<td><%=rsMain.getString("AGE")%></td>
			<td><%=rsMain.getString("rel_dob")%></td>
			<td><%=rsMain.getString("gender1")%></td>
			<td><input type="number" name="dep_contact" id="dep_contact<%=count%>" ></td>
		</tr>
<%}%>
		</tbody>	
	</table></center><br/>
<%}%>

<%if(isOther){%>
        <center>
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div clas="datagrid">
			<table class="listTable" style="border-collapse:collapse;" id="ti_table" border="1">
				<tr class="lst">
				<th><center>&sect;</center></th>
				<th><center>Person Name</center></th>
				<th><center>Relationship</center></th>
				<th><center>Age</center></th>
				<th >Gender</th>
				<th>Contact No</th>
				</tr>
				<tbody>
			<tr id="tr" style="display:none" class="tbodytr">
					<!--<td align="center"><span class="numberRow"><strong></strong></span>
					<input type="checkbox" name="chkboxx" id="chkB<%="#id#"%>" onclick="return guideLine1(<%="#id#"%>)">
					</td>-->
					<td align="center">
					<a onclick="removeRow(<%="#id#"%>,this)" href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
					<td><center><input type="text" name="person_name_add" id="person_name_add<%="#id#"%>"></center></td>
					<td><center><input type="text" name="rel_add"  id="rel_add<%="#id#"%>" /><center></td>
					<td><center><input type="number" name="age_rel" maxlength="2"   id="age_rel<%="#id#"%>"></center></td>
					<td>
					<select name="gender_rel" id="gender_rel<%="#id#"%>">
						<option value="M">Male</option>
						<option value="F">Female</option>
					</select>
					</td>
				<td >
					<input type="text" name="contact_rel" id="contact_rel<%="#id#"%>" value="" maxlength="13" >
				</td>
				</tr>
</tbody>	
</table></div></center>
<input type=hidden id="leg_count" name="leg_count">

<%}%>	
<%if(!("".equals(eventId) || "-1".equals(eventId))){%>
<div style="margin:5%">	
	<input type="checkbox" id="checkval" name="checkval" value="" onclick="return chkAllow()"> I hereby authorize recovery of (Rs. <b><u><span id="ttt"></span></u></b>)through payroll towards employee contribution for <b><u><%=evtName%></u></b>. In case of drop out, there shall be no refund.<br/>I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or injury occurring during the trip.<br/><br/>
	<div id="pay_disclaimer"><marquee behavior="alternate"><b>Note:</b><span class="req">	Payment will be deducted from your salary through automated PTA.However you may edit your requirment of tickets till cut of date <%=eventEndDate%>.</marquee><br/><br/></div>
	<center><input type="submit" name="submitEvt" style="display:none" id="submitEvt" value="Confirm Submission" onclick="return submitEvtForm();"></center>
	<input type="hidden" name="eventId" id="eventId" value="<%=eventId%>" />
	<input type="hidden" name="maxTicks" id="maxTicks" value="<%=maxTicks%>" />
	<input type="hidden" name="maxPrize" id="maxPrize" value="<%=maxPrize%>" />
	<input type="hidden" name="noTicks" id="noMaxTicks" value="<%=noOfTicksEmp%>" />
	<input type="hidden" name="ta" id="ta" value="0" />
	<input type="hidden" name="bPoints" id="bPoints" value="<%=bPoints%>" />
	<input type="hidden" name="evtName"  value="<%=evtName%>" />
	<input type="hidden" name="remTicks" id="tickCnt" value="<%=tickRemNo%>">
	<input type="hidden" name="action_type"  value="" />
</div>
<%}%>
</form>