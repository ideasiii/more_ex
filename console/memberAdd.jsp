<%@ page contentType="text/html; charset=utf-8" language="java" session="false"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Map"%>
<%@ page import="sdk.ideas.More"%>

<%
	request.setCharacterEncoding("UTF-8");

	final String strEmail = request.getParameter("email");
	final String strPassword = request.getParameter("password");
	final String strName = request.getParameter("name");
	final String strCompany = request.getParameter("company");
	final String strPhone = request.getParameter("phone");

	More more = new More();
	String strToken = more.generateToken(strEmail, false);
	int nResult = more.memberAdd(strEmail, strPassword, strName, strCompany, strPhone, strToken);

	String strResult = "註冊失敗<br>系統忙線中,請稍候再試";

	switch (nResult) {
		case More.MORE_ERR_SUCCESS :
			strResult = "註冊成功,請回到首頁執行登入";
			//more.SendingEmail("louis.ju.tw@gmail.com", "MORE member add success");
			break;
		case More.MORE_ERR_MEMBER_EXIST :
			strResult = "帳號 " + strEmail + " 已存在,無法新增註冊!!";
			break;
	}

	more = null;
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
<script type="text/javascript">
	function hideLoading()
	{
		document.getElementById('loading').style.display = "none";
		document.getElementById('result').style.display = "";
	}
</script>

<title>MORE MEMBER ADD</title>

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
								<img src="../image/more_logo.png" alt="MORE LOGO" />
							</div>
						</div>
					</div>
				</div>

				<!-- Navigation Bar -->
				<div id="navigation" class="pageWidth">
					<div class="pageContent"></div>
				</div>
				<!-- /Navigation Bar -->
			</div>
		</header>
		<div id="content">
			<div class="pageWidth">
				<div class="pageContent">

					<!-- Content Block -->
					<div id="blockList">
						<img alt="Loading" src="img/map_loading.gif" style="width: 260px; height: 260px;" id="loading" />

						<div class="form-group" style="margin-left: 70px;">
							<div class="col-sm-10">
								<p style="text-align: center;">
									<%=strResult%></p>
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-10">
								<button type="button" class="btn btn-success btn-lg centerHorizon" onClick="formSubmit('FormHome');" style="margin-top: 150px;">回首頁</button>
							</div>
						</div>
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
					<img class="footerLogo" alt="MORE Footbar Logo" src="../image/more.png">
					<ul class="footerLinks">
						<li><a target="_blank" href="morecontactus.jsp">Contact Us</a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!-- /footer -->

	<SCRIPT type="text/javascript">
		hideLoading();
	</SCRIPT>

</body>

<!-- Form -->
<form action="morehome.jsp" method="post" name="FormHome" id="FormHome"></form>



</HTML>

