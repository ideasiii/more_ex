<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Insert title here</title>
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
			<input name="signin" type="submit" value="登入" />
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


</body>
</html>