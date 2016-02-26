<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>

<%
	SerSdk serSdk = new SerSdk();
	final String strToken = request.getParameter(Common.USER_TOKEN);
	boolean bLogined = false;

	if (StringUtility.isValid(strToken)) {
		bLogined = true;
	}

	final String strHostUrl = request.getRequestURL().toString();
%>

<html lang="zh-Hant-TW">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Ideas Developer Concole ">
<meta name="author" content="EmilyChen">
<title>SER SDK Console</title>
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-theme.css" rel="stylesheet">

<!-- jQuery (Bootstrap 所有外掛均需要使用) -->
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/bootstrap.js"></script>


<!--Fonts-->
<link href='http://fonts.googleapis.com/css?family=Courgette'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css'>

<!-- Javascript -->
<script src="js/utility.js"></script>
<script src="js/signin.js"></script>
<script type="text/javascript">
	function showTab(tab) {

		switch (tab) {
		case 0:
			document.getElementById('tab_android').className = "active";
			document.getElementById('tab_ios').className = "";
			document.getElementById('sdk_android').style.display = "";
			document.getElementById('sdk_ios').style.display = "none";
			break;
		case 1:
			document.getElementById('tab_android').className = "";
			document.getElementById('tab_ios').className = "active";
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('sdk_ios').style.display = "";
			break;
		}

	}
</script>

