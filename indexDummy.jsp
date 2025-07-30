<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html lang="en"> <!--<![endif]-->
 <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<head>
<title>Event Nomination</title>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style1.css">
<link rel="stylesheet" href="css/styles.css">
   
  <style>

.listTable1 tr > th{
--border: px solid #FFFFFF;
box-shadow:0 0 10px #5D6D7E;
background-color: #CB4E46;
color:#FFF;
background: -webkit-linear-gradient(top ,#CB4E46, #1472C5);
background: -o-linear-gradient(top ,#CB4E46, #1472C5);
background: -moz-linear-gradient(top ,#CB4E46, #1472C5);
background: -ms-linear-gradient(top ,#CB4E46, #1472C5);
background: linear-gradient(top ,#CB4E46, #1472C5);
}	
.listTable1 tr:nth-child(even){
	background:#FDEDEC;
}
.listTable1 tr:nth-child(odd){
	background:#ebf1fa ;
}
.listTable1 td{
	padding:1% 0%;
}
  </style>

		<table class="listTable1" style="width:100%"><tr><th style="width:70px;"><img src="images/logo3.png" style="height:90px;float:left"></img></th>
<th valign="center" >
<label id="masterheader">Employee Connect Online System<label></th>
</tr></table>
<form id="login" action="login.jsp" autocomplete="off"  method="POST"  onsubmit="return FrontPage_Form1_Validator(this)"  name="FrontPage_Form1" >
<!--<div class="masthead">
<div style="width:10%"><img src="logo.png" style="height:auto;width:100px"></img></div>
<div ><h1 class="site-title" style="margin-left:30%" >Intimation under CDA rule</h1></div>
</div>-->
<br><br><br><br><br>
    <div class="login">
      <h1>Login</h1>
        <p><input type="text" name="t1" id="t1" MAXLENGTH="8"  placeholder="Employe No."></p>
        <p><input type="password" name="t2" id="t2"  placeholder="Password"></p>
        <p class="submit"><input type="submit" name="commit" value="Login"></p>
		</div><br/><br/>

 </form><br/>
<script Language="JavaScript" Type="text/javascript">
function FrontPage_Form1_Validator(theForm)
{
 
if(document.FrontPage_Form1.t1.value=="")
{
	alert("Please Enter Your ADS userid");
    document.FrontPage_Form1.t1.focus();
	return false;
}
if(document.FrontPage_Form1.t2.value=="")
{
	alert("Please Enter Your ADS password");
    document.FrontPage_Form1.t2.focus();
	return false;
}
}
</script>
</html>
