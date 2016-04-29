<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%
	request.setCharacterEncoding("utf-8");
	final String strEdit = request.getParameter(Common.APP_EDIT);
	final String strToken = request.getParameter(Common.USER_TOKEN);
	final String strAppId = request.getParameter(Common.APP_ID);
	final String strAppName = request.getParameter(Common.APP_NAME);
	final String strAppOs = request.getParameter(Common.APP_OS);
	final String strAppIcon = request.getParameter(Common.APP_ICON);
	final String strAppCategory = request.getParameter(Common.APP_CATEGORY);
	String strAppDesc = StringUtility.convertNull(request.getParameter(Common.APP_DESC));
	final String strUserName = request.getParameter(Common.USER_NAME);
	final String strUserPhone = request.getParameter(Common.USER_PHONE);
	final String strUserEmail = request.getParameter(Common.USER_EMAIL);

	if (!StringUtility.isValid(strToken) || !StringUtility.isValid(strAppId)) {
		response.sendRedirect("morehome.jsp");
		return;
	}

	boolean appEditAble = false;

	if (StringUtility.isValid(strEdit) && strEdit.trim().equals("true")) {
		appEditAble = true;
	}

	if (strAppDesc.trim().equals("null"))
		strAppDesc = "";
%>

<html lang="zh-Hant-TW">

<head>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="MORE Console">
<meta name="author" content="MORE Developer">

<title>MORE DEVICE DETAIL</title>

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
<script type="text/javascript" charset="utf-8">
	function setAppCategory(category, id)
	{
		var mySelect = document.getElementById(id);
		for (var i, j = 0; i = mySelect.options[j]; ++j)
		{
			if (i.value == category)
			{
				mySelect.selectedIndex = j;
				break;
			}
		}
	}
