<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="connection.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<script src="js/jquery-1.11.1.min.js" type="text/javascript"></script>
<meta http-equiv="Content-Language" content="en-us" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Cricket Coaching Camp</title>
<style type="text/css">
.style1 {
	border-collapse: collapse;
	
}
td,select,input[type="text"]{font-family:Verdana;
font-size:small;
}
th
{font-family:Verdana;
font-size:x-small;
}

.style2 {
	font-size: x-large;
	font-family: "Arial Rounded MT Bold";
}
.style3 {
	font-family: Verdana;
	font-size: medium;
	padding-bottom:40%;
	}
.style4 {
	font-family: Verdana;
}
.style5 {
	font-size: small;
}
body{
background-image:url('background.jpg');
/*opacity: 0.4;
filter: alpha(opacity=40);*/
}
.style6 {
	border-style: solid;
	border-width: 1px;
	border-collapse:collapse;
	border-color:#F2F2F2;
}
.style7 {
	border-width: 0px;
}
</style>
<script>
function validate()
{
var chek=false;
var loctn=document.forms["form1"]["loc"].value;
var checkboxes = document.getElementsByName("chk");
var coaching_cmp = document.getElementById("coaching_cmp").value;
 /*if(coaching_cmp==''){
	 alert("Please Select Coaching Camp");
	 //return false;
 }*/
for(var i=0;i<checkboxes.length;i++)
{
	var q=0;
if(checkboxes[i].checked==true)
	{
	chek=true;   
    var shirtsize = document.getElementById("shirtsize"+i).value;
	var checkboxes1 = document.getElementsByClassName('gameTypeClass'+i);
	
    if(shirtsize==''){
	 alert("Please select shirt size for row "+(i+1));
	 return false;
    }
   } 
   
}
if(chek==false)
{
alert("Select atleast one checkbox");
return false;
}
if(loctn==null || loctn=="" || loctn=="Select")
{
alert("Enter your Location");
return false;
}
return true;
}
function getSubmit(){
	if(!confirm("Are you sure,do you rally want to sumbit, No further changes will be allowed after suvbmission"))
		return false;
	else
		return true;
}
function goChange(Obj){
	var newValue=Obj.value;
	if(newValue=='Others'){
		$("#otherLocn").show();
	}else {
		$("#otherLocn").hide();
	}
}
</script>
</head>

<body>
<body>
<%
String sempno="";
/*String emp_no=request.getParameter("emp_no");
session.putValue("sempno",emp_no);
String sempno=(String)session.getAttribute("sempno");*/
sempno=(String)session.getValue("empno");
//out.println(sempno);
//sempno="31929180";
String emp_no=sempno;

%>
<form action="cricket.jsp" method="post" name="form1" onsubmit="return validate();">
<% 
//String empno="3"+sempno+"0";
String empno=sempno;

 %>
<% 
int j=0;
Statement st=con.createStatement();
PreparedStatement pmst=null;
ResultSet rs1=null;
String bu="";
String chkquery="select * from cricket_camp where emp_no=?";
//out.println(chkquery);
pmst=con.prepareStatement(chkquery);
pmst.setString(1,empno);
//pmst.setString(2,childnme);
rs1=pmst.executeQuery();
if(rs1.next()){%>
	<script>
	//alert("You have Already Submitted the Entries");
	//location.href="cricketrpt.jsp?emp_no=<%=emp_no.substring(1,7)%>";
	location.href="cricketrpt.jsp?emp_no=<%=emp_no%>";</script>
	
<%}
String query="",empn="",empnme="",budesc="",telphone="",emailid="",loc="",readonly="",camp="",COACHING_CAMP="",semp_no="",telemp="";
query="select e.emp_no,upper(e.emp_name),upper(e.budesc),j.emailid ,bu from empmaster e left outer join jde_emailid j on e.emp_no=j.emp_no where e.emp_no='"+empno+"' ";

