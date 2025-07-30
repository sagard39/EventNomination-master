<%-- 
    Document   : login
    Created on : Nov 24, 2018, 11:29:28 AM
    Author     : 10141S1V
--%>
<%@ page import="java.sql.*,java.text.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
<%@ page import="java.text.ParseException,java.text.SimpleDateFormat,java.util.Locale" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>login</title>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">  
<!--        <link rel="stylesheet" href="css/styles.css">-->
        <link rel="stylesheet" type="text/css" href="css/demo.css" media="all" />
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <style>
            body{
                font-family:  verdana,helvetica; 
/*                 background: url(images/army.png) no-repeat fixed;

                -webkit-background-size: cover;

                -moz-background-size: cover;

                -o-background-size: cover;

                background-size: cover;*/
            }
           
            footer {
                height: 40px;
                bottom: 0;
                width: 100%;
                position: fixed
            }

        </style>
        <script>
            function validateyy1()
            {
                if (document.forms[0].userId.value.length <= 1)
                {
                    alert("User Id Field Is Empty.");
                    forms[0].userId.focus();
                    return false;
                }
                if (document.forms[0].pwd.value.length <= 0)
                {
                    alert("Password Field Is Empty.");
                    forms[0].pwd.focus();
                    return false;
                }


                return true;
            }
        </script>
        <style>
             h1{
                color: #fff;
                text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135;
                font: 32px 'ChunkFiveRegular';
                text-align:center;
            }
        </style>
    </head>
    <body>
        <%

			//String GLOBAL_KEY = "vQaWqSxIxYfVOx97ryxV8A==";//dev
            String GLOBAL_KEY = "VeofaIVjTVrVorLOOt/crg==";//prod
			String APPID = "APP699";
String appid =  com.toml.dp.util.AES128Bit.encrypt(APPID, GLOBAL_KEY);	
//encrypt version and time using app specific key
//String APP_KEY = "i2SXsPVRc8LbMTY8vm8ooA=="; //dev
String APP_KEY = "wy6WQfvKj1E4XGuKvwpeIw=="; //prod
DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
String reqTime  = com.toml.dp.util.AES128Bit.encrypt(dateFormat.format(Calendar.getInstance().getTime()),APP_KEY);
String version = com.toml.dp.util.AES128Bit.encrypt("1.0", APP_KEY);	

		%>
	<form name="frmleave" action="https://commonauth.hpcl.co.in/sso/auth.jsp" method="post"> <!--prod-->
              <!--<form name="frmleave" action="http://10.90.171.112:8080/sso/auth.jsp" method="post">--> <!--dev-->
                

                <input type="hidden" name="appid" value="<%=appid%>">
                <input type="hidden" name="reqTime" value="<%=reqTime%>">
				<input type="hidden" name="version" value="<%=version%>">

                <script language="javascript">
                    document.frmleave.submit();
                </script>
            </form>
    </body>
</html>
