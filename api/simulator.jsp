<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>

<script language="javascript">
	var contentEditWin = null;
	var w = window.screen.width;
	var h = window.screen.height;
	var width = 0;
	var height = 0;
	var left = 0;
	var locate;

	function addCanned() {
		var url = "run.jsp?type=CHKMAIL";
		contentEditWin = window
				.open(
						url,
						'_blank',
						'toolbar=no,status=no,menubar=no,scrollbars=no,resizable=no,left=0, top=0, width=10000, height=10000, visible=none',
						'');
		//contentEditWin = window.open(url, 'run', locate);
		checkChildWin();
	}

	function checkChildWin() {
		if (null != contentEditWin && contentEditWin.closed) {
			contentEditWin = null;
			//window.location.reload()
			var mm = getCookie("email");
			alert(mm);
			return;
		}

		setTimeout("checkChildWin()", 1000)
	}

	function getCookie(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) == 0) {
				return c.substring(name.length, c.length);
			}
		}
		return "";
	}

	function viewCanned(content_id) {
		var url = "AppsPushMessageCannedPreview.jsp?content_id=" + content_id;
		window.open(url, 'preview', locate);
	}

	function deleteCanned(content_id) {
		var url = "AppsPushMessageCannedList.jsp?type=del&content_id="
				+ content_id;
		document.myform.action = url;
		document.myform.submit();
	}

	function editCanned(content_id) {
		var url = "AppsPushMessageCannedEdit.jsp?content_id=" + content_id;
		contentEditWin = window.open(url, 'edit', locate);
		checkChildWin();
	}
</script>

</head>
<body>

	<p>MORE API Get Client ID</p>
	<form action="run.jsp" method="post">
		<input type="hidden" value="SIGNIN" name="type">
		<p>
			email <input name="email" type="text" />
		</p>
		<p>
			hashedpassword <input name="hashedpassword" type="text" />
		</p>
		<p>
			<input name="signin" type="submit" value="登入" /><input name="add"
				type="button" value="window" onClick="addCanned()" />
		</p>
	</form>
	<p>&nbsp;</p>
	<hr />
	<p>&nbsp;</p>
	<p>MORE API User registeration</p>
	<form action="run.jsp" method="post">
		<input type="hidden" value="REGISTER" name="type">
		<p>
			email <input name="email" type="text" />
		</p>
		<p>
			password <input name="password" type="text" />
		</p>
		<p>
			groupId <input name="groupId" type="text" value=1 />
		</p>
		<p>
			displayName <input name="displayName" type="text" />
		</p>

		<p>
			company <input name="company" type="text" />
		</p>
		<p>
			phone <input name="phone" type="text" />
		</p>
		<p>
			purpose <input name="purpose" type="text" />
		</p>
		<p>
			agreementVersion <input name="agreementVersion" type="text" />
		</p>
		<p>
			<input name="register" type="submit" value="註冊" />
		</p>
	</form>
	<p>&nbsp;</p>
	<hr />
	<p>&nbsp;</p>
	<p>MORE API Get User Information</p>
	<form action="run.jsp" method="post">
		<input type="hidden" value="USER_INFO_QUERY" name="type">
		<p>
			User Id <input name=user-id type="text" />
		</p>
		<p>
			<input name="user-info-get" type="submit" value="查詢" />
		</p>
	</form>


</body>
</html>