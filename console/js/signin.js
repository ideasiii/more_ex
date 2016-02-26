function onLogin() {
	if (checkData()) {
		document.FormLogin.action = "auth_member.jsp";
		document.FormLogin.submit();
	}
}

function checkData() {
	var errMsg = '';
	if (document.FormLogin.account.value == '')
		errMsg += "Please input account !!\n";
	if (document.FormLogin.password.value == '')
		errMsg += "Please input password !!\n";
	if (errMsg == '') {
		return true;
	}
	alert(errMsg);
	return false;
}

function clear() {
	document.FormLogin.account.value = '';
	document.FormLogin.password.value = '';
}

function register() {
	document.FormLogin.action = "http://api.ser.ideas.iii.org.tw/api/register";
	document.FormLogin.submit();
}
