<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>

<%@page import="sdk.ideas.HttpsClient"%>
<%@ page import="org.json.JSONObject"%>

<%
	String strOutput = "";

	String strType = request.getParameter("type");
	if (null != strType && strType.trim().equals("SIGNIN"))
	{
		strOutput = "Start Sign in</br>";

		String strEmail = request.getParameter("email");
		strOutput += ("Email:" + strEmail + "</br>");

		String strPassword = request.getParameter("hashedpassword");
		strOutput += ("Password:" + strPassword + "</br>");

		JSONObject jobj = new JSONObject();
		jobj.put("email", strEmail);
		jobj.put("hashedPassword", strPassword);
		String httpsURL = "https://ser.kong.srm.pw/dashboard/token/client-id";
		//String stringData = "{\"email\":\"louisju@iii.org.tw\",\"hashedPassword\":\"Immortal_666\"}";
		HttpsClient httpsClient = new HttpsClient();
		String strResult = httpsClient.sendPost(httpsURL, jobj.toString());
		strOutput += ("post host:" + httpsURL + "</br>");
		strOutput += ("data:" + jobj.toString() + "</br>");
		strOutput += strResult;
	}
%>





<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
</head>
<body>
	<%=strOutput%>
</body>
</html>