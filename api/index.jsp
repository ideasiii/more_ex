<%@ page contentType="application/json; charset=utf-8" language="java" session="false"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.Map"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.HttpsClient.Response"%>
<%@ page import="org.json.JSONObject"%>

<%
	final int ID_API_AIPLUG_REGISTER = 1;
	final int ID_API_AIPLUG_VERIFY = 2;
	final int ID_API_AIPLUG_LIST = 3;
	final int ID_API_AIPLUG_CONFIGURE = 4;

	JSONObject jsonResp = new JSONObject();
	jsonResp.put("result", false);
	jsonResp.put("errcode", "-1");
	request.setCharacterEncoding("UTF-8");

	String strApi_id = request.getParameter("api_id");
	if (null != strApi_id && StringUtility.isNumeric(strApi_id))
	{
		int nApi_id = -1;
		try
		{
			nApi_id = Integer.valueOf(strApi_id);
		
		}
		catch (NumberFormatException e)
		{
			jsonResp.put("message", "api_id invalid, must be a number");
			out.println(jsonResp.toString());
		}
	}
	else
	{
		jsonResp.put("message", "api_id invalid !!");
		out.println(jsonResp.toString());
	}
	jsonResp = null;
%>




