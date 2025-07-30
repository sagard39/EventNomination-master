<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.nio.channels.Channels"%>
<%@page import="java.nio.channels.WritableByteChannel"%>
<%@page import="java.nio.charset.StandardCharsets"%>

        <%!

        public String token_value = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOm51bGwsImlzcyI6InJTYUtpbk05UVBpNUc3X0toVVBweXciLCJleHAiOjIwODI2OTU0MDAsImlhdCI6MTYzNTE1ODk3OH0.hY1NlRBF718SgjGwYzRHxR3XPZFXVsyKZ5_MFkTE8uA";

        public String sendData(String para) {
        String strUrl = "";
        StringBuilder strBuf = new StringBuilder(); 
         String result="";
        HttpURLConnection conn=null;
        BufferedReader reader=null;
        System.out.println(strUrl);
        try {

            //System.setProperty("https.proxyHost", proxyHost);
            //System.setProperty("https.proxyPort", proxyPort);

               // strUrl = "https://api.zoom.us/v2/users/me/meetings";
                //strUrl = "http://podev.hpcl.co.in:51600/RESTAdapter/HR/EventNomination";
                //strUrl = "http://podev.hpcl.co.in:51600/RESTAdapter/HR/PayrollData"; ///dev
                //strUrl = "https://poqas.hpcl.co.in:56701/RESTAdapter/HR/PayrollData"; ////uat
                strUrl = "https://poprdpasvr.sapphire.hpcl.in:50701/RESTAdapter/HR/PayrollData"; ///prod

                String jsonInputString="";

                System.out.println(strUrl);

                URL url = new URL(strUrl);

                conn = (HttpURLConnection) url.openConnection();
                conn.setConnectTimeout(10000);
                conn.setReadTimeout(10000);
                conn.setDoOutput(true);
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setRequestProperty("cache-control", "no-cache");

                String user ="hr_user"; ///dev
                String password ="Welcome@123"; ///dev

                user = "hrm_user"; ///prod
                password = "HrP0usr#4wrd"; //prod

                String auth = user + ":" + password;
                byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(StandardCharsets.UTF_8));
                String authHeaderValue = "Basic " + new String(encodedAuth);
                conn.setRequestProperty("Authorization", authHeaderValue);

             
                String json = para;

System.out.println(json);
conn.setDoOutput(true);
OutputStream os = conn.getOutputStream();
            os.write(json.getBytes("UTF-8"));
            os.close();

            // read the response
            InputStream in = new BufferedInputStream(conn.getInputStream());
            result = org.apache.commons.io.IOUtils.toString(in, "UTF-8");
            System.out.println("result" +result);
            //JSONObject jsonObject = new JSONObject(result);

            if (conn.getResponseCode() != 200) {
                throw new RuntimeException("HTTP GET Request Failed with Error code : "
                              + conn.getResponseCode());
            }
            reader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));
            String output = null;  
            while ((output = reader.readLine()) != null)  
            {
                strBuf.append(output); 
            }
            System.out.println("Result: "+strBuf.toString());
            System.out.println("Result123: "+strBuf.toString());
        }catch(Exception e){  
            e.printStackTrace();   
        }
        finally {
            if(reader!=null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if(conn!=null) {
                    conn.disconnect();
            }
        }
        System.out.println("Result final: "+result);
       return result ; 
       //return output;
    }





            %>     