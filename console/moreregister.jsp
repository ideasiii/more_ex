<%@ page contentType="text/html; charset=utf-8" language="java" session="false"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.More"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sdk.ideas.Logs"%>
<%
	final String strToken = request.getParameter(Common.USER_TOKEN);
	More more = new More();
	boolean bLogined = false;

	if (null != strToken && !strToken.trim().equals("null") && StringUtility.isValid(strToken)) {
		bLogined = true;
	}

	final String strHostUrl = request.getRequestURL().toString();
%>
<!DOCTYPE html>
<html id="XenForo" lang="utf-8" dir="LTR" class="Public NoJs LoggedOut NoSidebar  NoResponsive">
<head>
<head>
<meta charset="utf-8">
<meta name="keywords" content="MORE">
<meta name="description" content="MORE">

<link rel="stylesheet" href="../css/style.css" />
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/xenforo.js?_v=9a20bde6"></script>
<!-- Javascript -->
<script src="js/utility.js"></script>
<script src="js/more_login.js"></script>
<script type="text/javascript">
	
</script>
<title>MORE REGISTER</title>

</head>
<body>

	<!-- Header Mover-->
	<div id="headerMover">
		<div id="headerProxy"></div>
		<header>
			<div id="header">
				<div id="tabLinksLongBar"></div>
				<div id="logoBlock">
					<div class="pageWidth">
						<div class="pageContent">
							<div id="logo">
								<img src="../image/more3.png" alt="MORE" />
							</div>
						</div>
					</div>
				</div>

				<!-- Navigation Bar -->
				<div id="navigation" class="pageWidth">
					<div class="pageContent">
						<nav>
							<div class="navTabs">
								<ul class="publicTabs">

									<!-- MORE REGISTER -->
									<li class="navTab morehome selected"><span class="navLink" style="padding: 0 18px; cursor: default;">REGISTER</span></li>
									<!-- /MORE REGISTER -->

									<!-- MORE HOME -->
									<li class="navTab morehome Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreHome')">HOME</span></li>
									<!-- /MORE HOME -->

									<!-- MORE SDK -->
									<li class="navTab moresdk Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreSdk')">MORE SDK</span></li>
									<!-- /MORE SDK -->

									<!-- MORE API -->
									<li class="navTab moreapi Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreApi')">MORE API</span></li>
									<!-- /MORE API -->

									<!-- MORE MDM -->
									<li class="navTab moremdm Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreMdm')">MORE MDM</span></li>
									<!-- /MORE MDM -->

									<!-- MORE DASHBOARD -->
									<li class="navTab moredashboard Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreDashboard')">DASHBOARD</span></li>
									<!-- /MORE DASHBOARD -->

									<!-- MORE ABOUT -->
									<li class="navTab moreabout Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreAbout')">ABOUT</span></li>
									<!-- /MORE ABOUT -->

								</ul>
							</div>
						</nav>
					</div>
				</div>
				<!-- /Navigation Bar -->
			</div>
		</header>
		<div id="content">
			<div class="pageWidth">
				<div class="pageContent">

					<!-- Content Block -->
					<div id="blockList"></div>

					<div class="titleBar">
						<!-- /Content Block -->

						<p id="pageDescription" class="muted baseHtml">MORE register</p>
					</div>
				</div>
				<!-- /pageContent -->
			</div>
			<!-- /pageWidth -->
		</div>
		<!-- /content -->
	</div>
	<!-- /Header Mover-->

	<!-- footer -->
	<footer>
		<div class="footer">
			<div class="pageWidth">
				<div class="pageContent">
					<img class="footerLogo" alt="MORE Logo" src="../image/more_logo.png">
					<ul class="footerLinks">
						<li><a target="_blank" href="morecontactus.jsp">Contact Us</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!-- /footer -->

</body>

<form action="morehome.jsp" method="post" name="FormMoreHome" id="FormMoreHome">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moresdk.jsp" method="post" name="FormMoreSdk" id="FormMoreSdk">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moreapi.jsp" method="post" name="FormMoreApi" id="FormMoreApi">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moremdm.jsp" method="post" name="FormMoreMdm" id="FormMoreMdm">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moredashboard.jsp" method="post" name="FormMoreDashboard" id="FormMoreDashboard">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moreabout.jsp" method="post" name="FormMoreAbout" id="FormMoreAbout">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

</html>

<%
	more = null;
%>