<%@ include file = "connection.jsp"%>
<%
		String term = request.getParameter("term");
		//term = "kumar";
		term = term.toUpperCase();
		String supp = "", qry = "",supp1;
		PreparedStatement psdet = null;
		ResultSet rsdet = null;
		//qry = "SELECT trim(ABAN8),trim(ABAN8)||'-'||trim(ABALPH) FROM PRODDTA/F0101 WHERE EXISTS (SELECT 1 FROM PRODDTA/F4301 WHERE PHAN8=ABAN8 AND PHDCTO IN ('H1','OP','OQ','OR','OU','OG','OX','ON','OW','OF','OI','O3','O5')) AND UPPER(TRIM(ABALPH)) LIKE '%"+term+"%' or ABAN8 like '%"+term+"%'";
		qry = "SELECT distinct bu t1 ,budesc t2 FROM empmaster where lower(budesc) LIKE '%"+term+"%' or initcap(budesc) like '%"+term+"%' or upper(budesc) like '%"+term+"%'";
		psdet = con.prepareStatement(qry);
		rsdet = psdet.executeQuery();
		while(rsdet.next()){
			supp=supp+",{'id':'"+rsdet.getString(1)+"','text':'"+rsdet.getString(2)+"'}";
		}
		supp = supp.substring(1);
		supp = "["+supp+"]";
		supp1 = supp.replaceAll("'","\"");
		out.print(supp1);
		out.flush();
		%>

