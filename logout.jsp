<%
session.invalidate();
//response.sendRedirect("http://10.90.171.112:8080/sso/logout.jsp"); //dev
response.sendRedirect("https://commonauth.hpcl.co.in/sso/logout.jsp"); //prod
//response.sendRedirect("index.jsp");


%>
