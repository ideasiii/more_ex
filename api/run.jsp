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
		String httpsURL = "https://ser.kong.srm.pw/dashboard/token/client-id";

		// 抓取POST來的資料
		String strEmail = request.getParameter("email");
		strOutput += ("Email:" + strEmail + "</br>");

		String strPassword = request.getParameter("hashedpassword");
		strOutput += ("Password:" + strPassword + "</br>");

		// 產生JSON資料格式
		JSONObject jobj = new JSONObject();
		jobj.put("email", strEmail);
		jobj.put("hashedPassword", strPassword);

		HttpsClient httpsClient = new HttpsClient();
		String strResult = httpsClient.sendPost(httpsURL, jobj.toString());
		strOutput += ("post host:" + httpsURL + "</br>");
		strOutput += ("data:" + jobj.toString() + "</br>");
		strOutput += strResult;
	}

	if (null != strType && strType.trim().equals("REGISTER"))
	{
		strOutput = "Start Register</br>";
		String httpsURL = "https://ser.kong.srm.pw/dashboard/user";

		// ==== 抓取POST來的資料 ==== //
		String strEmail = request.getParameter("email");
		strOutput += ("Email:" + strEmail + "</br>");

		String strPassword = request.getParameter("password");
		strOutput += ("Password:" + strPassword + "</br>");

		String strGroupId = request.getParameter("groupId");
		strOutput += ("Group Id:" + strGroupId + "</br>");
		int nGroupId = Integer.valueOf(strGroupId);

		String strDisplayName = request.getParameter("displayName");
		strOutput += ("Display Name:" + strDisplayName + "</br>");

		String strDisplayImageBase64 = request.getParameter("displayImageBase64");
		strOutput += ("Image Base64:" + strDisplayImageBase64 + "</br>");

		String strCompany = request.getParameter("company");
		strOutput += ("Company:" + strCompany + "</br>");

		String strPhone = request.getParameter("phone");
		strOutput += ("Phone:" + strPhone + "</br>");

		String strPurpose = request.getParameter("purpose");
		strOutput += ("Purpose:" + strPurpose + "</br>");

		String strAgreementVersion = request.getParameter("agreementVersion");
		strOutput += ("Agreement Versio:" + strAgreementVersion + "</br>");

		// ==== 產生JSON資料格式 ==== //
		JSONObject jobj = new JSONObject();
		jobj.put("email", strEmail);
		jobj.put("password", strPassword);
		jobj.put("groupId", nGroupId);
		jobj.put("displayName", strDisplayName);
	
		jobj.put("company", strCompany);
		jobj.put("phone", strPhone);
		jobj.put("purpose", strPurpose);
		jobj.put("agreementVersion", strAgreementVersion);

		// ==== 傳送資料 ==== //
		HttpsClient httpsClient = new HttpsClient();
		String strResult = httpsClient.sendPost(httpsURL, jobj.toString());
		strOutput += ("post host:" + httpsURL + "</br>");
		strOutput += ("data:" + jobj.toString() + "</br>");
		strOutput += ("result: " + strResult + "</br>");
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