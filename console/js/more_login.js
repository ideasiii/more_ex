function onLogin()
{
	if (checkData())
	{
		document.login.action = "auth_member.jsp";
		document.login.submit();
	}
}

function checkData()
{
	var errMsg = '';
	if (document.login.account.value == '')
		errMsg += "Please input account !!\n";
	if (document.login.password.value == '')
		errMsg += "Please input password !!\n";
	if (errMsg == '')
	{
		return true;
	}
	alert(errMsg);
	return false;
}

function logout()
{
	document.location = "moresdk.jsp";
}