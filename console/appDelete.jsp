<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Logs"%>
<%@ page import="sdk.ideas.More"%>
<%
	final String strToken = request.getParameter(Common.USER_TOKEN);
	final String strAppId = request.getParameter(Common.APP_ID);
	if (!StringUtility.isValid(strToken) || !StringUtility.isValid(strAppId)) {
		response.sendRedirect("index.jsp");
		return;
	}

	More more = new More();
	Logs.showTrace("Delete App:" + strAppId);
%>

<HTML>
<HEAD>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<title>MORE</title>

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

	<form action="moresdk.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

</BODY>
</HTML>

<%
	more.deleteApp(strAppId);
	more = null;
%>
<script>
	formSubmit('FormAppList');
</script>