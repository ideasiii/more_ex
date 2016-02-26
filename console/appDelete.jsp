<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Logs"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%
	final String strToken = request.getParameter(Common.USER_TOKEN);
	final String strAppId = request.getParameter(Common.APP_ID);
	if (!StringUtility.isValid(strToken) || !StringUtility.isValid(strAppId)) {
		response.sendRedirect("index.jsp");
		return;
	}

	SerSdk serSdk = new SerSdk();
	Logs.showTrace("Delete App:" + strAppId);
%>

<HTML>
<HEAD>
<TITLE>SER SDK Console | APP Delete</TITLE>

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
	serSdk.deleteApp(strAppId);
	serSdk = null;
%>
<script>
	formSubmit('FormAppList');
</script>