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
<html id="XenForo" lang="UTF-8" dir="LTR" class="Public NoJs LoggedOut NoSidebar  NoResponsive">
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
			document.getElementById('api_smart_family').style.display = "block";
			document.getElementById('api_iot').style.display = "none";
			break;
		case 1:
			document.getElementById('api_smart_family').style.display = "none";
			document.getElementById('api_iot').style.display = "block";
			break;
		}
	}
</script>
<title>MORE API</title>

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
					<label for="LoginControl"><a href="#" class="concealed noOutline" onClick="formSubmit('FormMoreApi')">登出</a></label>
					<%
						}
						else
						{
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
									<li class="navTab templates Popup PopupControl PopupClosed"><a href="#" class="navLink" onClick="formSubmit('FormMoreSdk')">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MORE
											SDK</a>
										<div class="Menu JsOnly tabMenu templatesTabLinks">
											<div class="primaryContent menuHeader"></div>
										</div></li>
									<!-- /MORE SDK -->

									<!-- MORE API -->
									<li class="navTab moreapi selected"><a href="" class="navLink">MORE API</a>
										<div class="tabLinks">
											<ul class="secondaryContent blockLinksList">
												<li><a rel="nofollow" href="#" onClick="showTab(0)" id="a_smart_family">智慧家電</a></li>
												<li><a rel="nofollow" href="#" onClick="showTab(1)" id="a_iot">物連網</a></li>
											</ul>
										</div></li>
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
						<!-- API Smart Family -->
						<ul id="api_smart_family">
							<li>
								<div class="sdkBlock">Aiplug</div>
								<div class="option">
									<ul>
										<li><a class="download" href="/download/running/" data-ga-event="click" data-ga-category="Template" data-ga-action="Download Click"
											data-ga-label="Running Website Template"
										>Download</a></li>
										<li><a target="_blank" class="view" href="/preview/running/" data-ga-event="click" data-ga-category="Template" data-ga-action="Preview Click"
											data-ga-label="Running Website Template"
										>Document</a></li>
									</ul>
								</div>
							</li>
						</ul>
						<!-- /API Smart Family -->
						<!-- API IOT -->
						<ul id="api_iot">
							<li>
								<div class="sdkBlock">IOT</div>
								<div class="option">
									<ul>
										<li><a class="download" href="/download/running/" data-ga-event="click" data-ga-category="Template" data-ga-action="Download Click"
											data-ga-label="Running Website Template"
										>Download</a></li>
										<li><a target="_blank" class="view" href="/preview/running/" data-ga-event="click" data-ga-category="Template" data-ga-action="Preview Click"
											data-ga-label="Running Website Template"
										>Document</a></li>
									</ul>
								</div>
							</li>
						</ul>
						<!-- API IOT -->
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
						<li><a href="misc/contact">Contact Us</a></li>
						<li><a href="https://freewebsitetemplates.com/" class="homeLink">Home</a></li>
						<li><a href="/#navigation" class="topLink">Top</a></li>
					</ul>
				</div>
			</div>
		</div>

	</footer>
	<!-- /footer -->

	<form action="moresdk.jsp" method="post" name="FormMoreSdk" id="FormMoreSdk">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>
	<form action="moreapi.jsp" method="post" name="FormMoreApi" id="FormMoreApi"></form>

</body>
</html>