<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page trimDirectiveWhitespaces="true"%>

<HTML>
<head>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="MORE Console">
<meta name="author" content="MORE Developer">

<title>MORE｜Member Add</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/bootstrap-theme.css" rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="css/metisMenu.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Javascript -->
<script src="js/utility.js"></script>
<script type="text/javascript">
	function hideLoading()
	{
		document.getElementById('loading').style.display = "none";
		document.getElementById('result').style.display = "";
	}
</script>
</head>
<body>
	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-blue navbar-fixed-top" role="navigation" style="margin-bottom: 0">
			<div id="navbarCollapse" class="collapse navbar-collapse text-justify">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
					</button>
					<img src="img/ser_logo.png" class="img-responsive" alt="SER SDK Console">
				</div>
				<!-- /.navbar-static-side -->
			</div>
		</nav>

		<!-- Main Content-->
		<div class="jumbotron">
			<p style="text-align: center;">&nbsp;</p>
			<p style="text-align: center;">&nbsp;</p>
			<p style="text-align: center;">&nbsp;</p>
			<p style="text-align: center;">
				<img alt="Loading" src="img/map_loading.gif" style="width: 260px; height: 260px;" id="loading" />
			</p>

			<%@ page import="java.util.Map"%>
			<%@ page import="sdk.ideas.More"%>
			<%
				request.setCharacterEncoding("UTF-8");
				session.invalidate();
				/*
						Map<String, String[]> parameters = request.getParameterMap();
						for (String parameter : parameters.keySet())
				
						{
							String strValue = new String(parameters.get(parameter)[0].getBytes("ISO-8859-1"), "UTF-8");
							out.println("KEY:" + parameter + " VALUE:" + parameters.get(parameter)[0] + "</br>");
							System.out.println("KEY:" + parameter + " VALUE:" + parameters.get(parameter)[0]);
						}
						*/

				final String strEmail = request.getParameter("email");
				final String strPassword = request.getParameter("password");
				final String strName = request.getParameter("name");
				final String strCompany = request.getParameter("company");
				final String strPhone = request.getParameter("phone");

				More more = new More();
				String strToken = more.generateToken(strEmail, false);
				int nResult = more.memberAdd(strEmail, strPassword, strName, strCompany, strPhone, strToken);
				more = null;
				String strResult = "註冊失敗<br>系統忙線中,請稍候再試";

				switch (nResult) {
					case More.MORE_ERR_SUCCESS :
						strResult = "註冊成功,請回到首頁執行登入";
						break;
					case More.MORE_ERR_MEMBER_EXIST :
						strResult = "帳號 " + strEmail + " 已存在,無法新增註冊!!";
						break;
				}
			%>


			<div class="row" id="result" style="display: none;">
				<p style="text-align: center;">
					<%=strResult%><br> <br> <br> <br> <br> <a href="#" class="btn btn-primary navbar-btn active" role="button" onClick="formSubmit('FormHome');">回首頁</a>
				</p>
			</div>
		</div>
		<!-- Main Content -->

		<!-- Footer -->
		<div class="media navbar-inverse text-center">
			<h4 class="text-muted">&copy;2016 MORE SDK Console</h4>
		</div>

	</div>
	<!-- /#wrapper -->

	<!-- Form -->
	<form action="index.jsp" method="post" name="FormHome" id="FormHome"></form>
</body>
</HTML>

<SCRIPT type="text/javascript">
	hideLoading();
</SCRIPT>