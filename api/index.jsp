<%@ page contentType="application/json; charset=utf-8" language="java" session="false"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.Map"%>
<%@ page import="sdk.ideas.AiPlug"%>
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
			switch (nApi_id)
			{
			case ID_API_AIPLUG_REGISTER:
			{
				String strOwner = request.getParameter("owner");
				String strMail = request.getParameter("mail");
				if (!StringUtility.isValid(strOwner) || !StringUtility.isValid(strMail))
				{
					jsonResp.put("message", "parameter invalid");
					out.println(jsonResp.toString());
				}
				else
				{
					AiPlug aiplug = new AiPlug();
					Response resp = new Response();
					aiplug.register(strOwner, strMail, resp);
					aiplug = null;
					out.println(resp.mstrContent);
					jsonResp = null;
				}
			}
				break;
			case ID_API_AIPLUG_VERIFY:
			{
				String strOwner = request.getParameter("owner");
				String strSmsCode = request.getParameter("smscode");
				if (!StringUtility.isValid(strOwner) || !StringUtility.isValid(strSmsCode))
				{
					jsonResp.put("message", "parameter invalid");
					out.println(jsonResp.toString());
				}
				else
				{
					AiPlug aiplug = new AiPlug();
					Response resp = new Response();
					aiplug.verify(strOwner, strSmsCode, resp);
					aiplug = null;
					out.println(resp.mstrContent);
					jsonResp = null;
				}
			}
				break;
			case ID_API_AIPLUG_LIST:
			{
				String strOwner = request.getParameter("owner");
				String strToken = request.getParameter("token");
				if (!StringUtility.isValid(strOwner) || !StringUtility.isValid(strToken))
				{
					jsonResp.put("message", "parameter invalid");
					out.println(jsonResp.toString());
				}
				else
				{
					AiPlug aiplug = new AiPlug();
					Response resp = new Response();
					aiplug.list(strOwner, strToken, resp);
					aiplug = null;
					out.println(resp.mstrContent);
					jsonResp = null;
				}
			}
				break;
			case ID_API_AIPLUG_CONFIGURE:
			{
				String strOutletId = request.getParameter("outletid");
				String strStatus = request.getParameter("status");
				String strOwner = request.getParameter("owner");
				String strToken = request.getParameter("token");
				if (!StringUtility.isValid(strOutletId) || !StringUtility.isValid(strStatus)
						|| !StringUtility.isValid(strOwner) || !StringUtility.isValid(strToken))
				{
					jsonResp.put("message", "parameter invalid");
					out.println(jsonResp.toString());
				}
				else
				{
					AiPlug aiplug = new AiPlug();
					Response resp = new Response();
					aiplug.configure(strOutletId, strStatus, strOwner, strToken, resp);
					aiplug = null;
					out.println(resp.mstrContent);
					jsonResp = null;
				}
			}
				break;
			default:
				jsonResp.put("message", "unknow api_id");
				out.println(jsonResp.toString());
				break;
			}
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




