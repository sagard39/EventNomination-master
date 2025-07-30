<%@include file="header.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart" %>


<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<style>
	.listTable{
		background-color:green;
		border-spacing: 1px;
    border-collapse: separate;
	}
	.lst{
	background-color:#ECE0F8;
	 border-spacing: 1px;
    border-collapse: separate;
	text-align:center;
	}
	
a:hover {
    text-decoration:inherit;
	font-style:italic;
    color:Blue;
	
}
</style>

<script>
function sfresh() {
    document.form.action="main.jsp";
	var event=document.getElementById("eventname").value;
	alert(event);
	/*if(event=="SUMMER CAMP FOOTLOOSE"){
		alert("Age Critertia is 8 to 12 years(as on 31-07-17)");
	}else if(event=="Monsoon Hike 7:00 AM" || event="Monsoon Hike 8:00 AM"){
		alert("Age Critertia is 13 to 18 years(as on 31-07-17)");
	}*/
	document.form.submit();
}
</script>
<script>
$(document).ready(function() {
$('div#dialog').dialog({ autoOpen: false })
$('#confirm').click(function(){ $('div#dialog').dialog('open'); });
})
  </script>
  <script>
	function checkBoxVal(obj){
		var curCount = document.getElementById("noofticks").value;
		if(obj.checked)
			curCount++;
		else
			curCount--;
		document.getElementById("noofticks").value=curCount;
		amountChange(curCount);
		}
	function alrt(){
		alert("Please select Dependents from the list below");
		return false;
	}
  </script>
 
		<%
		/* JDE Data  */
		//31952830
		/*String storepath2="hpcl_grp1\\Cricket\\";
	String storepath1=request.getRealPath("/");
	String storepath=storepath1+storepath2;*/
		int noofticks1=0;
		double 	paymnt1=0.0;
		String empn="",sysdte="",car_no="",misc1="",eventname="";
			String qryins = "",sts="";
		String noofticks="" ,boardpnt ="",paymnt ="";
		String btnnme="",btnclkd = "",title="",ttitle="",status="",empBudesc="",style="";
		String fields="";
		String misc2="",misc3="";
		String maritalsts = "";
		String childName="";
		String childAge="";
		String childDOB="";
		int index=0;
		String checked="",needCycle="";
		PreparedStatement pmstgetsts = null;
		ResultSet rsgetsts = null;
		String fileFields0="",fileFields1="",fileFields2="";
		eventname=request.getParameter("eventname");
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
				if(name.equals("submit1")){
				btnclkd="submitted";
				
			}
				if("eventname".equals(name)){
						eventname=value;
						
				}
				if("noofticks".equals(name)){
						noofticks=value;
					
				}
				if("boardpnt".equals(name)){
						boardpnt=value;
				}
				if("paymnt".equals(name)){
						paymnt=value;
				}if("sts".equals(name)){
						sts=value;
				}if("empn".equals(name)){
						empn=value;
				}
				
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
								File fileToCreate1 = null;
								File fileToCreate2 = null;
								if(name.equals("fileFields")){
									title = emp+"."+extension;
									fileFields0 = title;
									fileToCreate = new File(filePath, fileFields0);	
								} 
								try{
									if(fileToCreate.exists() == false){
										fileItem.write(fileToCreate);
										//out.println("file zise"fileItem.getSize());
										ttitle = title.toString();
										if(name.equals("fileFields0")){
											ttitle = fileFields0.toString();
											fileFields0=ttitle;
											if(	fileFields0==null){
												fileFields0 = "";
											}
										}
										
										
									} else{
										//out.println("File Already Exist!!");
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
	

		
		
		
	//out.println("AA"+empn);	
	//empn="31919150";
		
		
		
		
		
		
		
		
		//SELECT YAMSA,YAAN8 FROM PRODDTA/F060120 WHERE YAAN8='31919150'
		pmstgetsts = con1.prepareStatement("SELECT YAMSA,YAAN8 FROM PRODDTA/F060120 WHERE YAAN8=?");
		pmstgetsts.setString(1,emp);
		rsgetsts = pmstgetsts.executeQuery();
		if(rsgetsts.next()){
			maritalsts =rsgetsts.getString(1);
		}
		int j=0;
		//String eventname = request.getParameter("eventname");
		
		Statement st =con.createStatement();
		PreparedStatement pmstselqry = null;
		String dbempno ="",dbboardpnt="",dbnoofticks ="",dbtotalpaymnt="0",dbsysdte="";
		Double dbpaymnt = 0.0;
		String dbeventname="";
		if(("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname)) || ("Tata Mumbai Marathon - Half Marathon".equals(eventname)) || ("Tata Mumbai Marathon - 10 Km Run".equals(eventname))){
			pmstselqry = con.prepareStatement("select EMP_NO from nomination where EMP_NO =? and EVTNME in ('CSR Tata Mumbai Marathon - Chanmpions of Disability','Tata Mumbai Marathon - Half Marathon','Tata Mumbai Marathon - 10 Km Run') and (flag<>'X' or flag is null) ");
			pmstselqry.setString(1,emp);
			rs = pmstselqry.executeQuery();
			if(rs.next()){
			%>
				<script>alert("You have already applied for this event.");
				location.href="mynomination.jsp";</script>
			<%}	
			}
		
		pmstselqry = null;
		PreparedStatement pmst=null;
		rs =null;
		 ResultSet rs1=null;
		pmstselqry = con.prepareStatement("select EMP_NO,TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,EVTNME from nomination where EMP_NO =? and EVTNME =? and (flag<>'X' or flag is null)");
		pmstselqry.setString(1,emp);
		pmstselqry.setString(2,eventname);
		rs = pmstselqry.executeQuery();
		if(rs.next()){ %>
			<script>alert("You have already applied for this event. Please go to my nominations and edit the event");
			location.href="mynomination.jsp";</script>
			<%
			dbempno = rs.getString(1);
			emp = dbempno;
			dbnoofticks = rs.getString(2); if(dbnoofticks == null){dbnoofticks = "";}
			dbboardpnt = rs.getString(3);
			dbtotalpaymnt = rs.getString(4);if(dbtotalpaymnt == null){dbtotalpaymnt = "0";}
			dbpaymnt = Double.parseDouble(dbtotalpaymnt);
			dbsysdte = rs.getString(5);
			dbeventname = rs.getString(7);
			eventname = dbeventname;
			
		}
		
		String evtplace="",cutofdte="",maxnoofticks="0",maxprice="0",evtnme="",maxtickemp="";
		String tempevt = "";
		boolean isExist =false;
		String tstQry1="select distinct EVTNME from NOMINATION_ADMIN where  regexp_like(EVTPLACE, trim('"+town+"'), 'i') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') order by EVTNME";
		pmstselqry = con.prepareStatement(tstQry1);
		//pmstselqry.setString(1,town);
		
		rs = pmstselqry.executeQuery();
		while(rs.next()){
			evtnme = rs.getString(1);
			if(evtnme.equals(eventname)){
				tempevt+="<option value='"+evtnme+"' selected>"+evtnme+"</option>";
				
			} else {
				tempevt+="<option value='"+evtnme+"'>"+evtnme+"</option>";
				
			}
			
			isExist = true;
		}
		
		if(isExist==false){
			%>
			<script>
			alert("There is no event in your town at present");
			
			</script>
		<%
		}
		if(isExist == true){
		int ticktsremain = 0;
		int nettickremain = 0;
		int remaingtick =0;
		String tstQry2="SELECT sum(TICKTSCNT) FROM NOMINATION WHERE EVTNME='"+eventname+"' and (flag<>'X' or flag is null)";
		pmstselqry = con.prepareStatement(tstQry2);
		//pmstselqry.setString(1,eventname);
		
		rs = pmstselqry.executeQuery();
		if(rs.next()){
			nettickremain = rs.getInt(1);
			if(String.valueOf(nettickremain) == null){
				nettickremain = 0;
			}
		} else {
			nettickremain = 0;
		}
		rs = null;
		pmstselqry = null;
		String tstQry="select EVTPLACE,to_char(CUTOFDTE,'dd-Mon-yyyy'),MAXTICK,MAXPRICE,EVTNME,INDIV_TICK,ADDFIELD from NOMINATION_ADMIN where regexp_like(EVTPLACE, trim('"+town+"'), 'i') and EVTNME='"+eventname+"'";
		pmstselqry = con.prepareStatement(tstQry);
		//pmstselqry.setString(1,town);
		//pmstselqry.setString(2,eventname);
		
		rs = pmstselqry.executeQuery();
		while(rs.next()){
			
			evtplace = rs.getString(1);
			cutofdte = rs.getString(2);
			maxnoofticks = rs.getString(3);
			ticktsremain = Integer.parseInt(maxnoofticks);
			maxprice = rs.getString(4);
			eventname = rs.getString(5);
			maxtickemp = rs.getString(6);
			fields=rs.getString(7);
			maxnoofticks = maxtickemp;
			/* if(("M").equals(maritalsts)){
			maxnoofticks = maxtickemp;
			} else{
				maxnoofticks = "2";
			} */
		} 
		
		String []fieldsName=null;
		if(!(fields ==null || ("".equals(fields))))
			fieldsName=fields.split("\\-");
		
		if(eventname!=null){
		remaingtick = ticktsremain-nettickremain ;
		if(remaingtick <=0){
			%>
			<script>alert("We have already reached the maximum no. of Requests that could be accommodated for this event. Thank You !!");
			location.href="mynomination.jsp";
			</script>
		<%}
		}
		//String [] boardloc = new String[]{"Andheri","Borivali","BKC","HP Nagar (W)","Dadar","HP Nagar (E)","Thane","Own arrangement","Vashi"};
		String [] boardloc = new String[]{"HP Nagar East","Vashi","Dadar"};
		%>
<script>
$( document ).ready(function() {
	var noofticks =0;
	$("#noofticks").on("keyup keydown change ",function(){
		noofticks = this.value;
		$("#paymnt").val(<%=maxprice%> * noofticks);
		$("#totval").html($("#paymnt").val());
		if($("#paymnt").val()=="0") {
			$("#pay_disclaimer").hide();
		} else {
			$("#pay_disclaimer").show();
		}
	});	
	
	$('input[id="checkval"]').click(function(){
            if($(this).prop("checked") == true){
				$(".submitcls").show();
            }
            else if($(this).prop("checked") == false){
				$(".submitcls").hide();
            }
	});	
});
</script>
<script>
function validate(){
	var paymnt = document.getElementById("paymnt").value;
	if("" == paymnt || "0" == paymnt || "0.0" == paymnt){
		//alert("You have not selected no. of Tickets");
		//return false;
	}
	var eventname=document.getElementById("eventname").value;
	/* alert(eventname);
	if(eventname=='CSR Tata Mumbai Marathon - Chanmpions of Disability' || eventname='Tata Mumbai Marathon - Half Marathon' || eventname='Tata Mumbai Marathon - 10 Km Run'){ */	
		var uploadFile=document.getElementById("fileField").value.trim();
		if(uploadFile==''){
			alert("Please Attach the file");
			return false;	
		}
	/*  } */ 
	var noofticks = document.getElementById("noofticks").value;
	if(uploadFile==''){
		alert("Please Upload The attachment");
		return false;
	}
	/*if("" == noofticks || "0" == boardpnt ||"0.0" == noofticks){
		alert("You have not selected no. of Tickets");
		return false;
	}/*
	if(noofticks > <%=remaingtick%>){
		alert("Tickets cannot exceed <%=remaingtick%>");
		return false;
	}
	/*if(noofticks > <%=maxnoofticks%>){
		alert("No. of Tickets cannot exceed <%=maxnoofticks%>");
		return false;
	}*/
	var boardpnt = document.getElementById("boardpnt").value;
	/*if("" == boardpnt){
		alert("Please select Boarding Point");
		return false;
	}*/
	$("#checkval").val("Y");
	//alert($("#checkval").val("Y"));
		if(checkBox==""){
				alert("Please Select all the Required CheckBoxes");
				return false;
		}
}
	function amountChange(count){
		$("#paymnt").val(<%=maxprice%> * count);
		//alert(count);
		$("#totval").html($("#paymnt").val());
	}

</script>
<style>
.tab2{
	margin:10% 20% 2% 20%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
	width:70%;
}
.tab2 td{
	padding:2% 0%;
	width:20%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#fff;
}
.tab2 tr:nth-child(odd){
	background:#ebf1fa ;
}
.req{
	color:red;
}
</style>	
<%

%>
	
<form name="form" method="post" enctype="multipart/form-data" >

<table class="tab2">
<tr><td>Select Event</td>
<td><select name="eventname" id="eventname" onchange="sfresh()"><option value="">Select</option><%=tempevt%></select>
</td></tr>
<%

if(!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname)) && !("Tata Mumbai Marathon - Half Marathon".equals(eventname)) && !("Tata Mumbai Marathon - 10 Km Run".equals(eventname))){%>
<tr>
<td>No. of tickets required <br/><!--Note: Children below 3 years do not require Tickets,<br/>however you are expected to carry valid age proof.
<br/>-->
<span class="req">
<% if(eventname != null){
	%>
<%		if(("S").equals(maritalsts)){%>
<!--( Maximum of <maxnoofticks> tickets  for Single employees )-->
<%		} else { %>
<!--( Maximum of <maxnoofticks> tickets  for Married employees )	-->
<%      }
}%>
</span></td>
<td>
<input type="hidden" name="empn" id="emp" value="<%=emp%>"/>
<input type="hidden" name="maxnoofticks" id="maxnoofticks" value="<%=maxnoofticks%>"/>
<input type="hidden" name="remaingtick" id="remaingtick" value="<%=remaingtick%>"/>
<input type="hidden" name="sysdte" id="sysdte" value="<%=dbsysdte%>"/>
<input type="number" name="noofticks" id="noofticks" min="0" value="<%=dbnoofticks%>" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" <%="Monsoon Hike 7:00 AM".equals(eventname) || "Monsoon Hike 8:00 AM".equals(eventname)?"readonly":"" %> <%="Monsoon Hike 7:00 AM".equals(eventname) || "Monsoon Hike 8:00 AM".equals(eventname)?"onclick='return alrt()'":"" %>/></td>
</tr>
<%} if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){%>
<tr>
<td>Name of Navigator : </td>
<td><input type="text" name="misc1" id="misc1" maxlength="40" style="width:100%"/></td>
</tr>
	
<%}else{
 if(!("Toilet Ek Prem Katha at Cinemax Eternity Mall  Nagpur ").equals(eventname)){
	%>
<tr>
<%if(!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname)) && !("Tata Mumbai Marathon - Half Marathon".equals(eventname)) && !("Tata Mumbai Marathon - 10 Km Run".equals(eventname))){%>	
<td>Select Boarding point<br/>(Will be applicable only if bus service is arranged.)</td><td><select name="boardpnt" id="boardpnt" >
<option value="">Select</option>
		<%
		for(int i = 0; i<boardloc.length; i++){
			%>
			<option value="<%=boardloc[i]%>"%><%=boardloc[i]%></option>
		<%}
		%>

</select>
</td>
<%}%>
<tr>		
	<td>upload File : </td><td><input type="file" name="fileFields" id="fileField"/><br>
	<font size="2px" color="red">Note : Please Attach Application form with Photograph and Identity Proof in Zip File Format.</font>
	</td>
</tr>


</tr>

<%}
}%>
<tr <%="CSR Swachhata Car Rally and Treasure Hunt".equals(eventname)?"":"style='display:none;background-color:white'" %>>
<td>Vehicle No.</td>
<td><input type="text" name="car_no" id="car_no" maxlength="20" style="width:100%;text-transform:uppercase;"></td>
</tr>
<tr>
<td>Payment</td><td><input type="number" name="paymnt" id="paymnt" onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" value="<%=dbpaymnt%>" readonly ></td>
</tr>

