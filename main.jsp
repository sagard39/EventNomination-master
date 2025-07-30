<%@include file="header1.jsp"%>
<!--

Addition-modification after Marathon addition
1)Maginficpop-up.js/jquery
2)Maginficpop-up.css
3)viewreports.jsp
-->
<link rel="stylesheet" href="css/magnific-popup.css">
<script type="text/javascript" src="js/jquery.magnific-popup.min.js"></script>
<%@include file="storepath.jsp"%>
<%@ page import="javax.activation.DataHandler,org.apache.commons.fileupload.servlet.ServletFileUpload"%>
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
function guidelineFun(id){
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#maxnoofticks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var tickPrize=parseInt($("#MAXPRICE").val());
	if(document.getElementById("chk"+id).checked ==true && !isNaN(noOfTicks)) {
		var val1=parseInt(document.getElementById("ta").value);
		val1++;
		//remTicks--;
		if(val1<=noOfTicks){
			//alert(noOfTicks);
			document.form.ta.value=val1;
			var val2=val1*tickPrize;
			document.getElementById("totval").innerHTML = val2;
			document.getElementById("noofticks").value = val1;
			document.getElementById("paymnt").value = val2;
			//document.getElementById("remTicks").innerHTML = remTicks;
			//document.getElementById("tickCnt").value=remTicks;		
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
		//remTicks++;
		document.form.ta.value=val1;
		var val2=val1*tickPrize;
		document.getElementById("totval").innerHTML = val2;
		document.getElementById("noofticks").value = val1;
		document.getElementById("paymnt").value= val2;
		//document.getElementById("remTicks").innerHTML = remTicks;
		//document.getElementById("tickCnt").value=remTicks;		
	}	
}

function sfresh() {
    document.form.action="main.jsp";
	var event=document.getElementById("eventname").value;
	alert(event);
	if(event=='Marathon'){
		$("#mrDeclaration").show();			
	}else{
		$("#mrDeclaration").hide();
	}
	/*if(event=="SUMMER CAMP FOOTLOOSE"){
		alert("Age Critertia is 8 to 12 years(as on 31-07-17)");
	}else if(event=="Monsoon Hike 7:00 AM" || event="Monsoon Hike 8:00 AM"){
		alert("Age Critertia is 13 to 18 years(as on 31-07-17)");
	}*/
	document.form.submit();
}
</script>
<script>

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};
function addEntry() {
	var remTicks=parseInt($("#tickCnt").val());
	var tickPrize=parseInt($("#MAXPRICE").val());
	var noOfTicks=parseInt($("#maxnoofticks").val());
	//alert(noOfTicks);
	//paymnt
	var maxPrz=parseInt($("#maxPrize").val());
	var val1=parseInt(document.getElementById("ta").value);
	var tot_amt=parseInt(document.getElementById("paymnt").value);
	val1++;
	/*remTicks--;*/
	if(!isNaN(noOfTicks) && val1<=noOfTicks){
		document.form.ta.value=val1;
		var val2=val1*tickPrize;
		document.getElementById("totval").innerHTML = val2;
		document.getElementById("noofticks").value = val1;
		document.getElementById("paymnt").value = val2;
		//document.getElementById("remTicks").innerHTML = remTicks;
		//document.getElementById("tickCnt").value=remTicks;		
	}else{
		alert("Max Ticket capacity exceeded");
		return false;
	}/*if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}*/
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
	/*var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());*/
	
	var tickPrize=parseInt($("#MAXPRICE").val());
	var row = $("#tr").html();
	$("#tr"+id).remove();
	var index = $("#ti_table tbody:first > tr").length;
	 row = row.replaceAll("#id#", index-1);
	$("#leg_count").val(index-1);
	 var val1=parseInt(document.getElementById("ta").value);
	val1--;
	document.form.ta.value=val1;
	var val2=val1*tickPrize;
	//remTicks++;	
	document.getElementById("noofticks").value = val1;
	document.getElementById("totval").innerHTML = val2;
	document.getElementById("paymnt").value = val2;
	/*document.getElementById("remTicks").innerHTML = remTicks;	
	document.getElementById("tickCnt").value=remTicks;*/		
	recalculate();
}
function recalculate() {
    var i = 1;

    $(".numberRow").each(function() {
        $(this).find("strong").text(i++); 
	
    });
	
}
function ageValidate(id1){
	var val1=parseInt(document.getElementById("age_rel"+id1).value);
	if(val1<3){
		alert("above the 15 Years are allowed only");
		return false;
	}
	
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
 function proceedAgree(){
	var chk1= document.getElementById("cls").value;
	 //var chk1=Obj.value;
	 if(chk1 !=null){
		 //alert("aaa");
		 $("#depTable").show();
		 $.magnificPopup.close();
	 }
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
		
response.sendRedirect("mainSubmit.jsp");
List<String> relCode=new ArrayList<String>();
List<String> othName=new ArrayList<String>();
List<String> othRel=new ArrayList<String>();
List<String> othAge=new ArrayList<String>();
List<String> othGen=new ArrayList<String>();
List<String> othContact=new ArrayList<String>();
List<String> empContactList=new ArrayList<String>();

String Contact_count="";
		/* JDE Data */
		//31952830
		/*String storepath2="hpcl_grp1\\Cricket\\";
	String storepath1=request.getRealPath("/");
	String storepath=storepath1+storepath2;*/
		int noofticks1=0;
		double 	paymnt1=0.0;
		String empn="",sysdte="",car_no="",misc1="",eventname="";
		String qryins = "",sts="";
		PreparedStatement pmstgetsts = null,psDep=null;
		ResultSet rsgetsts = null,rsDep=null;
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
		boolean isAllowed=false,isNagpurAllowed=false;
		String newQry="select emp_no,bu from empmaster where emp_no=? and( bu like '48%' or bu like '47%' or bu='10103026' or bu ='10157026')";
		psDep=con.prepareStatement(newQry);
		psDep.setString(1,emp);
		rsDep=psDep.executeQuery();
		if(rsDep.next()){
			isAllowed=true;
		}
		newQry="select emp_no,bu from empmaster where emp_no=? and bu in('11357002' , '13354002', '12354002', '12472400', '11488351')";
		psDep=con.prepareStatement(newQry);
		psDep.setString(1,emp);
		rsDep=psDep.executeQuery();
		if(rsDep.next()){
			isNagpurAllowed=true;
		}
		
		List<String>depList=new ArrayList<String>();
		
		String fileFields0="",fileFields1="",fileFields2="";
		eventname=request.getParameter("eventname");
		String depQuery="select person_code,person_name,relation_code,gender,trunc((sysdate-person_dob)/365) age,to_char(person_dob,'dd-Month-yyyy') dob from portal.jdep where emp_no=? and  round(sysdate-person_dob)>8 order by person_code asc";
		psDep=con.prepareStatement(depQuery);
		psDep.setString(1,emp);
		rsDep=psDep.executeQuery();
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
				}if("depName".equals(name)){
					depList.add(value);
				}
				if("chkBox".equals(name)){
						relCode.add(value);
						String[] conCount=value.split("\\#");
						for(int i=0;i<conCount.length;i++){
							Contact_count=conCount[i];
						}
					Contact_count="dep_contact"+Contact_count;	
				}				
				if(Contact_count.equals(name)){
						empContactList.add(value);
					//	out.println(empContactList);
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
	

		
	//out.println("aaa"+empContactList);	
		
	//out.println("AA"+empn);	
	//empn="31919150";
		
		
		
		//out.println("boardpoint is"+boardpnt);
		
		
		
		
		//SELECT YAMSA,YAAN8 FROM PRODDTA/F060120 WHERE YAAN8='31919150'
		/* pmstgetsts = con1.prepareStatement("SELECT YAMSA,YAAN8 FROM PRODDTA/F060120 WHERE YAAN8=?");
		pmstgetsts.setString(1,emp);
		rsgetsts = pmstgetsts.executeQuery();
		if(rsgetsts.next()){
			maritalsts =rsgetsts.getString(1);
		} */
		int j=0;
		//String eventname = request.getParameter("eventname");
		
		Statement st =con.createStatement();
		PreparedStatement pmstselqry = null;
		String dbempno ="",dbboardpnt="",dbnoofticks ="",dbtotalpaymnt="0",dbsysdte="";
		Double dbpaymnt = 0.0;
		String dbeventname="";
		if(("Power of Presence with Nithya Shanti 1000 HRS to  1300 HRS".equals(eventname)) || ("Power of Presence with Nithya Shanti 1400 HRS to  1730 HRS".equals(eventname))){
			pmstselqry = con.prepareStatement("select EMP_NO from nomination where EMP_NO =? and EVTNME in ('Power of Presence with Nithya Shanti 0900 HRS to  1300 HRS','Power of Presence with Nithya Shanti 1400 HRS to  1730 HRS') and (flag<>'X' or flag is null) ");
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
		List<String> evtList=new ArrayList<String>();
		rs = pmstselqry.executeQuery();
		while(rs.next()){
		
			evtnme = rs.getString(1);
			evtList.add(evtnme);
			if(evtnme.equals(eventname)){
				tempevt+="<option value='"+evtnme+"' selected>"+evtnme+"</option>";
				
			} else {
				tempevt+="<option value='"+evtnme+"'>"+evtnme+"</option>";
				
			}
			
			isExist = true;
		}
		//out.println("aaaa"+evtnme);
		if(eventname!=null){
			//out.println("aaaa"+eventname);
						//	out.println(eventname);

			if((eventname.equals("MR GOT TALENT (18th FEB 2018 at HPNW)")) && isAllowed==false){%>
			<script>
				alert("You are not Allowed for this Event");
				window.location.href="home.jsp";
			</script>
		<%}
			if((eventname.equals("Trip to Khinshi Lake")) && isNagpurAllowed==false){
			//	out.println(eventname);
				%>
			<script>
				alert("You are not Allowed for this Event");
				window.location.href="home.jsp";
			</script>
		<%}	
		}
		if(isExist==false){
			%>
			<script>
			//alert("There is no event in your town at present");
			//location.href="http://10.90.171.82:8080/hpcl_grp1/Marathon/index.jsp";
			//location.href="Marathon/index.jsp";
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
	//var boardpnt = document.getElementById("boardpnt").value;
	/*if(boardpnt==''){
		alert("Select the Boarding point");
		return false;
	}*/
	var noofticks=parseInt(document.getElementById("noofticks").value);
	if(noofticks==0){
		alert("No Value added");
		return false;
	}


	var leg_cnt=parseInt(document.getElementById("leg_count").value);
	for(var i=1;i<=leg_cnt;i++){
		var chkname=(document.getElementById("dep_contact"+i)).value;
		if((document.getElementById("chk"+i).checked) && chkname==''){
			alert("Entre the Contact number in Row no."+i);
			return false;
		}
			//return false;
	}
var person_name=document.getElementsByName("person_name_add");
var rel_add=document.getElementsByName("rel_add");
var age_rel=document.getElementsByName("age_rel");
var gender_rel=document.getElementsByName("gender_rel");
var contact_rel=document.getElementsByName("contact_rel");
var len=person_name.length;
//alert(len);
 for(i=0;i<(len-1);i++){
	var name_val=person_name[i].value;
	var rel_val=rel_add[i].value;
	var age_val=age_rel[i].value;
	var contact_val=contact_rel[i].value;
	

	if(name_val==''){
	 alert("Please Enter Person Name for row"+(i+1));
	 return false;
	}
	if(rel_val==''){
	 alert("Please Enter Relation for row"+(i+1));
	 return false;
    }
	if(age_val<15){
		alert("Please Enter Age more than 15 years  for row"+(i+1));
	 return false;
    }
	if(contact_val=='' || contact_val.length<10 ){
		alert("Please Enter proper 10 digit contact No. for row "+(i+1));
	 return false;
    }

 }
return true;	
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

<center><h2> <a href="#" style="color:red"><font size="5">Event Nomination</font></a></h2></center>
<input type="hidden" name="ta" id="ta" value="0" />
<input type="hidden" name="maxEmpTicks" id="maxEmpTicks" value="<%=maxtickemp%>" />
<div style="margin-top:20px;">
<center><table  class="listTable" style="border-collapse:collapse;"  border="1">
<!--<marquee behavior="alternate" style="color:red">Nomination for the event <i><b>CSR Tata Mumbai Marathon - Chanmpions of Disability</b></i> is Closeed.<marquee>-->
<tr><td>Select Event for Nomination</td>
<td style="width:70%"><select name="eventname" id="eventname" onchange="sfresh()"><option value="">Select</option><%=tempevt%></select>
</td></tr>

<%

if(!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname)) && !("Tata Mumbai Marathon - Half Marathon".equals(eventname)) && !("Tata Mumbai Marathon - 10 Km Run".equals(eventname))){%>
<tr>
<td>No. of Persons who would attend <br/><!--Note: Children below 3 years do not require Tickets,<br/>however you are expected to carry valid age proof.
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
<input type="hidden" name="sysdte" id="sysdte" value="<%=dbsysdte%>"  />
<input type="hidden" name="MAXPRICE" id="MAXPRICE" value="<%=maxprice%>"  />
<input type="number" name="noofticks" id="noofticks" min="0" value="0" readonly onkeypress="return isNumeric(event)" onkeydown="return isNumeric(event)" <%="Monsoon Hike 7:00 AM".equals(eventname) || "Monsoon Hike 8:00 AM".equals(eventname)?"readonly":"" %> <%="Monsoon Hike 7:00 AM".equals(eventname) || "Monsoon Hike 8:00 AM".equals(eventname)?"onclick='return alrt()'":"" %>/></td>
</tr>
<%} if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){%>
<tr>
<td>Name of Navigator : </td>
<td><input type="text" name="misc1" id="misc1" maxlength="40" style="width:100%"/></td>
</tr>
	
<%}else{
 if(!("Toilet Ek Prem Katha at Cinemax Eternity Mall  Nagpur ").equals(eventname)){
	%>
<!--<tr>
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
</td></tr>-->
<%}%>

<!--<tr>		
	<td>upload File : </td><td><input type="file" name="fileFields" id="fileField"/><br>
	<font size="2px" color="red">Note : Please Attach Application form with Photograph and Identity Proof in Zip File Format.</font>
	</td>
</tr>
</tr>-->

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
<%if("Marathon".equals(eventname)){%>
<tr id="mrDeclaration" >
<td>Declaration</td><td><a href="#guideline"  class="inline_popup" >View Declaration</a></td>
</tr>
<%}%>
</table><br/>

</div>

</center>
</div>
<!--<div id="guideline" class="target_popup mfp-hide">
<center><h3>View & Agree</h3></center>

I/my Ward declare, confirm and agree as follows ....
<ol>
<li> The information given by me/my ward in this entry form is true me/my ward is/am solely responsible for the accuracy of this information;</li>

<li> Have fully understood the risk and responsibility of participating in the HPCL Reboot Marathon 2017 event and will be participating entirely at my/his/her risk and responsibility;</li>

<li> Understand the risk of participating on a course with vehicular traffics, even if the course may be regulated/policed;</li>

<li> Understand that I/my ward must be of, and must train to, an appropriate level of fitness to participate in such a physically demanding event and I/my ward have obtained a medical clearance from a registered medical practitioner, allowing me to participate in the events;</li>

<li> For myself/ourselves and our legal representatives, waive all claim of whatsoever nature against any and all sponsors of the event, HPCL, Mumbai city, all political entities, authorities and official and all contractors working on or near the course, and all other person and entities associated with the event and the directors. Employees, agent and respective of all or any of the aforementioned including, but not limited to, any claims that might result from me/my ward participating in the event and whether on account of illness, injury, death or otherwise;</li>

<li>Agree that if I am/my ward is injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to at my/our risk and cost, transport me/my ward to a medical facility and or to administer emergency medical treatment and I/my ward waive's all claim that might result from such transport and or treatment or delay or deficiency therein. I shall pay or reimburse to you my/my ward's medical and emergency expenses and I/my ward hereby authorizes you to incur the same;</li>
<li> Shall provide to race official such medical data relating to me/my ward as they may request, I agree that nothing herein shall oblige the event official or organizers or any other person to incur any expense to provide any transport or treatment;</li>

<li> in case of any illness or injury caused to me or my ward or death suffered by me or my ward due to any force majeure event including but not limited to fire, riots or other civil disturbances, earthquake, storms, typhoons or any terrorist, none of the sponsors of the event or any political entity or authorities and official or any contractor or construction firm working on or near the course, or any person or entities associated with event or the directors, employee, agents or representative of all or any of the aforementioned shall be held liable by me/my ward or me/my ward's representative;</li>

<li>Understand, agree and irrevocably permit HPCL to share the information given me/my ward's in this application, with all/any entities associated with the HPCL Reboot Marathon 2017, at its own discretion;</li>

<li>Understand, agree and irrevocably permit HPCL Reboot Marathon 2017 to use my/my ward's photograph which may be photographed on the day of the event, for the sole purpose of promoting the HPCL Reboot Marathon 2017, at its own discretion;</li>

<li>Shall not hold the organizers and all/any of the event sponsors responsible for loss of my/his/her entry form and</li>

<li>I/my ward understand and agree to the event terms and guidelines.</li>

<li> Race timing certificates link would be displayed on the HPCL portal.</li>

<li>Winner will be decided based on Gun Time and Race Marshall's decision will be final.</li>
</ol>

<div><input type="checkbox" name="checkValue" value="Y" id="cls" ><b>I Agree the Terms and Conditions</b>
<br>
<center><input type="button" onclick="return proceedAgree();" value="Proceed" /></center>
</div>
</div>-->
<%if(!"Marathon".equals(eventname)){%>
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
int count=0;
String query="select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,contact_no from portal.jdep join workflow.empmaster using(emp_no) where emp_no=? and person_status_code='AC' and TRUNC((sysdate-(PERSON_DOB))/365) >=3  order by person_code";
PreparedStatement psMain=con.prepareStatement(query);
psMain.setString(1,emp);
ResultSet rsMain=psMain.executeQuery();
while(rsMain.next()){count++;
String relation_string=rsMain.getString("person_code")+"#"+rsMain.getString("relation_code")+"#"+rsMain.getString("gender")+"#"+rsMain.getString("age")+"#"+rsMain.getString("rel_dob")+"#"+count;
%>
		<tr>
			<td><%=count%></td>
			<td><input type="checkbox" name="chkBox" value="<%=relation_string%>" id="chk<%=count%>" onclick="return guidelineFun(<%=count%>)" ></td>
			<td><%=rsMain.getString("person_name")%></td>
			<td><%=rsMain.getString("RELATION_CODE1")%></td>
			<td><%=rsMain.getString("AGE")%></td>
			<td><%=rsMain.getString("rel_dob")%></td>
			<td><%=rsMain.getString("gender1")%></td>
			<td><input type="text" name="dep_contact<%=count%>" id="dep_contact<%=count%>" value='<%=rsMain.getString("contact_no")%>' ></td>
		</tr>
<%}%>
		</tbody>
<input type="hidden" name="leg_count" id="leg_count" value="<%=count%>"/>		
	</table></center><br/>
<center>
		<a title="Add" href="javascript:;" onclick="addEntry()"><img width="18" src="images/add1.png" /></a>
		<span class="v_t"  style="margin-right:100px">Add</span>
		<div class="datagrid">
			<table class="listTable" id="ti_table" style="border-collapse:collapse;"  border="1">
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
					<td><center><input type="number" name="age_rel" maxlength="2"   id="age_rel<%="#id#"%>" onblur="return ageValidate('<%="#id#"%>')"></center></td>
					<td>
					<select name="gender_rel" id="gender_rel<%="#id#"%>">
						<option value="M">Male</option>
						<option value="F">Female</option>
					</select>
					</td>
				<td>
					<input type="text" name="contact_rel" id="contact_rel<%="#id#"%>" value="" maxlength="13" >
				</td>
				</tr>
</tbody>	
</table></div></center>
<%}%>
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
String childquery="select to_char(person_dob,'dd/MM/YYYY') dob,round(months_between('31-JUL-17',person_dob)/12) relage,person_name from portal.jdep where emp_no='"+emp+"' and relation_code ='CH' and person_status_code ='AC' and trunc(months_between('31-JUL-17',person_dob)/12) between '12' and '18' ";
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
<%if(!"MR GOT TALENT (18th FEB 2018 at HPNW)".equals(eventname)){%>
<center><b><u><%=eventname%></u></b></center>
<%if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){%>
<input type="checkbox" id="checkval" name="checkval" value=""></u></b>
I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or
injury occurring during the trip.
<%}if((!("CSR Tata Mumbai Marathon - Chanmpions of Disability".equals(eventname))) || (!("CSR Half Marathon".equals(eventname)) ) || (!("CSR 10 Km Run".equals(eventname)))){%>
<input type="checkbox" id="checkval" name="checkval" value=""></u></b>
Note : I hereby authorize recovery of (Rs. <b><u><span id="totval"></span></u></b>
 ) (total amount) through payroll towards employee contribution for <b><u><%=eventname%></u></b>. In case of drop out, there shall be no refund.
<br/>
I am aware of the rules and regulations of Pin strike game and will adhere to same as prescribed by the Organisers and will play with true sportsman spirit.
<%}
else{%>
<input type="checkbox" id="checkval" name="checkval" value=""> I hereby authorize recovery of (Rs. <b><u><span id="totval"></span></u></b>
 ) (total amount) through payroll towards employee contribution for <b><u><%=eventname%></u></b>. In case of drop out, there shall be no refund.
<br/>
I also understand that I am responsible for the safety, security and health of my family members and their belongings. HPCL shall not be liable for any loss/damage or
injury occurring during the trip.
<%}}else{%>
<div style="display:none"><b><u><span id="totval"></span></u></b></div>
<%}%>
<br/><br/>
<input type="submit" name="submit1" id="submit1" <%=!"MR GOT TALENT (18th FEB 2018 at HPNW)".equals(eventname)?"style='display:none'":""%>  class="submitcls" value="Confirm Submission" onclick="return validate();">	
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
			out.println("<span class='req'><center><h2> <a href='http://10.90.171.82:8080/hpcl_grp1/Marathon/index.jsp' style='color:red'><font size='5>For Reboot@35+ Mumbai - Marathon / Walkathon 2017, click here</font></a></h2></center></span>");
		} %>