ResultSet rs=null;

rs=st.executeQuery(query);
if(rs.next())
{
empn=rs.getString(1);
empnme=rs.getString(2);
budesc=rs.getString(3);
emailid=rs.getString(4);
bu=rs.getString(5);
}


rs=null;
semp_no=sempno.substring(1);
telemp=semp_no.substring(0,semp_no.length()-1);

String telquery="SELECT DIR_OFF_TELNO1,DIR_MOBILE FROM portal.emp_tel_dir_details WHERE dir_emp_no='"+telemp+"'";
rs=st.executeQuery(telquery);
if(rs.next())
{
telphone=rs.getString(1)+" / "+rs.getString(2);
}
rs=null;

String locquery="select * from workflow.cricket_camp where emp_no='"+empno+"'";
rs=st.executeQuery(locquery);
if(rs.next())
{
loc=rs.getString("LOCTN");
camp=rs.getString("COACHING_CAMP");if(camp==null)camp="";
if(loc==null)
{
loc="";
}
else
{
readonly="readonly";
}
}
else
{
loc="";
}
rs=null;
	
String childquery="select to_char(person_dob,'dd/MM/YYYY') as person_dob,trunc(months_between('31-MAR-22',person_dob)/12) relage,person_name from portal.jdep where emp_no='"+empno+"' and relation_code ='CH' and person_status_code ='AC' and trunc(months_between('31-MAR-22',person_dob)/12) between '3' and '19'";

//portal.jdep
rs=st.executeQuery(childquery);


%>

<div>
<div style="width:20%;float:left;overflow:hidden"><img src="erplogo.GIF" alt=""/></div>
<div style="float:left;width:55%;position:relative;overflow:hidden"><center><span class="style2"> COACHING CAMP
</span>
<br/><span class="style4"><span class="style5"><strong>May 10, 2022 – May 28, 2022(Last date for online application 04th May,2022) <br/>
<br/>
HPCL Summer Coaching Camp-Mumbai</strong>
</span></span>
<br/>
<br/>

<span class="style"><strong>Application Form
</strong></span>
</center>
</div>
<a href="logout.jsp">Logout</a> || <a href="cricketrpt.jsp?emp_no=<%=emp_no%>">Report</a> || <a href="cricket_reports.jsp" target="_blank">Overview Report</a></div>

