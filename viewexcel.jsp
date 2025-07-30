<%@include file="connection.jsp"%>
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
		 response.setContentType ("application/vnd.ms-excel");
		response.setHeader ("Content-Disposition","attachment;filename=Event Details.xls");
		
		PreparedStatement pmstsel = null;
		ResultSet rs=null;
		String temptwn = "";
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
			qry = "SELECT COUNT(N.EMP_NO),N.boardpnt FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) GROUP BY N.boardpnt order by 2";
			dispth = "<tr><th>Boarding Point</th><th>Count</th></tr>";
		}else if("dept".equals(rep)){
			qry = "SELECT COUNT(N.EMP_NO),E.budesc FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO  WHERE E.TOWN IN ('"+temptwn+"') and (N.flag<>'X' or N.flag is null) GROUP BY E.budesc order by 2";
			dispth = "<tr><th>Department</th><th>Count</th></tr>";
		}else if("evt".equals(rep)){
			qry = "SELECT COUNT(N.EMP_NO),N.EVTNME FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) GROUP BY N.EVTNME order by 2";
			dispth = "<tr><th>Event Desc.</th><th>Count</th></tr>";
		}else{
			qry = "SELECT COUNT(N.EMP_NO),N.EMP_NO FROM NOMINATION N  where (N.flag<>'X' or N.flag is null) GROUP BY N.EMP_NO order by 2";
			dispth = "<tr><th>Emp.No</th><th>Count</th></tr>";
		}
		pmstsel = con.prepareStatement(qry);
		rs = pmstsel.executeQuery();
		%>
		
		<%=dispth%>
		<%
		while(rs.next()){
			cnt = rs.getString(1);
			colmn = rs.getString(2);
			%>
			<tr><td><%=colmn%></td><td><a href="viewreports.jsp?rep=<%=rep%>&val=<%=colmn%>"><%=cnt%></a></td></tr>
		<%}
		%>

</table>

		<%
		String dbemp="",dbtickcnt="",dbboardpnt="",dbpay="",dbevtnme="",dbempnme="";
		String dbtwn="",dbbu="",dbenterdte="";
		String dbemail = "";
		if(request.getParameter("val")!=null){
			String val = request.getParameter("val");
			if("loc".equals(rep)){
			//qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc  FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.town =? and (N.flag<>'X' or N.flag is null) order by 1";
			
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc,e.email   FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where n.BOARDPNT =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Boarding Point</th><th>Count</th></tr>";
			}else if("dept".equals(rep)){
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc,e.email   FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.budesc =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Department</th><th>Count</th></tr>";
			}else if("evt".equals(rep)){
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc,e.email   FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where n.EVTNME =? and (N.flag<>'X' or N.flag is null) order by 5 asc";
			dispth = "<tr><th>Event Desc.</th><th>Count</th></tr>";
			}else{
			qry = "SELECT N.EMP_NO,N.TICKTSCNT,N.BOARDPNT,N.PAYMENTCNT,N.ENTERDTE,N.ENTERBY,N.MODIFYDTE ,N.EVTNME,E.EMP_NAME,E.town,E.budesc,e.email   FROM NOMINATION N  LEFT JOIN EMPMASTER E ON N.EMP_NO = E.EMP_NO where E.EMP_NO =? and (N.flag<>'X' or N.flag is null) order by 1";
			dispth = "<tr><th>Emp.No</th><th>Count</th></tr>";
			}
			pmstsel = con.prepareStatement(qry);
			pmstsel.setString(1,val);
		
			rs = pmstsel.executeQuery();
			%>
			<center>
			<table id="tab1"><thead style="background-color:#658DB5">
			<tr><th>Event Desc.</th><th>Emp No.</th><th>Emp Name</th><th>Department</th><th>Town</th><th>Email</th><th>No. of Tickets</th><th>Payment</th><th>Boarding Point</th><th>Entered Date</th></tr>
			</thead>
			<% while(rs.next()){
				dbemp = rs.getString(1);
				dbtickcnt = rs.getString(2);
				dbboardpnt = rs.getString(3);
				dbpay = rs.getString(4);
				dbenterdte = rs.getString(5);
				dbevtnme = rs.getString(8);
				dbempnme = rs.getString(9);
				dbtwn = rs.getString(10);
				dbbu = rs.getString(11);
				dbemail = rs.getString(12);
				%>
				<tr><td><%=dbevtnme%></td><td><%=dbemp%></td><td><%=dbempnme%></td><td><%=dbbu%></td><td><%=dbtwn%></td><td><%=dbemail%></td><td><%=dbtickcnt%></td><td style="text-align:right"><%=dbpay%></td><td><%=dbboardpnt%></td><td><%=dbenterdte%></td></tr>
			<%}%>
			</table>
			</center>
			
		<%}
		%>
		
</body>

</html>