<%@ page language="java" contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>Github</title>
</head>

<form action="git.jsp">
	<button type="submit" class="btn btn-primary navbar-btn active">更新</button>
	<input name="pull" type="hidden" value="run" />
</form>

</html>

<%@ page import="java.util.*,java.io.*"%>

<%
	final String strPull = request.getParameter("pull");
	if (null != strPull)
	{
		String cmd = "./pull.sh";
		String outstr = "";

		try
		{
			Runtime rt = Runtime.getRuntime();
			Process p = rt.exec(cmd);

			try
			{
				InputStreamReader ise = new InputStreamReader(p.getErrorStream());
				BufferedReader bre = new BufferedReader(ise);
				InputStreamReader iso = new InputStreamReader(p.getInputStream());
				BufferedReader bro = new BufferedReader(iso);

				String line = null;
				while ((line = bre.readLine()) != null)
				{
					out.println(line + "<BR/>");
				}
				while ((line = bro.readLine()) != null)
				{
					out.println(line + "<BR/>");
				}

			}
			catch (IOException ioe)
			{
				ioe.printStackTrace();
			}

			int exitVal = p.waitFor();

			out.println(exitVal);
		}
		catch (Throwable t)
		{
			t.printStackTrace();
		}
	}
%>

