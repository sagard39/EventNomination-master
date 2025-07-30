<%@ include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@include file="uploadHelper.jsp"%>

<%@ page
	import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<script>
function getInactive(id){
	if(!confirm("Do you really want to delete this Image?"))
		return false;
	else {
		var newId = id;
		document.form1.actionId.value=newId;
		document.form1.submit();
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
	long fileSize = 0L;
	InputStream inputStream = null;
	String titleImg="",captionImg="",fileImg="",btnclkd="",title="",ttitle="",fileFields0="",actionId="";

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
						if (name.equals("btnUpload")) {
							btnclkd = "saved";
						}
						if (name.equals("title")) {
							titleImg = value;
						}if("captionImg".equals(name)){
							captionImg=value;
						}if("actionId".equals(name)){
							actionId=value;
						}
					} else {
						value = fileItem.getName();
						int ind = 0;
						String attError = "", filePath = "", a = "", filePath1 = "", filePath2 = "";
						boolean checkattach = name.contains("file");
						if (checkattach) { //if attach
							if (!"".equals(value)) {
								fileSize = fileItem.getSize();
								if (fileSize > 0) {
									int dotPos = value.lastIndexOf(".");
									if (dotPos == -1) {
										attError = "Please select the attachment file format to upload with extension";
										out.println("<br><br><br><h4 align=center><font color=red>" + attError
												+ "</h4>");
										return;
									} else {
										String extension = value.substring(dotPos + 1);
										if (((extension.equalsIgnoreCase("jpg"))&&(extension.equalsIgnoreCase("jpeg"))
												&& (extension.equalsIgnoreCase("png")))) {
											attError = "Please  select the attachment in jpg, jpeg, png format to upload";
											out.println("<br><br><br><h4 align=center><font color=red>" + attError
													+ "</h4>");
											return;
										} else {
											
											/*
						                    custom uploaded_file validation using secure-file-validator jar
						               	 by: Shashwat Gauatm
						           		*/
						                  // String fileName_check = Paths.get(fileItem).getFileName().toString();
						                   System.out.println("file name is : "+value);
						                   byte[] fileData = fileItem.get(); // this reads the content of the uploaded file
						                   Set<String> allowedExtensions = new HashSet<String>();
						                   allowedExtensions.add("jpg");
						                   allowedExtensions.add("jpeg");
						                   allowedExtensions.add("png");
						                   long maxSize_check = 10 * 1024 * 1024; // 10 MB
						                   // Use your SecureFileValidator method
						                   //ValidationResult result = SecureFileValidator.isSafeToUpload(value, fileData, allowedExtensions, maxSize_check);
						                   String result = callFileUploadAPI(fileItem, allowedExtensions, maxSize_check);
						                   System.out.println("validation result "+result.toString());
						                   String resultStr = result.toString();
						                   boolean isValid = resultStr.contains("\"valid\":true") || resultStr.contains("\"valid\": true");
						                       if (!isValid) {
						                               // Extract message manually
						                               String message = "Upload failed";
						                               int msgStart = resultStr.indexOf("\"message\":\"");
						                               if (msgStart != -1) {
						                                   int msgEnd = resultStr.indexOf("\"", msgStart + 10);
						                                   if (msgEnd != -1) {
						                                       message = resultStr.substring(msgStart + 10, msgEnd);
						                                   }
						                               }
						                       %>   
						                         <script>
						                            alert("Please only upload jpg, jpeg, png file ");
						                            window.location.href = "homepageImg.jsp";
						                         </script>
						                       <%
						                          return;
						                        } else {
						                              System.out.println("File successfully passed validation check");
												}
											/*
						                       end of file vaidation
						                   */

											inputStream = null;
        									inputStream = fileItem.getInputStream();

											ServletContext sc = session.getServletContext();

											filePath = storepath + "/slides/";

											/*tempDir = new File(filePath);
											if (tempDir.exists() == false) {
												tempDir.mkdir();
											}*/
											DateFormat df = new SimpleDateFormat("yyyyMMddhhmmSSS");
											Date today = Calendar.getInstance().getTime();
											String reportDate = df.format(today);
											File fileToCreate = null;
											/*if (name.equals("fileImg")) {
												title = reportDate+"." + extension;
												fileFields0 = title;
												fileToCreate = new File(filePath, fileFields0);
											}
											try {
												fileItem.write(fileToCreate);
												if (name.equals("fileImg")) {
													ttitle = fileFields0.toString();
													fileFields0 = ttitle;
													if (fileFields0 == null) {
														fileFields0 = "";
													}
													fileImg=ttitle;
												}
												
											 } catch (Exception e) {
												attError = "ERROR IN ATTACHMENT UPLOAD";
												e.getMessage();
												out.println("<br><br><br><h4 align=center><font color=red>"+attError+"-"+ e
														+ "..</h4>");
												return;
											} */
										}
									}
								}

							}
						}
					}
				}
			}
		}
