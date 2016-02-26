<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sdk.ideas.Logs"%>

<%
	SerSdk serSdk = new SerSdk();
	final String strToken = request.getParameter(Common.USER_TOKEN);
	boolean bLogined = false;

	if (StringUtility.isValid(strToken)) {
		bLogined = true;
	}

	final String strHostUrl = request.getRequestURL().toString();
	final String strShowIosDownload = request.getParameter(Common.IOS);
	final String strSdkUrl = request.getRequestURL().toString();
	final String strRegister = "register.html";
	//final String strRegister = "http://api.ser.ideas.iii.org.tw/api/register";
%>

<html lang="zh-Hant-TW">
<head>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="SER SDK主要能提供App開發者能更快速與簡潔的開發App程式，App開發人員只要將SER SDK加入到自己的App專案裡，透過API的呼叫即可執行SER SDK提供的服務">
<meta name="author" content="SER">
<title>MORE</title>
<!-- You can use open graph tags to customize link previews.
    Learn more: https://developers.facebook.com/docs/sharing/webmasters -->
<meta property="og:url" content="<%=strHostUrl%>" />
<meta property="og:type" content="website" />
<meta property="og:title" content="SER SDK Console" />
<meta property="og:description" content="SER SDK主要能提供App開發者能更快速與簡潔的開發App程式，App開發人員只要將SER SDK加入到自己的App專案裡，透過API的呼叫即可執行SER SDK提供的服務" />
<meta property="og:image" content="http://54.199.198.94:8080/IdeasDeveloperConsole/SerSdk/img/ser_logo.png" />

<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-theme.css" rel="stylesheet">

<!-- jQuery (Bootstrap 所有外掛均需要使用) -->
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/bootstrap.js"></script>


<!--Fonts-->
<link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>

<!-- Javascript -->
<script src="js/utility.js"></script>
<script src="js/signin.js"></script>
<script type="text/javascript">
	function showTab(tab)
	{

		switch (tab)
		{
		case 0:
			document.getElementById('tab_api').className = "";
			document.getElementById('tab_android').className = "active";
			document.getElementById('tab_ios').className = "";
			document.getElementById('sdk_android').style.display = "";
			document.getElementById('sdk_ios').style.display = "none";
			document.getElementById('more_api').style.display = "none";
			document.getElementById("type_download").innerHTML = 'Android SDK List';
			break;
		case 1:
			document.getElementById('tab_api').className = "";
			document.getElementById('tab_android').className = "";
			document.getElementById('tab_ios').className = "active";
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('more_api').style.display = "none";
			document.getElementById('sdk_ios').style.display = "";
			document.getElementById("type_download").innerHTML = 'IOS SDK List';
			break;
		case 2:
			document.getElementById('tab_api').className = "active";
			document.getElementById('tab_android').className = "";
			document.getElementById('tab_ios').className = "";
			document.getElementById('more_api').style.display = "";
			document.getElementById('sdk_ios').style.display = "none";
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById("type_download").innerHTML = 'MORE API List';
			break;
		}
	}

	var VisibleMenu = ''; // 記錄目前顯示的子選單的 ID

	// 顯示或隱藏子選單
	function switchMenu(theSubMenu)
	{
		var SubMenu = document.getElementById(theSubMenu);
		if (SubMenu.style.display == 'none')
		{ // 顯示子選單
			//SubMenu.style.minWidth = theMainMenu.clientWidth; // 讓子選單的最小寬度與主選單相同 (僅為了美觀)
			SubMenu.style.display = 'block';
			//hideMenu(); // 隱藏子選單
			//VisibleMenu = theSubMenu;
		}
		else
		{ // 隱藏子選單
			SubMenu.style.display = 'none';
			//if (theEvent != 'MouseOver' || VisibleMenu != theSubMenu)
			//{
			//	SubMenu.style.display = 'none';
			//	VisibleMenu = '';
			//}
		}
	}

	// 隱藏子選單
	function hideMenu()
	{
		if (VisibleMenu != '')
		{
			document.getElementById(VisibleMenu).style.display = 'none';
		}
		VisibleMenu = '';
	}
