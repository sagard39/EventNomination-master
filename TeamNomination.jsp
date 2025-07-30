<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" />
<%@ include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page
	import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<script type="text/javascript">
function getDependentsList(){
	var eno=$("#Empno").val();
	if(eno==""){
		alert("Please Enter Employee Number");
		return false;
	}
	if(eno.lenfth<8){
		alert("Please Enter the Employee Number Properly");
		return false;
	}
	if(eno.lenfth>8){
		alert("Please Enter the Employee Number Properly");
		return false;
	}
	if(!((eno.includes("3")) && (eno.includes("0")))){
		alert("Please Enter Employee Number Properly");
		return false;
	}
	$.ajax({
        type:"post",
        url:"getDependentsList.jsp",
		data:{eno:eno},
        success:function(result){
			var details="";
			//jsonObj=JSON.parse(result);
			//alert(jsonObj);
			// $.each(jsonObj,function(key, obj){
			//	details=obj.emprow;
				$("#dependents").html(result);
			 //});
		}
	});
}

  
	var cnt=0;
	function addList(obj){
		
		if(cnt==2){
			$("#chk"+obj).prop("checked", false);
			alert("Only two members are allowed");
			return false;
		}
		var str1="";
		var str;
		var value=$("#chk"+obj).val();
		//alert(value);
		str=value.split("_");
		var code=str[0];
		var name=str[1];
		cnt++;
		str1+="<div class='mteam' id='Mem"+cnt+"'>"+name+" Code:"+code+"<input type='hidden' name='code' id='code"+cnt+"' value='"+code+"'><img id='Img"+cnt+"' src='images/clear.png' height='15px' width='15px' onClick='del(this,"+cnt+");'/></div>";
			
		$("#teamM").append(str1);	
		
	}
	function del(obj,count){
		$("#chk"+count).prop("checked", false);
		$($(obj).parent()).remove();
		cnt--;
	}
	
	// $("#attamand input:checkbox").change(function() {
    // var ischecked= $(this).is(':checked');
    // if(!ischecked)
    // alert('uncheckd ' + $(this).val());
	// }); 
	$(document).ready(function(){
	$('input[name="attamand"]').click(function(){
			//debugger
            if($(this).prop("checked") == true){
                //alert("Checkbox is checked.");
				$("#file").prop('required',false);
            }
            else if($(this).prop("checked") == false){
                //alert("Checkbox is unchecked.");
				$("#file").prop('required',true);
            }
    });
	});
	
	
	function checkValidation(){
		var eteam=$("#teamName").val();
		if(eteam==""){
			alert("Please Enter Team Name");
			return false;
		}
		var team=$("#code1").val();
		var team1=$("#code2").val();
		//alert(team);
		if(team==""||team==undefined||team1==""||team1==undefined){
			alert("Please Enter aleast two member.");
			return false;
		}
		
		
		$('input[type=file]').each(function(){
		file = this.files[0]
		if(file != undefined && file.size/1024/1024 > 25) {
			alert("file size can not be more than 25MB");
			return false;
		}
		});
		var theme=$("#theme").val();
		if(theme=="0"){
			alert("Please Enter Theme");
			return false;
		}
	}
