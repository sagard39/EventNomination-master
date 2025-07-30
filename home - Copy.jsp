<%@include file="header1.jsp" %>
<%@include file="storepath.jsp"%>

<script type="text/javascript" src='js/jssor.slider.min.js'></script>

<style>
.hitcount{
	border:1px solid black;
	border-radius: 30%;
	background:#fff;
	padding:5px 5px 5px 5px;
	color:black;
	
}

/* GLOBAL STYLES
-------------------------------------------------- */
/* Padding below the footer and lighter body text */

body {
  --padding-top: 3rem;
  padding-bottom: 3rem;
  color: #5a5a5a;
}


/* CUSTOMIZE THE CAROUSEL
-------------------------------------------------- */

/* Carousel base class */
.carousel {
  margin-bottom: 4rem;
}
/* Since positioning the image, we need to help out the caption */
.carousel-caption {
  bottom: 3rem;
  z-index: 10;
}

/* Declare heights because of positioning of img element */
.carousel-item {
  height: 32rem;
  background-color: #777;
}
.carousel-item > img {
  position: absolute;
  top: 0;
  left: 0;
  min-width: 100%;
  height: 32rem;
}


/* MARKETING CONTENT
-------------------------------------------------- */

/* Center align the text within the three columns below the carousel */
.marketing .col-lg-4 {
  margin-bottom: 1.5rem;
  text-align: center;
}
.marketing h2 {
  font-weight: 400;
}
.marketing .col-lg-4 p {
  margin-right: .75rem;
  margin-left: .75rem;
}


/* Featurettes
------------------------- */

.featurette-divider {
  margin: 5rem 0; /* Space out the Bootstrap <hr> more */
}

/* Thin out the marketing headings */
.featurette-heading {
  font-weight: 300;
  line-height: 1;
  letter-spacing: -.05rem;
}


/* RESPONSIVE CSS
-------------------------------------------------- */

@media (min-width: 40em) {
  /* Bump up size of carousel content */
  .carousel-caption p {
    margin-bottom: 1.25rem;
    font-size: 1.25rem;
    line-height: 1.4;
  }

  .featurette-heading {
    font-size: 50px;
  }
}

@media (min-width: 62em) {
  .featurette-heading {
    margin-top: 7rem;
  }
}

#footer {text-align: center; background-color: #333; color: white; padding: 10px 0;}

body{
	font-family:cambria;
}
.card-header {
    /* padding: .75rem 1.25rem; */
    margin-bottom: 0;
    background-color: rgba(0,0,0,.03);
    border-bottom: 1px solid rgba(0,0,0,.125);
    padding: 0px 0px 0px 10px;
}
</style>
<script>
$(function () {
	function fadingScroller($el) {
		$el.animate({'opacity': 0}, 1000);
		$el.hide('slow', function () {
			$el.parent().append($el);
			$el.show();
			$el.animate({'opacity': 1}, 1000);
			setTimeout(function ($el) {
				return function () {
					fadingScroller($($el.selector));
				};
			}($el), 2000);
		});
	}
	fadingScroller($('#container div:first'));
});

</script>
<script>
	$('.carousel').carousel({
	interval: 50,
	
	});
	$('.carousel').carousel({
	pause:"hover",
	
	});

</script>
<body >	
	<div style="">
<div class="container-fluid">
<div class="row" style="margin-top:10px;" >
<%
String empBasicTown="",empBasicBU="";
String empBasicInfo="select town,bu from workflow.empmaster where emp_no=?";
PreparedStatement psBasicInfo=con.prepareStatement(empBasicInfo);
psBasicInfo.setString(1,emp);
ResultSet rsBasicInfo=psBasicInfo.executeQuery();
if(rsBasicInfo.next()){
	empBasicTown=rsBasicInfo.getString("town");
	empBasicBU=rsBasicInfo.getString("bu");
}
int empAge=0;	
		String query = "select trunc((sysdate-person_dob)/365) empAge from "+tempJdep+"jdep where relation_code='SL' and  emp_no=?";
		psBasicInfo=con.prepareStatement(query);
		psBasicInfo.setString(1,emp);
		rsBasicInfo=psBasicInfo.executeQuery();
		if(rsBasicInfo.next()){
			empAge=rsBasicInfo.getInt("empAge");
		}

