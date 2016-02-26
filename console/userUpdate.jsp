<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Logs"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.sqliteClient"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%
	request.setCharacterEncoding("utf-8");
	final String strToken = request.getParameter(Common.USER_TOKEN);
	final String strAppId = request.getParameter(Common.APP_ID);
	final String strUserName = request.getParameter(Common.USER_NAME);
	final String strUserPhone = request.getParameter(Common.USER_PHONE);
	final String strUserEmail = request.getParameter(Common.USER_EMAIL);
	if (!StringUtility.isValid(strToken) || !StringUtility.isValid(strAppId)) {
		response.sendRedirect("index.jsp");
		return;
	}
	Logs.showTrace("update user data: token=" + strToken + " app_id=" + strAppId + " user_name=" + strUserName
			+ " user_phone=" + strUserPhone + " user_email=" + strUserEmail);
%>

<HTML>
<HEAD>
<TITLE>SER SDK Console | User Update</TITLE>

<!-- Javascript -->
<script src="js/utility.js"></script>

</HEAD>
<BODY>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="img/loading.gif" style="width: 160px; height: 160px;" />
	</p>

	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

</BODY>
</HTML>

<%
	SerSdk serSdk = new SerSdk();
	serSdk.updateUser(strAppId, strUserName, strUserPhone, strUserEmail);
	serSdk = null;
%>
<script>
	setTimeout("formSubmit('FormAppList')", 1);
</script>