<%@include file="header.jsp"%>
<style>
.tab2{
	margin:10% 20% 2% 30%; 
	border:1px solid #2d67b2;
	border-collapse:collapse;
}
.tab2 td{
	padding:2% 0%;
}
td{
	border:1px solid #2d67b2;
}
.tab2 tr:nth-child(even){
	background:#fff;
}
.tab2 tr:nth-child(odd){
	background:#ebf1fa ;
}
</style>
<table class="tab2">
		<%
		PreparedStatement pmstsel = null;
		String temptwn = "",tckt_cnt="",dbbucd="",sbu="";
		int str=0;
//		out.println()
		String subQueryEvent1="";
		String subQueryEvent2="";
		String subQueryEvent3="";

		pmstsel = con.prepareStatement("select distinct evtplace from nomination_admin");
		rs = pmstsel.executeQuery();
		while(rs.next()){
			temptwn += ","+rs.getString(1);
		}
		temptwn = temptwn.replace(",","','");
		temptwn = temptwn.substring(3);
		pmstsel = null;
		rs = null;
		String rep = request.getParameter("rep");
		String qry = "";
		String cnt = "",colmn ="";
		String dispth = "<tr><th></th><th>Count</th></tr>";
		if("loc".equals(rep)){
			//qry = "SELECT COUNT(N.EMP_NO),E.TOWN FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO  WHERE E.TOWN IN ('"+temptwn+"') and (N.flag<>'X' or N.flag is null) GROUP BY E.TOWN order by 2";
			qry = "SELECT COUNT(N.EMP_NO),N.boardpnt,ticktscnt FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) GROUP BY N.boardpnt,ticktscnt order by 2";
			dispth = "<tr><th>Boarding Point</th><th>Count</th></tr>";
			str=1;
		}else if("dept".equals(rep)){
			qry = "SELECT COUNT(N.EMP_NO),E.budesc FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO  WHERE E.TOWN IN ('"+temptwn+"') and (N.flag<>'X' or N.flag is null) GROUP BY E.budesc order by 2";
			dispth = "<tr><th>Department</th><th>Count</th></tr>";
			str=2;
		}else if("evt".equals(rep)){
			
			qry = "SELECT COUNT(N.EMP_NO),N.EVTNME,sum(ticktscnt) as tckt_cnt FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) and N.EVTNME NOT IN('SUMMER CAMP FOOTLOOSE','SUMMER CAMP PATHFINDER')  GROUP BY N.EVTNME,needCycle order by 2";
			
			dispth = "<tr><th>Event Desc.</th><th>Count</th><th>No. Of Tickets</th></tr>";
			str=3;
		}else{
			qry = "SELECT COUNT(N.EMP_NO),N.EMP_NO FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) GROUP BY N.EMP_NO order by 2";
			dispth = "<tr><th>Emp.No</th><th>Count</th></tr>";
			str=4;
		}
		pmstsel = con.prepareStatement(qry);
		rs = pmstsel.executeQuery();
		%>
		
		<%=dispth%>
		<%
		String needCycle="";
		while(rs.next()){
			boolean cl=false;
			cnt = rs.getString(1);
			colmn = rs.getString(2);
			tckt_cnt = rs.getString(3);
					//out.println("value is"+colmn);
				
			%>
			<tr><td><%=colmn%></td><td style="text-align:center"><a href="viewreports.jsp?rep=<%=rep%>&val=<%=colmn%>"><%=cnt%></a></td><td style="text-align:center"><%=tckt_cnt%></td></tr>
		<%}
		if("evt".equals(rep)){
			String qury="select count(emp_no) as emp_no,Event_name from NOMINATION_DEPENDENTS GROUP BY EVENT_NAME";
		String clm1="";
		String clm2="";
		PreparedStatement psm1=con.prepareStatement(qury);
			ResultSet rsm1=psm1.executeQuery();
					while(rsm1.next()){
					clm1=rsm1.getString("emp_no");
					clm2=rsm1.getString("Event_name");
					
				%>	
					<tr><td style="text-align:center"><%=clm2%></td><td style="text-align:center"><a href="viewreports.jsp?rep=<%=rep%>&val=<%=clm2%>"><%=clm1%></a></td><td></td></tr>
				<%}%>
			
		
		<%}%>