</script>
<%
Connection conDev=null; 
Class.forName("oracle.jdbc.driver.OracleDriver");
conDev = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");
PreparedStatement ps=null,ps1=null,ps2=null;
ResultSet rs_empexist=null;
String btnclkd="",pcode="",title="",TeamName="",Theme="",fileName="",filePath2="",emp1="",emp2="",YEAR="2019",ttype="Film",attach="";
List<String> empEntry = new ArrayList<String>();
File fileToCreate = null;
boolean del=false;
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		int cn = 0;
			ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
			List fileItemsList = servletFileUpload.parseRequest(request);
			Iterator it = fileItemsList.iterator();
			File tempDir = null;
			File tempDir1 = null;
			File tempDir2 = null;
			while (it.hasNext()) {
				FileItem fileItem = (FileItem) it.next();
				{
					String name = fileItem.getFieldName();
					String value = fileItem.getString();
					if (fileItem.isFormField()) {
						if(name.equals("submit")){
							btnclkd="submit";
						}if(name.equals("teamName")){
							TeamName=value;
						}
						if(name.equals("code")){
							empEntry.add(value);
						}	
						if(name.equals("theme")){
							Theme=value;
						}
						
					}else {
						value = fileItem.getName();
						int ind = 0;
						String attError = "", filePath = "", a = "",ttitle="", filePath1 = "";
						boolean checkattach = name.contains("file");
						if (checkattach) { //if attach
				
							if (!"".equals(value)) {
										
								long fileSize = fileItem.getSize();
								if (fileSize > 0) {
									int dotPos = value.lastIndexOf(".");
									if (dotPos == -1) {
										attError = "Please select the attachment file format to upload with extension";
										out.println("<br><br><br><h4 align=center><font color=red>" + attError
												+ "</h4>");
										return;
									} else {
										String extension = value.substring(dotPos + 1);
										if (!(extension.equalsIgnoreCase("zip")
												|| extension.equalsIgnoreCase("pdf")
												|| extension.equalsIgnoreCase("jpg")
												|| extension.equalsIgnoreCase("jpeg")
												|| extension.equalsIgnoreCase("mp4")
												|| extension.equalsIgnoreCase("mov")
												|| extension.equalsIgnoreCase("webm")
												|| extension.equalsIgnoreCase("png"))) {
											attError = "Please select the attachment in following format - pdf, zip, jpg, jpeg, png,mp4,mov,webm";
											out.println("<br><br><br><h4 align=center><font color=red>" + attError
													+ "</h4>");
											return;
										} else {
											ServletContext sc = session.getServletContext();

											filePath = storepath + "/useruploads1/Film/";

											tempDir = new File(filePath);
											if (tempDir.exists() == false) {
												tempDir.mkdir();
											}
											DateFormat df = new SimpleDateFormat("yyyyMMddhhmmSSS");
											Date today = Calendar.getInstance().getTime();
											String reportDate = df.format(today);
											//File fileToCreate = null;
											if (name.startsWith("file")) {
												title = TeamName+"_"+reportDate+"." + extension;
												fileName=title;
											} 
											fileToCreate = new File(filePath, title);
											try {
												fileItem.write(fileToCreate);
												// if("file".equals(name)){
												// ttitle = fileName.toString();
												// if(ttitle==null) ttitle="";
												// fileName = ttitle;
												// filePath2=filePath+fileName;
												//}
											} catch (Exception e) {
												attError = "ERROR IN ATTACHMENT UPLOAD";
												e.getMessage();
												out.println("<br><br><br><h4 align=center><font color=red>" + e
														+ "..</h4>");
												return;
											}
										}
									}
								}

							}else{
								fileName="NO_FILE";
							}
						}
					}
				}
			}
			
	}
	if(btnclkd.equals("submit")){
		boolean isExist=false;
		ps1=conDev.prepareStatement("Select * from nomination_team where (MEM1=? or MEM2=?) and TYPE='Film'");
		
		for(int i=0;i<empEntry.size();i++){
			ps1.setString(1,empEntry.get(i));
			ps1.setString(2,empEntry.get(i));
			rs_empexist=ps1.executeQuery();
			if(rs_empexist.next()){
				isExist=true;
				if(fileToCreate!=null){
				del=fileToCreate.delete();
				}
				%>
				<script>
					alert("<%=empEntry.get(i)%> is already in another team please select other member.");
					windows.location.href="TeamNomination.jsp";
				</script>
				<%
				
			}
		}
		
		ps2=conDev.prepareStatement("Select * from nomination_team where TEAM_NAME=? and type='Film'");
		ps2.setString(1,TeamName);
		rs_empexist=ps2.executeQuery();
		if(rs_empexist.next()){
			isExist=true;
			if(fileToCreate!=null){
				del=fileToCreate.delete();
			}
				%>
				<script>
					alert("<%=TeamName%> is already Exists. Please enter different name.");
					windows.location.href="TeamNomination.jsp";
				</script>
			<%
		}
		
		int personCnt=2;
		ps2=con.prepareStatement("Select * from "+tempJdep+"jdep where emp_no=? and person_code in (?,?)");
		ps2.setString(1,login1);
		for(int i=0;i<empEntry.size();i++){
			ps2.setString(personCnt,empEntry.get(i));
			personCnt++;
		}
		rs_empexist=ps2.executeQuery();
		if(!rs_empexist.next()){
			isExist=true;
			if(fileToCreate!=null){
				del=fileToCreate.delete();
			}
				%>
				<script>
					alert("You need to select atleast one of your dependent member.");
					windows.location.href="TeamNomination.jsp";
				</script>
			<%
		}
		
		if(!isExist){
			int varcnt=2;
			int exe=0;
			ps=conDev.prepareStatement("insert into nomination_team(TEAM_NAME,MEM1,MEM2,UPDATED_BY,UPDATED_DATE,YEAR,TYPE,MEM10,MEM9) VALUES (?,?,?,?,sysdate,?,?,?,?)");
			ps.setString(1,TeamName);
			for(int i=0;i<empEntry.size();i++){
			ps.setString(varcnt,empEntry.get(i));
			varcnt++;
			}
			ps.setString(4,login1);
			ps.setString(5,YEAR);
			ps.setString(6,ttype);
			ps.setString(7,fileName);
			ps.setString(8,Theme);
			
			exe=ps.executeUpdate();
			if(exe>0){
				%>
				<script>
					alert("Team Nomination Submitted Successfully.");
					windows.location.href="TeamNomination.jsp";
				</script>
				<%
			}else{
				%>
				<script>
					alert("Error Occure.");
					windows.location.href="TeamNomination.jsp";
				</script>
				<%
			}
		}
		
	}
