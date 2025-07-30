<%@ include file="header.jsp"%>
<script>
function submitFun(){
	//alert("aaa");
	if(validate()){
		document.form1.action_type.value="submt";
		document.form1.submit();
	}else{
		return false;
	}
}
function validate(){
	var xxlS=parseInt(document.getElementById("xxlSize").value);
	var xlS=parseInt(document.getElementById("xlSize").value);
	var lS=parseInt(document.getElementById("lSize").value);
	var mS=parseInt(document.getElementById("mSize").value);
	var sS=parseInt(document.getElementById("sSize").value);
	var tot=parseInt(document.getElementById("tCount").value);
	var sumAll=xxlS+xlS+lS+mS+sS;
	if(tot<0){
		if(tot<sumAll || tot>sumAll){
			alert("You have selected "+sumAll+" t-Shirts while your Entries are "+tot);
			return false;
		}
	}	
	return true;
}
</script>
<%
int tCount=0;
String xxlS="",xlS="",lS="",mS="",sS="",finalCount="";
int cntxxlS=0,cntxlS=0,cntlS=0,cntmS=0,cntsS=0;
String emp_no=(String)session.getAttribute("login");
String query="select count(child_name) cnt from nomination_dependents where emp_no=? and event_name='CSR Tata Mumbai Marathon - Chanmpions of Disability'";
PreparedStatement ps=con.prepareStatement(query);
ps.setString(1,emp_no);
ResultSet rsT=ps.executeQuery();
if(rsT.next())
	tCount=rsT.getInt("cnt");
query="select * from nomination where emp_no=? and evtnme='CSR Tata Mumbai Marathon - Chanmpions of Disability'";
ps=con.prepareStatement(query);
ps.setString(1,emp_no);
rsT=ps.executeQuery();
if(!rsT.next()){
%>
	<script>
		alert("You have not Applied for this Event");
		window.location.href="main.jsp";
	</script>
<%}
int flg1=1;
String action_type=request.getParameter("action_type");
if("submt".equals(action_type)){
	xxlS=request.getParameter("XXL");
	if(!"0".equals(xxlS))
		finalCount += ",XXL:"+xxlS;
	xlS=request.getParameter("XL");
	if(!"0".equals(xlS))
		finalCount += ",XL:"+xlS;
	lS=request.getParameter("L");
	if(!"0".equals(lS))
		finalCount += ",L:"+lS;
	mS=request.getParameter("M");
	if(!"0".equals(mS))
		finalCount += ",M:"+mS;
	sS=request.getParameter("S");
	if(!"0".equals(sS))
		finalCount += ",S:"+sS;
	
	if(!"".equals(finalCount))
		finalCount = finalCount.substring(1);
	//finalCount="XXL:"+xxlS+",XL:"+xlS+",L:"+lS+",M:"+mS+",S:"+sS;
	query="update nomination set needcycle=? where emp_no=? and evtnme='CSR Tata Mumbai Marathon - Chanmpions of Disability' ";
	ps=con.prepareStatement(query);
	ps.setString(1,finalCount);
	ps.setString(2,emp_no);
	flg1=ps.executeUpdate();
	if(flg1>0){%>
		<script>
			alert("Data Submitted ");
			window.location.href="mynomination.jsp";
		</script>
	<%}
}

%>

<div style="margin-left:20%;margin-top:2%;margin-bottom:7%;margin-right:20%;background-color:#D5DBDB">
	<form name="form1" action="" method="post">
			<centeR><strong><u>Select the Size of T-shirts</u></strong><br/><br/><br/>
			<table>
				<tr><td><span>T-Shirt Size XXL</span></td><td style="padding-left:10%">
					<select name="XXL" id="xxlSize">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				
					</select>	
				</td></tr>	
				<tr><td><span>T-Shirt Size XL</span></td><td style="padding-left:10%">
					<select name="XL" id="xlSize">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				
					</select>	
				</td></tr>	
				<tr><td><span>T-Shirt Size L</span></td><td style="padding-left:10%">
					<select name="L" id="lSize">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				
					</select>	
				</td></tr>		
				<tr><td><span>T-Shirt Size M</span></td><td style="padding-left:10%">
					<select name="M" id="mSize">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				
					</select>	
				</td></tr>		
				<tr><td><span>T-Shirt Size S</span></td><td style="padding-left:10%">
					<select name="S" id="sSize">
						<option value="0">0</option>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				
					</select>	
				</td></tr>

			</table>	<br/><br/>
			<input type="submit" name="subShirts" value="Submit" onclick="return submitFun()"/>
			<input type="hidden" name="action_type" id="action_type" value="" />
			<input type="hidden" name="tCount" id="tCount" value="<%=tCount%>" /></center>
			
 	</form>
</div>

