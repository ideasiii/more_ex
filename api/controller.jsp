<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<%@ page import="sdk.ideas.module.Controller"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Controller API</title>
</head>
<body>

	<form action="semantic.jsp">
		<br> <br> 輸入 <br>
		<textarea cols="25" rows="10" name="txtinput"></textarea>
		<br> <br> 輸出 <br>
		<textarea readonly="readonly" cols="25" rows="10" name="txtoutput"></textarea>
		<br> <br> <br>
	</form>


	<%
		final String strCmpCommand = request.getParameter("command");
		if (null != strCmpCommand && 0 < strCmpCommand.length())
		{
			if (strCmpCommand.trim().equals("semantic_request"))
			{
				Controller.CMP_PACKET respPacket = new Controller.CMP_PACKET();
				int nStatue = Controller.cmpRequest("140.92.142.152", 2309, Controller.semantic_request,
						"{\"type\":0\"local\":0\"text\":\"Ivy Hello\"}", respPacket);
				out.println("status: " + String.valueOf(nStatue) + " body: " + respPacket.cmpBody);
				if (Controller.ERR_EXCEPTION == nStatue)
				{
					out.println("\nError: " + Controller.getLastError());
				}
			}
		}
	%>
</body>
</html>