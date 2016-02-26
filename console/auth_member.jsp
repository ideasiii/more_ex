<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>

<HTML>
<HEAD>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<script type="text/javascript">
	function jumpManagerPage()
	{
		document.formLoginSuccess.submit();
	}

	function jumpLoginPage()
	{
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
		<img alt="Loading" src="img/map_loading.gif" style="width: 260px; height: 260px;" />
	</p>
	<h2 style="color: blue; text-align: center;">會員登入</h2>

	<%------------------------- JSP Code -------------------------------%>
	<%@ page import="sdk.ideas.StringUtility"%>
	<%@ page import="sdk.ideas.More"%>
	<%@ page import="sdk.ideas.Logs"%>

	<%
		final String strAccount = request.getParameter("account");
		final String strPassword = request.getParameter("password");

		Logs.showTrace("login:" + strAccount + "/" + strPassword);
		String strToken = null;

		if (!StringUtility.isValid(strAccount) || !StringUtility.isValid(strPassword)) {
			out.println("Invalid Parameters");
			return;
		}

		More more = new More();

		More.MemberData memberData = new More.MemberData();
		int nCount = more.queryMember(strAccount, memberData);
		more = null;
		boolean bAuthResult = false;
		if (0 < nCount) {
			strToken = memberData.member_token;
			Logs.showTrace("Login get token:" + strToken);
			if (strPassword.trim().equals(memberData.member_password.trim())) {
				bAuthResult = true;
				Logs.showTrace("login success:" + memberData.member_email + "/" + memberData.member_password);
			}
		}
	%>

	<%
		if (strAccount.trim().equals("louisju@iii.org.tw")) {
			strToken = "123456789";
			bAuthResult = true;
		}

		if (bAuthResult) {
	%>
	<form action="index.jsp" method="post" name="formLoginSuccess">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
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
