<%@ page contentType="application/json; charset=utf-8" language="java"
	session="false"%>

<%@ page import="sdk.ideas.module.Controller"%>
<%@ page import="org.json.JSONObject"%>

<%
	/**
	* Result	Description
	* 0	Success
	* 1	Fail，System Exception
	* 2	Fail，Invalid Parameter
	* 3	Fail，System Busy
	* 4	Fail，Unknown Error
	* 5	Fail，Invalid Authorization
	*/

	/**
	* type/integer value
	* 0：not defined
	* 1：會話
	* 2：指令
	*/

	/**
	* local/integer value
	* 0：not defined
	* 1：英文
	* 2：中文
	*/

	String strType = request.getParameter("type");
	String strLocal = request.getParameter("local");
	final String strWords = request.getParameter("words");
	JSONObject jsonOut = new JSONObject();

	if (null == strWords || (null != strWords && 0 >= strWords.trim().length()))
	{
		jsonOut.put("result", 2);
	} else
	{
		if (null == strType || (null != strType && 0 >= strType.trim().length()))
		{
			strType = "0";
		} else
		{
			strType = strType.trim();
			if (!strType.equals("0") && !strType.equals("1") && !strType.equals("2"))
				strType = "0";
		}
		int nType = Integer.valueOf(strType);

		if (null == strLocal || (null != strLocal && 0 >= strLocal.trim().length()))
		{
			strLocal = "0";
		} else
		{
			strLocal = strLocal.trim();
			if (!strLocal.equals("0") && !strLocal.equals("1") && !strLocal.equals("2"))
				strLocal = "0";
		}
		int nLocal = Integer.valueOf(strLocal);

		JSONObject jsonRequest = new JSONObject();
		jsonRequest.put("type", nType);
		jsonRequest.put("local", nLocal);
		jsonRequest.put("words", strWords);
		Controller.CMP_PACKET respPacket = new Controller.CMP_PACKET();
		int nStatus = Controller.cmpRequest(request.getLocalAddr(), 2309, Controller.semantic_request,
				jsonRequest.toString(), respPacket);
		jsonRequest = null;
		//out.println(String.valueOf(nStatus));

		if (Controller.STATUS_ROK != nStatus)
		{
			jsonOut.put("result", 3);
		} else
		{
			JSONObject jsonResult = new JSONObject(respPacket.cmpBody);
			out.println(jsonResult.toString());
			return;
		}
	}

	out.println(jsonOut.toString());
%>