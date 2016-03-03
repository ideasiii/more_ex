function Trim(x)
{
	return x.replace(/^\s+|\s+$/gm, '');
}

function formSubmit(formName)
{
	var form = document.getElementById(formName);
	form.submit();
}

function checkAppAddData(formName)
{
	var form = document.getElementById(formName);
	var errMsg = '';

	if (Trim(form.app_name.value) == '')
		errMsg += "請輸入APP名稱 !!\n";

	if (Trim(form.user_name.value) == '')
		errMsg += "請輸入公司/個人名稱 !!\n";

	if (Trim(form.user_email.value) == '')
		errMsg += "請輸入聯絡電子郵件 !!\n";

	if (Trim(form.user_phone.value) == '')
		errMsg += "請輸入聯絡電話 !!\n";

	if (errMsg == '')
	{
		form.submit();
		return true;
	}
	alert(errMsg);
	return false;
}

function checkRegisterData(formName)
{
	var form = document.getElementById(formName);
	var errMsg = '';

	if (Trim(form.email.value) == '')
		errMsg += "請輸入申請者聯繫Email !!\n";

	if (Trim(form.password.value) == '')
		errMsg += "請輸入密碼 !!\n";

	if (Trim(form.password2.value) == '')
		errMsg += "請輸入再確認密碼 !!\n";

	if (Trim(form.name.value) == '')
		errMsg += "請輸入申請者 !!\n";

	if (Trim(form.company.value) == '')
		errMsg += "請輸入申請單位 !!\n";

	if (Trim(form.phone.value) == '')
		errMsg += "請輸入申請者聯繫電話 !!\n";

	if (Trim(form.password.value) != Trim(form.password2.value))
		errMsg += "再確認密碼錯誤 !!\n";

	if (errMsg == '')
	{
		form.submit();
		return true;
	}
	alert(errMsg);
	return false;
}

function switchShow(Element)
{
	var SubMenu = document.getElementById(Element);

	if (SubMenu.style.display == 'none')
	{
		SubMenu.style.display = 'block';
	}
	else
	{
		SubMenu.style.display = 'none';
	}
}