</head>
<body>
	<!-- Header  logo mark-->
	<nav role="navigation" class="navbar navbar-fixed-top navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" data-target="#navbarCollapse"
					data-toggle="collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>

			<div id="navbarCollapse"
				class="collapse navbar-collapse text-justify">
				<a class="nav navbar-nav navbar-left" href="#"> <img
					src="img/ser_logo.png" class="img-responsive" alt="IdeadBrand"></a>

				<!-- No Login -->

				<form class="navbar-form navbar-right" role="search"
					action="index.jsp" method="post" name="FormLogin" id="FormLogin">
					<div class="form-group">
						<label for="exampleInputEmail2" class="text-muted">電子郵件</label> <input
							type="email" class="form-control input-sm"
							id="exampleInputEmail2" placeholder="account@example.com"
							name="account">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword2" class="text-muted">密碼</label> <input
							type="password" class="form-control input-sm"
							id="exampleInputPassword2" placeholder="密碼" name="password">
					</div>
					<!-- 
					<div class="checkbox text-muted input-sm">
						<label> <input type="checkbox">記住我
						</label>
					</div>
					-->
					<a href="#" class="btn btn-primary navbar-btn active" role="button"
						onclick="onLogin()">&nbsp;&nbsp;登入</a> &nbsp;<a href="login.html"
						class="btn btn-success navbar-btn" role="button">註冊</a>
				</form>
				<!-- End No Login-->
				<!-- Login navbar-->
				<ul class="nav navbar-nav navbar-right text-lg"
					style="display: none" id="header_option">
					<li class="dropdown"><a data-toggle="dropdown"
						class="dropdown-toggle" href="#">我的APP<b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu"
							aria-labelledby="dropdownMenu1">
							<li><a href="#" onClick="formSubmit('FormAppAdd')">APP新增
							</a></li>
							<li><a href="#" onClick="formSubmit('FormAppList')">APP列表</a></li>
							<li class="divider"></li>
						</ul></li>
					<li class="dropdown"><a data-toggle="dropdown"
						class="dropdown-toggle" href="#">下載SDK<b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu"
							aria-labelledby="dropdownMenu2">
							<li><a href="#" onClick="showTab(0)">Android</a></li>
							<li><a href="#" onClick="showTab(1)">IOS</a></li>
							<li class="divider"></li>
							<li><a href="about.html">關於</a></li>
						</ul></li>

					<li><a href="logout.jsp">登出</a></li>
				</ul>
				<!--End Login navbar-->
			</div>
		</div>
	</nav>

	<!-- Main Content-->
	<div class="jumbotron">
		<div id="carousel-example-generic" class="carousel slide"
			data-ride="carousel">
			<!-- Indicators -->
			<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
				<li data-target="#carousel-example-generic" data-slide-to="3"></li>
			</ol>

			<!-- Wrapper for slides -->
			<div class="carousel-inner text-muted" role="listbox">
				<div class="item active">
					<img src="img/banner01.jpg" class="container-fluid"
						alt="idexbanner">
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
							<p>包含了：APP Event Tracking Service, Facebook Authentication
								Service</p>
							<p>Tencent QQ Authentication Service, IOT Service, Dashboard
								Service</p>
							<p>SER API Service…等服務。</p>
						</div>
					</div>
				</div>

			</div>

			<!-- Controls -->
			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#carousel-example-generic"
				role="button" data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>

	<!-- SDK List -->
	<div class="jumbotron">
		<div class="container-fluid">
			<ul class="nav nav-tabs">
				<li role="presentation" class="active" id="tab_android"><a
					href="#" onClick="showTab(0)"><img src="img/androidm.png"
						alt="android">SDK for Android</a></li>
				<li role="presentation" id="tab_ios"><a href="#"
					onClick="showTab(1)"><img src="img/iosm.png" alt="android">SDK
						for IOS</a></li>
			</ul>

			<h2 class="text-center text-muted">APP SDK Download</h2>

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
							<%=sdkData.sdk_owner%><img src="img/androidm.png" alt="android">
						</h4>
						<div class="caption">
							<h3><%=sdkData.sdk_name%></h3>
							<h5><%=sdkData.sdk_desc%></h5>
							<p>
								<a href="<%=sdkData.sdk_file%>" class="btn btn-primary"
									role="button"> <span class="glyphicon glyphicon-saved"
									aria-hidden="true"></span> FILE
								</a> <a href="<%=sdkData.sdk_doc%>" class="btn btn-danger"
									role="button"> <span class="glyphicon glyphicon-save-file"
									aria-hidden="true"></span> PDF
								</a>
							</p>

							<!--RWD shareButton Made By EmilyChen Start-->
							<div class="shareButton" id="fb-root">
								<!--FacebookStart-->
								<script>
									(function(d, s, id) {
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
									<div class="fb-like" data-href="<%=strHostUrl%>"
										data-width="20" data-layout="button_count" data-action="like"
										data-show-faces="true" data-share="true"></div>
								</div>
								<!--FacebookEND-->
							</div>
							<!--RWD shareButton Made By EmilyChen END-->
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
							<%=sdkData.sdk_owner%><img src="img/iosm.png" alt="ios">
						</h4>
						<div class="caption">
							<h3><%=sdkData.sdk_name%></h3>
							<h5><%=sdkData.sdk_desc%></h5>
							<p>
								<a href="<%=sdkData.sdk_file%>" class="btn btn-primary"
									role="button"> <span class="glyphicon glyphicon-saved"
									aria-hidden="true"></span> FILE
								</a> <a href="<%=sdkData.sdk_doc%>" class="btn btn-danger"
									role="button"> <span class="glyphicon glyphicon-save-file"
									aria-hidden="true"></span> PDF
								</a>
							</p>
							<!--RWD shareButton Made By EmilyChen Start-->
							<div class="shareButton" id="fb-root">
								<!--FacebookStart-->
								<script>
									(function(d, s, id) {
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
									<div class="fb-like" data-href="<%=strHostUrl%>"
										data-width="20" data-layout="button_count" data-action="like"
										data-show-faces="true" data-share="true"></div>
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

		</div>
	</div>
	<!--End jumbotron-->


	<!-- Footer -->
	<div class="media navbar-inverse text-center">
		<h4 class="text-muted">&copy;2016 SER SDK Console</h4>
	</div>

	<%
		if (StringUtility.isValid(strToken))
		{
			out.println(
					"<script>document.getElementById('header_option').style.display = \"\";document.getElementById('FormLogin').style.display = \"none\";</script>");
		}

		serSdk = null;
	%>
	<form action="appNew.jsp" method="post" name="FormAppAdd"
		id="FormAppAdd">
		<input name="<%=Common.USER_TOKEN%>" type="hidden"
			value="<%=strToken%>" />
	</form>
	<form action="applist.jsp" method="post" name="FormAppList"
		id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden"
			value="<%=strToken%>" />
	</form>
</body>
</html>