<%@ page import="java.sql.*,java.text.*,java.io.*,javax.servlet.*,java.util.*,java.lang.String,java.util.Date,java.util.Calendar" %>
<%@ page import="java.util.regex.Pattern" %>
<% 
response.setHeader("X-Frame-Options", "SAMEORIGIN"); 
response.setHeader("X-Content-Type-Options", "nosniff"); 
response.setHeader("X-XSS-Protection", "1; mode=block"); 
response.setHeader("Content-Security-Policy", "default-src 'self'; " + "script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net https://ajax.googleapis.com; " + "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; " + "font-src 'self' https://fonts.gstatic.com; " + "img-src 'self' data:; " + "object-src 'none'; " + "frame-ancestors 'self';");
%>


<%
String referer = request.getHeader("referer");
//if (referer == null || !referer.startsWith("https://webtest.hpcl.co.in")) {
if (referer == null || !referer.contains("v31982600")) {
  response.sendError(403, "Invalid access.");
  return;
}
%>

<%
String xssPattern = "(?i)((<script.*?>.*?</script>)|javascript:|onerror=|onload=|alert\\(|document\\.|window\\.)";
//String regex = "[&$+;=<>@!*^%#\\[\\]{}|]";
String regex = "[^a-zA-Z0-9\\s@&$;.,:()_\\-\"'/]";
String overflowPattern = "^-?\\d{10,}$"; // Integer overflow
//String sqlInjectionPattern = "(?i).*(['\";]+|--|\\b(OR|AND|SELECT|INSERT|DELETE|UPDATE|DROP|EXEC|UNION|WHERE)\\b).*";
String sqlInjectionPattern = "(?i).*(['\";]+|--|\\b(SELECT|INSERT|DELETE|UPDATE|DROP|EXEC|UNION|WHERE)\\b).*";
String htmlInjectionPattern = "(?i).*\\b(img|src|href|script|iframe|frame|\\.html|\\.jsp|web\\.xml|web-inf|testfire)\\b.*";

// REQUEST PARAMETER VALIDATION
Enumeration<String> enumstringlist = request.getParameterNames();
while (enumstringlist.hasMoreElements()) {
    String rstring = (String) enumstringlist.nextElement();
    String[] paramValueList = request.getParameterValues(rstring);

    for (String paramValue : paramValueList) {
        if (Pattern.compile(xssPattern).matcher(paramValue).find() ||
            Pattern.compile(regex).matcher(paramValue).find() ||
            Pattern.compile(overflowPattern).matcher(paramValue).find() ||
            Pattern.compile(sqlInjectionPattern).matcher(paramValue).find() ||
            Pattern.compile(htmlInjectionPattern).matcher(paramValue).find()) {
            
            System.out.println("Suspicious value detected: " + paramValue);
            session.invalidate();
            response.sendRedirect("logout.jsp");
            return;
        }
    }
}

// SESSION ATTRIBUTE VALIDATION
Enumeration<String> enumstringlist1 = session.getAttributeNames();
while (enumstringlist1.hasMoreElements()) {
    String sstring = (String) enumstringlist1.nextElement();
    Object val = session.getAttribute(sstring);
    if (val == null) continue;

    String paramValue = val.toString();
	//System.out.println("hey="+sstring);
    if(sstring!=null){ sstring = sstring.trim(); }
    // Skip safe session attributes (if known)
    if (sstring.equals("seshead") || sstring.equals("seshatf") || sstring.equals("seshmh") || sstring.equals("seshsko") || sstring.contains("Answer")) continue;

    if (Pattern.compile(xssPattern).matcher(paramValue).find() ||
        Pattern.compile(regex).matcher(paramValue).find() ||
        Pattern.compile(overflowPattern).matcher(paramValue).find() ||
        Pattern.compile(sqlInjectionPattern).matcher(paramValue).find() ||
        Pattern.compile(htmlInjectionPattern).matcher(paramValue).find()) {

        System.out.println("Session Suspicious value detected: " + paramValue);
        session.invalidate();
        response.sendRedirect("logout.jsp");
        return;
    }
}
%>


<%!
boolean isValidPodportalCookie(String input) {
    // Accept only safe values (e.g., alphanumeric and specific punctuation)
    return input != null && input.matches("^[a-zA-Z0-9.,@_-]{1,100}$");
}
%>

<%
/*
String shipopValue = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("ctoken".equals(cookie.getName())) {
            String value = cookie.getValue();
            if (isValidPodportalCookie(value)) {
            	shipopValue = value;
            } else {
                response.sendError(400, "Invalid cookie");
                return;
            }
        }
    }
}*/

Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        String cName = cookie.getName();
        String cValue = cookie.getValue();

        if ("JSESSIONID".equalsIgnoreCase(cName)) {
            if (Pattern.compile(xssPattern).matcher(cValue).find() ||
                Pattern.compile(regex).matcher(cValue).find() ||
                Pattern.compile(overflowPattern).matcher(cValue).find()) {

                System.out.println("Malicious JSESSIONID detected: " + cValue);
                session.invalidate();
                response.sendRedirect("logout.jsp");
                return;
            }
        }
    }
}