<table style="width: 60%" cellspacing="1" class="style1" align="center">
        <tr>
		<td  colspan="3"><u></u><br/><br/></td>
	   </tr>

	<tr>
		<td style="width: 210px">EMPLOYEE&#39;S NAME</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="empname" type="text" value="<%=empnme%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	<tr>
		<td style="width: 210px">EMPLOYEE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="empnum" type="text" value="<%=empn%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	<tr>
		<td style="width: 210px" >LOCATION</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<select name="loc" style="width: 209px" onchange="return goChange(this);" />
		<!--<option value="Waltair Park" <% if("Waltair Park".equals(loc)){ out.println("selected");}%>>Waltair Park</option>
		<option value="Yarada Park" <% if("Yarada Park".equals(loc)){ out.println("selected");}%>>Yarada Park</option>-->
		
		<option value="PH" <% if("PH".equals(loc)){ out.println("selected");}%>>PH</option>
		<option value="HB" <% if("HB".equals(loc)){ out.println("selected");}%>>HB</option>
		<option value="WZ" <% if("WZ".equals(loc)){ out.println("selected");}%>>WZ</option>
		<option value="MR" <% if("MR".equals(loc)){ out.println("selected");}%>>MR</option>
		<option value="Marathon" <% if("Marathon".equals(loc)){ out.println("selected");}%>>Marathon</option>
		<option value="WZTC" <% if("WZTC".equals(loc)){ out.println("selected");}%>>WZTC</option>
		<option value="Mazgaon Terminal <% if("Mazgaon Terminal".equals(loc)){ out.println("selected");}%>">Mazgaon Terminal</option>
		<option value="Sewree Wadala Complex" <% if("Sewree Wadala Complex".equals(loc)){ out.println("selected");}%>>Sewree Wadala Complex</option>
		<option value="Mahul Terminal" <% if("Mahul Terminal".equals(loc)){ out.println("selected");}%>>Mahul Terminal</option>
		<option value="Vashi Terminal" <% if("Vashi Terminal".equals(loc)){ out.println("selected");}%>>Vashi Terminal</option>
		<option value="Others" <% if("Others".equals(loc)){ out.println("selected");}%>>Others</option>
		</select>
		<input type = "text" name="otherLocn" id="otherLocn" style="display:none;"/>
		</td>
	</tr>
	<tr style="display:none"><td style="width: 210px">COACHING CAMP</td>
	    <td style="width: 17px">:</td>
	    <td style="width: 119px">
		<select name="coaching_cmp" id="coaching_cmp" style="width: 209px">
		<option value="">Select</option>
		<option value="Table Tennis" <%if("Table Tennis".equals(camp)){ out.println("selected");} %>>Table Tennis</option>
		<option value="Cricket" <%if("Cricket".equals(camp)){ out.println("selected");} %>>Cricket</option>
		<option value="Chess" <%if("Chess".equals(camp)){ out.println("selected");} %>>Chess</option>
		<!--<option value="Badminton" <%if("Badminton".equals(camp)){ out.println("selected");} %>>Badminton</option>-->
		<option value="Football" <%if("Football".equals(camp)){ out.println("selected");} %>>Football</option>
		</select>
		</td>
	</tr>
	<tr>
		<td style="width: 210px">DEPARTMENT</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="dept" type="text" value="<%=budesc%>" style="width: 203px" readonly="readonly" /></td>
	</tr>
	<tr>
		<td style="width: 210px">TELEPHONE /MOBILE NO.</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="telp" type="text" value="<%=telphone%>" style="width: 203px" readonly="readonly" /></td>
	</tr>
	<tr>
		<td style="width: 210px">EMAIL ID</td>
		<td style="width: 17px">:</td>
		<td style="width: 119px">
		<input name="email" type="text" value="<%=emailid%>" readonly="readonly" style="width: 203px" /></td>
	</tr>
	</table>
	<br/>
	<table style="width: 72%" border="1" cellpadding="0" cellspacing="0" align="center" class="style7">
	<tr>
        <th style="width: 100px" class="style6">&nbsp;</th>
		<th style="width: 210px" class="style6">NAME OF THE CHILD</th>
		<th style="width: 136px" class="style6">DATE OF BIRTH</th>
		<th style="width: 121px" class="style6">AGE<br />
		(AS ON 31-3-2022)</th>
		<th style="width: 100px" class="style6">T-SHIRT SIZE</th>
		<th style="width: 180px;display:none;" class="style6" style="">AGE GROUP</th>
		<th style="width: 180px" class="style6">Coaching Opted for</th>
	</tr>	
	<% 
	int dbflag=0,childAgeInt=0;
	String childnme="",childb="",childage="";
	String dbage="",dbshrtsize="",dbagegrp="",dbcamp="";

	while(rs.next())
	{
	childnme=rs.getString("person_name");
	childb=rs.getString("person_dob");
	childage=rs.getString("relage");
	childAgeInt=rs.getInt("relage");

	/*pmst.setString(1,empno);
	pmst.setString(2,childnme);
	rs1=pmst.executeQuery();
	if(rs1.next())
		{
		dbflag=1;
        dbage=rs1.getString("AGE");
		dbshrtsize=rs1.getString("SHIRT_SIZE");
		dbagegrp=rs1.getString("AGE_GTP");	
		dbcamp=rs1.getString("COACHING_CAMP");	
		}*/
		if((("Tennis").equals(dbcamp)) && (("Cricket").equals(dbcamp))){
		%>
<tr>
<td style="width: 100px" class="style6"><strong>Submitted</strong></td>
<td style="width: 136px" class="style6"><%=childnme%></td>
<td style="width: 136px" class="style6"><%=childb%></td>
<td style="width: 136px" class="style6"><%=dbage%></td>
<td style="width: 136px" class="style6"><%=dbshrtsize%></td>
<td style="width: 136px" class="style6" style="display:none"><%=dbagegrp%></td>
</tr>
		<%
		}	 
		else
		{
		dbflag=0;
			%>
	<tr>
	    <td style="width: 100px" class="style6"><input type="checkbox" name="chk" id="chk" value="<%=j%>"/></td>
	    <td class="style6"><input name="chldnme" type="text" value="<%=childnme%>" readonly="readonly" style="width: 203px" /></td>
	    <td style="width: 136px" class="style6">
		<input name="chldbrth" type="text" value="<%=childb%>" readonly="readonly" style="width: 145px" /></td>
        <td style="width: 121px" class="style6">
		<input name="chldage" type="text" readonly="readonly" value="<%=childage%>" style="width: 130px" /></td>
		<td style="width: 100px" class="style6">
		<select name="shirtsize" id ="shirtsize<%=j%>" style="width: 93px">
	<option value="">Select</option>
	<option value="24">24</option>
	<option value="26">26</option>
	<option value="28">28</option>
	<option value="30">30</option>
	<option value="32">32</option>
	<option value="34">34</option>
	<option value="36">36</option>
	<option value="38">38</option>
	<option value="40">40</option>
	<option value="42">42</option>
	<option value="44">44</option>
	</select></td>
<td style="width: 180px;display:none;" class="style6" >
	<select name="agegrp" style="width: 83px">
		<% if(Integer.parseInt(childage) >= 7 && Integer.parseInt(childage) < 9 )
	{
	%>
	<option value="7 to 9" selected="selected">7 to 9</option>

	<%}
	%>
	<% if(Integer.parseInt(childage) >= 9 && Integer.parseInt(childage) < 12 )
	{
	%>
	<option value="9 to 12" selected="selected">9 to 12</option>

	<%}
	%>
  <% if(Integer.parseInt(childage) >= 12 && Integer.parseInt(childage) <= 16 )
	{
	%>
    <option value="12 to 16">12 to 19</option>
    <%}
	%>

	</select>		
			</td>
			<td>

				<!--<input type="radio" name="gameType<%=j%>" id="gameType1" class="gameTypeClass<%=j%>" value="Badminton">&nbsp;Badminton<br>-->
	
				<input type="checkbox" name="gameType<%=j%>" id="gameType2" class="gameTypeClass<%=j%>" value="Table Tenis">&nbsp;Table Tenis <br>
				<input type="checkbox" name="gameType<%=j%>" id="gameType3" class="gameTypeClass<%=j%>" value="Cricket">&nbsp;Cricket &nbsp;<BR>
		        <input type="checkbox" name="gameType<%=j%>" id="gameType4" class="gameTypeClass<%=j%>" value="Football">&nbsp;Football  &nbsp;
				<input type="checkbox" name="gameType<%=j%>" id="gameType4" class="gameTypeClass<%=j%>" value="Chess">&nbsp;Chess  &nbsp;
			</td>

	</tr>
		<% 	j++;} //else end
              } // while end
	   %>
	</table>