PreparedStatement psImg = null;
ResultSet rsImg= null;
	if("saved".equals(btnclkd)){
		int maxId=0;
		String query = "select (nvl(max(id),0)+1) maxid from NOMINATION_GALLARY";
		psImg=con.prepareStatement(query);
		rsImg=psImg.executeQuery();
		if(rsImg.next()){
			maxId=rsImg.getInt("maxid");
		}
		query="insert into NOMINATION_GALLARY values(?,?,?,sysdate,?,?,?,'HOME',?)";
		psImg=con.prepareStatement(query);
		psImg.setInt(1,maxId);
		psImg.setString(2,fileImg);
		psImg.setString(3,captionImg);
		psImg.setString(4,emp);
		psImg.setString(5,"Y");
		psImg.setString(6,titleImg);
		psImg.setBinaryStream(7,inputStream, (int) fileSize);
		int updt=psImg.executeUpdate();
		if(updt>0){%>
			<script>
				alert("Image Uploaded successfully");
				location.href="homepageImg.jsp";
			</script>
		<%}	
	}
	if(!"".equals(actionId) && actionId!=null){
		psImg=con.prepareStatement("update NOMINATION_GALLARY set active='N' where id=? and type='HOME'");
		psImg.setString(1,actionId);
		int updt=psImg.executeUpdate();
		if(updt>0){%>
			<script>
				alert("Image deleted successfully");
				location.href="homepageImg.jsp";
			</script>
		<%}
	}
String query="select * from NOMINATION_GALLARY where active='Y' and type='HOME' and image is not null order by id ";
psImg=con.prepareStatement(query);
rsImg=psImg.executeQuery();
%>
<form name="form1" method="POST" action="" enctype="multipart/form-data">
<div class="container-fluid" style="min-height: 488px;">
<div class="row">	
	<div class="col-md-4">
	<div class="card mb10 box-shadow border-primary">
		<div class="card-header bg-primary style-app-name"><h4 class="text-white">Upload Image<h4></div>
		<div class="card-body">
			<div class="row">
				<div class="col-md-12">
					<label for="">Enter Title for Image</label>
					<input type="text" class="select-field" name="title" id="title" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<label for="">Enter Image</label>
					<input type="file" class="select-field" name="fileImg" id="fileImg" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 >
					<label for="">Enter Caption for Image</label>
					<textarea name="captionImg" rows="3" cols="33%" class="select-field"></textarea>
				</div>
			</div>
		</div>
		<div class="card-footer  style-right style-right-align">
			<button name="btnUpload" class="style-right-button">Upload</button>
		</div>
	</div>
	</div>
	<div class="col-md-8">
		<div class="card mb10 box-shadow border-primary">
			<div class="card-header bg-success style-app-name"><h4 class="text-white">Active Images</h4></div>
			<div class="card-body">
				<div class="row">
				<%
				String ext = "", exn="";
				int dotPosition = 0;
				while(rsImg.next()){
						ext = "jpg";
						exn = nullVal(rsImg.getString("file_name"));
						dotPosition = exn.lastIndexOf(".");
						if(dotPosition>0){
							ext = exn.substring(dotPosition+1);
						}						
						Blob blob = rsImg.getBlob("image");
						byte byteArray[] = blob.getBytes(1, (int) blob.length() );
						String base64Data = Base64.getEncoder().encodeToString(byteArray);

				%>	
					<div class="col-md-3">
					<div class="card">
						<img class="card-img-top" src="data:image/<%=ext%>;base64, <%=(base64Data) %>" alt="Blob Image" alt="Image">
						<div class="card-body">
						<p class="card-text"><%=rsImg.getString("title")%><a href="#" onclick = "return getInactive(<%=rsImg.getString("id")%>)"><img src="images/clear.png" width="30"></img></a></p>
						</div>
					</div>
					</div>
				<%}%>	
				</div>
			</div>
		</div>
	</div>
</div></div>
<input type="hidden" name="actionId" value="<%=actionId%>" />
<form>
<%@include file="footer.jsp"%>