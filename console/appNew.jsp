<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%
	final String strToken = request.getParameter(Common.USER_TOKEN);
	if (!StringUtility.isValid(strToken))
	{
		response.sendRedirect("index.jsp");
		return;
	}
%>

<html lang="zh-Hant-TW">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Ideas Developer Concole ">
<meta name="author" content="EmilyChen">
<title>SER SDK Console ｜管理首頁|app新增</title>
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
				<a class="img-responsive " href="#"> <img src="img/ser_logo.png" alt="IdeadBrand" onClick="formSubmit('FormAppManager');">
				</a>

			</div>
			<!-- Collection of nav links, forms, and other content for toggling -->
			<div id="navbarCollapse" class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a data-toggle="dropdown" class="dropdown-toggle" href="#">我的APP<b class="caret"></b></a>
						<ul role="menu" class="dropdown-menu" aria-labelledby="dropdownMenu1">
							<li><a href="#" onClick="formSubmit('FormAppList')">APP列表 </a></li>
							<li class="divider"></li>
						</ul></li>
					<li><a href="logout.jsp">登出</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Main Content-->
	<div class="jumbotron text-center">
		<div class="container-fluid">
			<h2 class="text-primary">登錄新的APP</h2>
			<h4 class="text-muted">請選擇APP平台</h4>
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#myModal1">
				<img src="img/android.png" class="img-responsive" alt="android">Android
			</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#myModal2">
				<img src="img/ios.png" class="img-responsive" alt="ios">IOS
			</button>
			<!-- Modal1 Android -->
			<form action="appadd.jsp" method="post" enctype="multipart/form-data" name="formAddAndroid" id="formAddAndroid">
				<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.APP_OS%>" type="hidden" value="<%=Common.ANDROID%>" />
				<div class="modal fade bs-example-modal-lg" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
								</button>
								<h4 class="modal-title text-success" id="myModalLabel">
									<img src="img/androidm.png" class="img-responsive" alt="android">Android平台
								</h4>
							</div>
							<div class="modal-body">
								<!-- Start android app input Form-->

								<!--APP NAME-->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="inputAPPName1" class="control-label">APP名稱</label>
										</div>
										<div class="col-md-9">
											<input type="text" class="form-control" id="inputAPPName1" placeholder="APP名稱" name="<%=Common.APP_NAME%>">
										</div>
									</div>
									<!-- end row-->
								</div>
								<!-- end form-group-->
								<!--APP Icon-->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="inputAPPplatform1" class="control-label">APP Icon</label>
										</div>
										<div class="col-md-9">
											<input class="form-control" name="<%=Common.APP_ICON%>" type="file" value="選擇檔案" />
										</div>
									</div>
									<!-- end row-->
								</div>
								<!-- end form-group-->
								<!--APP class-->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="inputAPPclass1" class="control-label">APP類別</label>
										</div>
										<div class="col-md-9">
											<select class="form-control" id="inputAPPclass1" name="<%=Common.APP_CATEGORY%>">
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
									<!-- end row-->
								</div>
								<!-- end form-group-->
								<!--input name -->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="inputName1" class="control-label">公司/個人名稱</label>
										</div>
										<div class="col-md-9">
											<input type="text" class="form-control" id="inputName1" placeholder="公司/個人名稱" name="<%=Common.USER_NAME%>">
										</div>
									</div>
									<!-- end row-->
								</div>
								<!-- end form-group-->
								<!--input email -->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="exampleInputEmail2">聯絡電子郵件</label>
										</div>
										<div class="col-md-9">
											<input type="email" class="form-control" id="exampleInputEmail2" placeholder="account@example.com" name="<%=Common.USER_EMAIL%>">
										</div>
									</div>
									<!-- end row-->
								</div>
								<!-- end form-group-->
								<!--input phone -->
								<div class="form-group">
									<div class="row">
										<div class="col-md-3">
											<label for="exampleInputPhone">聯絡電話</label>
										</div>
										<div class="col-md-9">
											<input type="text" class="form-control" id="exampleInputPhone" placeholder="+88612345678" name="<%=Common.USER_PHONE%>">
										</div>
									</div>
									<!-- end row-->
								</div>
								<!-- end form-group-->


								<div class="progress">
									<div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100" style="width: 10%;">10%</div>
								</div>
								<!--end progress -->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
								<button type="button" class="btn btn-success active" onClick="checkAppAddData('formAddAndroid')">新增並建立新的APP ID</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>

		<!-- End Modal1 Android-->
		<!-- Modal1 IOS -->
		<form action="appadd.jsp" method="post" enctype="multipart/form-data" name="formAddIOS" id="formAddIOS">
			<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.APP_OS%>" type="hidden" value="<%=Common.IOS%>" />
			<div class="modal fade bs-example-modal-lg" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">
								<img src="img/iosm.png" class="img-responsive" alt="ios">IOS平台
							</h4>
						</div>
						<div class="modal-body">
							<!-- Start ios app input Form-->
							<!--APP NAME-->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="inputAPPName1" class="control-label">APP名稱</label>
									</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="inputAPPName1" placeholder="APP名稱" name="<%=Common.APP_NAME%>">
									</div>
								</div>
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!--APP platform-->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="inputAPPplatform1" class="control-label">APP Icon</label>
									</div>
									<div class="col-md-9">
										<input class="form-control" name="<%=Common.APP_ICON%>" type="file" value="選擇檔案" />
									</div>
								</div>
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!--APP class-->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="inputAPPclass1" class="control-label">APP類別</label>
									</div>
									<div class="col-md-9">
										<select class="form-control" id="inputAPPclass1" name="<%=Common.APP_CATEGORY%>">
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
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!--input name -->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="inputName1" class="control-label">公司/個人名稱</label>
									</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="inputName1" placeholder="公司/個人名稱" name="<%=Common.USER_NAME%>">
									</div>
								</div>
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!--input email -->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="exampleInputEmail2">聯絡電子郵件</label>
									</div>
									<div class="col-md-9">
										<input type="email" class="form-control" id="exampleInputEmail2" placeholder="account@example.com" name="<%=Common.USER_EMAIL%>">
									</div>
								</div>
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!--input phone -->
							<div class="form-group">
								<div class="row">
									<div class="col-md-3">
										<label for="exampleInputPhone">聯絡電話</label>
									</div>
									<div class="col-md-9">
										<input type="text" class="form-control" id="exampleInputPhone" placeholder="+88612345678" name="<%=Common.USER_PHONE%>">
									</div>
								</div>
								<!-- end row-->
							</div>
							<!-- end form-group-->
							<!-- 
							<div class="progress">
								<div class="progress-bar progress-bar-info progress-bar-striped"
									role="progressbar" aria-valuenow="10" aria-valuemin="0"
									aria-valuemax="100" style="width: 10%;">10%</div>
							</div>
							-->
							<!--end progress -->

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
							<button type="submit" class="btn btn-info active" onClick="formSubmit('formAddIOS')">新增並建立新的APP ID</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- End Modal1 IOS-->
	<!--End jumbotron巨幕-->
	<!-- Footer -->
	<div class="media navbar-default text-center">
		<div class="media navbar-inverse text-center">
			<h4 class="text-muted">&copy;2016 SER SDK Console</h4>
		</div>
	</div>
	<form action="index.jsp" method="post" name="FormAppManager" id="FormAppManager">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>
</body>
</html>