</form>
		<%
		if(("submitted").equals(btnclkd)){
			
			con.setAutoCommit(false);
			
			//String empn="",sysdte="",car_no="",misc1="";
			//String qryins = "",sts="";
			//int noofticks = 0;
			//double paymnt = 0.0;
			int flag = 0;
			try { noofticks1 = Integer.parseInt(noofticks); } catch(Exception e) { noofticks1=0; }
			paymnt1 = Double.parseDouble(paymnt);
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
		//out.println("vlue is"+boardpnt);	
			if((sysdte!=null) && (!("").equals(sysdte))){
				qryins = "update NOMINATION set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,modifydte=sysdate,ENTERBY=? ,flag=?,NEEDCYCLE='"+needCycle+"' where EMP_NO =? and EVTNME =?";
			} else{
				misc1=fileFields0;
				misc2=fileFields1;
				misc3=fileFields2;
				qryins = "insert into NOMINATION (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,flag,EMP_NO,EVTNME,misc1,misc2,misc3,modifydte) values(?,?,?,sysdate,?,?,?,?,'"+misc1+"','"+misc2+"','"+misc3+"',sysdate)";
			}
			pmstins = con.prepareStatement(qryins);
			if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){
			pmstins.setInt(1,1);
			}else{
			pmstins.setInt(1,noofticks1);	
			}
			if(("CSR Swachhata Car Rally and Treasure Hunt").equals(eventname)){
			pmstins.setString(2,car_no);
			pmstins.setDouble(3,0);			
			}else{
			pmstins.setString(2,boardpnt);
			pmstins.setDouble(3,paymnt1);
			}			
			pmstins.setString(4,login1);
			pmstins.setString(5,sts);
			pmstins.setString(6,emp);
			pmstins.setString(7,eventname);
			
			flag = pmstins.executeUpdate();
			//out.println("<br/>values are"+flag);
			String qryDep1="insert into nomination_dependents (event_Name,emp_no,child_name,updated_date,RELATATION,age,gender,contact_no) values(?,?,?,sysdate,?,?,?,?)";
			PreparedStatement psDepIn=con.prepareStatement(qryDep1);
			int cntDep=0;
				if(relCode.size()>0){
					for(int i=0;i<relCode.size();i++){
						String [] arrName=relCode.get(i).split("#");
						String query="insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate,?)";
						PreparedStatement psMain1=con.prepareStatement(query);
						for(int k=0;k<arrName.length-1;k++){cntDep++;
							psMain1.setString(cntDep,arrName[k]);
						}cntDep=0;	
						psMain1.setString(6,eventname);
						psMain1.setString(7,emp);
						/*for(int a=0;a<empContactList.size();a++){*/
							psMain1.setString(8,empContactList.get(i));
						/*}*/
						psMain1.executeUpdate();	
				}
			}
			
			if(othName.size()>0){
				for(int i=0;i<othName.size();i++){
					if(!"".equals(nullVal(othName.get(i)))){
					psDepIn.setString(1,eventname);
					psDepIn.setString(2,emp);	
					psDepIn.setString(3,othName.get(i));
					psDepIn.setString(4,othRel.get(i));
					psDepIn.setString(5,othAge.get(i));
					psDepIn.setString(6,othGen.get(i));
					psDepIn.setString(7,othContact.get(i));
					int saurabh=psDepIn.executeUpdate();
					}
			}
			}
			
			if( flag >=1 ){
				%>
			<script>alert("Details Submitted");
			location.href="home.jsp";</script>
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
			
			}if("Marathon".equals(eventname)){
				String Insertquery="insert into nomination_dependents(EVENT_NAME,EMP_NO, CHILD_NAME,UPDATED_DATE) values(?,?,?,sysdate)";
				PreparedStatement psm1=con.prepareStatement(Insertquery);
				for(int i=0;i<depList.size();i++){
					psm1.setString(1,eventname);
					psm1.setString(2,emp);
					psm1.setString(3,depList.get(i));
					psm1.executeUpdate();
				}
			}
		}
		con.commit();	
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
