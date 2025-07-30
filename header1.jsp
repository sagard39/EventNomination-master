<%@include file="connection.jsp" %>

<%@ page import="java.util.Hashtable,javax.naming.ldap.*,javax.naming.directory.*,javax.naming.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>Event Nomination</title>
   <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
      <meta name="viewport" content="width=device-width, initial-scale=1">
</head>


<%

String font="", color="";

String get_font = "", get_color="";

get_font = request.getParameter("font");
get_color = request.getParameter("color");

%>


<%
		String login1 = (String)session.getAttribute("login");

    if(login1==null){ response.sendRedirect("index.jsp"); login1 = "";}


		String publishMail = "";

        SimpleDateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
        Date today_date =new Date();
        String todaydate_val = format.format(today_date);
        //out.println(todaydate_val);

		boolean isProcessAdmin =false,isDefAdmin=false,isTechnicalAdmin  = false;
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
					isProcessAdmin =true;
			}
		}//31908900-K S Shetty added on 26-Mar-18
/* 		if(("31918150".equals(login1)) ||  ("31919150".equals(login1)) || ("31924800".equals(login1)) || ("30074010".equals(login1)) || ("31960240".equals(login1)) || ("31905730".equals(login1)) || ("31960540".equals(login1)) || ("31969510".equals(login1)) || ("31908900".equals(login1))){
			isDefAdmin=true;
		 }			
 */			
		psNomination=con.prepareStatement("select emp_no,role from nomination_super where emp_no=?  AND FROM_DATE<=? AND TO_DATE >=?");
        //psNomination=con.prepareStatement("select emp_no,role from nomination_super where emp_no=?");
		psNomination.setString(1,login1);
        psNomination.setString(2,todaydate_val);
        psNomination.setString(3,todaydate_val);
		rsNom = psNomination.executeQuery();
		while(rsNom.next()){
			isDefAdmin = true;
			if("Technical_Admin".equals(rsNom.getString("role")))
				isTechnicalAdmin =true;
		}
		psNomination = con.prepareStatement("select emp_no,(select distinct(email) from empmaster where emp_no = a.emp_no ) emailStr,  role from nomination_super a where role= 'Technical_Admin'");
		rsNom = psNomination.executeQuery();
		while(rsNom.next()){
			publishMail += ","+rsNom.getString("emailStr");
			
		}
		if(!"".equals(publishMail)){
			publishMail = publishMail.substring(1);
		}

    /*if(login1.equals("31982600") || login1.equals("31912370") ){
    isDefAdmin=true;
    isTechnicalAdmin=true;
    isProcessAdmin=true;
  }*/

		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String emp ="",empnme ="",budesc ="",town ="",sbu_code="",bucode="",empCategory="",empGender="", emp_zonecd="";
		String qryempdetails = "select emp_no,trim(emp_name) emp_name,budesc,trim(TOWN) as town,sbu_code,bu,category,sex,trim(emp_designation) designation, zonecd from empmaster where trim(emp_no) = '"+login1+"'";
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
      emp_zonecd  = rs.getString("zonecd");
      if(emp_zonecd==null){emp_zonecd="";}
      //out.println("emp_zonecd_header="+emp_zonecd);
		} else{
			%>
			<script>
			alert("Invalid User");
			location.href="index.jsp";
			</script>
		<%}

		%>



<%
// out.println("get_font = "+get_font);
// out.println("get_color = "+get_color);

    if(get_font==null || get_font.equals("null")) {
    get_font = (String)session.getAttribute("get_font_session");
  
  if(get_font==null || get_font.equals("null")) { %>
    <link rel="stylesheet" type="text/css" href="css/style_font_medium.css">
<%  } else { %>
    <link rel="stylesheet" type="text/css" href="css/style_font_<%=get_font%>.css">
<%
    }
  } else {
    session.setAttribute("get_font_session",get_font);
%>
    <link rel="stylesheet" type="text/css" href="css/style_font_<%=get_font%>.css">
<%
   }
%>

<%
  if(get_color==null || get_color.equals("null")) {
    get_color = (String)session.getAttribute("get_color_session");
  
    if(get_color==null || get_color.equals("null")) { %>
    <link rel="stylesheet" type="text/css" href="css/style_light.css">
<%
  } else { %>
    <link rel="stylesheet" type="text/css" href="css/style_<%=get_color%>.css">
<%
   }
  } else {
    session.setAttribute("get_color_session",get_color);
%>
    <link rel="stylesheet" type="text/css" href="css/style_<%=get_color%>.css">
<%
   }
%>

<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/fonts/font-awesome-4.7.0/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="css/tipsy.css">
<link rel="stylesheet" href="css/magnific-popup.css">

