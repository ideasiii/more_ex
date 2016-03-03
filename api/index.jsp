<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="java.util.Map"%>

<html>
<head>
<title>MORE API</title>
</head>
<body>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="../console/img/map_loading.gif" style="width: 260px; height: 260px;" />
	</p>

	<%
		final int ID_API_AIPLUG_REGISTER = 1;
	
		out.println("Content-Type: " + request.getContentType());
		request.setCharacterEncoding("UTF-8");
		Map<String, String[]> parameters = request.getParameterMap();
		if (0 < parameters.size())
		{
			for (String parameter : parameters.keySet())
			{
				String strValue = new String(parameters.get(parameter)[0].getBytes("ISO-8859-1"), "UTF-8");
				out.println("KEY:" + parameter + " VALUE:" + parameters.get(parameter)[0]);
				System.out.println("KEY:" + parameter + " VALUE:" + parameters.get(parameter)[0]);
			}

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
						break;
					}
				}
				catch (NumberFormatException e)
				{
					out.println("Parameter api_id invalid, must be a number");
					System.out.println("Parameter api_id invalid, must be a number");
				}
			}
			else
			{
				out.println("Parameter api_id invalid");
				System.out.println("Parameter api_id invalid");
			}
			return;
		}
		else
		{
			out.println("Can't get parameters");
		}
	%>

</body>
</html>