<tr <%="Cycle Rally from HPNE to PH on 30th July 2017".equals(eventname)?"":"style='display:none'" %>>
<td>Need Cycle</td>

<td><select name="needCycle">
<option value="-1">Select</option>
<option value="Y">Y</option>
<option value="N">N</option>
</select>
</tr>

</table>
<center>
		<%
		if(("47".equals(bucode.substring(0,2))) || ("48".equals(bucode.substring(0,2)))){
		%>
		
		<input type="hidden" name="sts" id="sts" value="Pending with HR"/>
		<%
		} else {
		%>	
		<input type="hidden" name="sts" id="sts" value="A"/>
		<%}
		%>
		
<p>
<% if(("Monsoon Hike 7:00 AM".equals(eventname)) || ("Monsoon Hike 8:00 AM".equals(eventname))){%>
<h3 ><u> List of Dependents(12 to 18 Years)</u></h3>
<table border="1" >
	<thead>
		<tr class="listTable">
			<th >#</th>
			<th>Name of the Child</th>
			<th>Date of Birth</th>
			<th>Age(as on 31-07-17)</th>
			<!--<th>Age Group</th>-->
		</tr>
	</thead>
	<tbody>
		<%
String childquery="select to_char(person_dob,'dd/MM/YYYY') dob,round(months_between('31-JUL-17',person_dob)/12) relage,person_name from portal.jdep where emp_no='"+emp+"' and relation_code ='CH' and person_status_code ='AC' and trunc(months_between('31-JUL-17',person_dob)/12) between '12' and '18'";
String ageGroup="";
	
	PreparedStatement psm=con.prepareStatement(childquery);
	ResultSet rs2=psm.executeQuery();
	while(rs2.next()){ index++;
		int dob=rs2.getInt("relage");
			if(dob>=12&& dob<=18){
					ageGroup="12 to 18";		
		%>
			
		<tr class="lst">	
			<td><input type="checkbox" id="check<%=index%>" name="check<%=index%>" value=""<%= "Monsoon Hike 7:00 AM".equals(eventname) || "Monsoon Hike 8:00 AM".equals(eventname)?"":"disabled"%> onclick="return checkBoxVal(this)" ></td>
			<td><%=rs2.getString("person_name")%><input type="hidden" name="person_name<%=index%>" value="<%=rs2.getString("person_name")%>"></td>
			<td><%=rs2.getString("dob")%><input type="hidden" name="dob<%=index%>" value="<%=rs2.getString("dob")%>"></td>
			<td><%=rs2.getString("relage")%><input type="hidden" name="relage<%=index%>" value="<%=rs2.getString("relage")%>"></td>
			<!--<td><%=ageGroup%></td>-->
		</tr>
			<%} else if(dob>=8 && dob<=11){
					ageGroup="8 to 12";
					%>
 		<tr class="lst">	
			<td><input type="checkbox" id="check<%=index%>" name="check<%=index%>" value=""<%= "SUMMER CAMP FOOTLOOSE".equals(eventname)?"":"disabled"%> onclick="return checkBoxVal(this)" ></td>
			
			<td><%=rs2.getString("person_name")%><input type="hidden" name="person_name<%=index%>" value="<%=rs2.getString("person_name")%>"></td>
			<td><%=rs2.getString("dob")%><input type="hidden" name="dob<%=index%>" value="<%=rs2.getString("dob")%>"></td>
			<td><%=rs2.getString("relage")%><input type="hidden" name="relage<%=index%>" value="<%=rs2.getString("relage")%>"></td>
			<!--<td><%=ageGroup%></td>-->
		</tr>
	
	
	<%}
	}%>
		<input type="hidden" name="leg_count" id="leg_count" value="<%=index%>" />
		<input type="hidden" name="eventname" id="eventname" value="<%=eventname%>" />
	</tbody>
	<form name="formUpld" method="post" enctype="multipart/form-data" action="main.jsp">
	
	
	</form>
</table>
<br/>
<%}%>
<center><b><u><%=eventname%></u></b></center>
<%if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){%>
<input type="checkbox" id="checkval" name="checkval" value=""></u></b>
I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or
injury occurring during the trip.
<%}if((!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname))) || (!("CSR Half Marathon".equals(eventname)) ) || (!("CSR 10 Km Run".equals(eventname)))){%>
<input type="checkbox" id="checkval" name="checkval" value=""></u></b>
Note : Please Attach Application form with Photograph and Identity Proof in Zip File Format.
<%}
else{%>
<input type="checkbox" id="checkval" name="checkval" value=""> I hereby authorize recovery of (Rs. <b><u><span id="totval"></span></u></b>
 ) (total amount) through payroll towards employee contribution for <b><u><%=eventname%></u></b>. In case of drop out, there shall be no refund.
<br/>
I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or
injury occurring during the trip.
<%}%>
<br/><br/>
<input type="submit" name="submit1" id="submit1" style="display:none" class="submitcls" value="Confirm Submission" onclick="return validate();">	
<!--<a onclick="window.open('https://docs.google.com/forms/d/e/1FAIpQLSetLsSGphDqL69XMOdOL6k3GhmRDvGn8QmPVQ4slqxiDCojdQ/viewform')"><u>Click Here to Fill the Nomination Form(
TRAILBLAZERS ENROLLMENT FORM)</u></a>-->

