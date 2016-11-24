<%@ page language="java" contentType="application/json; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.sqlite.SQLiteConfig"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%!//==== Global define 全域 ====//

	final private int	ERROR_SUCCESS			= 0;
	final private int	ERROR_INVALID_PARAMETER	= -1;
	final private int	ERROR_EXCEPTION			= -4;

	//==== End Global define ====//%>

<%
	/*
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
			rs = stat.executeQuery("select app_id,app_name,app_category,user_name,create_date from app");
			int nCount = 0;
			while (rs.next())
			{
				jsonItem = new JSONObject();
				jsonItem.put("app_id", rs.getString("app_id"));
				jsonItem.put("app_name", rs.getString("app_name"));
				jsonItem.put("app_category", rs.getString("app_category"));
				jsonItem.put("user_name", rs.getString("user_name"));
				jsonItem.put("create_date", rs.getString("create_date"));
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
	
		}
		catch (Exception e)
		{
			jsonOutput.put("code", ERROR_EXCEPTION);
			jsonOutput.put("message", e.getMessage());
		}
		out.println(jsonOutput.toString());
		jsonOutput = null;*/
%>