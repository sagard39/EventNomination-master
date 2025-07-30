<%@include file="connection.jsp" %> 
<br>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Medical Insurance</title>
<link href="css/magnific-popup.css" rel="stylesheet" type="text/css" />
<script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="js/jquery.magnific-popup.min.js" type="text/javascript"></script>
<script src="js/jquery-ui.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() {    
        var $submit = $("#button1").hide(),
            $cbs = $('input[name="chk"]').click(function() {
                $submit.toggle( $cbs.is(":checked") );
            });    
			
    });
$(document).ready(function() {  	
	$cbs = $('input[name="chkbus"]').click(function() {
              $("#bus").show();
            });
});			
</script>
<style>
</style>
<body>

<center><h3>Declaration</h3></center>

I/my Ward hereby declare, confirm and agree as below..
<ol>
<li> The information given by me/my ward in this entry form is true and I am solely responsible for the accuracy of this information;</li>

<li>I have fully understood the risk and responsibility of participating in the HPCL Reboot Marathon 2017 event and will be participating entirely at my risk and responsibility for Self and each of my participants.</li>

<li>I understand the risk of participating in a Marathon.</li>

<li> I understand that I/my ward must be trained to an appropriate level of fitness to participate in such a physically demanding event and I/my ward have obtained a medical clearance from a registered medical practitioner, allowing me to participate in the event.</li>

<li> For myself/ourselves and our legal representatives, waive all claim of whatsoever nature against any and all sponsors of the event, HPCL and all other person and entities associated with the event and the directors. Employees, agent and respective of all or any of the aforementioned including, but not limited to, any claims that might result from me/my ward participating in the event and whether on account of illness, injury, death or otherwise.</li>

<li>Agree that if I am/my ward is injured or taken ill or otherwise suffer/s any detriment whatsoever, hereby irrevocably authorize the event official and organizers to at my/our risk and cost, transport me/my ward to a medical facility and or to administer emergency medical treatment and I/my ward waive all claim that might result from such transport and or treatment or delay or deficiency therein. I shall pay or reimburse to you my/my ward's medical and emergency expenses and I/my ward hereby authorizes you to incur the same.</li>

<li> Shall provide to race official such medical data relating to me/my ward as they may request, I agree that nothing herein shall oblige the event official or organizers or any other person to incur any expense to provide any transport or treatment.</li>

<li> In case of any illness or injury caused to me or my ward or death suffered by me or my ward due to any force majeure event including but not limited to fire, riots or other civil disturbances, earthquake, storms, typhoons or any terrorist, none of the sponsors of the event or any political entity or authorities and official or any contractor or construction firm working on or near the course, or any person or entities associated with event or the directors, employee, agents or representative of all or any of the aforementioned shall be held liable by me/my ward or me/my ward's representative.</li>

<li>Understand, agree and irrevocably permit HPCL to share the information given me/my ward's in this application, with all/any entities associated with the HPCL Reboot Marathon 2017, at its own discretion.</li>

<li>Understand, agree and irrevocably permit HPCL Reboot Marathon 2017 to use my/my ward's photograph which may be photographed on the day of the event, for the sole purpose of promoting the HPCL Reboot Marathon 2017, at its own discretion;</li>

<li>Shall not hold the Organizers and all/any of the event sponsors responsible for loss of my/his/her entry form and</li>

<li>I/my ward understand and agree to the event terms and guidelines.</li>

<li> Race timing certificates / Link to the same would be displayed on the HPCL Event Nomination portal.</li>

<li>Winner will be decided based on Gun Time and Race Marshall's decision will be final.</li>
</ol>

<div> <input type="checkbox" name="chk" id="chk" ><b>I Agree the Terms and Conditions.</b><br><br>
<input type="checkbox" name="chkbus" id="chkbus" ><b>Do you want to avail Bus Facility?</b>&nbsp;&nbsp;<select name="bus" id="bus" style="display:none;">
<option value="">Vashi</option>
<option value="">Dadar</option>
<option value="">Borivali</option>
</select>
<br>
<center> <center><button onclick="return closePopup()" style="background-color:#108A9C;color:#FFFFFF" name="button1" id="button1">Proceed and Submit</button> </center></center>
</div>


</body>
<script>
function closePopup(){
	
location.href="marathon.jsp";	
}
</script>
</html>