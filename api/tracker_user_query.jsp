<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.sqlite.SQLiteConfig"%>
<%@ page import="org.sqlite.SQLiteDataSource"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%!//==== Global define 全域 ====//

	final private int ERROR_SUCCESS = 0;
	final private int ERROR_INVALID_PARAMETER = -1;
	final private int ERROR_EXCEPTION = -4;

	//==== End Global define ====//%>

<%
	JSONObject jsonOutput = new JSONObject();
	JSONObject jsonItem = null;
	JSONArray jarrResult = new JSONArray();

	try
	{
		SQLiteConfig sqconfig = new SQLiteConfig();
		sqconfig.setReadOnly(true);
		sqconfig.setSharedCache(true);
		sqconfig.enableRecursiveTriggers(true);

		SQLiteDataSource ds = new SQLiteDataSource(sqconfig);
		ds.setUrl("jdbc:sqlite:/data/sqlite/ideas.db");
		ds.getConnection().setAutoCommit(true);

		Connection sqliteCon = ds.getConnection();

		Statement stat = null;
		ResultSet rs = null;
		stat = sqliteCon.createStatement();
		rs = stat.executeQuery("select * from user");
		int nCount = 0;
		while (rs.next())
		{
			jsonItem = new JSONObject();
			jsonItem.put("id", rs.getString("id"));
			jsonItem.put("app_id", rs.getString("app_id"));
			jsonItem.put("mac", rs.getString("mac"));
			jsonItem.put("os", rs.getString("os"));
			jsonItem.put("phone", rs.getString("phone"));
			jsonItem.put("fb_id", rs.getString("fb_id"));
			jsonItem.put("fb_name", rs.getString("fb_name"));
			jsonItem.put("fb_email", rs.getString("fb_email"));
			jsonItem.put("fb_account", rs.getString("fb_account"));
			jsonItem.put("g_account", rs.getString("g_account"));
			jsonItem.put("t_account", rs.getString("t_account"));
			jsonItem.put("created_date", rs.getString("created_date"));
			jarrResult.put(jsonItem);
			++nCount;
		}
		rs.close();
		stat.close();
		sqliteCon.close();
		jsonOutput.put("code", ERROR_SUCCESS);
		jsonOutput.put("message", "success");
		jsonOutput.put("count", nCount);
		jsonOutput.put("data", jarrResult);

	} catch (Exception e)
	{
		jsonOutput.put("code", ERROR_EXCEPTION);
		jsonOutput.put("message", e.getMessage());
	}
	out.println(jsonOutput.toString());
	jsonOutput = null;
%>

