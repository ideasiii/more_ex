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

	final String strContextPath = request.getContextPath();
	final String uri = request.getRequestURI();
	final String pageName = uri.substring(uri.lastIndexOf("/") + 1);
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
<script src="../js/xenforo.js"></script>
<script src="../js/bootstrap.min.js"></script>

<!-- Javascript -->
<script src="js/utility.js"></script>
<script src="js/more_login.js"></script>

<script type="text/javascript">
	function showTab(tab)
	{
		switch (tab)
		{
		case 0:
			document.getElementById('app_register').style.display = "none";
			document.getElementById('sdk_ios').style.display = "none";
			document.getElementById('my_app').style.display = "none";
			document.getElementById('sdk_android').style.display = "block";
			break;
		case 1:
			document.getElementById('app_register').style.display = "none";
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('my_app').style.display = "none";
			document.getElementById('sdk_ios').style.display = "block";
			break;
		case 2:
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('sdk_ios').style.display = "none";
			document.getElementById('my_app').style.display = "none";
			document.getElementById('app_register').style.display = "block";
			break;
		case 3:
			document.getElementById('sdk_android').style.display = "none";
			document.getElementById('sdk_ios').style.display = "none";
			document.getElementById('app_register').style.display = "none";
			document.getElementById('my_app').style.display = "block";
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
					<label for="LoginControl"><span class="concealed" onClick="formSubmit('FormMoreLogout')" style="cursor: pointer;">登出</span></label>
					<%
						} else {
					%>
					<label for="LoginControl"><span class="concealed noOutline" style="cursor: pointer;">登入</span></label>
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
		<input name="from" type="hidden" value="<%=pageName%>" />
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
					<input type="button" class="button primary" value="登入" tabindex="104" data-loginPhrase="登入" data-signupPhrase="登入" onclick="onLogin()" /> <input type="button"
						class="button primary" value="註冊" tabindex="104" data-loginPhrase="註冊" data-signupPhrase="註冊" onClick="formSubmit('FormMoreRegister')"
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
								<img src="../image/more_logo.png" alt="MORE LOGO" />
							</div>
						</div>
					</div>
				</div>
				<div id="navigation" class="pageWidth">
					<div class="pageContent">
						<nav>
							<div class="navTabs">
								<ul class="publicTabs">

									<!-- MORE HOME -->
									<li class="navTab morehome Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreHome')">HOME</span></li>
									<!-- /MORE HOME -->

									<!-- MORE SDK -->
									<li class="navTab moresdk selected"><span class="navLink" style="padding: 0 27px; cursor: default;">MORE SDK</span>
										<div class="tabLinks">
											<ul class="secondaryContent blockLinksList">
												<li><a rel="nofollow" href="#" onClick="showTab(0)" id="a_android">Android</a></li>
												<li><a rel="nofollow" href="#" onClick="showTab(1)" id="a_ios">IOS</a></li>
												<%
													if (bLogined) {
												%>
												<li><button type="button" class="btn btn-success btn-lg" onClick="showTab(3)" style="margin-left: 600px;">
														<p class="normalFont">My APP</p>
													</button></li>
												<li><div class="form-group">
														<div class="col-sm-10">
															<button type="button" class="btn btn-success btn-lg" onClick="showTab(2)">
																<p class="normalFont">APP Register
																<p>
															</button>
														</div>
													</div></li>
												<%
													}
												%>
											</ul>
										</div></li>
									<!-- /MORE SDK -->

									<!-- MORE API -->
									<li class="navTab moreapi Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreApi')">MORE API</span></li>
									<!-- /MORE API -->

									<!-- MORE MDM -->
									<li class="navTab moremdm Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreMdm')">MORE MDM</span></li>
									<!-- /MORE MDM -->

									<!-- MORE DASHBOARD -->
									<li class="navTab moredashboard Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreDashboard')">DASHBOARD</span></li>
									<!-- /MORE DASHBOARD -->

									<!-- MORE ABOUT -->
									<li class="navTab moreabout Popup PopupControl PopupClosed"><span class="navLink" onClick="formSubmit('FormMoreAbout')">ABOUT</span></li>
									<!-- /MORE ABOUT -->
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
						<!-- My APP -->
						<div id="my_app">
							<ul id="my_app_list">
								<%
									if (bLogined) {
										ArrayList<More.AppData> listApp = new ArrayList<More.AppData>();
										int nCountApp = more.queryApp(listApp, strToken);

										if (0 < nCountApp) {
											Iterator<More.AppData> it = null;
											it = listApp.iterator();
											More.AppData appData = null;
											String strAppIcon = null;
											while (it.hasNext()) {
												appData = it.next();
												strAppIcon = strContextPath + appData.app_icon;
								%>

								<li>
									<div class="sdkBlock">
										<img src="<%=strAppIcon%>" alt="android" class="logo">
										<p class="apptitle">
											<%=appData.app_name%></p>

										<DIV class="appdesc" style="width: 200px;">

											APP ID:<%=appData.app_id%>
											<BR> <br> APP 類別:<%=appData.app_category%>

										</DIV>
									</div>
									<div class="option">
										<ul>
											<li><form action="appdetail.jsp" method="post" name="<%=appData.app_id%>" id="<%=appData.app_id%>">
													<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" /> <input
														name="<%=Common.APP_ID%>" type="hidden" value="<%=appData.app_id%>"
													/> <input name="<%=Common.APP_NAME%>" type="hidden" value="<%=appData.app_name%>" /> <input name="<%=Common.APP_ICON%>" type="hidden" value="<%=appData.app_icon%>" />
													<input name="<%=Common.APP_DESC%>" type="hidden" value="<%=appData.app_description%>" /> <input name="<%=Common.APP_OS%>" type="hidden" value="<%=appData.app_os%>" />
													<input name="<%=Common.APP_CATEGORY%>" type="hidden" value="<%=appData.app_category%>" /> <input name="<%=Common.USER_NAME%>" type="hidden"
														value="<%=appData.user_name%>"
													/> <input name="<%=Common.USER_EMAIL%>" type="hidden" value="<%=appData.user_email%>" /> <input name="<%=Common.USER_PHONE%>" type="hidden"
														value="<%=appData.user_phone%>"
													/>
													<h5>
														<input type="submit" class="btn btn-primary" role="button" value="詳細資料">
													</h5>
												</form></li>

										</ul>
									</div>
								</li>
								<%
									}
										}
									}
								%>
							</ul>
						</div>
						<!-- /My APP -->
						<div id="app_register">
							<form action="appadd.jsp" method="post" enctype="multipart/form-data" name="formAppRegister" id="formAppRegister" class="form-horizontal">
								<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
								<div class="loginContainer">
									<div class="form-group" style="margin-bottom: 50px; font-size: 16px;">
										<b>APP 註冊</b>
									</div>

									<div class="form-group">
										<label for="<%=Common.APP_NAME%>" class="col-sm-2 control-label">APP名稱</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="<%=Common.APP_NAME%>" placeholder="Email Account" name="<%=Common.APP_NAME%>">
										</div>
									</div>

									<div class="form-group">
										<label for="<%=Common.APP_ICON%>" class="col-sm-2 control-label">APP 圖示</label>
										<div class="col-sm-10">
											<input class="form-control" name="<%=Common.APP_ICON%>" type="file" value="選擇檔案" />
										</div>
									</div>

									<div class="form-group">
										<label for="<%=Common.APP_OS%>" class="col-sm-2 control-label">APP作業系統</label>
										<div class="col-sm-10">
											<select class="form-control" id="<%=Common.APP_OS%>" name="<%=Common.APP_OS%>" style="height: 34px;">
												<option>Android</option>
												<option>IOS</option>
											</select>
										</div>
									</div>

									<div class="form-group">
										<label for="<%=Common.APP_CATEGORY%>" class="col-sm-2 control-label">APP類別</label>
										<div class="col-sm-10">
											<select class="form-control" id="<%=Common.APP_CATEGORY%>" name="<%=Common.APP_CATEGORY%>" style="height: 34px;">
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

									<div class="form-group">
										<label for="<%=Common.USER_NAME%>" class="col-sm-2 control-label">公司/個人名稱</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="<%=Common.USER_NAME%>" placeholder="公司/個人名稱" name="<%=Common.USER_NAME%>">
										</div>
									</div>

									<div class="form-group">
										<label for="<%=Common.USER_EMAIL%>" class="col-sm-2 control-label">聯絡電子郵件</label>
										<div class="col-sm-10">
											<input type="email" class="form-control" id="<%=Common.USER_EMAIL%>" placeholder="account@example.com" name="<%=Common.USER_EMAIL%>">
										</div>
									</div>

									<div class="form-group">
										<label for="<%=Common.USER_PHONE%>" class="col-sm-2 control-label">聯絡電話</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="<%=Common.USER_PHONE%>" placeholder="Phone" name="<%=Common.USER_PHONE%>">
										</div>
									</div>


									<div class="form-group">
										<div class="col-sm-10">
											<button type="button" class="btn btn-success active" onClick="checkAppAddData('formAppRegister')">新增並建立新的APP ID</button>
										</div>
									</div>
								</div>

							</form>
						</div>
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
							%>
							<li>
								<div class="sdkBlock">
									<img src="img/androidm.png" alt="android" class="logo">
									<p class="title"><%=sdkData.sdk_name%></p>
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

										//	if (!bLogined) {
										//		sdkData.sdk_file = "#";
										//	}
							%>
							<li>
								<div class="sdkBlock">
									<img src="img/iosm.png" alt="ios" class="logo">
									<p class="title"><%=sdkData.sdk_name%></p>
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
					<img class="footerLogo" alt="MORE Footbar Logo" src="../image/more.png">
					<ul class="footerLinks">
						<li><a target="_blank" href="morecontactus.jsp">Contact Us</a></li>
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

<form action="morehome.jsp" method="post" name="FormMoreLogout" id="FormMoreLogout"></form>

<form action="morehome.jsp" method="post" name="FormMoreHome" id="FormMoreHome">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moresdk.jsp" method="post" name="FormMoreSdk" id="FormMoreSdk">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moreapi.jsp" method="post" name="FormMoreApi" id="FormMoreApi">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moremdm.jsp" method="post" name="FormMoreMdm" id="FormMoreMdm">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moredashboard.jsp" method="post" name="FormMoreDashboard" id="FormMoreDashboard">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moreabout.jsp" method="post" name="FormMoreAbout" id="FormMoreAbout">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>

<form action="moreregister.jsp" method="post" name="FormMoreRegister" id="FormMoreRegister">
	<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
</form>
</html>

<%
	more = null;
%>