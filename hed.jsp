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
input[type="file"] {
background-color: #428bca;
    background: -webkit-linear-gradient(top ,#428bca, #00557f);
    background: -o-linear-gradient(top ,#428bca, #00557f);
    background: -moz-linear-gradient(top ,#428bca, #00557f);
    background: -ms-linear-gradient(top ,#428bca, #00557f);
    background: linear-gradient(top ,#428bca, #00557f);border-radius: 4px;
border: 1px solid #87A4C5;
cursor: pointer;
margin: 0;
padding: 0px;
color: #fff;
font-weight: bold;
 box-sizing: border-box;
}
 input[type="button"], input[type="reset"] ,input[type="submit"] {
	border-radius: 4px;
    border: 1px solid #428bca;
    cursor: pointer;
    padding: 2px 10px;
	color: #fff;
    font-weight: bold;
    font-size: 14px;
    height:30px;
	background-color: #428bca;
    background: -webkit-linear-gradient(top ,#428bca, #00557f);
    background: -o-linear-gradient(top ,#428bca, #00557f);
    background: -moz-linear-gradient(top ,#428bca, #00557f);
    background: -ms-linear-gradient(top ,#428bca, #00557f);
    background: linear-gradient(top ,#428bca, #00557f);
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
<link rel="stylesheet" href="css/magnific-popup.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/validate.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<script src="js/bootstrap.min.js"></script>

<!--<link rel="stylesheet" type="text/css" href="css/menu.css" />-->
</head>
<body>
		<%
		String login1 = (String)session.getAttribute("login");
		boolean isAdmn=false,isDefAdmin=false;
		String adminComp="";
		String qrynominate="select distinct evt_id,evtnme,adminEmp from nomination_admin where evt_id is not null and substr(adminEmp,0,8)=? or substr(adminEmp,10,18)=?";
		PreparedStatement psNomination=con.prepareStatement(qrynominate);
		psNomination.setString(1,login1);
		psNomination.setString(2,login1);
		ResultSet rsNom=psNomination.executeQuery();
		if(rsNom.next())
			adminComp=rsNom.getString("adminEmp");
		String [] adminList=adminComp.split("\\,");	
		
		if(adminList!=null && adminList.length!=0){
			for(int i=0;i<adminList.length;i++){
				if(adminList[i].equals(login1))
					isAdmn=true;
			}
		}//31908900-K S Shetty added on 26-Mar-18
		if(("31918150".equals(login1)) ||  ("31919150".equals(login1)) || ("31924800".equals(login1)) || ("30074010".equals(login1)) || ("31960240".equals(login1)) || ("31905730".equals(login1)) || ("31960540".equals(login1)) || ("31969510".equals(login1)) || ("31908900".equals(login1))){
			isDefAdmin=true;
		 }			
		//isAdmn=true;
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String emp ="",empnme ="",budesc ="",town ="",sbu_code="",bucode="",empCategory="",empGender="";
		String qryempdetails = "select emp_no,emp_name,budesc,trim(TOWN) as town,sbu_code,bu,category,sex from empmaster where trim(emp_no) = '"+login1+"'";
		rs = stmt.executeQuery(qryempdetails);
		if(rs.next()){
			emp = rs.getString(1);
			empnme = rs.getString(2);
			budesc = rs.getString(3);
			town = rs.getString(4);
			sbu_code =  rs.getString(5);
			bucode = rs.getString(6);
			empCategory = rs.getString(7);
			empGender = rs.getString("sex");
		} else{
			%>
			<script>
			alert("Invalid User");
			location.href="index.jsp";
			</script>
		<%}

		%>


    <header>
			<nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <a class="navbar-brand" href="home.jsp" style="float:left;"><img src="images/logo3.png" width="50%"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse  navbar-collapse" id="navbarColor02">
      <ul class="navbar-nav ml-auto ">
        <li class="nav-item active">
          <a class="nav-link" href="home.jsp">Home <span class="sr-only">(current)</span></a>
        </li>
         <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" style="cursor:pointer;" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Nomination</a>
			<div class="dropdown-menu" aria-labelledby="dropdown01">
				<a class="dropdown-item" href="mainSubmit.jsp">My Nomination</a>
			</div>
		</li>       
        <li class="nav-item">
          <a class="nav-link" href="mynomination1.jsp">My Nominations</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="mycancnomination.jsp">Cancelled Nomination</a>
        </li>
<% if(isAdmn || ("31919150".equals(emp)) || ("31924800".equals(emp)) || ("30074010".equals(emp)) || ("31960240".equals(emp)) || ("31905730".equals(emp)) || ("31960540".equals(emp)) || ("31969510".equals(emp)) || ("31908900".equals(emp)) ){%>
        <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" style="cursor:pointer;" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin</a>
			<div class="dropdown-menu" aria-labelledby="dropdown01">
		<%if(("31919150".equals(emp)) || ("31924800".equals(emp)) || ("30074010".equals(emp)) || ("31960240".equals(emp)) || ("31905730".equals(emp)) || ("31960540".equals(emp)) || ("31969510".equals(emp)) || ("31908900".equals(emp))){%>		
				<a  class="dropdown-item" href="data/Reboot_Report.pdf" target="_blank">Add Event</a>
				<a  class="dropdown-item" href="data/annual_plan.pdf" target="_blank">Edit Event</a>
				<a  class="dropdown-item" href="data/self_develop.pdf" target="_blank">Publish Pending Event</a>
		<%}%>	
		<%if(isAdmn || ("31919150".equals(emp)) || ("31924800".equals(emp)) || ("30074010".equals(emp)) || ("31960240".equals(emp)) || ("31905730".equals(emp)) || ("31960540".equals(emp)) || ("35415370".equals(emp)) || ("31969510".equals(emp)) || ("31908900".equals(emp))){%>				
				<a  class="dropdown-item" href="data/self_develop.pdf" target="_blank">Eventwise Report</a>
		 <%}%>			
			</div>
		</li>
<%}%>		
		<li class="nav-item">
          <a class="nav-link" href="logout.jsp">Logout</a>
        </li>
      </ul>
    </div>
  </nav>

</header>