String qry="SELECT * FROM(SELECT  TO_CHAR(CUTOFDTE,'dd-Mon-yyyy') CUTOFDTE,EVTNME EVT,EVT_ID,EVT_DATE ,ROW_NUMBER() OVER(ORDER BY EVT_DATE DESC) R,EVTPLACE FROM  NOMINATION_ADMIN WHERE CUTOFDTE>=sysdate AND STATUS='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"') WHERE R <=8 AND (REGEXP_LIKE(EVTPLACE, TRIM('"+empBasicTown+"'), 'i') OR EVTPLACE ='ALL')  union  SELECT * FROM(SELECT  TO_CHAR(CUTOFDTE,'dd-Mon-yyyy') CUTOFDTE,EVTNME EVT,EVT_ID,EVT_DATE ,ROW_NUMBER() OVER(ORDER BY EVT_DATE DESC) R,EVTPLACE FROM  NOMINATION_ADMIN WHERE CUTOFDTE>=sysdate AND STATUS='P' and emp_age_min<='"+empAge+"' and emp_age_max>='"+empAge+"') WHERE R <=8 and (REGEXP_LIKE(EVTPLACE, TRIM('"+empBasicBU+"'), 'i'))  ";

//String qry="select * from(select  to_char(CUTOFDTE,'dd-Mon-yyyy') CUTOFDTE,evtnme evt,evt_id,evt_date ,row_number() over(order by evt_date desc) r,evtPlace from  nomination_admin where evt_date is not null and status='P') where r <7";
PreparedStatement psHome=con.prepareStatement(qry);
ResultSet rsHome=psHome.executeQuery();
String rcntEvts="";

%> 	<div class="col-sm-3">
<div class="card mb12 box-shadow border-primary">
	<div class="card-header bg-primary"><h4 class="text-white">Curent Events</h4><h6 class="text-white">(My Town/BU)</h6></div>
	<div class="card-body bg-warning">
	<marquee onmouseover="this.stop();" onmouseout="this.start();"truespeed="1" height="10" width="100%" scrolldelay="20" scrollamount="1"   direction="up" style="height: 100%; width: 100%;">
			<%while(rsHome.next()){
				String dbcutofdte=rsHome.getString("CUTOFDTE");
				SimpleDateFormat fmt = new SimpleDateFormat("dd-MMM-yyyy");
					Date currentdte =new Date();
					Date dbdate = new Date(dbcutofdte);
					//Date dbEvtDate=new Date(dbevtDate);
					String currentdteval = fmt.format(currentdte);
				%>
				<hr/>
				<% if(currentdte.before(dbdate) || currentdteval.equals(dbcutofdte) ){%>
				<sup><img src="new.gif" width="30"></sup> &nbsp;<font size="3" color="#fff">
				<%}%>
				<font size="3" color="black"><a href="mainSubmit.jsp?eventId=<%=rsHome.getString("evt_id")%>"><%=rsHome.getString("evt")%></a></font>
			<%}%>
		</marquee></div>
</div></div>
<div class="col-sm-9">
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
 <!-- <ol class="carousel-indicators">
  <%
  int cnt=0;
  PreparedStatement psHomepage=con.prepareStatement("select id,FILE_NAME,title,CAPTION from NOMINATION_GALLARY where active='Y' and type='HOME' order by id ");
  ResultSet rsHomepage=psHomepage.executeQuery();
  while(rsHomepage.next()){cnt++;%>
    <li data-target="#carouselExampleIndicators" data-slide-to="<%=rsHomepage.getString("id")%>" class="<%=cnt==1?"active":""%>"></li>
 <% }
  %>
  </ol>-->
    <div class="carousel-inner">
<%
cnt=0;

rsHomepage=psHomepage.executeQuery();
while(rsHomepage.next()){cnt++;%>
	<div class="carousel-item <%=cnt==1?"active":""%>">
	 <img src="slides/<%=rsHomepage.getString("file_name")%>" alt="slide-image">
		<div class="carousel-caption d-none d-md-block">
			<h5><%=rsHomepage.getString("title")%></h5>
			<p><%=rsHomepage.getString("caption")%></p>
		</div>
  </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
  <%}	%>
</div>
		</div>
</div>
<%
int visitCount=0;
Class.forName("oracle.jdbc.driver.OracleDriver");
Connection conCount = DriverManager.getConnection("jdbc:oracle:thin:@//oradevdb.hpcl.co.in:1551/oradevdb","workflow","workflow");

String hitQuery="update app_visit_counter set count=count+1 where id=1 and app_name='Employee Connect'";
Statement psHit=conCount.createStatement();
psHit.execute(hitQuery);
hitQuery="select count from  app_visit_counter where id=1 and app_name='Employee Connect'";
psHit=conCount.createStatement();
ResultSet rsHit=psHit.executeQuery(hitQuery);
if(rsHit.next())
	visitCount=rsHit.getInt("count");
%>
				<div class="row" align="center" style="margin-left:40%;">
				
				   <b>Visitors Count : </b>
									<%for(int i = 0; i<String.valueOf(visitCount).length() ; i++){
					int j = Character.digit(String.valueOf(visitCount).charAt(i), 10);%>
						<center><span class="hitcount"><%=j%></span></center>		
					<%}%>
				<!--</div>-->
				
				</div>

<!--<div id="footer">
<center>
<%=visitCount%>
</center>
</div>-->

</div>
</body>
<%@ include file="footer.jsp"%>