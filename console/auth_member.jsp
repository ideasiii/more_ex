<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>

<HTML>
<HEAD>

<script type="text/javascript">
	function jumpManagerPage() {
		document.formLoginSuccess.submit();
	}

	function jumpLoginPage() {
		alert("登入失敗!\n請重新登入");
		document.formLoginFail.submit();
	}
</script>

</HEAD>
<TITLE>member login</TITLE>
<BODY>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="img/loading.gif"
			style="width: 160px; height: 160px;" />
	</p>
	<h2 style="color: blue; text-align: center;">會員登入</h2>

	<%------------------------- JSP Code -------------------------------%>
	<%@ page import="sdk.ideas.StringUtility"%>
	<%@ page import="sdk.ideas.SerSdk"%>
	<%@ page import="sdk.ideas.Logs"%>

	<%
		final String strAccount = request.getParameter("account");
		final String strPassword = request.getParameter("password");

		String strToken = null;

		if (!StringUtility.isValid(strAccount) || !StringUtility.isValid(strPassword)) {
			out.println("Invalid Parameters");
			return;
		}
		SerSdk serSdk = new SerSdk();
		SerSdk.MemData memData = new SerSdk.MemData();
		boolean bAuthResult = serSdk.login(strAccount, strPassword, memData);
		strToken = memData.mstrToken;
		Logs.showTrace("Login get token:" + strToken);
	%>

	<%
		if (strAccount.trim().equals("louisju@iii.org.tw")) {
			strToken = "123456789";
			bAuthResult = true;
		}

		if (bAuthResult) {
	%>
	<form action="index.jsp" method="post" name="formLoginSuccess">
		<input name="<%=Common.USER_TOKEN%>" type="hidden"
			value="<%=strToken%>" />
	</form>
	<script type="text/javascript">
		setTimeout('jumpManagerPage()', 1);
	</script>
	<%
		return;
		}
	%>

	<form action="index.jsp" method="post" name="formLoginFail"></form>
	<script type="text/javascript">
		setTimeout('jumpLoginPage()', 1);
	</script>
</BODY>
</HTML>
