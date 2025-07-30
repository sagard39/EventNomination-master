<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--><html lang="en"> <!--<![endif]-->
<head>
<%@include file="connection.jsp"%>
<meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Employee Connect</title>
  <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">-->
 <!-- <link rel="stylesheet" href="css/style1.css">-->
<link rel="stylesheet" href="css/styles.css">
<link rel="stylesheet" href="css/jquery-ui.css">
   <!--<link rel="stylesheet" href="css/reset.css">
  <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
<style>
.details{
	/*font-family: 'Open Sans', sans-serif;*/
	background: #ffffff;
	color: #009AE1;
}
.tab1{
	width:99%;
}
.tab1 tr:first-child{
	background:#2d67b2 ;
}
.span1{
	padding:6%;
}
body{
	background:url(images/body_background.jpg);
}
input[type=text],select,input[type=number]{
	width:99%;
}
input[type="button"], input[type="reset"], button, input[type="file"] {
background-color: #98B1CD;
border-radius: 4px;
border: 1px solid #87A4C5;
cursor: pointer;
margin: 0;
padding: 0px;
color: black;
font-weight: bold;
 box-sizing: border-box;
}
 input[type="submit"] {
background-color: #98B1CD;
border-radius: 4px;
border: 1px solid #87A4C5;
cursor: pointer;
padding: 2px 10px;
color: black;
font-weight: bold;
}
h2{
	font-size:50px;
	color:#fff;
}
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

<link rel="stylesheet" href="css/styles.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/validate.js"></script>
<!--<link rel="stylesheet" type="text/css" href="css/menu.css" />-->
</head>
<body>
		<%
		String login1 = (String)session.getAttribute("login");
		boolean isAdmn=false;
		String qrynominate="select * from nomination_admin where adminEmp=?";
		PreparedStatement psNomination=con.prepareStatement(qrynominate);
		psNomination.setString(1,login1);
		ResultSet rsNom=psNomination.executeQuery();
		if(rsNom.next())
			isAdmn=true;

		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String emp ="",empnme ="",budesc ="",town ="",sbu_code="",bucode="",empCategory="";
		String qryempdetails = "select emp_no,emp_name,budesc,trim(TOWN) as town,sbu_code,bu,category from empmaster where trim(emp_no) = '"+login1+"'";
		rs = stmt.executeQuery(qryempdetails);
		if(rs.next()){
			emp = rs.getString(1);
			empnme = rs.getString(2);
			budesc = rs.getString(3);
			town = rs.getString(4);
			sbu_code =  rs.getString(5);
			bucode = rs.getString(6);
			empCategory=rs.getString(7);
		} else{
			%>
			<script>
			alert("Invalid User");
			location.href="index.jsp";
			</script>
		<%}

		%>
		<table class="listTable1" style="width:100%"><tr><th style="width:70px;"><img src="images/logo3.png" style="height:90px;float:left"></img></th>
<th >
<label id="masterheader">Employee Connect Online System<label></th>
</tr></table>


<div class="main-menu">
      <div class="nav-mixed menu" >
        <nav id="multi-level-nav" class="multi-level-nav" role="navigation">
          <ul>
		  <li><a href="home.jsp">Home</a></li>
			<li class="has-children"><a href="#">Nomination<button class="dropdown-toggle" aria-expanded="true"><span class="screen-reader-text">Expand child menu</span></button></a>
			<ul class="sub-menu">
			<li><a href="main.jsp">Apply for Event</a></li>
			<!--<li><a href="mynomination.jsp">My Nominations</a></li>-->
			<!--<li><a href="mycancnomination.jsp">Cancelled Nominations</a></li>-->
			</ul>
			</li>
			<li><a href="mynomination.jsp">My Nominations</a></li>
			<li><a href="mycancnomination.jsp">Cancelled Nominations</a></li>
			<% if(isAdmn ||  "31960210".equals(emp) || "31918150".equals(emp) ||  "31919150".equals(emp) || "31924800".equals(emp) || "30074010".equals(emp) || "31960240".equals(emp) || "31905730".equals(emp) || "31960540".equals(emp)) { %>
			<li class="has-children"><a href="#">Admin<button class="dropdown-toggle" aria-expanded="true"><span class="screen-reader-text">Expand child menu</span></button></a>
			<ul class="sub-menu">
				<% if("31960210".equals(emp) || "31918150".equals(emp) ||  "31919150".equals(emp) || "31924800".equals(emp) || "30074010".equals(emp) || "31960240".equals(emp) || "31905730".equals(emp) || "31960540".equals(emp)) { %>
				<li><a href="editevent.jsp">Add Event</a></li>
				<li><a href="viewreports.jsp">All Report</a></li>
				<li><a href="viewreports.jsp?rep=loc">Bus Boarding point wise Report</a></li>
				<li><a href="viewreports.jsp?rep=dept">Department wise Report</a></li>
				<% } %>
				<li><a href="viewreports.jsp?rep=evt">Event wise Report</a></li>
			</ul></li>
			<% } %>
			<li style="float:right"><font size="4" color="#FFF">Welcome</font>:<%=empnme%>
				<font style="float:right;valign:center"><a href="logout.jsp"><IMG SRC="images/logout.jpg" width="18" title="Logout"></a></font>
			</li>
			<!--<li style="float:right"><a href="logout.jsp">Logout</a></li>-->
		  </ul>
		

		  </nav>
</div>
</div>