</script>

</head>
<body>
	<!-- Header  logo mark-->
	<nav class="navbar navbar-fixed-top navbar-blue " role="navigation" style="margin-bottom: 0">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
			</div>

			<div id="navbarCollapse" class="collapse navbar-collapse text-justify">
				<a class="nav navbar-nav navbar-left" href="#"> <img src="img/ser_logo.png" class="img-responsive" alt="IdeadBrand"></a>

				<!-- No Login -->

				<form class="navbar-form navbar-right" role="search" action="index.jsp" method="post" name="FormLogin" id="FormLogin">
					<div class="form-group">
						<label for="exampleInputEmail2" class="text-muted">電子郵件</label> <input type="email" class="form-control input-sm" id="exampleInputEmail2" placeholder="account@example.com"
							name="account"
						>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword2" class="text-muted">密碼</label> <input type="password" class="form-control input-sm" id="exampleInputPassword2" placeholder="密碼"
							name="password"
						>
					</div>
					<a href="#" class="btn btn-primary navbar-btn active" role="button" onclick="onLogin()">&nbsp;&nbsp;登入</a> &nbsp;<a href="#" onClick="formSubmit('FormRegister')"
						class="btn btn-success navbar-btn" role="button"
					>註冊</a>
				</form>
				<!-- End No Login-->
				<!-- Login navbar-->
				<ul class="nav navbar-nav navbar-right text-lg" style="display: none" id="header_option">
					<li class="dropdown"><a data-toggle="dropdown" class="text-muted" href="#"><B>我的APP</B><b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="#" onClick="formSubmit('FormAppAdd')">APP新增 </a></li>
							<li><a href="#" onClick="formSubmit('FormAppList')">APP列表</a></li>
							<li class="divider"></li>
						</ul></li>

					<li><a href="logout.jsp" class="text-muted"><B>登出</B></a></li>
				</ul>
				<!--End Login navbar-->
			</div>
		</div>
	</nav>

	<!-- Main Content-->
	<div class="jumbotron">
		<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
				<li data-target="#carousel-example-generic" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner text-muted" role="listbox">
				<div class="item active">
					<img src="img/banner01.jpg" class="container-fluid" alt="idexbanner">
					<div class="carousel-caption">
						<div>
							<h2>SER SDK Console</h2>
							<p>將多項服務與應用包裝成多個獨立的模組</p>
						</div>
					</div>
				</div>
				<div class="item">
					<img src="img/banner02.jpg" class="container-fluid" alt="android">
					<div class="carousel-caption">
						<div class="text-right">
							<h2>SER SDK Console</h2>
							<p>提供更快速與簡潔的開發模組給</p>
							<h3>Smart Mobile Device</h3>
						</div>
					</div>
				</div>
				<div class="item">
					<img src="img/banner03.jpg" class="container-fluid" alt="ios">
					<div class="carousel-caption">
						<div class="text-left text-warning">
							<h2>SER SDK</h2>
							<p>提供給APP開發人員可以加入到自己的APP專案裡</p>
							<p>透過API的呼叫即可執行多種應用與服務.</p>
						</div>
					</div>
				</div>
				<div class="item">
					<img src="img/banner04.jpg" class="container-fluid" alt="ios">
					<div class="carousel-caption">
						<div class="text-right">
							<h3>SER SDK Console</h3>
							<p>包含了：APP Event Tracking Service, Facebook Authentication Service</p>
							<p>Tencent QQ Authentication Service, IOT Service, Dashboard Service</p>
							<p>SER API Service…等服務。</p>
						</div>
					</div>
				</div>

			</div>

			<!-- Controls -->
			<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev"> <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next"> <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>

	<!-- SDK List -->
	<div class="jumbotron">
		<div class="container-fluid">
			<ul class="nav nav-tabs">
				<li role="presentation" class="active" id="tab_android"><a href="#" onClick="showTab(0)"><img src="img/androidm.png" alt="android" width="40" height="40">&nbsp;SDK
						for Android</a></li>
				<li role="presentation" id="tab_ios"><a href="#" onClick="showTab(1)"><img src="img/iosm.png" alt="android" width="40" height="40">&nbsp;SDK for IOS</a></li>
				<li role="presentation" id="tab_api"><a href="#" onClick="showTab(2)"><img src="img/icon-api.png" alt="api" width="40" height="40">&nbsp;MORE API</a></li>
			</ul>
			<p id="type_download" class="text-center text-muted" style="text-align: center;">Android SDK List</p>

			<%
				ArrayList<SerSdk.SdkData> listSdk = new ArrayList<SerSdk.SdkData>();
				int nCount = serSdk.querySdk(listSdk);
			%>

			<div class="row" id="sdk_android">
				<%
					if (0 < nCount) {
						Iterator<SerSdk.SdkData> it = null;
						it = listSdk.iterator();
						SerSdk.SdkData sdkData = null;
						while (it.hasNext()) {
							sdkData = it.next();
							if (sdkData.sdk_os.trim().equals("ios"))
								continue;

							if (!bLogined) {
								sdkData.sdk_file = "#";
							}
				%>
				<div class="col-sm-6 col-md-4">
					<div class="thumbnail">
						<h4>
							<%=sdkData.sdk_owner%>&nbsp;<img src="img/androidm.png" alt="android" width="40" height="40">
						</h4>
						<div class="caption">
							<h3><%=sdkData.sdk_name%></h3>
							<h5><%=sdkData.sdk_desc%></h5>
							<p>
								<a href="<%=sdkData.sdk_file%>" class="btn btn-primary" role="button"> <span class="glyphicon glyphicon-saved" aria-hidden="true"></span> FILE
								</a> <a href="<%=sdkData.sdk_doc%>" class="btn btn-danger" role="button"> <span class="glyphicon glyphicon-save-file" aria-hidden="true"></span> PDF
								</a>
							</p>

							<!-- Facebook like -->
							<div class="shareButton" id="fb-root">
								<script>
									(function(d, s, id)
									{
										var js, fjs = d.getElementsByTagName(s)[0];
										if (d.getElementById(id))
											return;
										js = d.createElement(s);
										js.id = id;
										js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v2.5";
										fjs.parentNode.insertBefore(js, fjs);
									}(document, 'script', 'facebook-jssdk'));
								</script>
								<div class="allShareBtn shareFacebook">
									<div class="fb-like" data-href="<%=strHostUrl%>" data-width="20" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
								</div>
							</div>
							<!--Facebook like END-->
						</div>
					</div>
					<!--End thumbnail-->
				</div>
				<%
					} // while
					}
				%>

			</div>
			<!--End android row-->

			<!-- IOS row -->
			<div class="row" id="sdk_ios" style="display: none;">
				<%
					if (0 < nCount) {
						Iterator<SerSdk.SdkData> it = null;
						it = listSdk.iterator();
						SerSdk.SdkData sdkData = null;
						while (it.hasNext()) {
							sdkData = it.next();
							if (sdkData.sdk_os.trim().equals("android"))
								continue;

							if (!bLogined) {
								sdkData.sdk_file = "#";
							}
				%>
				<div class="col-sm-6 col-md-4">
					<div class="thumbnail">
						<h4>
							<%=sdkData.sdk_owner%>&nbsp;<img src="img/iosm.png" alt="ios" width="40" height="40">
						</h4>
						<div class="caption">
							<h3><%=sdkData.sdk_name%></h3>
							<h5><%=sdkData.sdk_desc%></h5>
							<p>
								<a href="<%=sdkData.sdk_file%>" class="btn btn-primary" role="button"> <span class="glyphicon glyphicon-saved" aria-hidden="true"></span> FILE
								</a> <a href="<%=sdkData.sdk_doc%>" class="btn btn-danger" role="button"> <span class="glyphicon glyphicon-save-file" aria-hidden="true"></span> PDF
								</a>
							</p>
							<!--RWD shareButton Made By EmilyChen Start-->
							<div class="shareButton" id="fb-root">
								<!--FacebookStart-->
								<script>
									(function(d, s, id)
									{
										var js, fjs = d.getElementsByTagName(s)[0];
										if (d.getElementById(id))
											return;
										js = d.createElement(s);
										js.id = id;
										js.src = "//connect.facebook.net/zh_TW/sdk.js#xfbml=1&version=v2.5";
										fjs.parentNode.insertBefore(js, fjs);
									}(document, 'script', 'facebook-jssdk'));
								</script>
								<div class="allShareBtn shareFacebook">
									<div class="fb-like" data-href="<%=strHostUrl%>" data-width="20" data-layout="button_count" data-action="like" data-show-faces="true" data-share="true"></div>
								</div>
								<!--FacebookEND-->
							</div>
							<!--RWD shareButton Made By EmilyChen END-->
						</div>
					</div>
					<!--End thumbnail-->
				</div>
				<%
					}
					}
				%>
			</div>
			<!-- End IOS row -->
			<!-- API row -->
			<div class="row" id="more_api" style="display: none;">
				<div id="page-wrapper">
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-primary">
								<div class="panel-heading">AiPlug 智慧插座API</div>
								<div class="panel-body">
									<div class="row">

										<div class="col-lg-12">
											<div class="form-group">
												<img src="/IdeasDeveloperConsole/uploadfile/api/AiPlug_light-191x300.jpg" alt="" width=75 height=75>&nbsp;&nbsp;<label>FamilyAsyst AiPlug-WiFi智慧插座 可遠端遙控開關
													透過API切斷電源以避免浪費家庭電力 </label>
											</div>

											<div class="form-group">
												<div class="panel panel-primary">
													<div class="panel-heading">
														<a href="#" onClick="switchMenu('aiplug_api')" class="btn btn-success navbar-btn" role="button">POST</a>API註冊
													</div>
													<div class="panel-body" id="aiplug_api">
														<div class="row">
															<img src="/IdeasDeveloperConsole/uploadfile/api/AiPlug_light-191x300.jpg" alt="" width=75 height=75>&nbsp;&nbsp;<label>FamilyAsyst AiPlug-WiFi智慧插座
																可遠端遙控開關 透過API切斷電源以避免浪費家庭電力 </label>
														</div>
													</div>
												</div>
												<div class="form-group"></div>

											</div>
										</div>
										<!-- /.col-lg-12 (nested) -->
									</div>

									<!-- /.row -->
								</div>
								<div class="panel-footer"></div>
							</div>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /#page-wrapper -->
			</div>
			<!-- End API row -->
		</div>
	</div>
	<!--End jumbotron-->


	<!-- Footer -->
	<div class="media navbar-inverse text-center">
		<h4 class="text-muted">&copy;2016 MORE SDK Console</h4>
	</div>

	<%
		if (StringUtility.isValid(strToken))
		{
			out.println(
					"<script>document.getElementById('header_option').style.display = \"\";document.getElementById('FormLogin').style.display = \"none\";</script>");
		}

		serSdk = null;

		if (StringUtility.isValid(strShowIosDownload) && strShowIosDownload.trim().equals(Common.IOS))
		{
			out.println("<script>showTab(1);</script>");
		}
	%>
	<form action="appNew.jsp" method="post" name="FormAppAdd" id="FormAppAdd">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>
	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>
	<FORM action="<%=strRegister%>" method="post" name="FormRegister" id="FormRegister">
		<input name="sdk_url" type="hidden" value="<%=strSdkUrl%>" />
	</FORM>
</body>
</html>