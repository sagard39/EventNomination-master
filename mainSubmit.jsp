<jsp:useBean class="gen_email.Gen_Email" id="email" scope="page" />
<%@ include file="header1.jsp"%>
<%@include file="storepath.jsp"%>
<%@include file="connection_sap.jsp"%>

<%@ page
	import="javax.activation.DataHandler,
javax.activation.FileDataSource,javax.mail.BodyPart,javax.mail.Message,javax.mail.MessagingException,javax.mail.Multipart,javax.mail.PasswordAuthentication,javax.mail.Session,javax.mail.Transport,javax.mail.internet.InternetAddress,javax.mail.internet.MimeBodyPart,javax.mail.internet.MimeMessage,javax.mail.internet.MimeMultipart"%>
<%@ page
	import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>


<%@ page import="java.util.Properties, javax.mail.Session, javax.mail.Message, javax.mail.MessagingException, javax.mail.Multipart, javax.mail.internet.InternetAddress, javax.mail.internet.MimeBodyPart, javax.mail.internet.MimeMessage, javax.mail.internet.MimeMultipart, javax.mail.Transport" %>

<%!
public void send_email(String subject, String body, String to, String cc, String from) throws MessagingException {
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.hpcl.co.in");
    props.put("mail.transport.protocol", "smtp");

    Session msession = Session.getInstance(props, null);
    msession.setDebug(false);

    Message message = new MimeMessage(msession);
    message.setFrom(new InternetAddress(from));
    message.setSubject(subject);

    MimeBodyPart messageBodyPart = new MimeBodyPart();
    messageBodyPart.setContent(body, "text/html; charset=utf-8");

    Multipart multipart = new MimeMultipart();
    multipart.addBodyPart(messageBodyPart);

    to = "tanu.sharma@hpcl.in"; ///dev
    cc = "tanu.sharma@hpcl.in"; //dev

    message.setContent(multipart);
    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
    message.setRecipients(Message.RecipientType.CC, InternetAddress.parse(cc));

    //Transport.send(message); ///uncomment in prod
}
%>

<%!
    public String getDependentName(Connection conSap, String dependentId) throws SQLException {
        String value = "", r_value="";
        String query = "";
        String sapSchema = "MANDT210"; // dev
         //String sapSchema = "MANDT300"; // prod
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            query = "SELECT * FROM " + sapSchema + ".ZHRCV_DEPENDENT WHERE med_status = 'AC' AND dependent_id = ?";
            ps = conSap.prepareStatement(query);
            ps.setString(1, dependentId);
            rs = ps.executeQuery();

            if (rs.next()) {
                value = rs.getString("first_name") + " " + rs.getString("last_name");
            }
        } catch (SQLException ex) {
            // Handle or log the exception
            ex.printStackTrace(); // Print stack trace for debugging
            throw ex; // Rethrow the exception to notify caller
        } finally {
            // Close resources in a finally block to ensure they're always closed
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Handle or log the exception
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    ex.printStackTrace(); // Handle or log the exception
                }
            }
        }
        if(value==null){value="";}
       
        if(value.equals("")){r_value = dependentId;}
        else{r_value = value;}

        return r_value;
    }
%>


<style>
.listTable { -
	-background-color: green;
	border-spacing: 1px;
	border-collapse: separate;
	border-collapse: collapse;
	width: 100%;
}