<br/>
<br/>
<center><input type="submit" value="Submit" name="submit1" onclick="return getSubmit();" /></center>
<%
String insquery="",chldnme2="",chldbrth2="",chldage2="",shrtsize2="",agegrp2="";
/* try{ */
if(request.getParameter("submit1")!=null)
{

String valempnme=request.getParameter("empname"); 
String valempno=request.getParameter("empnum");
String sbvalempno=valempno.substring(1,7);
//String sbvalempno=valempno.substring(1,7);
String valloc=request.getParameter("loc");
String valcmp=request.getParameter("coaching_cmp");
String valdept=request.getParameter("dept");
String valtelp=request.getParameter("telp");
String valemail=request.getParameter("email");
String valchk[]=request.getParameterValues("chk");
String valchldnme[]=request.getParameterValues("chldnme");
String valchldbrth[]=request.getParameterValues("chldbrth");
String valchldage[]=request.getParameterValues("chldage");
String valshrtsize[]=request.getParameterValues("shirtsize");
String valagegrp[]=request.getParameterValues("agegrp");
String otherLocnName=request.getParameter("otherLocn");
int len=valchk.length;
out.println("GG"+len);
int insflag=0;
String check_camp="select EMP_NO,COACHING_CAMP,CHILD_NAME from CRICKET_CAMP where EMP_NO=? and CHILD_NAME=?";
PreparedStatement ps_check=con.prepareStatement(check_camp);
ResultSet rs_check=null;

insquery="insert into CRICKET_CAMP(EMP_NO,EMP_NAME,LOCTN,COACHING_CAMP,DEPARTMENT,EMAIL,TELPHONE,CHILD_NAME,CHIL_DOB,AGE,SHIRT_SIZE,AGE_GTP,enter_Date,locn_other)values(?,	?,?,?,?,?,?,?,to_date(?,'dd-mm-YYYY'),?,?,?,sysdate,?)";
PreparedStatement ps_insrt=con.prepareStatement(insquery);

	for(int k=0;k<len;k++)
   {  
    chldnme2= valchldnme[Integer.parseInt(valchk[k])];
	
    chldbrth2= valchldbrth[Integer.parseInt(valchk[k])];
    chldage2= valchldage[Integer.parseInt(valchk[k])];
    shrtsize2= valshrtsize[Integer.parseInt(valchk[k])];
    //agegrp2= valagegrp[Integer.parseInt(valchk[k])];
	ps_check.setString(1,valempno);
    //ps_check.setString(2,valcmp);
    ps_check.setString(2,chldnme2);
    rs_check=ps_check.executeQuery(); 
	
	if(rs_check.next()){%>
<script>
   alert("Entry for <%=valcmp%> already exist for <%=chldnme2%>");	  
</script>	
<%
    }
    else{ 
	out.println(chldnme2);
     String[] chooseGame = request.getParameterValues("gameType"+Integer.parseInt(valchk[k]));
	 String gamesName="";
	 out.println("chkd cvalu"+chooseGame);
	 if(chooseGame!=null){
	 for(int q=0;q<chooseGame.length;q++){
		 gamesName+=","+chooseGame[q];
	 }
	 if(gamesName.length()!=0){
		 gamesName=gamesName.substring(1);
	 }
	 
	out.println("here "+k+"<br>");
	ps_insrt.setString(1,valempno);
	ps_insrt.setString(2,valempnme);
	ps_insrt.setString(3,valloc);
	ps_insrt.setString(4,gamesName);//valcmp
	ps_insrt.setString(5,valdept);
	ps_insrt.setString(6,valemail);
	ps_insrt.setString(7,valtelp);
	ps_insrt.setString(8,chldnme2);
	ps_insrt.setString(9,chldbrth2);
	ps_insrt.setString(10,chldage2);
	ps_insrt.setString(11,shrtsize2);
	ps_insrt.setString(12,"");	
	ps_insrt.setString(13,otherLocnName);	
    insflag=ps_insrt.executeUpdate();
	}
	}
}

if(insflag>=1)
	{
	%>
	<script>alert("Data submitted ");
	location.href="cricketrpt.jsp?emp_no=<%=emp_no%>";</script>
	<%}

} //if submit end
/* } //try end


catch(NullPointerException  ex)
{
out.println("Select Checkbox");
}
catch(Exception e)
{
out.println(e);
} */

%>

</form>
</body>

</html>
