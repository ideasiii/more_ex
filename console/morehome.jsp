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
	final String uri = request.getRequestURI();
	final String pageName = uri.substring(uri.lastIndexOf("/") + 1);
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

<title>MORE HOME</title>

</head>
<body>
	<!-- Login Bar -->
	<div id="loginBar">
		<div class="pageWidth">
			<div class="pageContent">
				<h3 id="loginBarHandle">
					<%
						if (bLogined)
						{
					%>
					<label for="LoginControl"><span class="concealed" onClick="formSubmit('FormMoreLogout')" style="cursor: pointer;">登出</span></label>
					<%
						}
						else
						{
					%>
					<label for="LoginControl"><span class="concealed noOutline" style="cursor: pointer;">登入</span></label>
					<%
						}
					%>
				</h3>
			</div>
		</div>
	</div>
	<!-- /Login Bar -->
	<!-- Login Bar Content -->
	<form action="auth_member.jsp" method="post" class="xenForm" style="display: none" name="login" id="login">
		<input name="from" type="hidden" value="<%=pageName%>" />
		<div class="ctrlWrapper">
			<dl class="ctrlUnit">
				<dt>
					<label for="LoginControl">帳號</label>
				</dt>
				<dd>
					<input type="text" name="account" id="LoginControl" class="textCtrl" tabindex="101" style="height: 30px" />
				</dd>
			</dl>
			<dl class="ctrlUnit">
				<dt>
					<label for="ctrl_password">密碼</label>
				</dt>
				<dd>
					<input type="password" name="password" class="textCtrl" id="ctrl_password" tabindex="102" style="height: 30px" />
				</dd>
			</dl>
			<dl class="ctrlUnit submitUnit">
				<dt></dt>
				<dd>
					<input type="button" class="button primary" value="登入" tabindex="104" data-loginPhrase="登入" data-signupPhrase="登入" onclick="onLogin()" /> <input type="button"
						class="button primary" value="註冊" tabindex="104" data-loginPhrase="註冊" data-signupPhrase="註冊" onClick="formSubmit('FormMoreRegister')"
					/>
				</dd>
			</dl>
		</div>
	</form>
	<!-- /Login Bar Content -->

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

									<!-- MORE HOME -->
									<li class="navTab morehome selected"><span class="navLink" style="padding: 0 27px; cursor: default;">HOME</span></li>
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

					<!-- Block List -->
					<div id="blockList">
						<UL>
							<LI><IMG class="homeAD" alt="MORE SDK" src="img/banner01.jpg"> <span class="homeAdWord"> MORE SDK將多項服務與應用包裝成多個獨立的模組,透過API的呼叫即可執行多種應用與服務 </span></LI>
							<LI><span class="homeAdWordLeft" style="color: #369caa;"> MORE平台將多項服務與應用包裝成多個獨立的模組，提供給APP開發人員可以加入到自己的APP專案裡 透過API的呼叫即可執行多種應用與服務。 MORE平台提供的服務包含了：APP Event
									Tracking Service, Facebook Authentication Service Tencent QQ Authentication Service, IOT Service, Dashboard Service SER API Service…等服務。 </span><IMG class="homeAdRight"
								alt="MORE API" src="img/appmobile.jpg"
							></LI>
							<LI><IMG class="homeAD" alt="MORE MDM" src="img/mdm_ad.jpg" style="height: 400px;"> <span class="homeAdWord" style="color: #369caa;"> MORE Mobild Device
									Manager 手機群組管理應用,讓企業更靈活管理租用的終端設備</span></LI>
							<LI><IMG class="homeAD" alt="MORE TRACK" src="img/track_ad.jpg" style="height: 400px;"> <span class="homeAdWord"> MORE Tracker SDK收集終端裝置使用行為資料,透過MORE
									Dashboard了解未來商品趨勢與市場走向 </span></LI>
						</UL>
					</div>
					<!-- /Block List -->

					<div class="titleBar">

						<p id="pageDescription" class="muted baseHtml">
							<BR> <BR> MORE平台提供APP SDK, API, MDM, Dashboard…等服務。
						</p>
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

<form action="morehome.jsp" method="post" name="FormMoreLogout" id="FormMoreLogout"></form>

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

<form action="moreregister.jsp" method="post" name="FormMoreRegister" id="FormMoreRegister">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

</html>

<%
	more = null;
%>