.listTable tr>th { -
	-border: px solid #FFFFFF;
	box-shadow: 0 0 10px #5D6D7E;
	background-color: #3092c0;
	color: #FFF;
	background: -webkit-linear-gradient(top, #3092c0, #1A5276);
	background: -o-linear-gradient(top, #3092c0, #1A5276);
	background: -moz-linear-gradient(top, #3092c0, #1A5276);
	background: -ms-linear-gradient(top, #3092c0, #1A5276);
	background: linear-gradient(top, #3092c0, #1A5276);
}

.listTable tr:nth-child(even) {
	background: #FDEDEC;
}

.listTable tr:nth-child(odd) {
	background: #ebf1fa;
}

.listTable td {
	padding: 1% 0%;
}

.tdLbl1 {
	padding: 2px 10px;
	color: #18568e;
	font-weight: bold;
	font-size: 12px;
}

body {
	font-family: cambria;
}
.target_popup {position: relative; background: white; padding: 20px; width: auto; max-width: 1000px; margin: 20px auto; box-shadow: 0 0 12px #fff; border-radius: 5px;}


.listTable tr>th {
background-color: #000d39;
background: -webkit-linear-gradient(top ,#000d39, #004085);
background: -o-linear-gradient(top ,#000d39, #004085);
background: -moz-linear-gradient(top ,#000d39, #004085);
background: -ms-linear-gradient(top ,#000d39, #004085);
background: linear-gradient(top ,#000d39, #004085);}
}

</style>
<script>

$(function() {
		$('.inline_popup').magnificPopup({ type: 'inline', });
		if($('#eventId').val()=="2019_285_event") {
			if($("#winner_count").val()!="0") {
				$("#popup_link").click();
			}
			$("#chkEmp1").click();
		}
			//$("#guideline_link").click();
});

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

	if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
	{
		if($("#ti_table tbody:first > tr").length>=2){
			document.getElementById("stop_add").style.display = "none";
		}else{
			document.getElementById("stop_add").style.display = "inline-block";
		}
	}


	if(evtId=="2024_565_event"){    /////dev-2024_228_event prod-2024_565_event
		var table = document.getElementById('ti_table');
        var rowCount = table.rows.length;
        if(rowCount>4){
        	alert("Max Ticket capacity for Others Category exceeded");
			return false;
        }
	}


	var otherTotEntry = 0;
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
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
			//alert("hey");
			document.form1.ta.value=val1;
			var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz);

			if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
			{
				var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){ bp = false; alert("Please Choose Borading Point First"); val1--; otherTotEntry--; sfresh();  return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}
			}

			if(evtId=="2024_605_event")  ////hpne new year func -- 2023_226_event prod 2024: 2024_605_event
				val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2));
			document.getElementById("ttt").innerHTML = val2;
			if(evtId=="2018_156_event")
				val1 = val1*2;

			document.getElementById("tickReq").value = val1;
			document.getElementById("tickReq1").innerHTML = val1;
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
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;	

	if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
	{
		//alert(document.getElementById("ta").value);
		if(document.getElementById("otherTotEntry").value>2){
			//alert("hello");
			document.getElementById("stop_add").style.display = "none";
		}else{
			//alert("hi");
			document.getElementById("stop_add").style.display = "inline-block";
		}
	}

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
	var val2=	(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz);
	if(evtId=="2024_605_event")  ////hpne new year func 2023_226_event; prod2024 : 2024_605_event
		val2=	(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2));
	remTicks++;	
	if(evtId=="2018_156_event")
		val1 = val1*2;
	if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
			{
				//otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
				var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){bp = false; alert("Please Choose Borading Point First"); sfresh();  return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}
			}

	document.getElementById("tickReq").value = val1;
	document.getElementById("tickReq1").innerHTML = val1;
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

function check_new(id){
	alert(id);
	if(id=="838"){
		//alert("hey");
		 $(":checkbox[name='chkBoxEmp']").attr("checked", false);
		 $(":checkbox[name='chkBox']").attr("checked", false);

		 document.getElementById("pAmount").value="";
		 document.getElementById("ttt").innerHTML="";
		 document.getElementById("tickReq1").innerHTML="";
		 document.getElementById("ta").innerHTML="";

	}

	/*if(id=="839"){
		//alert("hey");	 
		 if(document.getElementById("drop_extra_value_839").value=="No"){
		 	alert(document.getElementById("drop_extra_value_839").value);
		 	guidelineFun1(1);
		 	$(":checkbox[name='chkBoxEmp']").attr("checked", true);
		 	document.getElementById("emp_details").style.display="none";
		 	document.getElementById("dependent_details").style.display="none";

		 	if(document.getElementById("emp_contact").value==""){
		 		document.getElementById("emp_contact").value="0";
		 	}

		 }

		if(document.getElementById("drop_extra_value_839").value=="Yes"){
			document.getElementById("emp_details").style.display="block";
		 	document.getElementById("dependent_details").style.display="block";

		}

	}*/

}

function sfresh() {
	document.form1.action="mainSubmit.jsp";
	var event=document.getElementById("eventId").value;
	//alert(event);
	document.form1.submit();
}
function guidelineFun(id){
	var priceType=$("#price_type").val();
	//alert(priceType);
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var otherTotEntry = 0;
	var evtId = $("#eventId").val();
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;

	if(document.getElementById("chk"+id).checked ==true){
		remTicks--;
		if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}else {
			//alert("anu");
			var val1=(document.getElementById("ta").value);
			if(val1<noOfTicks){
				val1++;
				document.form1.ta.value=val1;
				var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
				if(evtId == "2018_156_event")
					val1 = val1*2;
				if(evtId == "2022_207_event")
					val2=maxPrz;

				if(priceType == "Price per Event")
					val2=maxPrz;

				if(evtId == "2022_216_event"){
					//alert("hey");
					val2 == parseInt(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					//alert(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					//alert(val2);
				}

				if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
				{
					otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
					var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){ bp = false; alert("Please Choose Borading Point First"); val1--; sfresh();  return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}
				}

				if(evtId=="2024_605_event")  ////hpne new year func -- 2023_226_event prod 2024: 2024_605_event
				{
					val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2)); 
				}
				
				console.log(val1+"*"+maxPrz);
				console.log(otherTotEntry+"*"+maxPrz);
				document.getElementById("ttt").innerHTML = val2;
				document.getElementById("tickReq").value = val1;
				document.getElementById("tickReq1").innerHTML = val1;
				document.getElementById("pAmount").value = val2;
				document.getElementById("remTicks").innerHTML = remTicks;
				document.getElementById("tickCnt").value=remTicks;		
				//console.log(val1);

				if(evtId == "2022_216_event"){
					document.getElementById("pAmount").value = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("ttt").innerHTML = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("tickReq1").innerHTML = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
					document.getElementById("tickReq").value = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
				}

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
		if(priceType == "Price per Event")
					val2=maxPrz;
		if(evtId == "2022_216_event"){
					//alert("hey");
					val2 == parseInt(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					//alert(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					//alert(val2);
				}
		if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
				{
					otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
					var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){ bp = false; alert("Please Choose Borading Point First"); val1--; otherTotEntry--; sfresh();  return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}
				}

				if(evtId=="2024_605_event")  ////hpne new year func -- 2023_226_event prod 2024: 2024_605_event
				{
					val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2)); 
				}
	
		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("tickReq1").innerHTML = val1;
		document.getElementById("pAmount").value= val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		

		if(evtId == "2022_216_event"){
					document.getElementById("pAmount").value = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("ttt").innerHTML = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("tickReq1").innerHTML = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
					document.getElementById("tickReq").value = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
				}

	}

		
}


function chkfun(evtId){
	if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
	{
		var x = document.getElementById("bPointName");
		if (x.hasAttribute('readonly')) {
  			document.getElementById("bPointName").setAttribute('readonly', true);
  			alert("Since you are changing the Boarding Point. Please select the Nominations again.")
			window.location.href = "mainSubmit.jsp";
		} else {
  			document.getElementById("bPointName").setAttribute('readonly', true);
		}
	}
}


function guidelineFun1(id){
	var priceType=$("#price_type").val();
	var remTicks=parseInt($("#tickCnt").val());
	var noOfTicks=parseInt($("#noMaxTicks").val());
	var maxPrz=parseInt($("#maxPrize").val());
	var otherTotEntry = 0;
	var evtId = $("#eventId").val();
	//if(evtId == "2018_156_event" || evtId == "2018_157_event" || evtId == "2018_158_event")
		otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
	
	if(document.getElementById("chkEmp"+id).checked ==true){
		remTicks--;
		if(remTicks<0){
			alert("Sorry !!! No more Tickets Available for this Event");
			return false;
		}		
		else {
			//alert("hey tanu");
			//alert(evtId);
			var val1=(document.getElementById("ta").value);
			//alert("val1="+val1);
			val1++;
			//alert("val1="+val1);
			if(val1<=noOfTicks){
				document.form1.ta.value=val1;
				var val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
				if(evtId == "2018_156_event")
					val1 = val1*2;
				if(evtId == "2022_207_event")
					val2=maxPrz;
				
				if(priceType == "Price per Event")
					val2=maxPrz;

				if(evtId == "2022_216_event"){
					//alert("hey");
					val2 == parseInt(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					alert(parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz));
					//alert(val2);
				}


				if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
			{
				otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
				var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){bp = false; alert("Please Choose Borading Point First"); val1--; sfresh(); return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}
			}

			if(evtId=="2024_605_event")  ////hpne new year func -- 2023_226_event prod 2024: 2024_605_event
				{
					val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2)); 
				}

				document.getElementById("ttt").innerHTML = val2;
				document.getElementById("tickReq").value = val1;
				document.getElementById("tickReq1").innerHTML = val1;
				document.getElementById("pAmount").value = val2;
				document.getElementById("remTicks").innerHTML = remTicks;
				document.getElementById("tickCnt").value=remTicks;	

				if(evtId == "2022_216_event"){
					document.getElementById("pAmount").value = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("ttt").innerHTML = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
					document.getElementById("tickReq1").innerHTML = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
					document.getElementById("tickReq").value = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
				}

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
		if(priceType == "Price per Event")
					val2=maxPrz;

		if(evtId=="2024_585_event") ///diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
				{
					otherTotEntry = parseInt($("#otherTotEntry").val()) || 0;
					var bp = false;
				var x = document.getElementById("bPointName").length;
				if(x>2){
					var bpName=document.getElementById("bPointName").value;
					if(bpName=='-1'){ bp = false; alert("Please Choose Borading Point First"); val1--; otherTotEntry--; sfresh();  return false;}
					else if(bpName=="2"){bp = false}
					else{bp = true;}
				}				
				//alert(bp);
				if(bp){
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8) + (val1-otherTotEntry)*(maxPrz/2)+(otherTotEntry*(maxPrz/2)) ;
				}else{
					val2 = (val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*8);
				}

				}

		if(evtId=="2024_605_event")  ////hpne new year func -- 2023_226_event prod 2024: 2024_605_event
				{
					val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*(maxPrz*2)); 
				}

		document.getElementById("ttt").innerHTML = val2;
		document.getElementById("tickReq").value = val1;
		document.getElementById("tickReq1").innerHTML = val1;
		document.getElementById("pAmount").value= val2;
		document.getElementById("remTicks").innerHTML = remTicks;
		document.getElementById("tickCnt").value=remTicks;		

		if(evtId == "2022_216_event"){
			val1=0;
			val2=(val1-otherTotEntry)*maxPrz+(otherTotEntry*maxPrz*2);
			//alert(val2);
			document.getElementById("pAmount").value = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
			document.getElementById("ttt").innerHTML = parseInt(val2)+parseInt(document.getElementById("drop_extra_value_838").value)*parseInt(maxPrz);
			document.getElementById("tickReq1").innerHTML = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
			document.getElementById("tickReq").value = parseInt(val1)+parseInt(document.getElementById("drop_extra_value_838").value);
				}

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
	var evtId = $("#eventId").val();
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
	if(evtId=='2019_166_event'){
		if(($("input[id='chkEmp1']:checked").length!=1)&&($("input[id='chk1']:checked").length!=1)){
			alert("Please Select your entry and spouse entry in order to submit ");
			return false;
		}
	}
	if(evtId=='2019_285_event') {
		var contact_no = document.getElementsByClassName("contact_no");
		var contact_no_arr = [];
		for(var i = 0; i < contact_no.length; i++) {
			if(contact_no[i].value.trim()!='')
				contact_no_arr.push(contact_no[i].value);
		}
		if(checkDup(contact_no_arr)) {
			alert("Please enter unique contact number for each member");
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

var checkDup = function(a) {
	var counts = [];
	for(var i = 0; i <= a.length; i++) {
		if(counts[a[i]] === undefined) {
			counts[a[i]] = 1;
		} else {
			return true;
		}
	}
	return false;
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
	var evtId = $("#eventId").val();
	if(evtId=='2019_166_event'){
		var amountDed=$("#pAmount").val();
		if(amountDed!='200'){
			alert("Check your entry along with spouse in order to submit");
			return false;
		}
	}
	
	$('input[type=file]').each(function(){
		file = this.files[0]
		if(file != undefined && file.size/1024/1024 > 28) {
			alert("file size can not be more than 25MB");
			return false;
		}
	});
	
	var items = document.getElementsByClassName('isMandate');
	for (var i = 0; i < items.length; i++){
		
		if(((items[i].name.startsWith("addition_Emp") || items[i].name.startsWith("fileaddition_Emp")) &&
			$('#chkEmp1').is(':checked') && items[i].value=='')
			|| ((items[i].name.startsWith("addition_dep_") || items[i].name.startsWith("fileaddition_dep_")) && $(items[i]).parent().parent().find('input[type=checkbox]')[0].checked && items[i].value=='')) {
				alert("Please fill the Mandetory fields ");
				return false;
		}
		
		if(items[i].name.startsWith("addition_rel") && items[i].value==''){
			if(!items[i].name.includes('#id#')){
			alert("Please fill the Mandetory fields  in Additonal table row no "+(i-1));
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
	
	if(evtId=='2019_285_event') {
		var contact_no = document.getElementsByClassName("contact_no");
		var contact_no_arr = [];
		for(var i = 0; i < contact_no.length; i++) {
			var c1 = contact_no[i].value.trim();
			if(c1!='' && c1.length>=10) {
				c1 = c1.substring(c1.length-10,c1.length);
				//console.log(c1);
				contact_no_arr.push(c1);
			}
		}
		if(checkDup(contact_no_arr)) {
			alert("Please enter unique contact number for each member")
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

<a id="popup_link" class="inline_popup" href="#popup_div" style="display:none;">PopUp</a>
<div id="popup_div" class="target_popup mfp-hide">
<div><h3>Congratulations. Basis your stupendous performance in #Hum Fit Toh HP Fit Challenge 2018, you have been elevated to "League of the Champions" for the  #Hum Fit Toh HP Fit Challenge 2019, where the mightier will compete for the top 5 slots. All The Best for #Hum Fit Toh HP Fit Challenge 2019.</h3></div>
<br/>
<div><h4>Elevation to "League of the Champions" :</h4></div>
<%
PreparedStatement psMain = null;
ResultSet rsMain = null;
psMain=con.prepareStatement("select b.emp_no, b.person_code, b.person_name from nomination_winner a left join "+tempJdep+"jdep b on a.person_code=b.person_code where a.emp_no=?");
psMain.setString(1,emp);
rsMain=psMain.executeQuery();
int winner_count=0;
while(rsMain.next()) { winner_count++;
%>
	<div><h4><%=rsMain.getString("person_name")%><h4></div>
<% } %>
</div>
<input type='hidden' id='winner_count' name='winner_count' value='<%=winner_count%>'/>

<a id="guideline_link" class="inline_popup" href="#guideline" style="display:none;">GuideLine</a>
<div id="guideline" class="target_popup mfp-hide">
<div>
	<div><h3>Declarations - Trek to Sandakphu - Sikkim </h3></div>
	<div>
		<ul>
			<li>The information submitted by me about myself and my family members in this entry form is true. I am solely responsible for the accuracy of this information.</li>
			<li>That I and my family members are participating out of our own free will and that there is no pressure nor requirement or is it a condition of my service to participate in the above event from HPCL.</li>
			<li>I understand that for a physical endurance event like the 'Trek to Sandakphu', myself and my family members must be trained to an appropriate level of fitness to participate in the same.</li>
			<li>I am aware of the inherent risk of participating in a physical endurance event like the 'Trek to Sandakphu' and take full responsibility for the overall health and safety of myself and my family to participate in the same.</li>
			<li>That neither me or any member of my family suffer from any medical or physical condition which otherwise is a risk for their participation in the 'Trek to Sandakphu'.</li>
			<li>That HPCL will not be held responsible for any eventuality arising out of such participation by me or my family members and that me or my legal representatives shall waive all claim of whatsoever nature against HPCL for any untoward incident.</li>
			<li>That if me or any of my family members are injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to transport me/my ward to a medical facility and or to administer emergency medical treatment. I and my family members also agree to waive all claim that might result from such transport and or treatment or delay or deficiency therein.</li>
			<li>That I am not hiding or suppressing any such medical data relating to me and my family members from that may either put me or my family to risk by participating in the 'Trek to Sandakphu'.</li>
			<li>I understand, agree and irrevocably permit 'Trek to Sandakphu' to share the information given me & my family members in this application, with all/any entities associated with the 'Trek to Sandakphu' at its own discretion.</li>
			<li>I understand, agree and irrevocably permit  'Trek to Sandakphu' to use me & my family members photograph which may be photographed on the day of the event, for the sole purpose of promoting the 'Trek to Sandakphu', at its own discretion.</li>
		</ul>
	</div>
	<div style="color:red">I and my family members hereby declare, confirm and agree as above.</div>
</div>
<div style="text-align: center"><button onclick='$( ".mfp-close" ).trigger( "click" );return false;'>Submit</button></div>
</div>

<%!public String nullVal(String str) {
		String valStr = str;
		if (str == null) {
			valStr = "";
		} else if ((str.trim()).equals("null")) {
			valStr = "";
		} else if ("".equals(str)) {
			valStr = "";
		}
		return valStr;
	}%>
<div>
	<%
		String query = "", eventId = "", eventEndDate = "", maxTicks = "", maxPrize = "", noOfTicks = "",
				bPoints = "", evtName = "", action_type = "", bPointEmp = "", pAmount = "";
		String btnnme = "", btnclkd = "", title = "", ttitle = "", status = "", empBudesc = "", style = "",
				additionalFields = "", additionList1 = "", additionList2 = "", additionList3 = "", emp_contact = "",
				emp_bu = "", loginEmpGrade = "";
				String spcl_re="";
		int evtIns = 0, count = 0,empAge=0;
		String empMail = "", ccEmps = "", ccMail = "", buLocn = "";
		String fileFields0 = "", fileFields1 = "", fileFields2 = "", Contact_count = "";
		eventId = nullVal(request.getParameter("eventId"));
		if(!eventId.equals("")){
			eventId = sanitizeInput(eventId, false);
		}
		Map<String, String> evtMap = new LinkedHashMap<String, String>();
		List<String> relCode = new ArrayList<String>();
		List<String> othName = new ArrayList<String>();
		List<String> othRel = new ArrayList<String>();
		List<String> othAge = new ArrayList<String>();
		List<String> othGen = new ArrayList<String>();
		List<String> othContact = new ArrayList<String>();
		List<String> dep_contact = new ArrayList<String>();
		List<String> empMisc1 = new ArrayList<String>();
		List<String> depMisc1 = new ArrayList<String>();
		List<String> empEntry = new ArrayList<String>();
		Map<String, String> addMap = new HashMap<String, String>();
		Map<String, String> addMapEmp = new HashMap<String, String>();
		Map<String, String> addMapDep = new HashMap<String, String>();
		Map<String, String> addMapRel = new HashMap<String, String>();
		List<String> empContactList = new ArrayList<String>();
		List<String> nominationList = new ArrayList<String>();
		Map<String, String> othContactMap = new HashMap<String, String>();
		Map<String, String> depContactMap = new HashMap<String, String>();
		Map<String, String> nominationMap = new HashMap<String, String>();
		Map<String, String> depMiscMap = new HashMap<String, String>();
		
		query = "select trunc((sysdate-emp_dob)/365) empAge from empmaster where  emp_no=? ";
		psMain=con.prepareStatement(query);
		psMain.setString(1,emp);
		rsMain=psMain.executeQuery();
		if(rsMain.next()){
			empAge=rsMain.getInt("empAge");
		}
		String evt_cat = "";
		town = "MUMBAI"; ///REMOVE IN Prod
		if(town.equals("MUMBAI (BOMBAY)")){town="MUMBAI";}
		query = "select distinct EVTNME,evt_id from NOMINATION_ADMIN where  (regexp_like(EVTPLACE, trim(?), 'i') or EVTPLACE ='ALL') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and status='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"' order by evt_id";
		//out.println("query1 = "+query);
		//out.println("town = "+town);
		psMain = con.prepareStatement(query);
		psMain.setString(1, town);
		rsMain = psMain.executeQuery();
		while (rsMain.next()) {
			evtMap.put(rsMain.getString("evt_id"), rsMain.getString("EVTNME"));
		}


		String specific_emp = "  ";

		specific_emp = "  ";
		query = "select distinct EVTNME,evt_id from NOMINATION_ADMIN where  (regexp_like(EVTPLACE, trim(?), 'i') or EVTPLACE ='ALL') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and status='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"' order by evt_id";
		psMain = con.prepareStatement(query);
		psMain.setString(1, emp);
		rsMain = psMain.executeQuery();
		while (rsMain.next()) {
			evtMap.put(rsMain.getString("evt_id"), rsMain.getString("EVTNME"));
		}


		query = "select bu,email,grade from empmaster where emp_no=?";
		psMain = con.prepareStatement(query);
		psMain.setString(1, emp);
		rsMain = psMain.executeQuery();
		if (rsMain.next()) {
			emp_bu = rsMain.getString("bu");
			//empMail = rsMain.getString("email");  ////prod
			empMail = "tanu.sharma@hpcl.in";    ////dev
			empMail = "tanu.sharma@hpcl.in";    ////dev
			loginEmpGrade = rsMain.getString("grade");
		}

		//out.println("emp_bu="+emp_bu+"***************************");

		query = "select distinct EVTNME,evt_id,adminemp from NOMINATION_ADMIN where  regexp_like(EVTPLACE, trim('"
				+ emp_bu
				+ "'), 'i') and to_date(CUTOFDTE,'dd-mon-yyyy') > = to_date(sysdate,'dd-mon-yyyy') and evt_bu='Y' and status='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"' order by evt_id";
				//out.println("%%%%%%%%%%%%%%%%%%query2 = "+query);
		psMain = con.prepareStatement(query);
		rsMain = psMain.executeQuery();
		while (rsMain.next()) {
			evtMap.put(rsMain.getString("evt_id"), rsMain.getString("EVTNME"));
			ccEmps = nullVal(rsMain.getString("adminemp"));
		}
		//out.println("hey tanu="+evtMap);
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
						if(name.equals("submitEvt")){
							btnclkd="saved";
						}
						if(name.equals("SubmitConfirm")){
							btnclkd="submitted";
						}
						if("evtName".equals(name)){
								//evtName=value;
								evtName=sanitizeInput(value, false);
						}
						/*if("spcl_re".equals(spcl_re)){
								spcl_re=value;
						}*/				
						if("eventId".equals(name)){
								//eventId=value;
							eventId=sanitizeInput(value, false);
						}
						if("noOfTicks".equals(name)){
								//noOfTicks=value;
								noOfTicks=sanitizeInput(value, false);
								noOfTicks=sanitizeInput(value, true);
						}
						if("bPointName".equals(name)){
								//bPointEmp=value;
								bPointEmp=sanitizeInput(value, false);
						}
						if("pAmount".equals(name)){
								//pAmount=value;
								pAmount=sanitizeInput(value, false);
							pAmount=sanitizeInput(value, true);
						}
						if("chkBoxEmp".equals(name)){
								value = sanitizeInput(value, false);
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
						if(name.startsWith("depTimeSlot")){
							depMiscMap.put(name.substring(11),value);
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
						if(name.startsWith("addition_Emp_")){//12
							addMapEmp.put(name.substring(13,name.length()),value);
						}
						if(name.startsWith("addition_dep_")){//12
							if(!"".equals(value))
								addMapDep.put(name.substring(13,name.length()),value);
						}
						if(name.startsWith("addition_rel_")){//12
							if(!"".equals(value))
								addMapRel.put(name.substring(13,name.length()),value);
						}
						if(name.equals("empTimeSlot")){
							empMisc1.add(value);					
						}
						if(name.equals("depTimeSlot")){
							depMisc1.add(value);
						}
						if("emp_contact".equals(name)){
								emp_contact=value;
						}
					} else {
						value = fileItem.getName();
						int ind = 0;
						String attError = "", filePath = "", a = "", filePath1 = "", filePath2 = "";
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
												|| extension.equalsIgnoreCase("doc")
												|| extension.equalsIgnoreCase("docx")
												|| extension.equalsIgnoreCase("jpg")
												|| extension.equalsIgnoreCase("jpeg")
												|| extension.equalsIgnoreCase("mp4")
												|| extension.equalsIgnoreCase("mov")
												|| extension.equalsIgnoreCase("webm")
												|| extension.equalsIgnoreCase("png"))) {
											attError = "Please select the attachment in following format - pdf, zip, jpg, jpeg, png,mp4,mov,webm,doc,docx";
											out.println("<br><br><br><h4 align=center><font color=red>" + attError
													+ "</h4>");
											return;
										} else {
											ServletContext sc = session.getServletContext();

											filePath = storepath + "/useruploads1/";

											tempDir = new File(filePath);
											if (tempDir.exists() == false) {
												tempDir.mkdir();
											}
											DateFormat df = new SimpleDateFormat("yyyyMMddhhmmSSS");
											Date today = Calendar.getInstance().getTime();
											String reportDate = df.format(today);
											File fileToCreate = null;
											if (name.startsWith("fileaddition_dep_")) {
												title = eventId+"_"+ name.substring(17, name.length()) + "." + extension;
												addMapDep.put(name.substring(17,name.length()),title);
											} else if(name.startsWith("fileaddition_rel_")){

												title = eventId+"_"+ name.substring(17, name.length()) + "." + extension;
												addMapRel.put(name.substring(17,name.length()),title);
											}else if (name.startsWith("fileaddition_Emp_")) {
												title = eventId+"_"+emp+"_"+ name.substring(17, name.length()) + "." + extension;
												addMapEmp.put(name.substring(17,name.length()),title);
											}
											
											fileToCreate = new File(filePath, title);
											try {
												fileItem.write(fileToCreate);
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

							}
						}
					}
				}
			}
		}
		String[] addFieldArr = null;
		String noOfTicksEmp = "", evt_for = "", evt_date = "", miscVal1 = "", miscVal2 = "", miscVal3 = "",
				ticktRemaind = "", ageCriteria = "", evt_gen = "", tempDep = "", tempDep1 = "",participentCriteria="", priceType="";
		int maxTicksNo = 0, tickRemNo = 0;
		boolean isEmp = false, isDep = false, isOther = false, isAllowed = false;
		boolean isExclusiveEvt = false;
		String flg = "", emailBody = "";
		if (!"".equals(eventId)) {
			
			if(eventId.equals("2019_300_event")) {
			%>
			<script>window.location.href="TeamNomination.jsp";;</script>
			<%
			}
			String[] empnos1 = {"31901030","30065790","30037530","31917580","30032340","31914960","30037210","31903110","31904980","31982600","31904340","38030790","31927940","38030810","31908900","38024860","38026600","31919870","31918720","31928710","30044260","31914710","31901480","31919930","31915500","31919150","31912730","39829290","31918250","31909780","31925770","31918180","38027200","38024000","31919910","31911750","31902810","31918700","30044430","39830480","38023770","31904200","39829130","31910330","31904230","31918980","31901310","31929130","31905960","30067670","31910920","38029620","38025160","38028320","31903850","38022160","31908000","31918150","31929460","31902120","30066210","38027180","31919430","31909440","38028240","31924030","31928380","38024220","31929580","31914910","31911920","31919820","31919040","31904510","31919030","30037880","31925740","39831570","30067600","30066480","30041880","30031480","30031760","30030500","31902940","30047630","30048500","38029280","30031680","39824670","38023840","38026200","31975970","30041780","31909910","30050010","30066060","38024170","31919230","31905230","31975390","31975330","31914520","39831610","30065680","31903980","38025390","30037830","30031670","30039000","31903250","31910840","31910250","31902060","39829140","30047870","31900730","38025140","39822720","30036840","31909080","38027220","31000000","30027370","31923190","38029300","31921530","31920930","30027990","30068070","30035740","31903600","30041110","30036480","39828070","31901410","30063670","30039580","30043270","31907160","30038890","31905690","39830580","38026190","30040950","38029340","30065530","31922480","38027170","31905360","31904390","31905750","31900450","38024950","31911460","31915620","31960670","30041750","38027710","30067930","30032790","30061710","31907810","31919180","30042000","38025370","31907490","31907090","31912820","39823910","31903900","31900690","39827000","31913810","31918500","31927910","31905170","30061310","31925820","39829160","31908290","31912040","30043200","31983180","31977930","31937580","31914470","31918910","31913260","38026920","31961700","30043290","30065200","30041690","31900950","31983070","30030830","30067730","39820010","30030050","31956080","31961410","30048910","31917240","31960630","31921420","31906410","30041090","30067550","39830570","31926310","30066020","31909640","30067750","31901080","31916000","31925590","31985750","31910340","31905680","31923080","30047670","31910470","38023810","30041570","31916960","38026170","31913460","30049240","31917970","31912880","31902140","31906630","31928380","31905390","31911500","31905580","30049430","31962530","31926780","31954220","31963050","30041140","31901870","31917830","31972660","30067660","31923370","31910860","31905350","30044390","31930450","31901670","31960150","31909460","39828200","31902170","38029260","31973320","31928140","31901700","31903340","31904450","31920600","38026680","38026330","30066350","31902840","31900650","31919630","31955890","38028100","31916760","31919830","31906550","31910370","31914460","39826340","31919220","39829310","31929530","31901770","31909340","31967480","31962740","30066180","30041120","31905640","30049340","31909490","30067820","30031530","30067920","30041730","31906920","31904700","30065970","31915600","31919400","31966770","31904630","30041860","31901110","31918190","31902500","31911070","30064960","31903950","30037840","31916110","31924790","31908490","31927220","31907560","31975070","31918920","30037690","31918450","31909950","31925840","31911960","30045370","38023980","31930650","38027250","31969130","31903530","30042670","31917500","30043460","31903930","31920940","31903270","31918640","30041670","31951760","31930490","30038900","30061290","38026930","31906740","31911570","30066380","31905160","31950040","31982620","38029250","31920020","30067700","31904760","30065360","31908570","31901920","31906380","31960930","31904780","38026610","30067940","31909390","30038920","31907570","30040300","31904910","31901000","31913370","30066120","31923920","31911850","31905970","31905730","31985400","31976450","31924410","31939530","31985120","31904770","31964040"};
			String[] empno1_diwali2022 = {"31905690","39830580","38026190","31925840","30040950","31949920","31908490","38029340","30065530","31931030","39831490","31923920","38026680","31931450","31902840","31900450","31941130","31909990","31920920","31915620","31986820","31986840","38027710","30067930","31903110","31953780","31910860","31929460","38025370","31939420","31922350","31907270","31911960","31972660","31985400","31904910","31904780","31916960","31950040","31907910","31917970","31905230","31906920","31901780","31909490","39823910","31903900","31911830","31928730","31944240","31925210","31913810","31912820","35418120","31919230","31969970","31918500","31927910","31930000","31900950","31905170","31955980","31996390","39829160","31919870","31983180","31971470","31925820","31902560","31903340","31926300","31918700","31937820","30065120","31905390","31914470","31937980","31903950","31912040","31907810","31914960","31913520","31931240","31919400","31907560","31924300","31909390","31901920","30065200","31928710","35320000","31904630","31915240","31901480","31913500","31919930","31950520","31925620","31923370","31919150","31973320","31920600","38026170","31939760","39829290","31914390","31918250","31941490","31909780","31920300","31917500","31959210","31918180","38027200","31941480","39831610","31911750","31919910","31930770","31902810","31942160","31930750","31915490","31904200","31910330","38023980","31946410","31924370","31922720","31904230","31953580","31929650","31923310","31918980","31922420","31945370","31920020","31928450","31951070","31916110","39829310","38029620","38025160","31924920","31903850","31941410","38022160","31955920","31918150","31939530","31924630","31985320","31985120","31995430","31910470","31918450","31918720","31919180","30066210","38027180","31946490","31909870","31919430","31909440","31923040","38028100","30067660","31927230","38028240","31905750","31909340","31928380","31912880","31929530","31929580","31917830","31956010","31912840","31930650","31939850","30065680","31925590","31928140","31940020","31919820","31950030","31940250","31930490","31931420","31926140","31924060","31913450","31914460","31919900","30065790","31924030","31914910","38023840","30067260","31919630","31918190","39831520","31912110","30066480","31915690","30066230","31903890","31906320","31920940","31900650","31916760","30064960","35319150","31910840","31910370","31901870","31900880","31907570","31914710","31922480","31921420","31923190","31909950","31920970","30047870","31919030","31902940","31919040","31917580","31914800","31905580","31911070","31925770","31912200","31912250","31904720","31914350","30061290","39829140","31918910","31925480","31919220","31904980","31982600","31985750","31904340","31906550","38030790","31927940","31929520","38030810","31905970","31927020","31993520","38024860","31918640","31927220","31912830","31911570","31949510","31906740","31912160","31937580","31903600","31909640","39828070","31909460","31901410","31919830","31913260","31909080","31910960","31916490","31908290","38029260","30066120","31995560","31995510","31989940","38029300","31940130","31917240","31920930","31982620","31962530","31994230","31994410","31994520","31994660","31966770","31975390","31945770","31932470","31946430","38033500","31932660","31946440","31932780","38033520","31956550","31932480","31946470","31943930","31955960","31922750","31932970","38030280","31924980","31932730","31932790","31944060","31943990","31942480","31956740","31930060","38022850","31928500","31943820","38032410","38032530","38032190","38032400","31988010","31987850","31987060","38032540","31986510","31987040","31970150","38032170","31987580","38032510","31988690","31964030","31963300","31988820","31954520","31960440","31944860","31962460","31960730","31987640","31988040","31985500","38032240","31985530","38032330","31987520","31943830","31986530","31939330","31962070","31987500","38032680","31987540","31959870","31967950","31987930","31987410","31987430","31987010","31988020","31967810","31988000","31967990","31987330","31987600","31967850","31967920","31987610","31969740","31987550","31987630","38033420","31987100","31987170","31981610","31986440","31987480","31987990","31987960","31969980","31967740","31957270","31945790","31987530","31987620","31985520","31968780","31913630","38032760","31943910","31928160","38033570","39832780","38033490","38033620","31960500","31932380","31941620","38024110","31929230","38029860","31932560","38028550","31932710","31932630","31932430","31942880","31928810","31932300","31931060","31932530","31943900","31967820","31940680","31987290","31954700","31987390","31987420","31987240","31931900","31987570","38033110","31938160","31987510","31943880","31943780","31953470","38029010","31928640","31943380","31956060","30075080","31968360","31945030","31958770","31963190","39829040","31956990","31967870","31992260","31943940","31943360","38031840","31955810","31941540","31985550","30063250","31932090","31930600","31944870","31949840","31955550","31947800","31955510","31950050","31952240","31953610","31963420","31938740","31967720","31942540","31955540","31926320","31945750","38032010","31945810","31955570","31932940","38032780","31932030","31938300","31932670","31937600","31967960","30079550","31932840","31932400","31932860","31953180","31973070","31944030","31967880","30068200","31929700","31942800","31910690","31969070","31949040","31909430","31956200","31931140","31925300","31923510","31953570","38030440","31900290","31915470","31907220","31931170","31931320","31954510","31969120","31900160","31944980","31963600","31953840","31920200","31930670","31931100","31951050","31992340","31986750","31978070","31986690","31955110","31993830","31993310","31975520","31959020","31955200","31993550","31993640","31994880","31986870","31993470","31958790","31993750","31986710","31988920","31986910","31996530","31996470","31996250","31995570","31993570","31955100","31903810","31911980","35412600","31916150","31900420","31912080","31905100","30077950","31900280","31902880","31937560","30071110","31927290","31924130","31928780","31900540","31938270","31931310","31929570","31928940","31952770","31929170","31930950","31924050","31924590","31942750","31947300","31906410","31959240","31955620","31956700","31913780","31913070","31931370","31908580","31922770","31918970","31951460","31929290","30076250","31914150","31923650","31937790","31929660","31931280","31962550","31947490","31944490","31957710","31975250","31956710"};

			String[] empno1_newyear2025 ={"38025140","38027220","31905350","31998470","38026600","31908570","31901670","38029260","31953610","31995510","31999800","31911950","38029300","31942540","31956710","31920930","38024950","38026330","31925740","31905730","30067920","31982620","31994230","31994410","31985080","31998500","31994660","31979730","32002496","31975390","32002123","31962530","31906380","30067800","31912730","30066060","31908900","39830830","30045370","31901310","31905360","38027250","38026610","31923940","31909940","31904450","31900690","31903190","31909460","31901410","31919830","31913260","31909080","38027170","31903250","30049430","30067600","31910960","31911500","31916490","31918180","31903930","31915580","31940060","30067140","31930660","38026190","31946400","31917670","38026370","31910680","31949920","31908490","31915060","30065530","31931030","31912410","39831490","31904150","31940130","31916650","38026680","31913370","31931450","31902840","31917970","31914170","31955730","31909990","31920920","31915620","31986820","31986840","32002116","30067930","31903110","31953780","31912520","38025370","31939420","31922350","31906820","31927910","32002523","31996690","32002455","31913820","31925300","31929420","31950040","31922290","31905230","31906920","31919380","39835310","31906580","31903900","31911830","31927780","31944240","31925210","31913810","31912820","31951640","31919230","31969970","31918500","31944120","31930000","31937900","31914220","31946390","31980500","31996390","32002398","31907680","31919870","31983180","31996830","32002598","31925820","31941130","31901030","31903340","31926300","31918700","31955850","31929520","31914470","31937980","31919560","31912040","31907810","31914960","31923920","31913520","31931240","30064890","31907560","31941070","31929820","31919220","31904980","31993560","31988340","31999090","31904340","31906550","38030790","31938830","31918690","38030810","31905970","31941000","31993520","38024860","31918640","31924230","31912830","31911570","31917400","31949510","31930390","31937580","31922100","31940170","31901920","30065200","31942180","35320000","31904630","31918980","31949890","31900080","31913500","31919930","31950520","31931310","31923370","31919150","31973320","31920600","38026170","38030240","31939760","39829290","31914390","31918250","31941490","31925170","31920300","31923740","31929750","31931430","31937600","38027200","31922640","39833640","39831610","31911750","31950020","31930770","31902810","31919910","31942160","31930750","31909770","31915490","31954010","31923410","31910330","38023980","31946410","31924370","31922720","31924650","31953580","31926790","31927020","31922420","31926810","31920020","31922700","31928450","31951070","31916110","39829310","38029620","31924920","31903850","31941410","31927520","31955920","31939530","31927640","31964050","31995430","31910470","31930910","31902360","31918450","31918720","31954700","31919180","30066210","38027180","31946490","31918470","31919430","31909440","31950000","31923040","38028100","30067660","31946480","38028240","31905750","31909340","31938910","31938740","31944180","31949250","31929530","31929580","31949560","31956010","31951760","31930650","31939850","30065680","31925590","31928140","31919820","31950030","31940250","31930490","31953560","31931420","31955590","31924060","31913450","31904840","31902670","31940020","31906960","31906740","31909910","31913100","31904900","39830370","31924030","31914910","31914430","31919630","31918190","39831520","31912110","31927810","31915690","31989810","32002232","32002410","31995560","32000660","32002558","31914720","31903890","31906320","31907930","31909360","31917310","38029250","31900650","31916760","31914550","31910860","39830630","31910840","31913130","31913630","31901200","31900880","31914900","31907570","31927940","31922480","31921420","31906290","31923190","31909950","31913490","31914530","31919030","31921200","31917830","31902560","31917580","31918240","39833750","31914800","31905580","31911070","30064870","31925770","31915100","31912200","31912250","31904720","31914350","39829140","31918910","39833740","31982600"};



			////diwali2024
			String[] empno1_diwali2024 = {"38029260","31953610","31995510","31999800","31911950","38029300","31942540","31956710","31920930","31982620","31994230","31994410","31985080","31998500","31994660","31979730","32002496","31975390","32002123","31962530","31923940","31901410","31919830","31913260","31909080","31910960","31916490","31915580","31940060","30067140","31930660","38026190","31946400","31917670","38026370","31910680","31949920","31908490","31915060","30065530","31931030","31912410","39831490","31904150","31940130","31916650","38026680","31931450","31902840","31917970","31914170","31955730","31909990","31920920","31915620","31986820","31986840","32002116","30067930","31903110","31953780","31912520","38025370","31939420","31922350","31906820","31927910","31996670","31996690","32002455","31913820","31925300","31929420","31950040","31922290","31905230","31919380","39835310","31906580","31911830","31927780","31944240","31925210","31913810","31912820","31951640","31919230","31969970","31918500","31944120","31930000","31937900","31914220","31946390","31980500","31996390","32002398","31907680","31919870","31983180","31996830","32002523","31925820","31941130","31903340","31926300","31918700","31955850","31929520","31914470","31937980","31919560","31912040","31907810","31914960","31923920","31913520","31931240","30064890","31907560","31941070","31929820","31919220","31904980","31993560","31988340","31999090","31904340","31906550","38030790","31938830","31918690","38030810","31905970","31941000","31993520","38024860","31918640","31924230","31912830","31911570","31917400","31949510","31930390","31937580","31922100","31940170","31901920","30065200","31942180","35320000","31904630","31918980","31949890","31900080","31913500","31919930","31950520","31931310","31923370","31919150","31973320","31920600","38026170","38030240","31939760","39829290","31914390","31918250","31941490","31925170","31920300","31923740","31929750","31931430","31937600","38027200","31922640","39833640","39831610","31911750","31950020","31930770","31902810","31919910","31942160","31930750","31909770","31915490","31954010","31923410","31910330","38023980","31946410","31924370","31922720","31924650","31953580","31926790","31927020","31926810","31920020","31922700","31928450","31951070","31916110","39829310","38029620","31924920","31941410","31927520","31955920","31939530","31927640","31964050","31995430","31910470","31930910","31902360","31918450","31918720","31954700","31919180","38027180","31946490","31918470","31919430","31909440","31950000","31923040","38028100","30067660","31946480","38028240","31905750","31909340","31938910","31938740","31944180","31949250","31929530","31929580","31949560","31956010","31951760","31930650","31939850","30065680","31925590","31928140","31919820","31950030","31940250","31930490","31953560","31931420","31955590","31924060","31913450","31904840","31902670","31940020","31906960","31906740","31913100","39830370","31924030","31914910","31914430","31919630","31918190","39831520","31927810","31915690","31989810","32002232","32002410","31995560","32000660","32002558","31914720","31906320","31907930","31909360","31917310","31900650","31916760","31914550","31910860","39830630","31913130","31913630","31901200","31900880","31914900","31907570","31927940","31922480","31921420","31923190","31909950","31913490","31914530","31919030","31921200","31917830","31902560","31917580","31918240","31914800","31905580","31925770","31915100","31912250","31904720","31914350","31918910","39833740","31945770","31932470","31946430","31947220","38033500","31932660","31946440","31932780","38033520","31932480","31946470","31943930","31955960","31922750","31932970","38030280","31924980","31932730","31932790","31944060","31956950","31943990","31942480","31938590","31930060","31967850","31946370","31943820","38032410","38032530","31987390","31987840","38032400","31988010","31987130","31987060","38032540","31987900","31987040","31970150","31986510","31987580","38032510","31988690","31962760","31987820","31988820","31960440","31980330","31985530","31987430","31987250","31987490","31960730","31988170","31988180","31988150","31988140","31960230","31987940","31987780","31988040","31987640","31987740","31983590","38032330","31987520","31987980","31987970","31988080","31939330","31962070","31987500","38032680","31987540","31957560","31967950","31987410","31987470","31987010","31988020","31968410","31967810","31988000","31987850","31987890","31972150","31987650","31987600","31987140","31967920","31987610","31968480","31987550","31970790","31987630","38033420","31987790","31987730","31981610","31987480","31987990","31987960","31969980","31967740","31966770","31945790","31987530","31987620","31985520","31990730","31968780","31987810","31938540","31943830","31944150","31961540","38032760","31932230","31943910","31928160","38033570","39832780","38033490","38033620","31960500","31932380","31941620","38024110","31929230","38029860","31932560","38028550","31932710","31932630","31932430","31940680","31942880","31928810","31932300","31931060","31932530","31943900","31945030","31967820","31949090","31987290","31960460","31963580","31987240","31987420","31952260","31931900","31987570","31938160","31987510","31943880","31954640","31943780","31953470","38029010","31978050","31943380","31956060","31969650","30075080","31968360","31962460","31952640","31957900","31963190","31970840","31956990","31992260","31943940","31943360","38031840","31955810","31969510","31985550","30063250","31932090","31930600","31944870","31949840","31947800","31955510","31950050","31951300","31963300","31963420","31962190","31967720","31953490","31955540","31926320","31945750","38032010","31945810","31955570","31932940","38032780","31932030","31938300","31932670","31949700","31967960","30079550","31932840","31932400","31932860","31953180","31973070","31944030","31967880","31937560","31963480","31927290","31953570","31947560","31939250","31938270","31956460","31956270","31943370","31952770","31946120","31929170","31930950","31924050","31942750","31947300","31945080","31959240","31945980","31956700","31913780","31913070","31942800","31910690","31949040","31909430","31975080","31931140","31923510","31931400","38030440","31930970","31915470","31907220","31931170","30068200","31929700","31931320","31954510","31954240","31931470","31958770","31929180","31955200","31920200","31930670","31931100","31951050","31992340","31993640","31955110","31996490","31986690","31996580","32001630","32001270","31998930","31993540","31993750","31998910","32001340","31996640","31996530","31996470","31995570","32002107","31969220","31956190","31966950","31946450","31982880","31954460","31959990","31969040","31969080","31950590","31945410","31969240","31963700","31969260","31976310","31993580","31984050","31996510","31996500","31996520","31974770","31986950","31956390","31971810","31972280","31975930","31982000","31984760","31990980","31948820","31986910","31951880","31969430","31968560","31990840","31985700","31949590","31975790","31977210","31991020","31971960","31988470","31970620","31967160","31963780","31991060","31969330","31993310","31978730","31966370","31976360","31978800","31988520","31988590","31993600","31966910","31969870","31931370","31908580","31922770","31918970","31975540","31914150","31923650","31937790","31920060","31929660","31931280","31911980","31956210","31916150","31900420","31958790","31905100","30077950","31963030","31977950","31902880","30067260","31969130","31996710","31975630","31975250","31912590","31926730","31900710","31901810","31917740","31909720","32002112","31995170","32002237","32002462","31904140","31909640","31909670","31905010","31910350","31902280","31904640","31916930","31900500","31908520","31982600","31958530", "31953550","31923750","31947190", "31922420"};



			////mr aquamagica
			String[] empno_mr_aqua = {"31953530","38033630","31931880","31944770","38030480","38027970","38030040","38033630","31987160","38029590","38030540","38031090","31931980","38033280","31932410","31932140","38030010","31932240","38029930","31932420","31932190","31943980","38031580","31932390","38027500","31932550","31932080","32002218","38033110","38033700","31964020","38031100","31949760","31940430","32002316","38033650","31987950","31987200","31987020","38029090","38033290","31960930","31998970","31961700","32002192","31972740","38033260","38031110","38029840","38030960","31964130","38026030","31908750","31908300","32002480","32002413","31955590","31906740","32002560","31999300","32002439","32002442","32002531","39830370","39831610","32002222","31986840","31986770","31914960","32002170","32002520","31930490","31942180","31980450","38027180","31926790","31921420","39831490","31927810","32002500","32000910","31956010","31928140","31922100","31918190","32002523","31946270","32002406","32002429","32002532","32002424","31932730","31931900","32002075","31932840","38033570","32000870","31967880","31932430","31970150","31987820","31987580","31987550","31985550","32002222","32002206","32002217","31985530","32002208","31932710","31987360","32000960","31943970","31969980","31987260","31987760","38028600","31987970","38033160","31932910","31987040","31999540","31970260","32002200","31943880","31987050","31927290","31932380","31932790","31932480","31987530","31943910","31987650","31955510","32002212","32002199","31967720","31945790","38027810","38033140","31987850","31945980","31932660","31955570","31967810","31996370","32000780","31987490","31943820","31987290","31987810","31987150","31932030","31955810","31932970","31988140","31958530","32002194","31987130","31967960","31987430","31930600","38033520","31943990","31967950","32001250","31988000","31987500","31943930","31932780","31987920","31988150","31987470","31979230","31987840","31932090","31932630","31988690","31988180","31932940","31971420","31932560","31943900","31986060","31932530","31974350","32001080","32002099","31998890","31987140","31987030","31988190","38033500","31983590","31968360","32002193","31987890","31962290","31951140","31942080","38025470","31994230","38031420","31959510","31962760","31944020","31943940","38031210","31985490","32002226","38030090","38030080","30068440","31982600"};

			//mr aquamagica - prod = 2024_608_event, dev=2025_230_event
			if(("2024_608_event".equals(eventId) && Arrays.asList(empno_mr_aqua).contains(emp)) ) { %>
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}


			if(("2020_349_event".equals(eventId) || "2020_350_event".equals(eventId)) && !Arrays.asList(empnos1).contains(emp)) { %>
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}

			if(("2022_215_event".equals(eventId)) && !Arrays.asList(empno1_diwali2022).contains(emp)) { %>
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}

			///2023_226_event /hpne new year event id prod2024 - 2024_605_event
			if(("2024_605_event".equals(eventId)) && !Arrays.asList(empno1_newyear2025).contains(emp)) { %> 
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}

			////diwali2024 event----dev : 2024_229_event. Prod : 2024_585_event
			if(("2024_585_event".equals(eventId)) && !Arrays.asList(empno1_diwali2024).contains(emp)) { %> 
			<script>
			alert("This event is not applicable for you.");
			window.location.href="mynomination1.jsp";
			</script>
			<%	return;
			
			}


			query = "select to_char(CUTOFDTE,'dd-Mon-YYYY') cutOffDate,cast (MAXTICK as int) MAXTICK,MAXPRICE,EVTNME,NOOFMAXTICK,INDIV_TICK,BOARDINGPNT1 bpoints,ADDFIELD,ADMINEMP,EVT_ID,evt_for,bus_facility,to_char(evt_date ,'dd-Mon-yyyy') evt_date,evt_cat,age_criteria,evt_gen,email_body,PARTICIPENT_CRITERIA,TICKET_TYPE from workflow.nomination_admin where evt_id=? and cutofdte>=sysdate-1";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				eventEndDate = nullVal(rsMain.getString("cutOffDate"));
				maxTicksNo = rsMain.getInt("MAXTICK");
				maxPrize = nullVal(rsMain.getString("MAXPRICE"));
				noOfTicksEmp = nullVal(rsMain.getString("NOOFMAXTICK"));
				bPoints = nullVal(rsMain.getString("bpoints"));
				evtName = nullVal(rsMain.getString("EVTNME"));
				additionalFields = nullVal(rsMain.getString("addfield"));
				evt_for = rsMain.getString("evt_for");
				evt_date = nullVal(rsMain.getString("evt_date"));
				evt_cat = nullVal(rsMain.getString("evt_cat"));
				evt_gen = nullVal(rsMain.getString("evt_gen"));
				ageCriteria = nullVal(rsMain.getString("age_criteria"));
				ccEmps = nullVal(rsMain.getString("ADMINEMP"));
				emailBody = nullVal(rsMain.getString("email_body"));
				participentCriteria=nullVal(rsMain.getString("participent_criteria"));
				priceType=nullVal(rsMain.getString("TICKET_TYPE"));
			}
			if (!"".equals(emailBody))
				emailBody = emailBody.replaceAll("\n", "<br>");
			if (!"".equals(ccEmps)) {
				String[] ccEmpsMembers = ccEmps.split("\\,");

				ResultSet rsMail = null;
				String queryMail = "select email from empmaster where emp_no=?";
				PreparedStatement psMail = con.prepareStatement(queryMail);
				for (int i = 0; i < ccEmpsMembers.length; i++) {
					psMail.setString(1, ccEmpsMembers[i]);
					rsMail = psMail.executeQuery();
					if (rsMail.next())
						//ccMail += "," + nullVal(rsMail.getString("email"));  ///prod
 						ccMail += "," + "prajakta26297@gmail.com";   ///dev
 						ccMail += "," + "tanu.sharma@hpcl.in";   ///dev
				}
				if (rsMail != null)
					rsMail.close();
				if (psMail != null)
					psMail.close();
				if (!"".equals(ccMail))
					ccMail = ccMail.substring(1);
			}
			if (!"".equals(additionalFields)) {
				addFieldArr = additionalFields.split("-");
				//out.println(addFieldArr.length);
			}
			String[] evt_forArr = evt_for.split(",");
			for (int i = 0; i < evt_forArr.length; i++) {
				if (evt_forArr[i].equals("E"))
					isEmp = true;
				if (evt_forArr[i].contains("C") || evt_forArr[i].contains("S") || evt_forArr[i].contains("P")) {
					isDep = true;
					tempDep = "and relation_desc in (";
					if (evt_forArr[i].contains("C")) {
						tempDep1 += ",'Child'";
					}
					if (evt_forArr[i].contains("S")) {
						tempDep1 += ",'Spouse'";
					}
					if (evt_forArr[i].contains("P")) {
						tempDep1 += ",'Father','Mother'";
					}

				}
				if (evt_forArr[i].equals("O"))
					isOther = true;
			}
			if (!"".equals(nullVal(tempDep1))) {
				tempDep1 = tempDep1.substring(1);
				tempDep = tempDep + tempDep1 + ")";
			}
			query = "select count(ticktscnt) numVCl,sum(ticktscnt) tickCount from nomination where evtnme=? and flag in('A','S')";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {

				if (rsMain.getInt("numVCl") > 0) {
					tickRemNo = maxTicksNo - rsMain.getInt("tickCount");
				} else {
					tickRemNo = maxTicksNo;
				}
			}
			/*********************************Checking the Exclusive Events**********************/
			List<String> exclEvt = new ArrayList<String>();
			String keyExcl = "", valStr = "";
			//boolean isExclusiveEvt = false;
			query = "select key,EVENT_ID from nomination_exclusive where EVENT_ID = ?  or EVENT_ID  in(select EVENT_ID from nomination_exclusive where key = (select key from nomination_exclusive where EVENT_ID = ? ))";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, eventId);
			rsMain = psMain.executeQuery();
			while (rsMain.next()) {
				exclEvt.add(nullVal(rsMain.getString("EVENT_ID")));
				keyExcl = nullVal(rsMain.getString("key"));
			}
			if (exclEvt.size() > 0) {
				for (int i = 0; i < exclEvt.size(); i++) {
					valStr += ",'" + exclEvt.get(i) + "'";
				}
				valStr = valStr.substring(1);
			}
			if (!"".equals(keyExcl)) {
				query = "select evtnme,flag from nomination where emp_no=? and evtnme in(" + valStr + ")";

			} else {
				query = "select evtnme,flag from nomination where evtnme='" + eventId + "' and emp_no=? ";
			}
			psMain = con.prepareStatement(query);
			psMain.setString(1, emp);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				flg = nullVal(rsMain.getString("flag"));
			}
			if ("S".equals(flg)) {
	%>
	<%
		if (!"".equals(keyExcl)) {
	%>
	<script>
			alert("You have already Submitted your Nomination for the Same Event in one of the Show Timings available");
			window.location.href="mynomination1.jsp";
		</script>
	<%
		} else {
	%>
	<script>
			alert("You have already Submitted your Nomination for this Event");
			window.location.href="mynomination1.jsp";
		</script>
	<%
		}
	%>
	<%
		}
			if (("".equals(flg) || "X".equals(flg)) && tickRemNo <= 0) {
	%>
	<script>
			alert("Sorry, No more tickets available!!!!");
			window.location.href="home.jsp";
		</script>
	<%
		}
		}
		String additional_empList = "";
		String buLocn_grade = "";
		// code needs to be changed - use OR condition
		if (!"".equals(eventId)) {
			if (bPoints.contains("MR"))
				buLocn = " and PERSONNEL_SUB_AREA='MRMU' ";
				//buLocn = " and (bu like '48%' or bu like '47%' or bu ='10157026')";
			else if (bPoints.contains("VR"))
				buLocn = " and PERSONNEL_SUB_AREA='VRVZ' ";
				//buLocn = " and bu like '46%'";
			else if (bPoints.contains("MKTG"))
				buLocn = " and PERSONNEL_SUB_AREA not in ('MRMU', 'VRVZ') ";
				//buLocn = " and (bu not like '4%')";
			else
				buLocn = " and bu is not null";
		}
		if ("2019_166_event".equals(eventId)) { // for Employees and  having spouse
			//additional_empList = " and emp_no in ('31919150','31918180','39822720','31907930') ";
			additional_empList = " and relation_code='SP' and relation_code<>'SL'";
		}

		if("2023_514_event".equals(eventId)){  /////prod
		//if("2023_222_event".equals(eventId)){  /////dev
			buLocn_grade = " and grade in ('10A','10B','10C','10D') ";
		}

		String qry = "select emp_no from empmaster where emp_no=? " + buLocn + buLocn_grade;
		//out.println("qry="+qry);
		PreparedStatement psLocn = con.prepareStatement(qry);
		psLocn.setString(1, emp);
		ResultSet rsLocn = psLocn.executeQuery();
		if (!rsLocn.next()) {
	%>
	<script>
		alert("You are Not Allowed to access this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}

		if ("".equals(ageCriteria))
			ageCriteria = "is not null";
		else
			ageCriteria = "between " + ageCriteria;
		if ("M".equals(evt_cat) && !"M".equals(empCategory)) {
	%>
	<script>
		alert("This Event is only for Management Employees");
		window.location.href="mainSubmit.jsp";
	</script>
	<%
		}
		if ("N".equals(evt_cat) && "M".equals(empCategory)) {
	%>
	<script>
		alert("This Event is only for Non-Management Employees");
		window.location.href="home.jsp";
	</script>
	<%
		}

		if ("MALE".equals(evt_gen) && !"MALE".equals(empGender)) {
	%>
	<script>
		alert("Only Men are Allowed for this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}
		if ("FEMALE".equals(evt_gen) && !"FEMALE".equals(empGender)) {
	%>
	<script>
		alert("Only Women are Allowed for this Event");
		window.location.href="home.jsp";
	</script>
	<%
		}
		/*
		qry = "select emp_no from " + tempJdep + "jdep where emp_no =? " + additional_empList;
		psLocn = con.prepareStatement(qry);
		psLocn.setString(1, emp);
		rsLocn = psLocn.executeQuery();
		if (!rsLocn.next()) {
	%>
	<script>
		alert("This Event is Allowed only for Married Employees");
		window.location.href = "home.jsp";
	</script>
	<%
		} */
		String FlagUpdate = "", tempFlag = "";

		if ("submitted".equals(btnclkd) || "saved".equals(btnclkd)) {
			if ("submitted".equals(btnclkd))
				FlagUpdate = "S";
			else if ("saved".equals(btnclkd))
				FlagUpdate = "A";
			con.setAutoCommit(false);

			//*******Entry in master table*******/////
			query = "select flag from nomination where evtnme =? and emp_no =?";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, emp);
			rsMain = psMain.executeQuery();
			if (rsMain.next()) {
				tempFlag = nullVal(rsMain.getString("flag"));
			}
			if ("".equals(tempFlag)) {
				query = "insert into nomination (TICKTSCNT,BOARDPNT,PAYMENTCNT,ENTERDTE,ENTERBY,MODIFYDTE,FLAG,EMP_NO,EVTNME) values(?,?,?,sysdate,?,sysdate,'"
						+ FlagUpdate + "',?,?)";
			} else {
				if ("A".equals(tempFlag) || "X".equals(tempFlag)) {
					query = "update nomination set TICKTSCNT=?,BOARDPNT=?,PAYMENTCNT=?,ENTERBY=?,MODIFYDTE=sysdate,FLAG='"
							+ FlagUpdate + "' where emp_no=? and evtnme=? ";
				} else
					return;
			}

			psMain = con.prepareStatement(query);
			psMain.setString(1, noOfTicks);
			psMain.setString(2, bPointEmp);
			psMain.setString(3, pAmount);
			psMain.setString(4, emp);
			psMain.setString(5, emp);
			psMain.setString(6, eventId);
			evtIns = psMain.executeUpdate();

			/*******Entry For Additional Columns*////////////

			query = "delete from nomination_emp_add where id in(select id from nomination_addition where evt_id=?) and emp_no=?";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, emp);
			psMain.executeUpdate();

			query = "delete from nomination_emp_add where id in(select id from NOMINATION_QUESTIONNAIRE where evt_id=?) and emp_no=?";
			psMain = con.prepareStatement(query);
			psMain.setString(1, eventId);
			psMain.setString(2, emp);
			psMain.executeUpdate();

			query = "insert into nomination_emp_add (id,value,emp_no,person_code) values(?,?,?,?)";
			psMain = con.prepareStatement(query);
			/* 		for(Map.Entry<String,String> entry:addMap.entrySet()){
						psMain.setString(1,entry.getKey());		
						psMain.setString(2,entry.getValue());		
						psMain.setString(3,emp);		
						psMain.executeUpdate();
					}
			 */ /*****To Insert Employee Additional Entry**********/

			for (Map.Entry<String, String> entry : addMapEmp.entrySet()) {
				psMain.setString(1, entry.getKey());
				psMain.setString(2, entry.getValue());
				psMain.setString(3, emp);
				psMain.setString(4, emp);
				psMain.executeUpdate();
			}

			/******To Insert Dependents Additional Entry*********/
			//out.println(addMapDep.toString());
			for (Map.Entry<String, String> entry : addMapDep.entrySet()) {
				String[] splitArr = (entry.getKey()).split("_");
				psMain.setString(1, splitArr[1]);
				psMain.setString(2, entry.getValue());
				psMain.setString(3, emp);
				psMain.setString(4, splitArr[0]);
				psMain.executeUpdate();
			}
			for (Map.Entry<String, String> entry : addMapRel.entrySet()) {
				String[] splitArr = (entry.getKey()).split("_");
				if(!splitArr[0].equals("#id#")){
				psMain.setString(1, splitArr[1]);
				psMain.setString(2, entry.getValue());
				psMain.setString(3, emp);
				psMain.setString(4, splitArr[0]);
				psMain.executeUpdate();
				}
			}
			
			//int aa = 10; if(aa==10) return;

			/*******delete Entries in Dependent Table to Update Entries*////////
			String delQry = "delete from nomination_dependents where emp_no=? and event_name=?";
			PreparedStatement psDel = con.prepareStatement(delQry);
			psDel.setString(1, emp);
			psDel.setString(2, eventId);
			psDel.executeUpdate();
			
			// to check already applied and count for marathon event
			boolean errorEvent = false;
			if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
			psDel = con.prepareStatement("select count(*) from nomination_dependents where emp_no=? and event_name in (select evtnme from nomination where evtnme in ('2019_233_event','2019_234_event','2019_235_event') and flag='S' and emp_no=?)");
			psDel.setString(1, emp);
			psDel.setString(2, emp);
			rsMain = psDel.executeQuery();
			if(rsMain.next())
				count = rsMain.getInt(1);
			count += empEntry.size() + relCode.size();
			if(count > 4)
				errorEvent = true;
			
			psDel = con.prepareStatement("select * from nomination_dependents where event_name in (select evtnme from nomination where evtnme in ('2019_233_event','2019_234_event','2019_235_event') and flag='S' and emp_no=?) and child_name=?");
			psDel.setString(1, emp);
			}
			
			/////*********To Enter the entry of Employee*******/////
			query = "insert into nomination_dependents (CHILD_NAME,RELATATION,GENDER,AGE,DATE_OF_BIRTH,EVENT_NAME,EMP_NO,UPDATED_DATE,contact_no,misc1) values(?,?,?,?,to_date(?,'dd-Mon-yyyy'),?,?,sysdate,?,?)";
			psMain = con.prepareStatement(query);

			count = 0;

			/*if(eventId.equals("2022_216_event")){
				if(empEntry.size() <= 0){
					empEntry.add(spcl_re);
				}
			}

			out.println(spcl_re);*/

			if (isEmp && empEntry.size() > 0) {
				out.println("inside");
				String[] arrName = empEntry.get(0).split("#");
				if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
				psDel.setString(2, arrName[0]);
				rsMain = psDel.executeQuery();
				if(rsMain.next())
					errorEvent = true;
				}
				
				for (int i = 0; i < arrName.length; i++) {
					count++;
					psMain.setString(count, arrName[i]);
				}
				psMain.setString(6, eventId);
				psMain.setString(7, emp);
				psMain.setString(8, emp_contact);
				if ("2019_180_event".equals(eventId)) {
					psMain.setString(9, nullVal(empMisc1.get(0)));
				} else {
					psMain.setString(9, "");
				}

				psMain.addBatch();
			}
			count = 0;

			/****To Enter the JDE Dependents Entry ****/
			if (isDep && relCode.size() > 0) {
				for (int i = 0; i < relCode.size(); i++) {
					String[] arrName = relCode.get(i).split("#");
					if ("2019_233_event".equals(eventId) || "2019_234_event".equals(eventId) || "2019_235_event".equals(eventId)) {
					psDel.setString(2, arrName[0]);
					rsMain = psDel.executeQuery();
					if(rsMain.next())
						errorEvent = true;
					}
					
					for (int j = 0; j < arrName.length - 1; j++) {
						count++;
						psMain.setString(count, arrName[j]);

					}
					count = 0;
					psMain.setString(6, eventId);
					psMain.setString(7, emp);
					for (Map.Entry<String, String> entry : depContactMap.entrySet()) {
						if (arrName[arrName.length - 1].equals(entry.getKey()))
							psMain.setString(8, entry.getValue());
					}
					if ("2019_180_event".equals(eventId)) {
						for (Map.Entry<String, String> entry1 : depMiscMap.entrySet()) {
							if (arrName[arrName.length - 1].equals(entry1.getKey()))
								psMain.setString(9, entry1.getValue());
						}
					} else {
						psMain.setString(9, "");
					}

					psMain.addBatch();
				}
			}
			boolean isRollBack = false;
			if(errorEvent) {
%>
		<script>alert("You have already applied for same event in other category");</script>
		<script> window.location.href="mynomination1.jsp"; </script>
<%
				con.rollback();
				isRollBack = true;
				return;
			}
			
			//********TO Enter the entry out of JDE Dependents*************************//

			if (isOther && othName.size() > 0) {
				for (int i = 0; i < othName.size(); i++) {
					if (!"".equals(othName.get(i))) {
						psMain.setString(1, othName.get(i));
						psMain.setString(2, othRel.get(i));
						psMain.setString(3, othGen.get(i));
						psMain.setString(4, othAge.get(i));
						psMain.setString(5, "");
						psMain.setString(6, eventId);
						psMain.setString(7, emp);
						psMain.setString(8, othContact.get(i));
						if ("2019_180_event".equals(eventId)) {
							psMain.setString(9, nullVal(depMisc1.get(i)));
						} else {
							psMain.setString(9, "");
						}

						psMain.addBatch();
					}
				}
			}
			int[] dataArr = psMain.executeBatch();
			if (dataArr.length == 0) {
				con.rollback();
				isRollBack = true;
			} else {
				con.commit();
				//con.rollback();
			}

			out.println("isOther="+isOther);

			if (isRollBack) {
	%>
	<script>
				alert("Something went Wrong");
			//	window.location.href="mynomination1.jsp";
			</script>
	<%
		} else {
				if ("S".equals(FlagUpdate)) {

					String message = "", subject = "";
					//subject = devMsgSub + "Event Nomination - ";
					subject = "Event Nomination - ";
					if ("2018_133_event".equals(eventId)) {
						message = "You have successfully nominated for your team for the Event CORPORATE RANNEETI 6.0<br/><br/>Thank You, <br/><br/>CORPORATE RANNEETI 6.0 Team";

					} else {
						String temp_rel_chk= "";
						String newQryMail = "SELECT A.CHILD_NAME, nvl(B.PERSON_NAME,A.CHILD_NAME) PERSON_NAME, A.AGE, a.relatation, a.contact_no FROM NOMINATION_DEPENDENTS A LEFT JOIN "+tempJdep+"JDEP B ON A.EMP_NO=B.EMP_NO AND A.CHILD_NAME=B.PERSON_CODE where event_name=? and a.emp_no =?";
						PreparedStatement psMailBody = con.prepareStatement(newQryMail);
						psMailBody.setString(1, eventId);
						psMailBody.setString(2, emp);
						ResultSet rsMailBody = psMailBody.executeQuery();
						int newMailCount = 0;
						String tableMsg = "<table border=1><tr><th>Sr.No</th><th>Person Name</th><th>Age</th><th>Relation</th><th>Contact No</th></tr>";
						while (rsMailBody.next()) {
							newMailCount++;

							temp_rel_chk = rsMailBody.getString("relatation");
							if(temp_rel_chk==null){temp_rel_chk="";}

							if(temp_rel_chk.equals("Self")){
								tableMsg += "<tr><td>" + newMailCount + "</td><td>"
									+ rsMailBody.getString("person_name") + "</td><td>"
									+ rsMailBody.getString("AGE") + "</td><td>" + rsMailBody.getString("relatation")
									+ "</td><td>" + rsMailBody.getString("contact_no") + "</td></tr>";
							}else{
									tableMsg += "<tr><td>" + newMailCount + "</td><td>"
									+ getDependentName(con_sap,rsMailBody.getString("person_name")) + "</td><td>"
									+ rsMailBody.getString("AGE") + "</td><td>" + rsMailBody.getString("relatation")
									+ "</td><td>" + rsMailBody.getString("contact_no") + "</td></tr>";
							}

						}
						tableMsg += "</table>";
						message = "Your  request for <b>" + noOfTicks
								+ "</b> nominations for <b>" + evtName
								+ " </b> has been successfully registered, as per details given below-<br><br/> "+tableMsg+"<br/>"+emailBody+"<br/><br>Thank You ,<br/>" + "<br/>"
								+ "\"" + evtName + "\"" + " Team";
						
					}

					if (!"2018_126_event".equals(eventId) && evtIns > 0) {
						//String email_str = email.gen_email_call("APP208","D", " ",message,empMail,ccMail,"",subject+evtName+" ",request.getServerName(),"003","EmployeeConnect@hpcl.in",request.getRemoteHost());				
						//String email_str = email.gen_email_call("APP208", "D", " ", message,empMail,ccMail, "",subject + evtName + " ", request.getServerName(), "003", "EmployeeConnect@hpcl.in",request.getRemoteHost()); ////uncomment in production
						
//send_email(subject + evtName + " ", message, empMail, ccMail , "EmployeeConnect@hpcl.in"); ///uncomment in prod
//out.println("hey="+email_str+"-"+empMail);
					}

				}
	%>
	<script>
			alert("Data Inserted Successfully");
			window.location.href="mynomination1.jsp";
			</script>
	<%
		}
		}
		count = 0;
		if (!"".equals(flg) || "A".equals(flg)) {
			PreparedStatement psEntry = null;
			ResultSet rsEntry = null;
			String DispQry = "select na.evtnme Event_Name,n.EMP_NO,n.TICKTSCNT,n.BOARDPNT,n.PAYMENTCNT,n.EVTNME from nomination_admin na left join nomination n on na.evt_id=n.evtnme where na.evt_id=? and n.emp_no=? and flag <> 'X'";
			psEntry = con.prepareStatement(DispQry);
			psEntry.setString(1, eventId);
			psEntry.setString(2, emp);
			rsEntry = psEntry.executeQuery();
			if (rsEntry.next()) {
				noOfTicks = rsEntry.getString("TICKTSCNT");
				bPointEmp = rsEntry.getString("BOARDPNT");
				pAmount = rsEntry.getString("PAYMENTCNT");

			}
			DispQry = "select child_name,contact_no from nomination_dependents where event_name=? and emp_no=?";
			psEntry = con.prepareStatement(DispQry);
			psEntry.setString(1, eventId);
			psEntry.setString(2, emp);
			rsEntry = psEntry.executeQuery();
			while (rsEntry.next()) {
				nominationList.add(rsEntry.getString("child_name"));
				nominationMap.put(rsEntry.getString("child_name"), rsEntry.getString("contact_no"));
			}
		}
	%>

	<div class="container" style="min-height: 465px;">
	<div class="row">
	<div class="col-sm-12 ">
		<form name="form1" method="post" action="mainSubmit.jsp"
			enctype="multipart/form-data">
			<input type="hidden" name="age_criteria" id="age_criteria"
				value="<%=ageCriteria%>">
			<input type="hidden" name="price_type" id="price_type"
				value="<%=priceType%>">
			<div class="card md10 box-shadow border-success">
				<div class="card-header style-app-name" >
					<h5 class="text-white">
						New Event Nomination
						</h3>
				</div>
				<div class="card-body table-responsive">
					<!--<input type="text" name="spcl_re" id="spcl_re" >-->
					<table class="listTable" style="">
						<tr>
							<td width="20%" class="tdLbl1" style="padding: 10px;">Select the Event</td>
							<td style="padding: 10px;"><select name="eventId"
								id="eventId" class="form-control" onchange="return sfresh()"
								<%=!"".equals(eventId) ? "disabled" : ""%>>
									<option value="-1">Select</option>
									<%
										for (Map.Entry<String, String> entry : evtMap.entrySet()) {
									%>
									<option value="<%=entry.getKey()%>"
										<%=entry.getKey().equals(eventId) ? "selected" : ""%>><%=entry.getValue()%></option>
									<%
										}
									%>
							</select>
							
						<% if (!("".equals(eventId) || "-1".equals(eventId))) { %>
						<input type="hidden" class="select-field" name="eventId" id="eventId" value="<%=eventId%>" />
						<% } %>
							
							</td>
							<td style="padding: 10px;" class="tdLbl1">Date of Event</td>
							<%
								if ("2018_156_event".equals(eventId)) {
							%>
							<td style="padding: 10px;"><input type="hidden"
								name="evt_date" class="form-control" value="<%=evt_date%>"
								readonly> <span>25-Dec-2018 & 26-Dec-2018</span></td>
							<%
								} else {
							%>
							<td style="padding: 10px;">
								<%
									if (!("2019_172_event".equals(eventId) || "2019_173_event".equals(eventId)
												|| "2019_176_event".equals(eventId) || "2019_171_event".equals(eventId)
												|| "2019_175_event".equals(eventId) || "2019_174_event".equals(eventId))) {
								%> <input type="text" name="evt_date" class="select-field"
								value="<%=evt_date%>" readonly> <%
	}
 %>
							</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td class="tdLbl1" style="padding: 10px;">No of Entries Required</td>
							<td style="padding: 10px;">
								<!--<input type="number" readonly name="noOfTicks" id="tickReq" class="select-field" value="<%=noOfTicks%>">-->
								<input type="hidden" name="noOfTicks" id="tickReq" value="<%=noOfTicks%>" />
								<span id="tickReq1"><%=noOfTicks%></span>
							</td>
							<td class="tdLbl1" style="padding: 10px;">Enter the Boarding Point</td>
							<td style="padding: 10px;"><select name="bPointName"
								class="form-control" id="bPointName" onchange="chkfun('<%=eventId%>')" >
									<option value="-1">Select</option>
									<%
										boolean isBoarding = false;
										query = "select boarding_point,bus_facility from nomination_bp where evt_id=?";
										PreparedStatement psRow = con.prepareStatement(query);
										psRow.setString(1, eventId);
										ResultSet rsRow = psRow.executeQuery();
										if (rsRow.next()) {

											if ("Y".equals(nullVal(rsRow.getString("bus_facility")))) {
												isBoarding = true;
												if (!"".equals(nullVal(rsRow.getString("boarding_point")))) {
													String[] boardPt = nullVal(rsRow.getString("boarding_point")).split("\\,");
													for (int i = 0; i < boardPt.length; i++) {
									%>
									<option value="<%=boardPt[i]%>"
										<%=boardPt[i].equals(bPointEmp) ? "selected" : ""%>><%=boardPt[i]%></option>
									<%
										}
												}
											}
										}
									%>
									<option value="2" <%=!isBoarding ? "selected" : ""%>>Not
										Applicable</option>
							</select></td>
						</tr>

						<%
							int countRow = 0;
							String addQry = "";
							addQry = "select distinct a.evt_id, a.id, b.value, a.lbl_name, a.lbl_type, a.def_value, a.ISMANDATE, a.STATUS from nomination_addition a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where  a.evt_id=? and a.level_type=? and a.STATUS=? order by a.id";
							psRow = con.prepareStatement(addQry);
							psRow.setString(1, emp);
							psRow.setString(2, eventId);
							psRow.setString(3, "E");
							psRow.setString(4, "A");
							rsRow = psRow.executeQuery();
							while (rsRow.next()) {
								countRow++;
						%>
						<tr>
							<td class="tdLbl1" style="padding: 10px;"><%=rsRow.getString("lbl_Name")%><%=rsRow.getString("ISMANDATE").equals("Y") ? "<span style='color:red'>*</span>" : ""%><input
								type="hidden" name="isMandate" class="form-control"
								value="<%=rsRow.getString("ISMANDATE")%>"></td>
							<td colspan="3" style="padding: 10px;">
								<%
									if ("file".equals(rsRow.getString("lbl_type"))) {
								%> <input type="hidden"
								name="addition_Emp_<%=rsRow.getString("id")%>"
								id="addition_Emp_<%=rsRow.getString("id")%>"
								value="<%=nullVal(rsRow.getString("value"))%>" /> <input
								type="<%=rsRow.getString("lbl_Type")%>" class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
								name="fileaddition_Emp_<%=rsRow.getString("id")%>" /> <%
	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
								target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
	}
 %> <%
	} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
 %> <textarea cols="100%" rows="2" maxlength="150" 
									class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="addition_Emp_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>

								<%
									} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
								%> <select name="addition_Emp_<%=rsRow.getString("id")%>"
								class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
									<option value="">Select</option>
									<%
										if (!"".equals(nullVal(rsRow.getString("def_value")))) {
													String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
													for (int i = 0; i < defValues.length; i++) {
									%>
									<option value="<%=nullVal(defValues[i])%>"
										<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
									<%
										}
												}
									%>
							</select> <%
	} else {
 %> <input type="text"
								class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
								name="addition_Emp_<%=rsRow.getString("id")%>"
								value="<%=nullVal(rsRow.getString("value"))%>"> <%
	}
 %>
							</td>
						</tr>
						<%
							}
							float percentVal = 0.0f;
						%>


						<!-- ---------Added by Prajakta for Questionnaire----- -->

								<%
							countRow = 0;
							String get_id_val="";
							String quesQry = "";
							quesQry = "select distinct a.evt_id, a.id, b.value, a.QUESTIONNAIRE, a.QUESTION_TYPE, a.DEFAULT_VALUES, a.MANDATORY, a.STATUS from NOMINATION_QUESTIONNAIRE a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where  a.evt_id=? and a.STATUS=? order by a.id";
						
							psRow = con.prepareStatement(quesQry);
							psRow.setString(1, emp);
							psRow.setString(2, eventId);
							psRow.setString(3, "A");
							rsRow = psRow.executeQuery();
							while (rsRow.next()) {
								countRow++;
						%>
						<tr>
							<td class="tdLbl1" style="padding: 10px;"><%=rsRow.getString("QUESTIONNAIRE")%><%=rsRow.getString("MANDATORY").equals("Y") ? "<span style='color:red'>*</span>" : ""%><input
								type="hidden" name="mandatory" class="form-control"
								value="<%=rsRow.getString("MANDATORY")%>"></td>
							<td colspan="3" style="padding: 10px;">
								<%
									if ("file".equals(rsRow.getString("QUESTION_TYPE"))) {
										%> <input type="hidden"
										name="addition_Emp_<%=rsRow.getString("id")%>"
										id="addition_Emp_<%=rsRow.getString("id")%>"
										value="<%=nullVal(rsRow.getString("value"))%>" /> <input
										type="<%=rsRow.getString("QUESTION_TYPE")%>" class="form-control <%=rsRow.getString("MANDATORY").equals("Y") ? "mandatory" : ""%>"
										name="fileaddition_Emp_<%=rsRow.getString("id")%>" /> <%
											if (!"".equals(nullVal(rsRow.getString("value")))) {
										 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
																		target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
											}
										 
								}

								 else if ("textarea".equals(rsRow.getString("QUESTION_TYPE"))) {
									 %> <textarea cols="100%" rows="2" maxlength="150" 
											class="form-control <%=rsRow.getString("MANDATORY").equals("Y") ? "mandatory" : ""%>"
											name="addition_Emp_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>

										<%
									}

									 else if ("drop down".equals(rsRow.getString("QUESTION_TYPE"))) {
									 		get_id_val = rsRow.getString("id");
									 		if(get_id_val==null){get_id_val="";}
										%> <select id="drop_extra_value_<%=rsRow.getString("id")%>" name="addition_Emp_<%=rsRow.getString("id")%>"
										class="<%=rsRow.getString("MANDATORY").equals("Y") ? "mandatory" : ""%>" onchange="check_new('<%=get_id_val%>')" >
											<option value="">Select</option>
											<%
												if (!"".equals(nullVal(rsRow.getString("DEFAULT_VALUES")))) {
															String[] defValues = nullVal(rsRow.getString("DEFAULT_VALUES")).split("\\,");
															for (int i = 0; i < defValues.length; i++) {
											%>
											<option value="<%=nullVal(defValues[i])%>"
												<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
											<%
												}
														}
											%>
											</select> <%
									} 

									else {
				 						%> 	<input type="text"
												class="form-control <%=rsRow.getString("MANDATORY").equals("Y") ? "isMandate" : ""%>"
												name="addition_Emp_<%=rsRow.getString("id")%>"
												value="<%=nullVal(rsRow.getString("value"))%>"> <%
									}
 								%>
							</td>
						</tr>
						<%
							}
							//float percentVal = 0.0f;
						%>


						<!-- ---------End by Prajakta for Questionnaire----- -->

						<tr>
							<td class="tdLbl1" style="padding: 10px;">
								<span <%=("0".equals(maxPrize)) ? "style ='display:none'": ""%> >Total Confirmatory Amount</span>
							</td>
							<td style="padding: 10px;"><input class="select-field"
								type="number" readonly name="pAmount" id="pAmount"
								value="<%=pAmount%>" <%=("0".equals(maxPrize)) ? "style ='display:none'": ""%> /></td>
							<td class="tdLbl1" style="padding: 10px;">Remaining Tickets</td>
							<center>
								<span id="remTicks" style="display: none"><%=tickRemNo%></span><b></b><span
									style="display: none"><%=maxTicksNo%></span>
							</center>
							<td style="padding: 10px;"><div class="progress">
									<%
										percentVal = ((float) tickRemNo / (float) maxTicksNo) * 100;
									%>
									<div class="progress-bar progress-bar-striped bg-danger"
										style="width:<%=100.0f - percentVal%>%"><%=maxTicksNo - tickRemNo%></div>
									<div class="progress-bar progress-bar-striped bg-success"
										style="width:<%=percentVal%>%"><%=tickRemNo%></div>
								</div></td>
						</tr>
					</table>
				</div>
			</div>
			</center>
			<br />

			<%
			String e_chk_humfit = "2023_511_event";  ////prod
			//e_chk_humfit = "2023_221_event";    ////dev
			if(eventId.equals(e_chk_humfit)){%>
			<span id="message">
				<center class="style-text-red"><i><u><b>***Important Note : Please mention email and phone number used to register Android / iOS Phone.***</b></u></i></center>
			</span>
			<%}%>
			
			
			<%
				if (isEmp) {
			%>
			<!--<center><font size="4" class="tdLbl1"><b>Employee Details</b></font>-->
			<div class="card md-12 box-shadow border-success" id="emp_details">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h5 class="text-white">
						Employee Details</b>
					</h2>
				</div>
				<div class="card-body table-responsive" style="overflow-x:auto;">
					<table class="table table-hover table-bordered listTable">
						<thead class="bg-default alert-primary ">
							<tr>
								<th>#</th>
								<th>&sect;</th>
								<th>Employee Name</th>
								<th>Age</th>
								<th>Date of Birth</th>
								<th>Gender</th>
								<th width="15%">Contact No.</th>
								<%
									psRow = con.prepareStatement(addQry);
										psRow.setString(1, emp);
										psRow.setString(2, eventId);
										psRow.setString(3, "A");
										psRow.setString(4, "A");
										rsRow = psRow.executeQuery();
										while (rsRow.next()) {
								%>
								<th><%=rsRow.getString("lbl_name")%></th>

								<%
									}
								%>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<th>Preferred Time Slot</th>
								<!--<th>Misc Col2</th>-->
								<%
									}
								%>
							
						</thead>
						<tbody>
							<%
								//**Entry of Employee**//
								/*	query = "select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,contact_no from "
											+ tempJdep
											+ "jdep join empmaster using(emp_no) where emp_no=? and person_code =? and TRUNC((sysdate-(PERSON_DOB))/365) "
											+ ageCriteria;
									if ("2018_129_event".equals(eventId))
										query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
									if("M".equals(participentCriteria)){
										query +=" and gender ='M'";
									}if("F".equals(participentCriteria)){
										query +=" and gender ='F'";
									}
								*/
									////commented by tanu

									query = "select emp_no as person_code, emp_name as person_name, decode(sex,'MALE','Male','FEMALE','Female',SEX) gender1,SEX as gender,TRUNC((sysdate-(emp_dob))/365) AGE,to_char(emp_dob,'dd-Mon-yyyy') rel_dob,contact_no from empmaster where emp_no=? and EMP_NO =? and TRUNC((sysdate-(emp_dob))/365) "
											+ ageCriteria;
									if ("2018_129_event".equals(eventId))
										query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
									if("M".equals(participentCriteria)){
										query +=" and sex ='MALE'";
									}if("F".equals(participentCriteria)){
										query +=" and sex ='FEMALE'";
									}

									//out.println(query);
									//out.println("emp="+emp);
									psMain = con.prepareStatement(query);
									psMain.setString(1, emp);
									psMain.setString(2, emp);
									rsMain = psMain.executeQuery();
									while (rsMain.next()) {
										count++;
										String relation_string = rsMain.getString("person_code") + "#Self" + "#" + rsMain.getString("gender") + "#" + rsMain.getString("age") + "#"
												+ rsMain.getString("rel_dob");

									/*if ("2022_216_event".equals(eventId) && rsMain.getString("relation_code").equals("SL")){
										%>
											<script>
												//document.getElementById("spcl_re").value = "<%=relation_string%>";
											</script>
										<%
									}*/
							%>
							<tr>
								<td><%=count%></td>
								<td><input type="checkbox" name="chkBoxEmp"
									value="<%=relation_string%>"
									<%="2019_285_event".equals(eventId) ? "style='display:none'" : ""%>
									id="chkEmp<%=count%>"
									onclick="return guidelineFun1(<%=count%>)"></td>
								<td><%=rsMain.getString("person_name")%></td>
								<td><%=rsMain.getString("AGE")%></td>
								<td><%=rsMain.getString("rel_dob")%></td>
								<td><%=rsMain.getString("gender1")%></td>
								<td><input type="text" name="emp_contact"
									class="select-field contact_no" id="emp_contact"
									value="<%=nullVal(rsMain.getString("contact_no"))%>"
									maxlength="13"></td>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<td><select name="empTimeSlot">
										<option value="07:30AM-04:00PM">07:30AM-04:00PM</option>
										<option value="07:30AM-01:00PM">07:30AM-01:00PM</option>
										<option value="07:30AM-10:30PM">07:30AM-10:30PM</option>
										<option value="01:00PM-04:00PM">01:00PM-04:00PM</option>
								</select></td>
								<%
									}
											psRow = con.prepareStatement(addQry);
											psRow.setString(1, emp);
											psRow.setString(2, eventId);
											psRow.setString(3, "A");
											psRow.setString(4, "A");
											rsRow = psRow.executeQuery();
											while (rsRow.next()) {
								%>
								<td>
									<%
										if ("file".equals(rsRow.getString("lbl_type"))) {
									%> <input type="hidden"
									name="addition_Emp_<%=rsRow.getString("id")%>"
									id="addition_Emp_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>" /> <input
									type="<%=rsRow.getString("lbl_Type")%>"
									class="form-control <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="fileaddition_Emp_<%=rsRow.getString("id")%>" /> <%
	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
									target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
	}
 %> <%
										} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
									%> <textarea cols="100%" rows="2" maxlength="150" 
										class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
										name="addition_Emp_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
									<%
										} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
									%> <select name="addition_Emp_<%=rsRow.getString("id")%>"
									class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
										<option value="">Select</option>
										<%
											if (!"".equals(nullVal(rsRow.getString("def_value")))) {
																String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
																for (int i = 0; i < defValues.length; i++) {
										%>
										<option value="<%=nullVal(defValues[i])%>"
											<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
										<%
											}
															}
										%>
								</select> <%
	} else {
 %> <input type="text"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y")?"isMandate":""%>"
									name="addition_Emp_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>"> <%
	}
 %>
								</td>
								<%
									}
								%>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</div>
			</div>
			<br />
			<!--Entry for Employee Details Close-->
			<!--Entry of JDE Dependents Open-->
			<%
				}
				if (isDep) {
			%>

			<div class="card mb10 box-shadow  border-success" id="dependent_details">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h5 class="text-white">Dependents Details</h5>
				</div>
				<div class="card-body">
					<div class="table-responsive" style="overflow-x:auto;">
					<table class="table table-hover table-bordered listTable " border="1">
						<!--<thead class="alert alert-primary">-->
							<tr>
								<th>#</th>
								<th>&sect;</th>
								<th>Dependent Name</th>
								<th>Relation</th>
								<th>Age</th>
								<th>Date of Birth</th>
								<th>Gender</th>
								<th width="15%">Contact No. <span style="color:red;" >  * </span></th>
								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<th>Preferred Time Slot</th>
								<%
									}
										psRow = con.prepareStatement(addQry);
										psRow.setString(1, emp);
										psRow.setString(2, eventId);
										psRow.setString(3,"A");
										psRow.setString(4,"A");
										
										rsRow = psRow.executeQuery();
										while (rsRow.next()) {
								%>
								<th><%=rsRow.getString("lbl_name")%> <span style="color:red;" <%= rsRow.getString("ismandate").equals("Y")?"":"hidden"%>>  * </span></th>
								<%
									}
								%>
							</tr>
						<!--</thead>-->
						<tbody>
							<%
								count = 0;
									////here dependents
									query = "select person_code,event_name,person_name,decode(j.gender,'MALE','Male','FEMALE','Female',j.gender)gender1,j.gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,nvl(nd.contact_no,' ') contact_no from  "
											+ tempJdep
											+ "jdep j left join empmaster e on j.emp_no=e.emp_no left join nomination_dependents nd on j.emp_no=nd.emp_no and j.person_code=nd.child_name and event_name=?  where j.emp_no=? and j.person_code<> ? "
											+ tempDep + "  and person_status_code ='AC' and TRUNC((sysdate-(PERSON_DOB))/365) "
											+ ageCriteria + " ";
									if ("2018_129_event".equals(eventId))
										query += " and TRUNC((sysdate-(EMP_DOB))/365) between 35 and 55 ";
									
									
									if("M".equals(participentCriteria)){
										query +=" and j.gender ='M'";
									}if("F".equals(participentCriteria)){
										query +=" and j.gender ='F'";
									}	
									query += " order by person_code ";	

									//out.println("query before ="+query);

									//out.println("<br/><br/>");

									////sap changes
									query = "select DEPENDENT_ID AS person_code, concat(FIRST_NAME,' ',LAST_NAME) as person_name, GENDER_DESC as gender1, GENDER_DESC as gender, RELATION_DESC as RELATION_CODE1, RELATION_DESC as RELATION_CODE , FORMAT(DATE_OF_BIRTH ,'dd-MMM-yyyy') rel_dob, (DATEDIFF(day, DATE_OF_BIRTH , GETDATE())/365) AS age from "+sap_schema+".ZHRCV_DEPENDENT where med_status = 'AC' and EMPLOYEE_NUMBER =?  "+ tempDep + " and (DATEDIFF(day, DATE_OF_BIRTH , GETDATE())/365) "
											+ ageCriteria + " ";
									if("M".equals(participentCriteria)){
										query +=" and GENDER_DESC ='MALE'";
									}if("F".equals(participentCriteria)){
										query +=" and GENDER_DESC ='FEMALE'";
									}	
									query += " order by DEPENDENT_ID ";	
									//out.println(query);

									psMain = con_sap.prepareStatement(query);
									//psMain.setString(1, eventId);
									//psMain.setString(2, emp);
									psMain.setString(1, emp);
									rsMain = psMain.executeQuery();
									while (rsMain.next()) {
										count++;
										String relation_string = rsMain.getString("person_code") + "#" + rsMain.getString("relation_code")
												+ "#" + rsMain.getString("gender") + "#" + rsMain.getString("age") + "#"
												+ rsMain.getString("rel_dob") + "#" + count;
							%>
							<tr>
								<td><%=count%></td>
								<td><input type="checkbox" name="chkBox"
									value="<%=relation_string%>"
									<%=(nominationList.contains(rsMain.getString("person_code"))
							&& ("2018_126_event".equals(eventId))) ? "checked" : ""%>
									<%="2018_126_event".equals(eventId) ? "style = 'display:none'" : ""%>
									id="chk<%=count%>" onclick="return guidelineFun(<%=count%>)"></td>
								<td><%=rsMain.getString("person_name")%></td>
								<td><%=rsMain.getString("RELATION_CODE1")%></td>
								<td><%=rsMain.getString("AGE")%></td>
								<td><%=rsMain.getString("rel_dob")%></td>
								<td><%=rsMain.getString("gender1")%></td>
								<td><input type="text" class="select-field contact_no"
									name="dep_contact<%=count%>" id="dep_contact<%=count%>"
									value=""
									maxlength="13"></td>

								<%
									if ("2019_180_event".equals(eventId)) {
								%>
								<td><select name="depTimeSlot<%=count%>">
										<option value="07:30AM-04:00PM">07:30AM-04:00PM</option>
										<option value="07:30AM-01:00PM">07:30AM-01:00PM</option>
										<option value="07:30AM-10:30PM">07:30AM-10:30PM</option>
										<option value="01:00PM-04:00PM">01:00PM-04:00PM</option>
								</select></td>
								<%
									}
											psRow = con.prepareStatement(addQry);
											psRow.setString(1, emp);
											psRow.setString(2, eventId);
											psRow.setString(3,"A");
											psRow.setString(4,"A");
											rsRow = psRow.executeQuery();
											while (rsRow.next()) {
								%>
								<td>
									<%
										if ("file".equals(rsRow.getString("lbl_type"))) {
									%> <input type="hidden"
									name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									id="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>" /> <input
									type="<%=rsRow.getString("lbl_Type")%>"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="fileaddition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>" /> <%
	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
									target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
	}
 %> <%
										} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
									%> <textarea cols="100%" rows="2" maxlength="150" 
										class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
										name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
									<%
										} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
									%> <select name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
										<option value="">Select</option>
										<%
											if (!"".equals(nullVal(rsRow.getString("def_value")))) {
																String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
																for (int i = 0; i < defValues.length; i++) {
										%>
										<option value="<%=nullVal(defValues[i])%>"
											<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
										<%
											}
															}
										%>
								</select> <%
	} else {
 %> <input type="text"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="addition_dep_<%=rsMain.getString("person_code")%>_<%=rsRow.getString("id")%>"
									value=""> <%
	}
 %>
								</td>
								<%
									}
								%>


							</tr>
							<%
								}
							%>
							<input type="hidden" name="hidCountDep" id="hidCountDep"
								value="<%=count%>" />

						</tbody>
					</table>
					</div>
				</div>
			</div>
			<br />
			<%
				}
			%>
			<!--Entry of JDE Entries Close-->
			<!--Entry of Out of JDE Entries Open-->
			<%
				if (isOther) {
					String temp = "", PERSON_CD = "";
					int counttt = -1;
			%>
			<div class="card md-12 box shadow">
				<div class="card-header bg-primary style-hp-navyBlue">
					<h2>Additional Requests</h2>
				</div>
				<div class="card-body table-responsive" style="overflow-x:auto;">
					<span id="stop_add"><a title="Add" href="javascript:;" onclick="addEntry()"><img
						width="18" src="images/add1.png" /></a> <span class="v_t"
						style="margin-right: 100px">Add</span></span>
					<div class="datagrid">
						<table class="table table-hover table-bordered listTable"
							style="border-collapse: collapse;" id="ti_table">
							<thead class="alert alert-success">
								<tr class="lst">
									<th><center>&sect;</center></th>
									<th><center>Person Name</center></th>
									<th><center>Relationship</center></th>
									<th><center>Age</center></th>
									<th>Gender</th>
									<th>Contact No <span style="color:red;" >  * </span></th>
									<%
									//String addQry1="select distinct a.evt_id, a.id, b.value, a.lbl_name, a.lbl_type, a.def_value, a.ISMANDATE from nomination_addition a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where a.evt_id=? and a.level_type=? and a.STATUS=? and  LENGTH(b.person_code)<8 order by a.id ";
									String addQry11="select * from nomination_addition where evt_id=? and level_type=? ";
									psRow = con.prepareStatement(addQry11);
										//psRow.setString(1, emp);
										psRow.setString(1, eventId);
										psRow.setString(2,"A");
										//psRow.setString(4,"A");
										
										rsRow = psRow.executeQuery();
										while (rsRow.next()) {
								%>
								<th><%=rsRow.getString("lbl_name")%> <span style="color:red;" <%= rsRow.getString("ismandate").equals("Y")?"":"hidden"%>>  * </span> </th>
								<%
									}
								%>
								</tr>
							</thead>

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
									if (("").equals(PERSON_CD)) {
										temp = "#id#";
									}
									/* 	else{
											 temp = ""+counttt;		 
										 } */
							%>
							<tbody>
								<tr id="tr<%="#id#".equals(temp) ? "" : temp%>" class="tbodytr"
									style='<%="#id#".equals(temp) ? "display: none" : ""%>'>
									<td align="center"><a onclick="removeRow(<%=temp%>,this)"
										href="javascript:;"><img src="images/clear.png" width="18" /></a></td>
									<td><center>
											<input type="text" name="person_name_add"
												id="person_name_add<%=temp%>" value="">
										</center></td>
									<td><center>
											<input type="text" name="rel_add" id="rel_add<%=temp%>"
												value="" />
											<center></td>
									<td><center>
											<input type="number" name="age_rel" maxlength="2"
												id="age_rel<%=temp%>" value=""
												onblur="return ageValid(this)">
										</center></td>
									<td><select name="gender_rel" id="gender_rel<%=temp%>">
											<option value="M">Male</option>
											<option value="F">Female</option>
									</select></td>
									<td><input type="text" name="contact_rel"
										id="contact_rel<%=temp%>" maxlength="13" value=""></td>
										<%
										String addQry1="select distinct a.evt_id, a.id, b.value, a.lbl_name, a.lbl_type, a.def_value, a.ISMANDATE from nomination_addition a left join nomination_emp_add b on a.id=b.id and b.emp_no=? where a.evt_id=? and a.level_type=? and a.STATUS=?  order by a.id ";
															//psRow = con.prepareStatement(addQry11);
															psRow = con.prepareStatement(addQry1);
											psRow.setString(1, emp);
											psRow.setString(2, eventId);
											psRow.setString(3,"A");
											psRow.setString(4,"A");
											rsRow = psRow.executeQuery();
											while (rsRow.next()) {
								%>
								<td>
									<%
										if ("file".equals(rsRow.getString("lbl_type"))) {
									%> <input type="hidden"
									name="addition_rel_<%=temp%>_<%=rsRow.getString("id")%>"
									id="addition_rel_<%=temp%>_<%=rsRow.getString("id")%>"
									value="<%=nullVal(rsRow.getString("value"))%>" /> <input
									type="<%=rsRow.getString("lbl_Type")%>"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="fileaddition_rel_<%=temp%>_<%=rsRow.getString("id")%>" /> <%
	if (!"".equals(nullVal(rsRow.getString("value")))) {
 %> <a href="useruploads1/<%=nullVal(rsRow.getString("value"))%>"
									target="_blank"><%=nullVal(rsRow.getString("value"))%></a> <%
	}
 %> <%
										} else if ("textarea".equals(rsRow.getString("lbl_type"))) {
									%> <textarea cols="100%" rows="2" maxlength="150" 
										class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
										name="addition_rel_<%=temp%>_<%=rsRow.getString("id")%>"><%=nullVal(rsRow.getString("value"))%></textarea>
									<%
										} else if ("drop down".equals(rsRow.getString("lbl_Type"))) {
									%> <select name="addition_rel_<%=temp%>_<%=rsRow.getString("id")%>"
									class="<%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>">
										<option value="">Select</option>
										<%
											if (!"".equals(nullVal(rsRow.getString("def_value")))) {
																String[] defValues = nullVal(rsRow.getString("def_value")).split("\\,");
																for (int i = 0; i < defValues.length; i++) {
										%>
										<option value="<%=nullVal(defValues[i])%>"
											<%=defValues[i].equals(rsRow.getString("value")) ? "selected" : ""%>><%=nullVal(defValues[i])%></option>
										<%
											}
															}
										%>
								</select> <%
	} else {
 %> <input type="text"
									class="select-field <%=rsRow.getString("ISMANDATE").equals("Y") ? "isMandate" : ""%>"
									name="addition_rel_<%=temp%>_<%=rsRow.getString("id")%>"
									value=""> <%
	}
 %>
								</td>
								<%
									}
								%>

										
								</tr>
							</tbody>
							<%
								//}
							%>
						</table>
					</div>
				</div>
			</div>
			<input type=hidden id="leg_count" name="leg_count">
			<%
				}
			%>
			<!--Entry for Out of JDE entry close-->
			<% if (!("".equals(eventId) || "-1".equals(eventId)) ) { %>
			<div style="margin: 5%">
				<p
					<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize) ||  ("2023_221_event".equals(eventId)))
						? "style ='display:none'"
						: ""%>>
					<input type="checkbox" id="checkval" name="checkval" value=""
						<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize)) ? "" : ""%>
						onclick="return chkAllow()"
						<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize)) ? "style='display:none'"
								: ""%>>
					<%
						if ("2019_193_event".equals(eventId)) {
					%>
					I hereby authorize recovery of amount selected through payroll
					towards confirmatory amount for PATHSHAALA LIBRARY & RESOURCE CENTRE.<b
						style=""><u><span id="ttt"><%=pAmount%></span></u></b>
					<%
						} else if (!"2019_180_event".equals(eventId) ) {
					%>
					I hereby authorize recovery of (Rs. <b><u><span id="ttt"><%=pAmount%></span></u></b>)through
					payroll towards confirmatory amount for <b><u><%=evtName%></u></b>.
					In case of drop out, there shall be no refund.
					<%
						}
					%>
					<br />
					<%
						if ("2019_178_event".equals(eventId) || "2019_177_event".equals(eventId)) {
					%>
					Please ensure that the timing certficates is available with you as
					you will be required to submit the same.<br /> You would recieve a
					seperate email asking for the same at an appropriate time.
					<%
						} else if ("2019_180_event".equals(eventId)) {
					%>
					I hereby confirm my participation as volunteer at HP SAMPARK Inter
					Orphanage Sports on 13.4.2019.<b style="display: none"><u><span
							id="ttt"><%=pAmount%></span></u></b>
					<%
						}
					%>

					<%
						if(eventId.equals(e_chk_humfit)){%>
						<span id="message">
							<center class="style-text-red"><i><u><b>
								<input type="checkbox" id="checkval" name="checkval" value="" onclick="return chkAllow()">
							I have read the Circular on Hum Fit Toh HP Fit Challenge 2023 and confirm participation of Self / Family Members accordingly.</b></u></i></center>
						</span>
					<%}%>

					<br /> <br />
				<div
					<%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"style ='display:none'":""%>
					id="pay_disclaimer">
					<marquee behavior="alternate">
						<span style="display: none"><b>Note:</b></span><span class="req"
							style="display: none"> Payment will be deducted from your
							salary through automated PTA. However you may edit your
							requirement of tickets till cut of date <%=eventEndDate%>.
						</span>
					</marquee>
					<br /> <br />
				</div>
				</p>
				<center>

					<%////pinkathon event id -prod:2023_524_event
					if(eventId.equals("2023_524_event")){%>
						<center><span>I / my family members are voluntarily participating in the Pinkathon 2023 with complete knowledge of the associated risks and I agree to accept the responsibility for all risks of injury.</span></center>
					<%}%>

					<!--<input type="submit" name="submitEvt" <%=("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize))?"":"style='display:none'"%>  id="submitEvt" value="Save" onclick="return submitEvtForm();">-->
					<input type="submit" name="SubmitConfirm"
						<%=( ("".equals(maxPrize) || "0".equals(maxPrize) || "0.0".equals(maxPrize)) && (!e_chk_humfit.equals(eventId)) )?"":"style='display:none'"%>
						id="submitEvt1" value="Confirm" class="style-right-button" onclick="return submitEvtForm1();">
						
						<%/* if(e_chk_humfit.equals(eventId)){%>
						<input type="submit" name="SubmitConfirm" id="submitEvt1" value="Confirm 2" class="style-right-button" onclick="return submitEvtForm1();">
						<%}*/%>
				</center>
				
					<input type="hidden" name="maxTicks"
					id="maxTicks" value="<%=maxTicks%>" /> <input type="hidden"
					name="maxPrize" id="maxPrize" value="<%=maxPrize%>" /> <input
					type="hidden" name="noTicks" id="noMaxTicks"
					value="<%=noOfTicksEmp%>" /> 

					<input type="hidden" name="ta"
					id="ta" value="<%=noOfTicks%>" /> 

					<input type="hidden"
					name="otherTotEntry" id="otherTotEntry" /> <input type="hidden"
					name="bPoints" id="bPoints" value="<%=bPoints%>" /> <input
					type="hidden" name="evtName" value="<%=evtName%>" /> <input
					type="hidden" name="remTicks" id="tickCnt" value="<%=tickRemNo%>">
				<input type="hidden" name="action_type" value="" />
			</div>
			<%}%>
		</form>
		</div></div></div></br>
		
		<%@include file="footer.jsp"%>
		
		<!--<img src="images/p1.jpg" />-->
		<!--<a href="Marathon/index.jsp">For YPC Marathon-2019 ,Click here(Visakh Refinary,Non Management Employees)</a>-->
		<!--<div style="text-align: center; font-weight: bold; font-size: 20px;">
<span style="color: red;">For HP Marathon </span><a href="Marathon/" style="">Click Here</a>
</div>-->