%>
		
<div class="container" style="min-height: 465px;">
	<div class="row">
		<div class="col-sm-12 ">		
			<form name="form1" method="post" action="TeamNomination.jsp" enctype="multipart/form-data">
				<div class="card md10 box-shadow border-success">
					<div class="card-header style-app-name" >
						<h5 class="text-white">HP Got Talent - Film Making</h5>
						
					</div>
					<h6  style="padding: 10px;" class="style-text-red">The last date of receiving of USB Drive with Reboot@35+ Team, WZ is 15th November 2019</h6>
					<div class="card-body table-responsive">
						<table class="listTable style-border-0">
							<tr>
								<td style="font-weight: bold;">Team Name:</td>
								<td><input type="text" class="select-field" style="width:60%;" name="teamName" id="teamName" required></td>
								<td width="20%" class="tdLbl1" style="padding: 10px;font-weight: bold;"><!--Enter Employee No To-->Select Team Members</td>
								<td width="30%">
									<input type="text" id="Empno" name="Empno" style="width:60%;" class="select-field"  placeholder="Employee No." value="" >
									<input type="button" class="style-right-button style-round" name="getDep" id="getDep" value="Search" onclick="return getDependentsList();">
								</td>
							</tr>
							<tr>
								<td width="10%" style="font-weight: bold;">
									Select Name 
								</td>	
								<td id="dependents" name="dependents">
									<input type="hidden" name="count" id="count">
								</td>
							
								<td style="font-weight: bold;">Team Members</td>
								<td>
									<div id="teamM">
										
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="checkbox" name="attamand" id="attamand"><span style="font-weight: bold;">  Video Send by USB Drive.</span>
								</td>
								<td style="font-weight: bold;">Upload Video</td>
								<td><input type="file" name="file" id="file" required><br/><span class="style-text-red" style="font-weight: bold;">File Size should be less than 25 MB.</span></td>
							</tr>
							<tr>	
								<td style="font-weight: bold;">Theme</td>
								<td><select class="select-field" style="width:60%;"  name="theme" id="theme">
									<option value="0">Select</option>
									<option value="Emotion">Emotion</option>
									<option value="Future">Future</option>
									<option value="Fate">Fate</option>
									<option value="Social Awareness">Social Awareness</option>
									<option value="HP First">HP First</option>
								</select></td>
								<td colspan="2"></td>
								
							</tr>
							<tr>
								<td colspan="4">
									<input class="style-right-button style-right" type="submit" name="submit" onclick="return checkValidation();" id="submit" value="Submit">
								</td>
							</tr>
						</table>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<%
if(conDev!=null) {
	conDev.close();
}
%>

<%@include file="footer.jsp"%>
		
