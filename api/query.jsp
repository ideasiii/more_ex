<%@ page contentType="text/html; charset=utf-8" language="java"
	session="false"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="sdk.ideas.Mongo"%>
<%@ page import="sdk.ideas.Mongo.Filter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>

<%
	// example: query.jsp?app_id=1462241606197&start_date=2016-07-10&end_date=2016-07-15
	final String strAPPID = request.getParameter("app_id");
	final String strStartDate = request.getParameter("start_date");
	final String strEndDate = request.getParameter("end_date");
%>





<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MongoDB Query</title>
</head>

<body>
	<%
		if (null == strAPPID)
		{
			out.println("<h1>Error</h1><br><h2>No APP ID</h2></body></html>");
			return;
		}

		Mongo mongo = new Mongo();
		mongo.Connect("localhost", 27017);
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

		JSONObject jsonobj = null;
		HashMap<String, String> listKey = new HashMap<String, String>();

		for (int i = 0; i < listResult.size(); ++i)
		{
			jsonobj = new JSONObject(listResult.get(i));
			jsonobj.remove("_id");

			Iterator<?> keys = jsonobj.keys();

			while (keys.hasNext())
			{
				String key = (String) keys.next();
				listKey.put(key, key);
			}
		}
	%>

	<h1>
		Total:
		<%=nCount%></h1>
	<p>&nbsp;</p>
	<table align="center" border="1" cellpadding="1" cellspacing="1"
		style="width: 80%;">
		<thead>
			<tr>
				<%
					for (Object key : listKey.keySet())
					{
						out.println("<th scope=\"col\">" + (String) key + "</th>");
					}
				%>
			</tr>
		</thead>
		<tbody>
			<%
				for (int i = 0; i < listResult.size(); ++i)
				{
					jsonobj = new JSONObject(listResult.get(i));
					jsonobj.remove("_id");

					out.println("<tr>");
					for (Object key : listKey.keySet())
					{
						if (jsonobj.has((String) key))
						{
							out.println("<td>" + String.valueOf(jsonobj.get((String) key)) + "</td>");
						}
						else
						{
							out.println("<td>&nbsp;</td>");
						}
					}
					out.println("</tr>");
				}
			%>
		</tbody>
	</table>
	<p>&nbsp;</p>

</body>
</html>