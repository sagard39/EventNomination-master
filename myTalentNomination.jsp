<%@ include file="header1.jsp"%>
<!--myTalentNomination.jsp-->

<%
String query="",activities="";
PreparedStatement psNew=null;
ResultSet rsNew=null;
int countNew=0;
query="select a.dep_code,j.person_name name,activity from NOMINATION_cltrs a left join jdep j on a.emp_no=j.emp_no and a.dep_code=j.person_code where a.emp_no=?";
psNew =con.prepareStatement(query);
psNew.setString(1,emp);
Set<String> actList=new HashSet<String>();
rsNew=psNew.executeQuery();
%>
<div style="margin-top:5%">
<form name="form1" method="POST" action="">

	<center>
		<font size="4" color="blue">You have Successfully Submitted the following Entries</font><br/>
		<table border="1" class="listTable1" style="border-collapse:collapse ;width:60%">
			<tr>
				<th>&sect;</th>
				<th>Name</th>
				<th>Hobby</th>
			</tr>
	<%while(rsNew.next()){activities="";%>		
			<tr><td><%=++countNew%></td>
				<td>
					<%=rsNew.getString("name")%>
				</td>
				<td><%
				String newAct=rsNew.getString("activity");
				String [] newActArr=newAct.split(",");
				for(int i=0;i<newActArr.length;i++)
					actList.add(newActArr[i]);
				if(actList.contains("C"))
						activities +=","+"Cultural";
				if(actList.contains("Ph"))
						activities +=","+"Photography";					
				if(actList.contains("Ad"))
						activities +=","+"Adventure";					
				if(actList.contains("Pa"))
						activities +=","+"Painting";					
				if(actList.contains("M"))
						activities +=","+"Mindfulness";
				
				activities=activities.substring(1);	
				%>
					<%=activities%>
				</td>
			</tr>
	<%actList.clear();}%>		
		</table><br/>
		<button><a href="logout.jsp">OK</a></button> 
	</centeR>
</form>
</div>
