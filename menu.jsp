<!DOCTYPE html>
<%@include file="connection.jsp" %>
<html >
  <head>
       <meta http-equiv="content-type" content="text/html;charset=utf-8" />
	   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Menu</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/styles.css">
	<Script src="js/jquery-2.2.2.min.js" type="text/javascript"></script>
		<Script src="js/index.js" type="text/javascript"></script>
		<style>
		.centered {
padding:0px;
margin:0px
}
		</style>
  </head>
  <body>

    <div class="outer-wrap">
  <header class="masthead">  
  <div >
  <!--<div class="centered"  style="border:1px solid white">-->
 <% String emp="";%>
 <img src="images/logo3.png" style="height:130px;width:100px"></img>
 	<div class="site-branding" style="float:right;margin-left:15%"><font color="white"><h4 style="padding-right:20px"></h4></font></div>
 <div class="site-branding" style="float:right">
      <h1 class="site-title" style="padding-top:20px;font-size:1 em;"></h1>
	</div>
			<!--<div class="clear"></div>
 </div>
    <div class="site-branding">
     
	</div><!-- .site-title -->
  </div><!-- .centered -->

    <div class="main-menu">
      <div class="nav-mixed menu">
        <nav id="multi-level-nav" class="multi-level-nav" role="navigation">
          <ul>
            <ul>
            <li><a href="main.jsp">Home</a></li>
            <li class="has-children">
              <a href="#">My Task<button class="dropdown-toggle" aria-expanded="true"><span class="screen-reader-text">Expand child menu</span></button></a>
              <ul class="sub-menu">
               <li><a href="mynomination.jsp">View My Nomination</li>
			   <li><a href="mycancnomination.jsp">View Cancelled Nomination</li>
              </ul>
            </li>
          	<li class="has-children">
              <a href="#">Admin<button class="dropdown-toggle" aria-expanded="false"><span class="screen-reader-text">Expand child menu</span></button></a>
              <ul class="sub-menu">
                <% if(("31919150".equals(emp)) || ("31924800".equals(emp)) || ("30074010".equals(emp))){%>
				 <li><a href="editevent.jsp">Nomination</a></li>
				<li><a href="viewreports.jsp">View All Report</a></li>
				<li><a href="viewreports.jsp?rep=loc">View Location wise Report</a></li>
				<li><a href="viewreports.jsp?rep=dept">View Department wise Report</a></li>
				<li><a href="viewreports.jsp?rep=evt">View Event wise Report</a></li>
			 <%} %>
				 </ul>
            </li>
            <li><a href="logout.jsp">Logout</a></li>
          </ul>
        </nav><!-- #multi-level-nav .multi-level-nav -->
      </div><!-- .mixed-menu -->
      </div><!-- main-menu -->
    </header><!-- .masthead -->
</div><!-- .outer-wrap -->
    <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src="js/index.js"></script>
  </body>
  <br>
</html>
