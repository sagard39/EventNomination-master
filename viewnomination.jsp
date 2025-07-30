<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" /> 
<%@include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload,org.apache.commons.fileupload.FileItem, org.apache.commons.io.FilenameUtils, org.apache.commons.fileupload.disk.DiskFileItemFactory"%>

<style>
.tab2{
margin:10% 0% 1% 15%; 
border:1px solid #2d67b2;
border-collapse:collapse;
width: 70%;
}
.tab2 td{padding:2% 0%;}
td{border:1px solid #2d67b2;}
.tab2 tr:nth-child(even){background:#fff;}
.tab2 tr:nth-child(odd){background:#ebf1fa;}
#tab1{border-collapse: collapse;}
#tab1 th{border:1px solid #000;}
</style>
<script>

function validateit(){
var x=0;
var y=0;
var a=$("#value").val();
var l=0;
for(l=1;l<=a;l++){
var upload="uploadfile"+l;
var uploadd="uploadfilee"+l;
var uploaddd="uploadfileee"+l;

var photo = document.getElementById(upload);
var uploadfile = photo.files[0];
if(uploadfile===undefined || uploadfile===void(0)){
alert("Please Select Row "+l+" First File upload");
return false;
}

var photo1 = document.getElementById(uploadd);
var uploadfile1 = photo1.files[0];
if(uploadfile1===undefined || uploadfile1===void(0)){
alert("Please Select Row "+l+" Second File upload");
return false;
}

var photo2 = document.getElementById(uploaddd);
if(typeof(photo2) != 'undefined' && photo2 != null){
 var uploadfile2 = photo2.files[0];
if(uploadfile2===undefined || uploadfile2===void(0)){
alert("Please Select Row "+l+" Third File upload");
return false;
}
}else{

}
}

$('input[type=file]').each(function(){
		file = this.files[0]
		if(file != undefined && file.size/1024/1024 > 25) {
			alert("file size can not be more than 25MB");
			return false;
		}
	});
document.form1.submit();
}

</script>
<%!
		private String nulval(String a){
			String temp = a;
			if(a==null || ("".equals(a))){
				temp = "";
			}
			if(("null").equals(a)){
				temp = "";
			}
			return temp;
		}	
%>

<%
String eventname="",uploadfile="",person_code="",fileName="",misc="",fileName1="",misc1="",fileName2="",misc2="";
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
PreparedStatement ps_misc_update1=null;
PreparedStatement ps_misc_update2=null;
PreparedStatement ps_misc_update3=null;
PreparedStatement ps_misc=null;
ResultSet rs_misc=null;
int i=0;

if(isMultipart)
    {

	ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
	List fileItemsList = servletFileUpload.parseRequest(request);
    Iterator it = fileItemsList.iterator();
    
    File tempDir = null;
    String attnames="";
	while (it.hasNext()){
		//count=0;
			FileItem fileItem = (FileItem)it.next();
			String name = fileItem.getFieldName();
			String value = fileItem.getString();

	if (fileItem.isFormField()){
				
				if(name.equals("event_name")){
					eventname=value;
				}else if(name.equals("person_code")){
					person_code=value;
				}

	}

			 if (!fileItem.isFormField()){
				 
ps_misc=con.prepareStatement("select misc1,misc2,misc3 from nomination_dependents where child_name=? and event_name=?");
ps_misc.setString(1,person_code);
ps_misc.setString(2,eventname);
rs_misc=ps_misc.executeQuery();
if(rs_misc.next()){
misc=rs_misc.getString("misc1");
misc1=rs_misc.getString("misc2");
misc2=rs_misc.getString("misc3");
}
//out.print(misc+"<br>");
//out.print(misc1+"<br>");
//out.print(misc2+"<br>");
//out.print(person_code+"<br>");
//out.print(eventname+"<br>");

							value = fileItem.getName();
						    int ind=0;
							String attError="",filePath="",a="";
							boolean misc_1=false;
							boolean misc_2=false;
							boolean misc_3=false;
							boolean checkattach=name.contains("uploadfile");
							boolean checkattach1=name.contains("uploadfile1");
							boolean checkattach2=name.contains("uploadfile2");
							if(checkattach || checkattach1 || checkattach2){
								if(!value.equals("")){
							
									long fileSize = fileItem.getSize();
									if(fileSize > 0){
										
									int dotPos= value.lastIndexOf(".");
									if(dotPos == -1){
										attError = "Please select the attachment file format to upload with extension";
										out.println("<br><br><br><h4 align=center><font color=red>"+attError+"</h4>");
										return;
									}else{
									
										String extension = value.substring(dotPos+1).toLowerCase();                
										if(!(extension.equalsIgnoreCase("jpg")) && !(extension.equalsIgnoreCase("pdf")) && !(extension.equalsIgnoreCase("xlsx")) &&!(extension.equalsIgnoreCase("png"))&& !(extension.equalsIgnoreCase("bmp")) && !(extension.equalsIgnoreCase("gif")) && !(extension.equalsIgnoreCase("jpeg")) && !(extension.equalsIgnoreCase("mp4")) && !(extension.equalsIgnoreCase("mov")) && !(extension.equalsIgnoreCase("webm"))){
											attError = "Please select the attachment in jpg,bmp,png file format to upload";
											out.println("<br><br><br><h4 align=center><font color=red>"+attError+"</h4>");
											return;
										}else{
											//out.println("a4-"+name);
											//else if it is a pdf file
											ServletContext sc = session.getServletContext();
											filePath = storepath +"/useruploads1/";
											String fileDirTemp = storepath+"/useruploads1/";
											tempDir = new File(filePath);
											if(tempDir.exists() == false){
												tempDir.mkdir();
											}
										       
											File fileToCreate = null;
											File fileToCreate1 = null;
											File fileToCreate2 = null;
										
											//try{
											if(checkattach){
											misc_1=true;	
											if(!nulval(misc).contains(nulval(person_code))){
										    fileName=misc+"_"+person_code+"_"+eventname+"III"+"_1."+extension;
										    fileToCreate = new File(filePath,fileName);
										
											if(fileToCreate.exists() == false){
											fileItem.write(fileToCreate);
											if(name.equals("uploadfile")){
                                            fileName=misc+"_"+person_code+"_"+eventname+"III"+"_1."+extension;												
											}}else{
											fileItem.write(fileToCreate);
											if(name.equals("uploadfile")){
                                            //fileName=misc+"_"+person_code+"_"+eventname+"III"+"_1."+extension;												
											}
											}
											}
											}
											
											if(checkattach1){
											misc_2=true;
											if(!nulval(misc1).contains(nulval(person_code))){
										    fileName1=misc1+"_"+person_code+"_"+eventname+"III"+"_2."+extension;
										    fileToCreate1 = new File(filePath,fileName1);
										
											if(fileToCreate1.exists() == false){
											fileItem.write(fileToCreate1);
											if(name.equals("uploadfile1")){
                                            fileName1=misc1+"_"+person_code+"_"+eventname+"III"+"_2."+extension;												
											}}else{
											fileItem.write(fileToCreate1);
											if(name.equals("uploadfile1")){
                                            //fileName1=misc1+"_"+person_code+"_"+eventname+"III"+"_2."+extension;												
											}	
											}
											}
											}
											
											if(checkattach2){
											misc_3=true;
											if(!nulval(misc2).contains(nulval(person_code))){
										    fileName2=misc2+"_"+person_code+"_"+eventname+"III"+"_3."+extension;
										    fileToCreate2 = new File(filePath,fileName2);	
											if(fileToCreate2.exists() == false){
											fileItem.write(fileToCreate2);
											if(name.equals("uploadfile2")){
                                            fileName2=misc2+"_"+person_code+"_"+eventname+"III"+"_3."+extension;												
											}}else{
											fileItem.write(fileToCreate2);
											if(name.equals("uploadfile2")){
                                            //fileName2=misc2+"_"+person_code+"_"+eventname+"III"+"_3."+extension;												
											}	
											}
											}
											}
																				 
											/*  }catch (Exception e){
												attError = "ERROR IN ATTACHMENT UPLOAD";
												e.getMessage();
												out.println("<br><br><br><h4 align=center><font color=red>"+e+"..</h4>");
												return;
											} */ 
										}
									}
									}else{
									}
								}
							
							}
							

	if(misc_1){
	ps_misc_update1=con.prepareStatement("update nomination_dependents set misc1=? where child_name=? and event_name=?");
	ps_misc_update1.setString(1,fileName);	
	ps_misc_update1.setString(2,person_code);
	ps_misc_update1.setString(3,eventname);
	ps_misc_update1.executeUpdate();
	}
	
	if(misc_2){
	ps_misc_update2=con.prepareStatement("update nomination_dependents set misc2=? where child_name=? and event_name=?");
	ps_misc_update2.setString(1,fileName1);	
	ps_misc_update2.setString(2,person_code);
	ps_misc_update2.setString(3,eventname);
	ps_misc_update2.executeUpdate();
	}
	
	if(misc_3){
	ps_misc_update3=con.prepareStatement("update nomination_dependents set misc3=? where child_name=? and event_name=?");
	ps_misc_update3.setString(1,fileName2);	
	ps_misc_update3.setString(2,person_code);
	ps_misc_update3.setString(3,eventname);
	ps_misc_update3.executeUpdate();
	}
	
	}
	}
}

%>

<%
String evnt_name=request.getParameter("evnt_name");
String passempno=request.getParameter("passempno");
 SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy");  
PreparedStatement ps_evnt=null;
ResultSet rs_evnt=null;
ps_evnt=con.prepareStatement("select distinct a.event_name,DECODE(a.RELATATION,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATATION) as  relatation,a.age,a.gender,a.child_name person_code,a.misc1,a.misc2,a.misc3 from nomination_dependents a LEFT JOIN "+tempJdep+"jdep b ON  b.person_code=a.child_name  where a.event_name=? and a.emp_no=? and (a.misc1 is not null) ");
ps_evnt.setString(1,evnt_name);
ps_evnt.setString(2,emp);
rs_evnt=ps_evnt.executeQuery();
int indexx=0;
%>
    <div class="container" style="min-height: 465px;">
	<div class="row">
	<div class="col-sm-12 ">
	<form name="form1" id="form1" method="post" action="" enctype="multipart/form-data">
	<div class="card md10 box-shadow border-success">
	<div class="card-header style-app-name"><h5 class="text-white">Event Nomination</h5></div>
	<div class="card-body table-responsive">
	<table class="listTable" style="">
	<thead class ="alert alert-success">
	<tr>
	<th style="width:5%;">No</th>
	<th style="width:15%;">Event Name</th>
	<th style="width:10%;">Relation</th>
	<th style="width:5%">Age</th>
	<th style="width:5%">Gender</th>
	<th style="width:20%">Upload</th>
	<th style="width:20%">Upload</th>
	<%if("2019_295_event".equals(evnt_name)){%><th style="width:20%">Upload</th><%}%>
	</tr>
	</thead>
	
<%while(rs_evnt.next()){indexx++;
misc=rs_evnt.getString("misc1");
person_code=rs_evnt.getString("person_code");%>						
	<tr>
	<td class="tdLbl1" style="padding: 10px;"><%=indexx%></td>
	<td class="tdLbl1" style="padding: 10px;"><input type="hidden" name="person_code" value="<%=rs_evnt.getString("person_code")%>" id="person_code"><input type="hidden" name="event_name" value="<%=rs_evnt.getString("event_name")%>" id="event_name" ><%=rs_evnt.getString("event_name")%></td>
	<td style="padding: 10px;"><%=rs_evnt.getString("relatation")%></td>
	<td style="padding: 10px;"><%=rs_evnt.getString("age")%></td>
	<td class="tdLbl1" style="padding: 10px;"><%=rs_evnt.getString("gender")%></td>
	<td style="padding: 10px;">
	<%if(nulval(rs_evnt.getString("misc1")).contains(""+rs_evnt.getString("event_name")+"")){%><a target="_blank" href="useruploads1/<%=nulval(rs_evnt.getString("misc1"))%>">View Document..</a>
	<input type="hidden" name="hidden_uploadfile" id="hidden_uploadfile<%=indexx%>" value="<%=nulval(rs_evnt.getString("misc1"))%>">
	<%}else{%><input style="width:140px;" type="file" name="uploadfile" id="uploadfile<%=indexx%>" class="select-field" value=""><%}%>
	</td>
	
	<td style="padding: 10px;">
	<%if(nulval(rs_evnt.getString("misc2")).contains(""+rs_evnt.getString("event_name")+"")){%><a target="_blank" href="useruploads1/<%=nulval(rs_evnt.getString("misc2"))%>">View Document..</a>
	<input type="hidden" name="hidden_uploadfile1" id="hidden_uploadfilee<%=indexx%>" value="<%=nulval(rs_evnt.getString("misc2"))%>">
	<%}else{%><input style="width:140px;" type="file" name="uploadfile1" id="uploadfilee<%=indexx%>" class="select-field" value=""><%}%>
	</td>
	
	<%if("2019_295_event".equals(evnt_name)){%>
	<td style="padding: 10px;">
	<%if(nulval(rs_evnt.getString("misc3")).contains(""+rs_evnt.getString("event_name")+"")){%><a target="_blank" href="useruploads1/<%=nulval(rs_evnt.getString("misc3"))%>">View Document..</a>
	<input type="hidden" name="hidden_uploadfile2" id="hidden_uploadfileee<%=indexx%>" value="<%=nulval(rs_evnt.getString("misc3"))%>">
	<%}else{%><input style="width:140px;" type="file" name="uploadfile2" id="uploadfileee<%=indexx%>" class="select-field" value=""><%}%>
	</td>
    <%}%>
	
	</tr>
<%}%>
	</table>
	</div>
	<input type="hidden" value="<%=indexx%>" name="value" id="value"/>
	<%if(!nulval(misc).contains(""+person_code+"")){%>
	<div><input class="style-right-button style-right" width="50%" type="button" onclick="validateit();" name="subt" value="Submit" id="subt"></div>
	<%}%>
	</div>
	</div>
	</form>
	</div>
	</div>