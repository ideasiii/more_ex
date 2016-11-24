<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="sdk.ideas.Mongo"%>
<%@ page import="sdk.ideas.Mongo.Filter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>

<%!//==== Global define =====//

	final private int	ERROR_SUCCESS			= 0;
	final private int	ERROR_INVALID_PARAMETER	= -1;

	//==== End Global define ====//%>

<%
	//example: query.jsp?app_id=1462241606197&start_date=2016-07-10&end_date=2016-07-15
	final String strAPPID = request.getParameter("app_id");
	final String strStartDate = request.getParameter("start_date");
	final String strEndDate = request.getParameter("end_date");

	JSONObject jsonOutput = new JSONObject();

	try
	{
		if (null == strAPPID)
		{
			jsonOutput.put("code", ERROR_INVALID_PARAMETER);
			jsonOutput.put("message", "Invalid Parameter, no app_id");
		}
		else
		{
			Mongo mongo = new Mongo();
			mongo.Connect("127.0.0.1", 27017);
			ArrayList<String> listResult = new ArrayList<String>();
			ArrayList<Filter> listFilter = new ArrayList<Filter>();

			Filter f1 = new Filter();
			f1.strField = "ID";
			f1.mapFilter.put("$regex", strAPPID);
			listFilter.add(f1);

			if (null != strStartDate || null != strEndDate)
			{
				Filter f2 = new Filter();
				f2.strField = "create_date";
				if (null != strStartDate)
				{
					f2.mapFilter.put("$gte", strStartDate + " 00:00:00");
				}

				if (null != strEndDate)
				{
					f2.mapFilter.put("$lte", strEndDate + " 23:59:59");
				}
				listFilter.add(f2);
			}

			int nCount = mongo.query("access", "mobile", listFilter, listResult);
			mongo = null;
			JSONObject jsonobj = null;
			JSONArray jarrResult = new JSONArray();
			for (int i = 0; i < listResult.size(); ++i)
			{
				jsonobj = new JSONObject(listResult.get(i));
				jsonobj.remove("_id");
			//	jarrResult.put(jsonobj);
				out.println(jsonobj.toString());
			}
			jsonOutput.append("data", jarrResult);
		}
	}
	catch (Exception e)
	{
		jsonOutput.put("error", e.getMessage());
	}

//	out.println(jsonOutput.toString());
	jsonOutput = null;
%>