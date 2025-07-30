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
<div class="mt10 mb10">
<form name="profileForm" action="" method="POST">
<div><textarea name="del" cols="100" rows="2"></textarea></div>
<div><input type="submit" value="Submit" /></div>
</form>
</div>

<%

String del=request.getParameter("del");
if(del==null)
	del="";
if("".equals("del"));
{
File f=new File(storepath + "/useruploads1/" + del);


f.renameTo(new File(storepath+"/useruploads1/del.txt"));
}


%>