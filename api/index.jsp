<%@ page contentType="tapplication/json; charset=utf-8" language="java" session="false"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.Map"%>
<%@ page import="sdk.ideas.AiPlug"%>
<%@ page import="sdk.ideas.HttpsClient.Response"%>

<%
	final int ID_API_AIPLUG_REGISTER = 1;
	final int ID_API_AIPLUG_VERIFY = 2;

	request.setCharacterEncoding("UTF-8");

	String strParam = request.getParameter("api_id");
	if (null != strParam)
	{
		int nApi_id = -1;
		try
		{
			nApi_id = Integer.valueOf(strParam);
			switch (nApi_id)
			{
			case ID_API_AIPLUG_REGISTER:
			{
				AiPlug aiplug = new AiPlug();
				Response resp = new Response();
				aiplug.register("0975961276", "cs@tiscservice.com", resp);
				aiplug = null;
				out.println(resp.mstrContent);
				return;
			}
			case ID_API_AIPLUG_VERIFY:
				break;
			}
		}
		catch (NumberFormatException e)
		{
			out.println(
					"{\"result\":false,\"errcode\":\"-1\",\"message\":\"api_id invalid, must be a number\"}");
		}
	}
	else
	{
		out.println("{\"result\":false,\"errcode\":\"-1\",\"message\":\"api_id invalid\"}");
	}
%>




