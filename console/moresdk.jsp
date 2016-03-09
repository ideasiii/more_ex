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
	final String strShowIosSdk = request.getParameter(Common.IOS);

	ArrayList<More.SdkData> listSdk = new ArrayList<More.SdkData>();
	int nCount = more.querySdk(listSdk);
	int nshowSdkType = 0;
	if (StringUtility.isValid(strShowIosSdk) && strShowIosSdk.trim().equals(Common.IOS))
		nshowSdkType = 1;
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
	function showTab(tab)
	{
		switch (tab)
		{
		case 0:
			document.getElementById('sdk_android').style.display = "block";
			document.getElementById('sdk_ios').style.display = "none";
			break;
		case 1:
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('sdk_ios').style.display = "block";
			break;
		}
	}
</script>
<title>MORE SDK</title>

</head>
<body>
	<!-- Login Bar -->
	<div id="loginBar">
		<div class="pageWidth">
			<div class="pageContent">
				<h3 id="loginBarHandle">
					<%
						if (bLogined) {
					%>
					<label for="LoginControl"><a href="#" class="concealed noOutline" onClick="formSubmit('FormMoreSdk')">登出</a></label>
					<%
						} else {
					%>
					<label for="LoginControl"><a href="login.html" class="concealed noOutline">登入</a></label>
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
		<input name="from" type="hidden" value="moresdk.jsp" />
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
					<input type="button" class="button primary" value="登入" tabindex="104" data-loginPhrase="登入" data-signupPhrase="登入" onclick="onLogin()" /> <input type="submit"
						class="button primary" value="註冊" tabindex="104" data-loginPhrase="註冊" data-signupPhrase="註冊"
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
				<div id="navigation" class="pageWidth">
					<div class="pageContent">
						<nav>
							<div class="navTabs">
								<ul class="publicTabs">

									<!-- MORE SDK -->
									<li class="navTab templates selected"><a href="#" class="navLink">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MORE SDK</a>
										<div class="tabLinks">
											<ul class="secondaryContent blockLinksList">
												<li><a rel="nofollow" href="#" onClick="showTab(0)" id="a_android">Android</a></li>
												<li><a rel="nofollow" href="#" onClick="showTab(1)" id="a_ios">IOS</a></li>
											</ul>
										</div></li>
									<!-- /MORE SDK -->

									<!-- MORE API -->
									<li class="navTab moreapi Popup PopupControl PopupClosed"><a href="#" class="navLink" onClick="formSubmit('FormMoreApi')">MORE API</a></li>
									<!-- /MORE API -->
								</ul>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</header>
		<div id="content">
			<div class="pageWidth">
				<div class="pageContent">
					<div id="blockList">
						<!-- SDK Android List -->
						<ul id="sdk_android">
							<%
								if (0 < nCount) {
									Iterator<More.SdkData> it = null;
									it = listSdk.iterator();
									More.SdkData sdkData = null;
									while (it.hasNext()) {
										sdkData = it.next();
										if (sdkData.sdk_os.trim().equals("ios"))
											continue;

										if (!bLogined) {
											sdkData.sdk_file = "#";
										}
							%>
							<li>
								<div class="sdkBlock">
									<img src="img/androidm.png" alt="android" class="logo">
									<p class="title"><%=sdkData.sdk_name%></p>
									<HR>
									<p class="desc"><%=sdkData.sdk_desc%></p>
								</div>
								<div class="option">
									<ul>
										<li><a class="download" href="<%=sdkData.sdk_file%>">Download</a></li>
										<li><a target="_blank" class="view" href="<%=sdkData.sdk_doc%>">Document</a></li>
									</ul>
								</div>
							</li>

							<%
								}
								}
							%>
						</ul>
						<!-- /SDK Android List -->
						<!-- SDK IOS List -->
						<ul id="sdk_ios">
							<%
								if (0 < nCount) {
									Iterator<More.SdkData> it = null;
									it = listSdk.iterator();
									More.SdkData sdkData = null;
									while (it.hasNext()) {
										sdkData = it.next();
										if (sdkData.sdk_os.trim().equals("android"))
											continue;

										if (!bLogined) {
											sdkData.sdk_file = "#";
										}
							%>
							<li>
								<div class="sdkBlock">
									<img src="img/iosm.png" alt="ios" class="logo">
									<p class="title"><%=sdkData.sdk_name%></p>
									<HR>
									<p class="desc"><%=sdkData.sdk_desc%></p>
								</div>
								<div class="option">
									<ul>
										<li><a class="download" href="<%=sdkData.sdk_file%>">Download</a></li>
										<li><a target="_blank" class="view" href="<%=sdkData.sdk_doc%>">Document</a></li>
									</ul>
								</div>
							</li>

							<%
								}
								}
							%>
						</ul>
						<!-- /SDK IOS List -->
					</div>

					<div class="titleBar">
						<h1></h1>
						<p id="pageDescription" class="muted baseHtml">
							MORE平台將多項服務與應用包裝成多個獨立的模組，提供給APP開發人員可以加入到自己的APP專案裡 透過API的呼叫即可執行多種應用與服務。<br>MORE平台提供的服務包含了：APP Event Tracking Service, Facebook Authentication Service Tencent QQ
							Authentication Service, IOT Service, Dashboard Service SER API Service…等服務。
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
						<li><a href="#">Contact Us</a></li>
						<li><a href="moresdk.jsp" class="homeLink">Home</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!-- /footer -->

	<!-- Show SDK List -->
	<script>
		showTab(
	<%=nshowSdkType%>
		);
	</script>
	<!-- /Show SDK List -->
</body>

<form action="moreapi.jsp" method="post" name="FormMoreApi" id="FormMoreApi">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moresdk.jsp" method="post" name="FormMoreSdk" id="FormMoreSdk"></form>
</html>

<%
	more = null;
%>