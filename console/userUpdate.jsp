<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Logs"%>
<%@ page import="sdk.ideas.More"%>

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
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<title>MORE USER UPDATE</title>

<!-- Javascript -->
<script src="js/utility.js"></script>

</HEAD>
<BODY>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="img/map_loading.gif" style="width: 260px; height: 260px;" />
	</p>

	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

</BODY>
</HTML>

<%
	More more = new More();
	more.updateUser(strAppId, strUserName, strUserPhone, strUserEmail);
	more = null;
%>
<script>
	setTimeout("formSubmit('FormAppList')", 1);
</script>