<script>
    var url = window.location.href.split('?')[0];
    if(window.location.href.split('?').length>1)
    {
    var URL1=window.location.href.split('?')[1];
    var url2=URL1.split('&');
    var url3='';
    for(i=0;i<URL1.split('&').length;i++)
    {
      //alert(url2[i]);
      if(url2[i].includes('font') || url2[i].includes('color') )
      {
        //alert('contains');
      }
      else{
        url3=(url3=="")?url3+'?'+url2[i]:url3+'&'+url2[i];
        // if(url3=='')
        // {
          // url3=url3+'?'+url2[i];
          // //alert(url3);
        // }
        // else{
          // url3=url3+'&'+url2[i];
          // //alert(url3);
        // }
        //url = url+'?'+;
      }
    }
    if(url3!='')
    {
      url = url+url3+'&';
    }else{
      url=url+'?';
    }
    
    }
    else{
      url=url+'?';
    }
</script>

<style type="text/css">
  .container-fluid-wid{
       width: 95%!important; margin-left: auto; margin-right: auto;
  }
  a:hover{
  	text-decoration: none;
  }

  .nav-link>a{
  	color: white;
  }

  .dropdown-item{
    color: white;
  }

  .bootstrap-datetimepicker-widget{
    display: inline-block!important;
  }

  .timepicker-sbs{
    display: inline-block!important;
  }
  
  
  
  .dropdown-submenu {
  position: relative;
}

.dropdown-submenu > .dropdown-menu {
  top: 0;
  left: 100%;
  margin-top: -1px;
  display: none;
}

.dropdown-submenu:hover > .dropdown-menu {
  display: block;
}
  
</style>

<body>
  
<%
 /* String csrf1 = (String)session.getAttribute("csrf1");
  String cs = request.getParameter("cs");
  if(cs==null||csrf1==null || !cs.equals(csrf1)){
   response.sendRedirect("logout.jsp");  //if csrf is null in Page
  }*/


  String empno = "", empName="", admin_str="", uploader_str="", approver_str="", hqo_task_str="",role="";
  Boolean admin=false, Port_officer=false, Vessel_master=false;

  empno = (String)session.getAttribute("USRID");
  empName = (String)session.getAttribute("ename");
  role = (String)session.getAttribute("role");
  //admin_str = (String)session.getAttribute("admin");
  //uploader_str = (String)session.getAttribute("uploader");
  //approver_str = (String)session.getAttribute("approver");
  //hqo_task_str = (String)session.getAttribute("hqo_task");
  //hqo_task_str = (String)session.getAttribute("hqo_task");

 /* if(role.equals("admin")){admin=true;}
  else{admin=false;}

  if(role.equals("Port_officer")){Port_officer=true;}
  else{Port_officer=false;}

  if(role.equals("Vessel_master")){Vessel_master=true;}
  else{Vessel_master=false;}*/

 

%>




