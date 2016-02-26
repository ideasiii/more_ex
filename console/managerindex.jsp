<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
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
		response.sendRedirect("login.html");
		return;
	}
%>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Ideas Developer Concole ">
<meta name="author" content="EmilyChen">
<title>Ideas Developer Console ｜ 管理首頁</title>
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
<link
	href='https://fonts.googleapis.com/css?family=Oswald&subset=latin,latin-ext'
	rel='stylesheet' type='text/css'>
<style>
body {
	font-family: 'Oswald', sans-serif;
	font-size: 18px;
}
</style>

<!-- Javascript -->
<script src="js/utility.js"></script>

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
				<img src="img/logo.png" alt="IdeadBrand">
			</div>
			<!-- Collection of nav links, forms, and other content for toggling -->
			<div id="navbarCollapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><button type="button"
							class="btn btn-primary navbar-btn active"
							onClick="formSubmit('FormSdkDownload');">下載Ideas SDK</button></li>
					<li><a href="logout.jsp">登出</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Main Content-->
	<div class="jumbotron">
		<h2 class="text-center bg-primary">Ideas Developer Console</h2>
		<img src="img/login-bg.png" alt="登入管理頁面"> <img src="img/add.png"
			alt="APP ADD" onClick="formSubmit('FormAppAdd')"> 登錄新APP<BR>
		<div class="panel panel-success">

			<%
				sqliteClient sqlite = new sqliteClient();
				Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);

				// query android app	
				String strSQL = "select * from app where app_os = 'android' and user_token = '" + strToken + "'";
				ArrayList<HashMap<String, String>> listData = new ArrayList<HashMap<String, String>>();
				try
				{
					sqlite.query(con, strSQL, Common.listAppField, listData);
				}
				catch (Exception e)
				{
					out.println(e.toString());
				}

				// query IOS app
				strSQL = "select * from app where app_os = 'ios' and user_token = '" + strToken + "'";
				ArrayList<HashMap<String, String>> listIOSData = new ArrayList<HashMap<String, String>>();
				try
				{
					sqlite.query(con, strSQL, Common.listAppField, listIOSData);
				}
				catch (Exception e)
				{
					out.println(e.toString());
				}

				con.close();
				sqlite = null;

				Iterator<HashMap<String, String>> it = null;
				HashMap<String, String> mapItem;
				String strAppId = "";
				String strAppName = "";
				String strAppOs = "";
				String strAppIcon = "";
				String strAppCategory = "";

				if (0 < listData.size())
				{
			%>
			<div class="panel-heading">
				<h3 class="panel-title text-center">Android App 列表</h3>
			</div>
			<div class="panel-body">
				<%
					it = listData.iterator();
						while (it.hasNext())
						{
							mapItem = it.next();
							strAppId = mapItem.get(Common.APP_ID);
							if (mapItem.containsKey(Common.APP_NAME))
							{
								strAppName = mapItem.get(Common.APP_NAME);
							}
							if (mapItem.containsKey(Common.APP_OS))
							{
								strAppOs = mapItem.get(Common.APP_OS);
							}
							if (mapItem.containsKey(Common.APP_ICON))
							{
								strAppIcon = request.getContextPath() + mapItem.get(Common.APP_ICON);
							}
							if (mapItem.containsKey(Common.APP_CATEGORY))
							{
								strAppCategory = mapItem.get(Common.APP_CATEGORY);
							}
				%>
				<div class="media">
					<div class="media-left">
						<a href="#"> <img class="media-object" width=70 height=70
							src="<%=strAppIcon%>" alt="<%=strAppName%>">
						</a>
					</div>
					<div class="media-body">
						<h4 class="media-heading"><%=strAppName%></h4>
						APP ID:
						<%=strAppId%>
					</div>
				</div>
				<%
					} // while
					} // android list

					if (0 < listIOSData.size())
					{
				%>
			</div>
			<!-- End Android panel body-->
			<div class="panel-heading">
				<h3 class="panel-title text-center">IOS App 列表</h3>
			</div>
			<div class="panel-body">
				<%
					it = listIOSData.iterator();
						while (it.hasNext())
						{
							mapItem = it.next();
							strAppId = mapItem.get(Common.APP_ID);
							if (mapItem.containsKey(Common.APP_NAME))
							{
								strAppName = mapItem.get(Common.APP_NAME);
							}
							if (mapItem.containsKey(Common.APP_OS))
							{
								strAppOs = mapItem.get(Common.APP_OS);
							}
							if (mapItem.containsKey(Common.APP_ICON))
							{
								strAppIcon = request.getContextPath() + mapItem.get(Common.APP_ICON);
							}
							if (mapItem.containsKey(Common.APP_CATEGORY))
							{
								strAppCategory = mapItem.get(Common.APP_CATEGORY);
							}
				%>
				<div class="media">
					<div class="media-left">
						<a href="#"> <img class="media-object" width=70 height=70
							src="<%=strAppIcon%>" alt="<%=strAppName%>">
						</a>
					</div>
					<div class="media-body">
						<h4 class="media-heading"><%=strAppName%></h4>
						APP ID:
						<%=strAppId%>
					</div>
				</div>
				<%
					} // while
					} // ios list
				%>
			</div>
			<!-- End IOS panel body-->

		</div>
		<!--End panel-->

	</div>



	<!-- Footer -->
	<div class="media navbar-inverse text-center">
		<div class="media-left media-middle">
			<a href="#"> <img class="media-object" src="img/logo-black.png"
				alt="頁尾">
			</a>
		</div>

		<div class="media-body media-middle">
			<h4 class="media-heading text-warning">&copy; Ideas Developer
				Console</h4>
		</div>
	</div>

	<form action="appNew.jsp" method="post" name="FormAppAdd"
		id="FormAppAdd">
		<input name="<%=Common.USER_TOKEN%>" type="hidden"
			value="<%=strToken%>" />
	</form>

	<form action="sdkDownload.jsp" method="post" name="FormSdkDownload"
		id="FormSdkDownload">
		<input name="<%=Common.USER_TOKEN%>" type="hidden"
			value="<%=strToken%>" />
	</form>
</body>
</html>