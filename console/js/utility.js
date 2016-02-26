function Trim(x) {
	return x.replace(/^\s+|\s+$/gm, '');
}

function formSubmit(formName) {
	var form = document.getElementById(formName);
	form.submit();
}

function checkAppAddData(formName) {
	var form = document.getElementById(formName);
	var errMsg = '';

	if (Trim(form.app_name.value) == '')
		errMsg += "請輸入APP名稱 !!\n";

	if (errMsg == '') {
		form.submit();
		return true;
	}
	alert(errMsg);
	return false;
}