</p>
<!--<span class="req">
*Please Ensure that You Fill up the Nomination Form also
</span>-->
<br/>
<br/>
<%if(("The HPCL Monsoon Drive and Treasure Hunt").equals(eventname)){%>
<div id="pay_disclaimer">Note: <span class="req">
However you may edit your requirment of tickets till cut of date <%=cutofdte%>.
		</span></div>
<%}/* if((!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname))) || (!("CSR Half Marathon".equals(eventname)) ) || (!("CSR 10 Km Run".equals(eventname)))){%>
<div id="pay_disclaimer">Note: <span class="req">Payment will be deducted from your salary through automated PTA.<br/>
However you may edit your requirment of tickets till cut of date <%=cutofdte%>.
		</span></div>
<%} */%>

</center>
<%}
		else{
			out.println("<span class='req'>There is no active event for your location at present</span>");
		} %>
</form>
		<%
		if(("submitted").equals(btnclkd)){
			
			
			
			//String empn="",sysdte="",car_no="",misc1="";
			//String qryins = "",sts="";
			//int noofticks = 0;
			//double paymnt = 0.0;
			int flag = 0;
			//noofticks1 = Integer.parseInt(noofticks);
			//paymnt1 = Double.parseDouble(paymnt);
			//boardpnt = request.getParameter("boardpnt");
			//empn = request.getParameter("empn");
			//sysdte = request.getParameter("sysdte");
			//eventname = request.getParameter("eventname");
			//needCycle = request.getParameter("needCycle");
			//car_no = request.getParameter("car_no");
			car_no=car_no.toUpperCase();
			sts = request.getParameter("sts");
			//misc1 = request.getParameter("addFields0");
			//misc2 = request.getParameter("addFields1");
			//misc3 = request.getParameter("addFields2");
			PreparedStatement pmstins = null;
			PreparedStatement pmstexist = null;
			ResultSet rsexist=null;
			
			//String exist="select emp_no from nomination where emp_no='"+empn+"' and  evtnme like '%Tata%' and flag <> 'X'";
			String exist="select emp_no from nomination where emp_no='"+empn+"' and  evtnme like ? and flag <> 'X'";
			pmstexist=con.prepareStatement(exist);
			pmstexist.setString(1,eventname);
			rsexist=pmstexist.executeQuery();
			
		if(rsexist.next()){%>				
				<Script>
					alert("You have already Submitted for this event");
					location.href="mynomination.jsp"
				</Script>
			
		<%}
		else{
			
			if((sysdte!=null) && (!("").equals(sysdte))){
				qryins = "update NOMINATION set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,modifydte=sysdate,ENTERBY=? ,flag=?,NEEDCYCLE='"+needCycle+"' where EMP_NO =? and EVTNME =?";
			} else{
				misc1=fileFields0;
				misc2=fileFields1;
				misc3=fileFields2;
				qryins = "insert into NOMINATION (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,flag,EMP_NO,EVTNME,misc1,misc2,misc3) values(?,?,?,sysdate,?,?,?,?,'"+misc1+"','"+misc2+"','"+misc3+"')";
			}
			pmstins = con.prepareStatement(qryins);
			if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){
			pmstins.setInt(1,1);
			}else{
			pmstins.setInt(1,0);	
			}
			if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){
			pmstins.setString(2,car_no);
			pmstins.setDouble(3,0);			
			}else{
			pmstins.setString(2,"MUMBAI");
			pmstins.setDouble(3,0.0);
			}			
			pmstins.setString(4,login1);
			pmstins.setString(5,sts);
			pmstins.setString(6,emp);
			pmstins.setString(7,eventname);
			
			flag = pmstins.executeUpdate();
			//out.println("<br/>values are"+flag);
			if( flag == 1 ){
				%>
			<script>alert("Details Submitted");
			//location.href="main.jsp";</script>
			<%} else{
				%>
			<script>alert("Error");
			location.href="main.jsp";</script>
			<%}
			if(("Monsoon Hike 7:00 AM".equals(eventname)) || ("Monsoon Hike 8:00 AM".equals(eventname))){
			String Insertquery="insert into NOMINATION_DEPENDENTS(EVENT_NAME,EMP_NO, CHILD_NAME, DATE_OF_BIRTH, UPDATED_DATE, AGE) values('"+eventname+"',?,?,to_date(?,'dd-mm-yy'),sysdate,?) ";	
			PreparedStatement psm1=con.prepareStatement(Insertquery);			
				int x=0;
			for(int i=1;i<=index;i++){
				out.println("value of index is"+index+"<br/>"+"i is"+i);
					checked=request.getParameter("check"+i);
					//out.println("check is"+checked+"here");
					if(checked != null){
						psm1.setString(1,emp);
						psm1.setString(2,request.getParameter("person_name"+i));
						psm1.setString(3,request.getParameter("dob"+i));
						psm1.setString(4,request.getParameter("relage"+i));
						x=psm1.executeUpdate();
					}
					
			}
			
			}
		}	
	}
		%>
	
</body>
<!--SQL TABLE NOMINATION_DEPENDENTS 
CREATE TABLE NOMINATION_DEPENDENTS
  (
    EVENT_NAME VARCHAR2(200 BYTE) NOT NULL ENABLE,
    EMP_NO     VARCHAR2(8 BYTE) NOT NULL ENABLE,
    CHILD_NAME VARCHAR2(25 BYTE) NOT NULL ENABLE,
    DATE_OF_BIRTH DATE,
    UPDATED_DATE DATE,
    AGE VARCHAR2(2 BYTE),
    CONSTRAINT NOMINATION_DEPENDENTS_PK PRIMARY KEY (EVENT_NAME, EMP_NO, CHILD_NAME) 
  );
 

 
-->
</html>
<%@include file="footer.jsp"%>