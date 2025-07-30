<%-- 
    Document   : uploadHelper
    Created on : May 17, 2025, 7:51:34?PM
    Author     : 32002470
--%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>


<%! 
private static final char[] BASE64_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".toCharArray();

public String encodeBase64(byte[] data) {
    StringBuilder sb = new StringBuilder();
    int padding = 0;

    for (int i = 0; i < data.length; i += 3) {
        int b = ((data[i] & 0xFF) << 16) & 0xFFFFFF;
        if (i + 1 < data.length) {
            b |= (data[i + 1] & 0xFF) << 8;
        } else {
            padding++;
        }
        if (i + 2 < data.length) {
            b |= (data[i + 2] & 0xFF);
        } else {
            padding++;
        }

        int c1 = (b >> 18) & 0x3F;
        int c2 = (b >> 12) & 0x3F;
        int c3 = (b >> 6) & 0x3F;
        int c4 = b & 0x3F;

        sb.append(BASE64_CHARS[c1]);
        sb.append(BASE64_CHARS[c2]);
        sb.append(padding < 2 ? BASE64_CHARS[c3] : '=');
        sb.append(padding < 1 ? BASE64_CHARS[c4] : '=');
    }

    return sb.toString();
}
%>


<%! 
public String callFileUploadAPI(FileItem fileItem, Set<String> allowedExtensions, long maxFileSize) {
    if (fileItem == null || fileItem.isFormField()) {
        return "{\"value\": false, \"message\": \"Invalid file input.\"}";
    }
    String targetURL = "https://webtest.hpcl.co.in/secure_file_validator_api/api/validate-file";
    String username = "devadmin";  // replace with actual username
    String password = "FiLe$246";  // replace with actual password

    String boundary = UUID.randomUUID().toString();
    String LINE_FEED = "\r\n";

    HttpURLConnection connection = null;
    OutputStream outputStream = null;
    PrintWriter writer = null;
    StringBuilder response = new StringBuilder();

    try {
        URL url = new URL(targetURL);
        connection = (HttpURLConnection) url.openConnection();

        connection.setUseCaches(false);
        connection.setDoOutput(true);
        connection.setDoInput(true);
        connection.setRequestMethod("POST");

        // Basic Auth Header
        //String encodedAuth = Base64.getEncoder().encodeToString((username + ":" + password).getBytes("UTF-8"));
        String encodedAuth = encodeBase64((username + ":" + password).getBytes("UTF-8"));
        connection.setRequestProperty("Authorization", "Basic " + encodedAuth);

        // Multipart Content-Type Header
        connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

        outputStream = connection.getOutputStream();
        writer = new PrintWriter(new OutputStreamWriter(outputStream, "UTF-8"), true);

        // ----------- File part -----------
        String fileName = fileItem.getName();
        String contentType = fileItem.getContentType();
        writer.append("--").append(boundary).append(LINE_FEED);
        writer.append("Content-Disposition: form-data; name=\"file\"; filename=\"").append(fileName).append("\"").append(LINE_FEED);
        writer.append("Content-Type: ").append(contentType).append(LINE_FEED);
        writer.append(LINE_FEED);
        writer.flush();

        // Write file bytes to outputStream
        InputStream inputStream = fileItem.getInputStream();
        byte[] buffer = new byte[4096];
        int bytesRead = -1;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.flush();
        inputStream.close();

        writer.append(LINE_FEED);
        writer.flush();

        // ----------- allowedExtensions part -----------
        for (String ext : allowedExtensions) {
            writer.append("--").append(boundary).append(LINE_FEED);
            writer.append("Content-Disposition: form-data; name=\"allowedExtensions\"").append(LINE_FEED);
            writer.append(LINE_FEED);
            writer.append(ext).append(LINE_FEED);
            writer.flush();
        }

        // ----------- maxFileSize part -----------
        writer.append("--").append(boundary).append(LINE_FEED);
        writer.append("Content-Disposition: form-data; name=\"maxFileSize\"").append(LINE_FEED);
        writer.append(LINE_FEED);
        writer.append(String.valueOf(maxFileSize)).append(LINE_FEED);
        writer.flush();

        // End of multipart/form-data.
        writer.append("--").append(boundary).append("--").append(LINE_FEED);
        writer.close();

        // ----------- Read response -----------
        int status = connection.getResponseCode();
        InputStream respStream = (status >= 200 && status < 300) ? connection.getInputStream() : connection.getErrorStream();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(respStream))) {
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        return "{\"value\": false, \"message\": \"Exception: " + e.getMessage() + "\"}";
    } finally {
        if (connection != null) connection.disconnect();
        if (writer != null) writer.close();
        if (outputStream != null) try { outputStream.close(); } catch(Exception ignored) {}
    }

    return response.toString();
}
%>


