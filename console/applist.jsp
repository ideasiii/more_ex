<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.sqliteClient"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>

<%
	final String strToken = request.getParameter(Common.USER_TOKEN);
	if (!StringUtility.isValid(strToken))
	{
		response.sendRedirect("index.jsp");
		return;
	}
	SerSdk serSdk = new SerSdk();
%>

<html lang="zh-Hant-TW">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="SER SDK Console">
<meta name="author" content="EmilyChen">
<title>SER SDK Console ｜首頁| APP列表</title>
<!-- Bootstrap -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-social.css" rel="stylesheet">
<link href="css/bootstrap-theme.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="css/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/sb-admin-2.css" rel="stylesheet">

<!-- jQuery (Bootstrap 所有外掛均需要使用) -->
<script src="js/jquery-1.11.3.min.js"></script>
<script src="js/bootstrap.js"></script>

<!-- Custom Fonts -->
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!--Fonts-->
<link href='http://fonts.googleapis.com/css?family=Courgette' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Roboto' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>

<!-- Javascript -->
<script src="js/utility.js"></script>

</head>
<body>


	<!-- Header  logo mark-->
	<nav role="navigation" class="navbar navbar-fixed-top navbar-inverse">
		<div class="container-fluid">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
					<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
			</div>

			<div id="navbarCollapse" class="collapse navbar-collapse text-justify">
				<a class="nav navbar-nav navbar-left" href="#"> <img src="img/ser_logo.png" alt="IdeadBrand" onClick="formSubmit('FormHome');"></a>
				<ul class="nav navbar-nav navbar-right text-lg">
					<li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#">我的APP<b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="appadd.html">APP新增 </a></li>
							<li class="divider"></li>
						</ul></li>
					<li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#">下載SDK<b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu" aria-labelledby="dropdownMenu2">
							<li><a href="#">Android</a></li>
							<li><a href="#">IOS</a></li>
							<li class="divider"></li>
							<li><a href="about.html">關於</a></li>
						</ul></li>
					<li><a href="logout.jsp">登出</a></li>
				</ul>
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

	<div class="container-fluid">

		<ul class="nav nav-tabs">
			<li role="presentation" class="active" id="tab_android"><a href="#" onClick="formSubmit('FormAppAdd')"><img src="img/appadd.png" alt="android">新增APP</a></li>
		</ul>

		<h2 class="text-center text-muted">APP 列表</h2>
		<div class="row">
			<!--Start row-->

			<%
				ArrayList<SerSdk.AppData> listApp = new ArrayList<SerSdk.AppData>();
				int nCount = serSdk.queryApp(listApp, strToken);

				if (0 < nCount)
				{
					Iterator<SerSdk.AppData> it = null;
					it = listApp.iterator();
					SerSdk.AppData appData = null;
					String strAppIcon = null;
					while (it.hasNext())
					{
						appData = it.next();
						strAppIcon = request.getContextPath() + appData.app_icon;
			%>

			<div class="offset-2 col-sm-6 col-md-3">
				<div class="thumbnail">
					<!-- APP Icon and Name -->
					<h4>
						<img class="img-rounded" width=70 height=70 src="<%=strAppIcon%>" alt="appname"><%=appData.app_name%>
					</h4>
					<!-- APP ID -->
					<div class="caption">
						<h5>
							APP ID:<%=appData.app_id%></h5>
						<h5 class="text-primary">
							APP 類別:<%=appData.app_category%></h5>

						<form action="appdetail.jsp" method="post" name="<%=appData.app_id%>" id="<%=appData.app_id%>">
							<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input
								name="<%=Common.APP_ID%>" type="hidden" value="<%=appData.app_id%>"
							/> <input name="<%=Common.APP_NAME%>" type="hidden" value="<%=appData.app_name%>" /> <input name="<%=Common.APP_ICON%>" type="hidden" value="<%=appData.app_icon%>" /> <input
								name="<%=Common.APP_DESC%>" type="hidden" value="<%=appData.app_description%>"
							/> <input name="<%=Common.APP_OS%>" type="hidden" value="<%=appData.app_os%>" /> <input name="<%=Common.APP_CATEGORY%>" type="hidden" value="<%=appData.app_category%>" />
							<input name="<%=Common.USER_NAME%>" type="hidden" value="<%=appData.user_name%>" /> <input name="<%=Common.USER_EMAIL%>" type="hidden" value="<%=appData.user_email%>" /> <input
								name="<%=Common.USER_PHONE%>" type="hidden" value="<%=appData.user_phone%>"
							/>
							<h5>
								<input type="submit" class="btn btn-primary" role="button" value="詳細資料">
							</h5>
						</form>
					</div>
					<!--End thumbnail-->
				</div>
				<!--End col-sm-6 col-md-3-->
			</div>
			<%
				} // while
				}
			%>
		</div>
		<!--End row-->
	</div>
	<!-- container-fluid-->

	<!-- Footer -->
	<div class="media navbar-inverse text-center">
		<h4 class="text-muted">&copy;2016 SER SDK Console</h4>
	</div>

	<%
		serSdk = null;
	%>

	<form action="index.jsp" method="post" name="FormHome" id="FormHome">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<form action="appNew.jsp" method="post" name="FormAppAdd" id="FormAppAdd">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>
</body>
</html>