</table>

		<%
		//out.println(request.getParameter("val"));
		int rowCount=0;
		String subquery1="";
		String subquery2="";
		String subquery3="";
		if("evt".equals(rep) && ("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val")))){
			subquery1=",D.CHILD_NAME,D.AGE";
			subquery2="left join NOMINATION_DEPENDENTS D ON N.emp_no=d.emp_no ";
			if("SUMMER CAMP PATHFINDER".equals(request.getParameter("val"))){
				subquery3=" and d.EVENT_NAME='SUMMER CAMP PATHFINDER' ";
			} else if("SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))){
				subquery3=" and d.EVENT_NAME='SUMMER CAMP FOOTLOOSE' ";
			}
		} if("evt".equals(rep) && ("Cycle Rally from HPNE to PH on 30th July 2017".equals(request.getParameter("val")))){
			subquery1=",count(N.NEEDCYCLE )needCycle";
			//subquery3=" group by n.needCycle ";
		}	
		String dbemp="",dbtickcnt="",dbboardpnt="",dbpay="",dbevtnme="",dbempnme="", dbemail="";
		String dbtwn="",dbbu="",dbenterdte="",dbChildName="",dbChildAge="",grd="",desig="";
		if(request.getParameter("val")!=null){
			String val = request.getParameter("val");
			if("loc".equals(rep)){
			//qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email  FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.town =? and (N.flag<>'X' or N.flag is null) order by 1";
			
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email  FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where n.BOARDPNT =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Boarding Point</th><th>Count</th></tr>";
			}else if("dept".equals(rep)){
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email  FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.budesc =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Department</th><th>Count</th></tr>";
			}else if("evt".equals(rep)){
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email, E.bu,E.grade,E.sbu_code "+subquery1+" FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO "+subquery2 +"where n.EVTNME =? and (N.flag<>'X' or N.flag is null)"+subquery3+"order by N.ENTERDTE desc";
				if("Cycle Rally from HPNE to PH on 30th July 2017".equals(val)){
					qry="SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email, E.bu,E.grade,E.sbu_code,decode(needcycle,'Y','Yes','N','No','-1','NOT SPECFIED',needcycle) FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where n.EVTNME =? and (N.flag<>'X' or N.flag is null) group by N.EMP_NO, N.TICKTSCNT, N.BOARDPNT, N.PAYMENTCNT, N.ENTERDTE, N.ENTERBY, N.MODIFYDTE, N.EVTNME,N.needcycle, E.EMP_NAME, E.town, E.budesc, E.email, E.bu, E.grade, E.sbu_code order by N.ENTERDTE desc";
				}
			dispth = "<tr><th>Event Desc.</th><th>Count</th></tr>";
			//out.println(qry);
			}else{
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc, E.email  FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.EMP_NO =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Emp.No</th><th>Count</th></tr>";
			}
			pmstsel = con.prepareStatement(qry);
			pmstsel.setString(1,val);
			rs = pmstsel.executeQuery();
			%>
			<center>
			<table id="tab1">
				<thead style="background-color:#658DB5">
					<tr>
						<th>#</th>
						<th>Event Desc.</th>
						<th>Emp No.</th>
						<th>Emp Name</th>
						<th>Email</th>
						<th>Grade</th>
						<th>SBU</th>
						<th>Business Unit</th>
						<th>Department</th>
						<th>No. of Tickets</th>
			<%if(!("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) && "evt".equals(rep) ){%>		
						<th>Payment</th>
			<%}%>						
						<th>Entered Date</th>
			<%
			if(("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) && "evt".equals(rep) ){%>
						<th>Child Name</th>
						<th>Child Age</th>
					
			<%}%>
			<%if(("Cycle Rally from HPNE to PH on 30th July 2017").equals(request.getParameter("val"))){%>
						<th>Cycle Required</th>
			<%}%>
					</tr>
			</thead>
			<% while(rs.next()){rowCount++;
				dbemp = rs.getString(1);
				dbtickcnt = rs.getString(2);
				dbboardpnt = rs.getString(3);
				dbpay = rs.getString(4);
				dbenterdte = rs.getString(5);
				dbevtnme = rs.getString(8);
				dbempnme = rs.getString(9);
				dbemail = rs.getString(12);
				dbtwn = rs.getString(10);
				dbbu = rs.getString(11);
				dbbucd = rs.getString(13);
				grd= rs.getString(14);
				sbu= rs.getString(15);
				//needCycle=rs.getInt("needcycle");
				if(("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) &&"evt".equals(rep) ){
						dbChildName=rs.getString(15);
						dbChildAge=rs.getString(16);
				}
				if("Cycle Rally from HPNE to PH on 30th July 2017".equals(request.getParameter("val"))){
					needCycle=rs.getString(16);
				}
				%>
				<tr>
					<td><%=rowCount%></td>
					<td><%=dbevtnme%></td>
					<td><%=dbemp%></td>
					<td><%=dbempnme%></td>
					<td><%=dbemail%></td>
					<td><%=grd%></td>
					<td><%=sbu%></td>
					<td><%=dbbucd%></td>
					<td><%=dbbu%></td>
					<td style="text-align:center;"><%=("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) &&"evt".equals(rep)?"1":dbtickcnt%></td>
				<%if(!("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) && "evt".equals(rep) ){%>	
					<td style="text-align:right;"><%=dbpay%></td>
				<%}%>	
					<td><%=dbenterdte%></td>
				<%if(("SUMMER CAMP PATHFINDER".equals(request.getParameter("val")) || "SUMMER CAMP FOOTLOOSE".equals(request.getParameter("val"))) && "evt".equals(rep) ){%>
					<td><%=dbChildName%></td>
					<td><%=dbChildAge%>
				
				<%}%>
				<%if("Cycle Rally from HPNE to PH on 30th July 2017".equals(request.getParameter("val"))){%>
						<td><%=needCycle%></td>
			<%}%>
				</tr>
			<%}%>
			</table>
			</center>
		<%}
		%>
</body>
<!--
SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,
E.EMP_NAME,E.town,E.budesc,D.CHILD_NAME,D.AGE  FROM NOMINATION N  LEFT JOIN 
NOMINATION_DEPENDENTS D ON N.EMP_NO=D.EMP_NO LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO 
where n.EVTNME ='SUMMER CAMP PATHFINDER' and N.flag<>'X' and (N.flag<>'X' or N.flag is null)
order by 5 asc;

-->
</html>
<%@include file="footer.jsp"%>