%>


<%! 

public static String sanitizeLDAP(String input) {
    if (input == null) return "";
    return input.replaceAll("([\\\\*()|&=!><~])", "")  // remove special LDAP characters
                .replaceAll("[\\x00-\\x1F]", "")       // remove control characters
                .trim();
}

    public String escapeJs(String input) {
        return input == null ? "" : input.replaceAll("\"", "\\\\\"").replaceAll("'", "\\\\'");
    }
%>

<%!

public boolean escapeBoolean(boolean input) {
    return input;
}

public int escapeInteger(int input) {
    if (input < 0 || input > 9999999) {
        return 0; 
    }
    return input;
}

public double escapeDecimal(double input) {
    if (input < 0.0 || input > 9999999.99) {
        return 0.00; 
    }
    return input;
}

public Object escapeObject(Object input) {
    if (input == null) return "";

    String s = input.toString(); // Convert Object to String
    StringBuilder out = new StringBuilder(Math.max(16, s.length()));
    for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        switch (c) {
            case '<': out.append("&lt;"); break;
            case '>': out.append("&gt;"); break;
            case '&': out.append("&amp;"); break;
            case '"': out.append("&quot;"); break;
            case '\'': out.append("&#x27;"); break;
            case '/': out.append("&#x2F;"); break;
            default: out.append(c);
        }
    }
    return out.toString(); // Still returns a String, but declared as Object
}



public String escapeHtml(String s) {
    if (s == null) return "";
    StringBuilder out = new StringBuilder(Math.max(16, s.length()));
    for (int i = 0; i < s.length(); i++) {
        char c = s.charAt(i);
        switch (c) {
            case '<': out.append("&lt;"); break;
            case '>': out.append("&gt;"); break;
            case '&': out.append("&amp;"); break;
            case '"': out.append("&quot;"); break;
            case '\'': out.append("&#x27;"); break;
            case '/': out.append("&#x2F;"); break;
            default: out.append(c);
        }
    }
    return out.toString();
}



public String sanitizeInput(String input, boolean isNumeric) {
    if (input == null || input.trim().equalsIgnoreCase("null")) return isNumeric ? "0" : "";
    
    input = input.trim();
    
    if (isNumeric) {
        try {
            double amnt = Double.parseDouble(input);
            if (amnt < 0 || amnt > 9999999) throw new Exception("Invalid amount");
            return input;
        } catch (Exception e) {
            return "0";
        }
    } else {
        // Stronger sanitation for strings
        input = input.replaceAll("[<>\"'%();+&]", ""); // remove risky characters
        input = input.replaceAll("(?i)<script.*?>.*?</script.*?>", ""); // remove script tags
        input = input.replaceAll("(?i)<.*?javascript:.*?>.*?</.*?>", ""); // inline JS
        input = input.replaceAll("(?i)<style.*?>.*?</style.*?>", ""); // style tag
        input = input.replaceAll("(?i)on\\w+\\s*=\\s*['\"].*?['\"]", ""); // onload, onclick etc.
        input = input.replaceAll("(?i)data:[^\\s]*", ""); // strip base64/data URLs
        input = input.replaceAll("(?i)base64", ""); // explicit base64 check
        //input = input.replaceAll("(?i)\\b(and|or|not|last|contains|starts-with|ends-with)\\b", ""); // SQL keywords
        input = input.replaceAll("(?i)\\b(not|last|contains|starts-with|ends-with)\\b", ""); // SQL keywords
        input = input.replaceAll("(?i)<iframe.*?>.*?</iframe.*?>", ""); // removes iframe tags
        input = input.replaceAll("(?i)<.*?src=.*?>", ""); // removes src attributes with external refs
        input = input.replaceAll("(?i)<.*?>", ""); // final fallback to strip all HTML tags

        
        return input;
    }
}

%>



<%!
public boolean isValidId(String id) {
    return id != null && id.matches("^\\d{1,10}$");
}

public boolean isAlphaNumSafe(String input, int maxLength) {
    return input != null && input.length() <= maxLength && input.matches("^[a-zA-Z0-9 _\\-]+$");
}

public boolean isValidDecimal(String val) {
    return val != null && val.matches("^\\d+(\\.\\d{1,3})?$");
}

public boolean isValidDate(String val) {
    return val != null && val.matches("^\\d{2}[-/]\\d{2}[-/]\\d{4}$");
}
%>