</script>
</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-bottom: 0">
			<div id="navbarCollapse" class="collapse navbar-collapse text-justify">
				<div class="navbar-header">
					
					<a class="nav navbar-nav navbar-left" href="#" onClick="formSubmit('FormHome');"><img src="../image/more_logo.png" alt="MORE"
						style="margin-left:5px;padding: 25px; width: 180px; height: 120px;box-shadow: 0 0 5px #888;border: 1px solid #fff;"
					></a>
				</div>
			</div>
		</nav>

		<div class="navbar-default sidebar" role="navigation">
			<div class="sidebar-nav navbar-collapse">
				<ul class="nav" id="side-menu">
					<li class="sidebar-search">
						<div class="input-group custom-search-form"></div> <!-- /input-group -->
					</li>
					<li><a href="#"><i class="fa  fa-th-list fa-fw"></i> 設定<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="#" onClick="formSubmit('FormAppEdit')">修改</a></li>
							<li><a href="#" data-toggle="modal" data-target="#myModal1">刪除</a></li>
						</ul> <!-- /.nav-second-level --></li>
				</ul>
			</div>
		</div>

		<div class="modal fade bs-example-modal-lg" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
						</button>
						<img src="img/warning.png" width=80 height=80 class="img-responsive" alt="android">
					</div>
					<div class="modal-body">
						<div class="form-group">
							<div style="text-align: center">
								<h4 class="modal-title text-danger" id="myModalLabel">
									是否刪除
									<%=strAppName%>
									APP
								</h4>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
							<button type="button" class="btn btn-danger " onClick="formSubmit('FormAppDelete')">刪除</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header"></h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<!-- /.col-lg-12 -->
			<div class="row">
				<div class="col-lg-12">

					<div class="panel panel-primary">
						<div class="panel-heading">基本設定</div>
						<div class="panel-body">
							<div class="row">

								<form action="appUpdate.jsp" method="post" enctype="multipart/form-data" name="formAppUpdate" id="formAppUpdate">
									<input name="<%=Common.APP_ID%>" type="hidden" value="<%=strAppId%>" /> <input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
									<div class="col-lg-6">

										<div class="form-group">
											<img src="<%=request.getContextPath() + strAppIcon%>" alt="<%=strAppIcon%>" width=75 height=75>&nbsp;&nbsp;<label>Device 圖示<input type="file"
												name="<%=Common.APP_ICON%>" id="<%=Common.APP_ICON%>" style="display: none;"
											>
											</label>
										</div>

										<div class="form-group">
											<label>Device 名稱</label> <input class="form-control" id="<%=Common.APP_NAME%>" name="<%=Common.APP_NAME%>" value="<%=strAppName%>" disabled>
										</div>

										<div class="form-group">
											<label>Device 類型</label> <select class="form-control" id="<%=Common.APP_OS%>" name="<%=Common.APP_OS%>" disabled>
												<%
													if (strAppOs.trim().equals(Common.ANDROID))
													{
												%>
												<option selected>Android</option>
												<option>IOS</option>
												<%
													}
													else if(strAppOs.trim().equals(Common.IOS))
													{
												%>
												<option>Android</option>
												<option selected>IOS</option>
												<%
													}
												%>
											</select>
										</div>

										<div class="form-group">
											<label>Device 分類</label> <select class="form-control" id="<%=Common.APP_CATEGORY%>" name="<%=Common.APP_CATEGORY%>" disabled>
												<option>工具</option>
												<option>天氣</option>
												<option>生活品味</option>
												<option>生產應用</option>
												<option>交通運輸</option>
												<option>社交</option>
												<option>音樂與音效</option>
												<option>個人化</option>
												<option>娛樂</option>
												<option>旅遊與地方資訊</option>
												<option>財經</option>
												<option>健康塑身</option>
												<option>動態桌布</option>
												<option>商業</option>
												<option>教育</option>
												<option>通訊</option>
												<option>媒體與影片</option>
												<option>程式庫與試用程式</option>
												<option>新聞與雜誌</option>
												<option>運動</option>
												<option>圖書與參考資源</option>
												<option>漫畫</option>
												<option>購物</option>
												<option>醫療</option>
												<option>攝影</option>
												<option>遊戲</option>
												<option>家庭</option>
											</select>
										</div>
									</div>
									<!-- /.col-lg-6 (nested) -->
									<div class="col-lg-6">
										<h2>
											Device ID:<%=strAppId%></h2>
										<div class="form-group">
											<br /> <br /> <br /> <label>Device 描述說明</label>
											<p>
												<textarea cols="50" rows="7" style="font-size: 16px; padding: 5px;" disabled id="<%=Common.APP_DESC%>" name="<%=Common.APP_DESC%>">
												<%=strAppDesc%>
											</textarea>
										</div>
										<input type="submit" class="btn btn-primary" value="Device 設定更新" style="display: none;" id="btn_app_update_submit">
									</div>
								</form>
								<!-- /.col-lg-6 (nested) -->
							</div>

							<!-- /.row -->
						</div>
						<div class="panel-footer"></div>
					</div>
				</div>
			</div>
			<!-- /.row -->
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-info">
						<div class="panel-heading">個人資料設定</div>
						<div class="panel-body">
							<div class="row">
								<form action="userUpdate.jsp" method="post" name="FormUserUpdate" id="FormUserUpdate">
									<input name="<%=Common.APP_ID%>" type="hidden" value="<%=strAppId%>" /> <input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
									<div class="col-lg-6">
										<div class="form-group has-success">
											<label class="control-label" for="inputSuccess">公司/個人名稱</label> <input type="text" class="form-control" disabled id='<%=Common.USER_NAME%>' name='<%=Common.USER_NAME%>'
												value='<%=strUserName%>'
											>
										</div>
										<div class="form-group has-error">
											<label class="control-label" for="inputError">聯絡電話</label> <input type="text" class="form-control" disabled id='<%=Common.USER_PHONE%>' name='<%=Common.USER_PHONE%>'
												value='<%=strUserPhone%>'
											>
										</div>
									</div>

									<!-- /.col-lg-6 (nested) -->
									<div class="col-lg-6">
										<div class="form-group has-warning">
											<label class="control-label" for="inputWarning">聯絡電子郵件</label> <input type="text" class="form-control" disabled id='<%=Common.USER_EMAIL%>' name='<%=Common.USER_EMAIL%>'
												value='<%=strUserEmail%>'
											>
										</div>
										<br />
										<button type="submit" class="btn btn-primary" style="display: none;" id="btn_user_update_submit">個人資料更新</button>
									</div>
								</form>
								<!-- /.col-lg-6 (nested) -->
							</div>
							<!-- /.row (nested) -->
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</div>
		<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="js/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="js/sb-admin-2.js"></script>

	<form action="moresdk.jsp" method="post" name="FormHome" id="FormHome">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<form action="appNew.jsp" method="post" name="FormAppAdd" id="FormAppAdd">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<form action="appDelete.jsp" method="post" name="FormAppDelete" id="FormAppDelete">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.APP_ID%>" type="hidden" value="<%=strAppId%>" />
	</form>

	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<form action="appdetail.jsp" method="post" name="FormAppEdit" id="FormAppEdit">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.APP_EDIT%>" type="hidden" value="true" /> <input name="<%=Common.APP_ID%>"
			type="hidden" value="<%=strAppId%>"
		/> <input name="<%=Common.APP_NAME%>" type="hidden" value="<%=strAppName%>" /> <input name="<%=Common.APP_OS%>" type="hidden" value="<%=strAppOs%>" /> <input
			name="<%=Common.APP_ICON%>" type="hidden" value="<%=strAppIcon%>"
		/> <input name="<%=Common.APP_CATEGORY%>" type="hidden" value="<%=strAppCategory%>" /> <input name="<%=Common.USER_NAME%>" type="hidden" value="<%=strUserName%>" /> <input
			name="<%=Common.USER_PHONE%>" type="hidden" value="<%=strUserPhone%>"
		/> <input name="<%=Common.USER_EMAIL%>" type="hidden" value="<%=strUserEmail%>" /> <input name="<%=Common.APP_DESC%>" type="hidden" value="<%=strAppDesc%>" />
	</form>
	<%
		out.println("<script>setAppCategory('" + strAppCategory + "','" + Common.APP_CATEGORY + "');</script>");
		if (appEditAble)
		{
			out.println(
					"<script>document.getElementById('" + Common.APP_ICON + "').style.display = \"\";</script>");
			out.println("<script>document.getElementById('" + Common.APP_NAME + "').disabled = false;</script>");
			out.println("<script>document.getElementById('" + Common.APP_OS + "').disabled = false;</script>");
			out.println(
					"<script>document.getElementById('" + Common.APP_CATEGORY + "').disabled = false;</script>");
			out.println("<script>document.getElementById('" + Common.APP_DESC + "').disabled = false;</script>");
			out.println("<script>document.getElementById('" + Common.USER_NAME + "').disabled = false;</script>");
			out.println("<script>document.getElementById('" + Common.USER_PHONE + "').disabled = false;</script>");
			out.println("<script>document.getElementById('" + Common.USER_EMAIL + "').disabled = false;</script>");
			out.println("<script>document.getElementById('btn_app_update_submit').style.display = \"\";</script>");
			out.println("<script>document.getElementById('btn_user_update_submit').style.display = \"\";</script>");
		}
	%>
</body>

</html>

