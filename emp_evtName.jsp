<%@ include file="header1.jsp"%>

<script>
function sbmtNew(){
	if(validate()){
		document.form1.action_type.value="submit";
		document.form1.submit();
	}else{
		return false;
	}
}
function validate(){
	var countNew=document.getElementById("countNew").value;
	for(var i=1;i<=countNew;i++){
		if($("input[name='chkNew']:checked").length==0){
			alert("Please Select alteat one participant For Event");
			return false;	
		}else if($("input[id='chkNew"+i+"']:checked").length!=0){
			if($("input[name='hobbySel"+i+"']:checked").length==0){
				alert("Please Select atleast one hobby in Row No."+i);
				return false;
			}
		}	
	}
	
	return true;
}
</script>
<%
PreparedStatement psNew=null,psNewIns=null;
ResultSet rsNew=null;
int countNew=0;
String query="select * from empmaster where  emp_no=? and category ='M'  and ( bu like '48%' or bu like '47%' or bu='10103026' or bu ='10157026' ) ";
psNew=con2.prepareStatement(query);
psNew.setString(1,emp);
rsNew=psNew.executeQuery();
if(!rsNew.next()){%>
	<script>
		alert("You are not Allowed to Access this Event");
		window.location.href="home.jsp";
	</script>
<%}
query="select * from NOMINATION_cltrs where emp_no=?";
psNew=con.prepareStatement(query);
psNew.setString(1,emp);
rsNew=psNew.executeQuery();
if(rsNew.next()){%>
	<script>
		alert("You have already Submitted the Entries");
		window.location.href="myTalentNomination.jsp";
	</script>
<%}
query="select person_code,person_name,decode(gender,'M','Male','F','Female',gender) gender1,gender,DECODE(RELATION_CODE,'SL','Self','SP','Spouse','CH','Child','FA','Father','MO','Mother',RELATION_CODE) RELATION_CODE1,relation_code,TRUNC((sysdate-(PERSON_DOB))/365) AGE,to_char(PERSON_DOB,'dd-Mon-yyyy') rel_dob,contact_no from portal.jdep join empmaster using(emp_no) where emp_no=? order by person_code";
psNew=con2.prepareStatement(query);
psNew.setString(1,emp);
rsNew=psNew.executeQuery();
String []chkNme=request.getParameterValues("chkNew");
String action_type=request.getParameter("action_type");
query="insert into NOMINATION_cltrs (emp_no,updated_by,dep_code,activity,status,UPDATE_DT,modified_dt) values(?,?,?,?,?,sysdate,sysdate)";
psNewIns=con.prepareStatement(query);
if("submit".equals(action_type)){
	if(chkNme!=null){
		for(int i=0;i<chkNme.length;i++){
			if(chkNme[i]!=null){
				String val1=chkNme[i].substring(0,1);
				String dep_code=chkNme[i].substring(2,10);
				String evtString="";
				String[] evtArr=request.getParameterValues("hobbySel"+val1);
				if(evtArr !=null){
					for(int j=0;j<evtArr.length;j++){
						if(evtArr[j] !=null){
							evtString +=","+evtArr[j];
						}
					}
					evtString=evtString.substring(1);
				}
				
				psNewIns.setString(1,emp);
				psNewIns.setString(2,emp);
				psNewIns.setString(3,dep_code);
				psNewIns.setString(4,evtString);
				psNewIns.setString(5,"S");
				psNewIns.addBatch();
			}
		}
	}	
	int[] res=psNewIns.executeBatch();
	if(res.length==chkNme.length){
		con.commit();
	%>
		<script>
			alert("Data Inserted Successfully");
			window.location.href="myTalentNomination.jsp";
		</script>	
	<%}else {
		con.rollback();
	%>
		<script>
			alert("Something went Wrong");
			window.location.href="home.jsp";
		</script>
	<%}	
}
%>

<div style="margin-top:5%">
	<form method="POST" action="" name="form1" >
	<centeR><h3>MR GOT TALENT</h3></h3>
		<center><table border="1" class="listTable1" style="border-collapse:collapse;width:70%" >
			<thead>
				<tr>
					<th style="width:2%"></th>
					<th style="width:5%">&sect;</th>
					<th style="width:20%">Name</th>
					<th style="width:10%">Age</th>
					<th style="width:10%">Relation</th>
					<th style="width:10%">Gender</th>
					<th style="width:25%">Events</th>
				</tr>
			</thead>
			<tbody>
			<%while(rsNew.next()){countNew++;%>
				<tr>
					<td><%=countNew%></td>
					<td><input type="checkbox" name="chkNew" id="chkNew<%=countNew%>" value="<%=countNew%>#<%=rsNew.getString("person_code")%>"/></td>
					<td><%=rsNew.getString("person_name")%></td>
					<td><%=rsNew.getString("AGE")%></td>
					<td><%=rsNew.getString("RELATION_CODE1")%></td>
					<td><%=rsNew.getString("gender1")%></td>
					<td>
						<input type="checkbox" name="hobbySel<%=countNew%>" id="hobbySel1" class="hobbySel<%=countNew%>" value="C">&nbsp;Cultural &nbsp;&nbsp;
						<input type="checkbox" name="hobbySel<%=countNew%>" id="hobbySel2" class="hobbySel<%=countNew%>" value="Ph">&nbsp;Photography <br/>
						<input type="checkbox" name="hobbySel<%=countNew%>" id="hobbySel4" class="hobbySel<%=countNew%>" value="Ad">&nbsp;Adventure
						<input type="checkbox" name="hobbySel<%=countNew%>" id="hobbySel5" class="hobbySel<%=countNew%>" value="Pa">&nbsp;Painting <br/>
						<input type="checkbox" name="hobbySel<%=countNew%>" id="hobbySel3" class="hobbySel<%=countNew%>" value="M">&nbsp;Mindfulness (Health & Yoga) 
					</td>
				</tr>	
			<%}%>	
			</tbody>
		</table><br/>
		<input type="hidden" name="countNew" id="countNew" value="<%=countNew%>" />
		<input type="hidden" name="action_type" value="" />
		<input type="submit" name="submtNew" value="SUBMIT" onclick="return sbmtNew()">
		</center></form>
</div>