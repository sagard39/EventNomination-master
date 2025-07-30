<!DOCTYPE html>
<html lang="en">
<head>
	<title>Event Nomination</title>
 <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
<style>

.wrap-input100{
	height: 60px!important;
}

@media only screen and (max-width: 768px) {
  .login100-form {
    width: 100%!important;
    border: 2px solid #000d39;
  }
}

.login100-more{
	background-image: url('images/222.jpg'); background-size: cover; background-position: top!important; width: 70%!important;
}

</style>

<%
	Cookie[] cookies = request.getCookies();
	boolean foundCookie = false;
	if(cookies != null) {
	for(int i = 0; i < cookies.length; i++) {
			Cookie c = cookies[i];
			if (c.getName().equals("ctoken")) {
//out.println("ctoken = " + c.getValue());
					foundCookie = true;
			}
	}
	}
	if (!foundCookie) {
			Cookie c = new Cookie("ctoken", "random");
			c.setMaxAge(20*60);
			response.addCookie(c);
	}
%>

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet"  href="css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet"  href="css/style.css">
<!--===============================================================================================-->
	<link rel="stylesheet" href="css/main22.css">
<!--===============================================================================================-->
</head>
<body style="background-color: #666666;">
	
	<div class="limiter" style="height: 650px!important;">
		<div class="container-login100" style="height: 100%">
			<div class="wrap-login100" style="height: 100%">
				<form class="login100-form validate-form" action="login.jsp" method="POST" onsubmit="submit()">
					<span class="login100-form-title1">
						<center><img src="images/hp.png" style="width: 25%">
							<h3 class="style-padding-16"><b><i>Event Nomination<br/><span style="font-size: 48%">(Employee Connect / Reboot35+ / Yuvantage / Sampark)</span></i></b></h3><br/>
						</center>					
					</span>

					
					<div class="wrap-input100 validate-input" data-validate = "Enter Employee Number">
						<input class="input100" type="text" name="t1" id="t1" required="required" placeholder="Employee Number" required="required">						
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="t2" id="t2" required="required" placeholder="Password" required="required" autocomplete="off">						
					</div>
					<div class="container-login100-form-btn">
						<button class="login100-form-btn">
							Login
						</button>
					</div>		
				</form>
				<div class="login100-more">
				</div>
			</div>
		</div>
	</div>
	
	

	
	
<!--===============================================================================================-->
	<script src="js/jquery-3.7.1.min.js"></script>

	<script src="js/popper.js"></script>
	<script src="js/bootstrap.min.js"></script>


	<script>
		/*if (!!(navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/rv:9/)) || (typeof $.browser !== "undefined" && $.browser.msie == 1))
		{
  				alert("Please dont use IE. Application works Best in Chrome and IE 10 and above");
  				window.close();
		}*/
		/*if (navigator.appName == 'Microsoft Internet Explorer' ||  !!(navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/rv:9/)) || (typeof $.browser !== "undefined" && $.browser.msie == 1))
		{
  				alert("Please dont use IE. Application works Best in Chrome and IE 10 and above");
  				window.close();
		}*/
	</script>

</body>
</html>