<div class="container-fluid">
  <div class="row">

     <div class="col-sm-3 col-md-3 col-lg-3" id="big_logo" style="z-index:1000; padding-left: 0px; ">
          <%if(get_color==null || get_color.equals("null")){%>
          <img src="images/new_logo_light.svg" style="height: 99%;">
          <%}else{
          %>
             <img src="images/new_logo_<%=get_color%>.svg" style="height: 99%;">
          <%
        }%>
      </div>


    <div class="col-sm-12 col-md-12 col-lg-9">
      <div class="row">

        <div class="col-sm-12 col-md-12 col-lg-12 style-app-name">

         <div id="small_logo" class="style-left" style="width: 10%; margin: 1% 0% 0% 1%;">
            <a href="http://my.hpcl.co.in/j2ee/portal/landing/home.jsp"><img src="images/Logo.svg" style="height: 5%; width: 100%"></a>
          </div>

         <h3 class="style-right style-text-white" style="padding-top: 0.7%">Event Nomination &nbsp;&nbsp;&nbsp;&nbsp;</h3>
           <%/* %>
           <ul class="style-right" style="display: inline-block; list-style-type: none; margin-top:0.6%"> 
               <li class="style-text-white" id="font_choice">
                   <span style="font-size: 80%">Text Size :</span> 
                   <span class="style-medium style-text-white" style="cursor: pointer;"  onclick="window.location.href=url+'font=medium&color=<%=get_color%>'"><b>&#65;&nbsp;</b></span>
                   <span class="style-large style-text-white" style="cursor: pointer;"  onclick="window.location.href=url+'font=large&color=<%=get_color%>'"><b>&#65;&nbsp;</b></span>
                   <!--<span class="style-xlarge style-text-white" onclick="window.location.href='index.jsp?font=xlarge'"><b>&#65;</b>&nbsp;</span> -->&nbsp;&nbsp;&nbsp;
                   <span style="font-size: 80%">Color Contrast :</span> 
                   <span class="style-border style-header-darkBlue style-display-inline-grid" style="cursor: pointer;"  onclick="window.location.href=url+'font=<%=get_font%>&color=dark'">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                   <span class="style-border style-blue style-display-inline-grid" style="cursor: pointer;"  onclick="window.location.href=url+'font=<%=get_font%>&color=light'">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                   <!--<span class="style-border style-gradient style-display-inline-grid" onclick="window.location.href='index1.jsp?font=<%=get_font%>&color=gradient'">&nbsp;&nbsp;&nbsp;&nbsp;</span>--> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </li>
          </ul><%*/ %>
        </div>




        <div class="col-sm-12 col-md-12 col-lg-12" style="margin-top:0.5%; padding: 0%">
		 <nav class="navbar navbar-expand-md navbar-dark navbar-fixed-top style-menu-color" style="z-index:98; padding : .5rem 1rem;">
		 &nbsp;&nbsp;
		 <span class="style-right">
        <button class="navbar-toggler style-text-white style-grey style-right" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
          <span class="navbar-toggler-icon style-grey"></span>
        </button>&nbsp;&nbsp;
      </span>
	   <div class="collapse navbar-collapse" id="collapsibleNavbar">
	   <ul class="navbar-nav ml-md-auto">
			<li class="nav-item active">
				<a class="nav-link" href="home.jsp">Home <span class="sr-only">(current)</span></a>
			</li>
			<li class="nav-item dropdown" id="claimId1">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				Nomination
				</a>
        
				<div class="dropdown-menu" id="custmDropdown1" aria-labelledby="navbarDropdown" style="display: none;">
				<a class="dropdown-item" href="mainSubmit.jsp">New Nomination</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="mynomination1.jsp">My Nominations</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="mycancnomination.jsp">My Cancelled Nominations</a>
				<%if("30036060".equals(login1) || "31926330".equals(login1)){%>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="reportFit.jsp">Hum Fit toh HP Fit</a>
					
				<%}%>
				</div>
			</li>
			<%/* %>
			<li class="nav-item">
				<a class="nav-link" href="https://team.hpcl.in/sites/NIGall/_layouts/pictlib/Menu.aspx" target="_blank">Gallery</a>
			</li>
			<%*/ %>
			<% if(isProcessAdmin   || isDefAdmin){%>
			<li class="nav-item dropdown" id="claimId2">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				Admin
				</a>
				<div class="dropdown-menu" id="custmDropdown2" aria-labelledby="navbarDropdown" style="display: none;">
				<%if(isDefAdmin){%>	
				<a class="dropdown-item" href="newEvent.jsp">Add Event</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="editExistEvt.jsp">Edit Event</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="evtPublish.jsp">Publish Pending Event</a>
				<%}%>	
				<%if(isProcessAdmin    || isDefAdmin){%>	
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="viewReports1.jsp">Eventwise Report</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="adminFeedback.jsp">Event Feedback</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" target="_blank" href="data/user_manual.pdf">User Manual</a>
							
				<%/*if("31926330".equals(login1) || "35322030".equals(login1) || "31982600".equals(login1) || "31919150".equals(login1) || "31960230".equals(login1)){%>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="adminTeamCluster.jsp">Team Formation Link</a>
		
				<%}*/%>
				<%} 
				
				/*if("31926330".equals(login1) || "31976260".equals(login1) || isTechnicalAdmin ){%>
		
				<%}if(isTechnicalAdmin ){%>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="addAdmin.jsp">Add Admin</a>
				<div class="dropdown-divider"></div>
				<a class="dropdown-item" href="homepageImg.jsp">Update Homepage Images</a>
				
				<%}*/%>	
				
				
				</div>
			</li>
			<%}%>
			<li class="nav-item">
				<a class="nav-link" href="logout.jsp">Logout &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
			</li>
		 </ul>
		 </div>
		 </nav>
		</div>

      </div>
    </div>

  </div>
</div>


</body>



<script src="js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="js/jquery-1.10.2.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
<script src="js/jquery-ui.js"></script>
<!--<script src="js/tipsy.js"></script>-->




<script type="text/javascript">
  var nav = $('.subBar');
    if (nav.length) {
        var fixmeTop = nav.offset().top -22;
        $(window).scroll(function () {
            var currentScroll = $(window).scrollTop();
            if (currentScroll >= fixmeTop) {
                $('.subBar').css({
                    position: 'fixed',
                    top: '0px',
                    left: '0',
                    width : '100%',
                    margin : '0px',
                });
            } else {
                $('.subBar').css({
                    position: 'static'
                });
            }
        });
    }
</script>

<script type="text/javascript">
  $("#font_choice").parent().removeClass("ml-auto");
</script>

<script type="text/javascript">

    $(function () {
    $("#claimId1").hover(function () {
        $("#custmDropdown1").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown1").fadeOut("slow");
    });
});
  
    $(function () {
    
    $("#claimId2").hover(function () {
        $("#custmDropdown2").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown2").fadeOut("slow");
    });
});

    $(function () {
    
    $("#claimId3").hover(function () {
        $("#custmDropdown3").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown3").fadeOut("slow");
    });
});

    $(function () {
    
    $("#claimId4").hover(function () {
        $("#custmDropdown4").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown4").fadeOut("slow");
    });
});
    $(function () {
    
    $("#claimId5").hover(function () {
        $("#custmDropdown5").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown5").fadeOut("slow");
    });
});
    $(function () {
    
    $("#claimId6").hover(function () {
        $("#custmDropdown6").fadeIn("slow");
    }).mouseleave(function () {
        $("#custmDropdown6").fadeOut("slow");
    });
});

</script>




<script>
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('.dropdown-submenu > a').forEach(function (el) {
    el.addEventListener('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      let submenu = this.nextElementSibling;
      if (submenu) submenu.classList.toggle('show');
    });
  });
});
</script>



</html>
