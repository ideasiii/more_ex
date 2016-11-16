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
			<input name="email" type="text" />
		</p>
		<p>
			<input name="hashedpassword" type="text" />
		</p>
		<p>
			<input name="signin" type="submit" value="登入" />
		</p>
	</form>
	<p>&nbsp;</p>
	<hr />
	<p>&nbsp;</p>


</body>
</html>