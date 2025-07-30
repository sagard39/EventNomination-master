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
	<link rel="stylesheet" href="css/jquery-ui.css">
<style>

body{
	font-family:cambria;
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
.header .header-nav ul#nav-library ul.dropdown-menu {
    position: relative;
    z-index: 10000;
}
.card-header {
    /* padding: .75rem 1.25rem; */
    margin-bottom: 0;
    background-color: rgba(0,0,0,.03);
    border-bottom: 1px solid rgba(0,0,0,.125);
    padding: 0px 0px 0px 10px;
}
</style>

<link rel="stylesheet" href="css/magnific-popup.css">
<script src="js/jquery-1.10.2.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/validate.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet"/>
<script src="js/bootstrap.min.js"></script>
<link rel="stytlesheet" href="css/customcss.css">

<!--<link rel="stylesheet" type="text/css" href="css/menu.css" />-->
</head>
<body>
		<%
		String login1 = (String)session.getAttribute("login");
		String publishMail = "";
		boolean isAdmn=false,isDefAdmin=false,isSuperAdmin = false;
		String adminComp="",emp_desig="";
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
/* 		if(("31918150".equals(login1)) ||  ("31919150".equals(login1)) || ("31924800".equals(login1)) || ("30074010".equals(login1)) || ("31960240".equals(login1)) || ("31905730".equals(login1)) || ("31960540".equals(login1)) || ("31969510".equals(login1)) || ("31908900".equals(login1))){
			isDefAdmin=true;
		 }			
 */			
		psNomination=con.prepareStatement("select emp_no,role from nomination_super where emp_no=?");
		psNomination.setString(1,login1);
		rsNom = psNomination.executeQuery();
		while(rsNom.next()){
			isDefAdmin = true;
			if("Super_Admin".equals(rsNom.getString("role")))
				isSuperAdmin=true;
		}
		psNomination = con.prepareStatement("select emp_no,(select email from empmaster where emp_no = a.emp_no) emailStr,  role from nomination_super a where role= 'Super_Admin'");
		rsNom = psNomination.executeQuery();
		while(rsNom.next()){
			publishMail += ","+rsNom.getString("emailStr");
			
		}
		if(!"".equals(publishMail)){
			publishMail = publishMail.substring(1);
		}
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String emp ="",empnme ="",budesc ="",town ="",sbu_code="",bucode="",empCategory="",empGender="";
		String qryempdetails = "select emp_no,trim(emp_name) emp_name,budesc,trim(TOWN) as town,sbu_code,bu,category,sex,trim(emp_designation) designation from empmaster where trim(emp_no) = '"+login1+"'";
		rs = stmt.executeQuery(qryempdetails);
		if(rs.next()){
			emp = rs.getString(1);
			empnme = rs.getString(2);
			budesc = rs.getString(3);
			town = rs.getString(4);
			sbu_code =  rs.getString(5);
			bucode = rs.getString(6);
			empCategory = rs.getString(7);
			emp_desig = rs.getString("designation");
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
    <a class="navbar-brand" href="home.jsp" ><img src="images/logo3.png" class="d-inline-block align-top" alt="" width="40"><font size="5" face="algerian">Event Nomination</font></a>
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
				<a class="dropdown-item" href="mainSubmit.jsp">New Nomination</a>
				<a class="dropdown-item" href="mynomination1.jsp">My Nominations</a>
				<a class="dropdown-item" href="mycancnomination.jsp">My Cancelled Nominations</a>
				<a class="dropdown-item" href="fitFeedBack.jsp">Feedback for Hum Fit Toh HP Fit</a>
				<%if("30036060".equals(login1) || "31926330".equals(login1)){%>
					<a class="dropdown-item" href="reportFit.jsp">Hum Fit toh HP Fit</a>
				<%}%>
			</div>
		</li>       
		<li class="nav-item">
          <a class="nav-link" href="https://team.hpcl.in/sites/NIGall/_layouts/pictlib/Menu.aspx" target="_blank">Gallery</a>
        </li>

<% if(isAdmn  || isDefAdmin){%>
        <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" style="cursor:pointer;" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Admin</a>
			<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown01">
		<%if(isDefAdmin){%>		
				<!--<a  class="dropdown-item" href="editevent1.jsp" >Add Event</a>-->
				<a  class="dropdown-item" href="newEvent.jsp" >Add Event</a>
				<a  class="dropdown-item" href="editExistEvt.jsp" >Edit Event</a>
				<a  class="dropdown-item" href="evtPublish.jsp" >Publish Pending Event</a>
		<%}%>	
		<%if(isAdmn   || isDefAdmin){%>				
				<a  class="dropdown-item" href="viewReports1.jsp">Eventwise Report</a>
				<a  class="dropdown-item" href="adminFeedback.jsp">Event Feedback</a>
				<a class="dropdown-item" target="_blank" href="data/user_manual.pdf">User Manual</a>
				<%if("31976260".equals(login1) || "31970140".equals(login1)){%>
				<a  class="dropdown-item" href="adminTeamCluster.jsp">Team Formation Link</a>
				<%}%>
		 <%} if("31926330".equals(login1) || "31976260".equals(login1) || isSuperAdmin){%>
				<a class = "dropdown-item" href= "adminFeedback_fit.jsp">Feedback for Hum Fit Toh HP Fit</a>
		 <%}if(isSuperAdmin){%>
				<a class = "dropdown-item" href ="addAdmin.jsp">Add Admin</a>
				<a class = "dropdown-item" href ="homepageImg.jsp">Update Homepage Images </a>
		 <%}%>	
			</div>
		</li>
<%}%>		
		<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" style="cursor:pointer;" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Logout</a>
			<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown02">
				<div class="card sm-10">
				<div class="card-body"><%=empnme%><br/>
					
				</div>
				<div class="card-footer">
					<a href="logout.jsp"><button class="btn btn- btn-danger">Logout</button></a> 
				</div>
				</div>
			</div>	
        </li>

      </ul>
    </div>
  </nav>

</header>
<div style="margin-top: 10px; "></div>
<link rel="stytlesheet" href="css/customcss.css">
