package sdk.ideas;

import java.net.HttpURLConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import org.json.JSONObject;

public class SerSdk
{
	final String mstrLoginURL = "http://api.ser.ideas.iii.org.tw/api/user/sdk_user_status";

	public static class MemData
	{
		public int mnAppId;
		public String mstrToken;
	}

	public static class SdkData
	{
		public String sdk_id;
		public String sdk_os;
		public String sdk_owner;
		public String sdk_name;
		public String sdk_desc;
		public String sdk_file;
		public String sdk_doc;
		public String create_date;
	}

	public static class AppData
	{
		public String app_id;
		public String app_name;
		public String app_category;
		public String app_description;
		public String app_icon;
		public String app_os;
		public String user_token;
		public String user_name;
		public String user_email;
		public String user_phone;
		public String create_date;
	}

	public SerSdk()
	{

	}

	public boolean login(String strAccount, String strPassword, MemData memData)
	{
		boolean bAuthResult = false;
		if (!StringUtility.isValid(strAccount) || !StringUtility.isValid(strPassword))
		{
			Logs.showError("[SER SDK] Invalid Login Parameters");
			return bAuthResult;
		}

		try
		{
			final String strParam = "account=" + strAccount + "&password=" + strPassword;
			Logs.showTrace("MORE SDK Login:" + strParam);
			HttpsClient httpClient = new HttpsClient();
			HttpsClient.Response resp = new HttpsClient.Response();
			httpClient.sendPost(mstrLoginURL, strParam, resp);
			httpClient = null;

			if (HttpURLConnection.HTTP_OK == resp.mnCode && StringUtility.isValid(resp.mstrContent))
			{
				Logs.showTrace("MORE SDK Login Response:" + resp.mstrContent);
				JSONObject jsonObj;
				jsonObj = new JSONObject(resp.mstrContent);
				bAuthResult = jsonObj.getBoolean("result");
				if (bAuthResult)
				{
					// JSONArray jsonArray = jsonObj.getJSONArray("response");
					// JSONObject jsonItem = jsonArray.getJSONObject(0);
					memData.mstrToken = strAccount; // jsonItem.getString("token");
					memData.mnAppId = 0;// jsonItem.getInt("appid");
					Logs.showTrace("MORE SDK Login Success, Account:" + strAccount);
				}
				else
				{
					Logs.showTrace("MORE SDK Login Fail, Account:" + strAccount);
				}
				jsonObj = null;
			}
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
		}
		return bAuthResult;
	}

	public int querySdk(ArrayList<SdkData> listSdk)
	{
		int nCount = 0;

		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);
			String strSQL = "select * from sdk order by create_date;";
			ArrayList<HashMap<String, String>> listData = new ArrayList<HashMap<String, String>>();
			sqlite.query(con, strSQL, Common.listSdkField, listData);
			con.close();
			sqlite = null;

			if (0 < listData.size())
			{
				Iterator<HashMap<String, String>> it = null;
				HashMap<String, String> mapItem;
				it = listData.iterator();
				SdkData sdkData = null;
				while (it.hasNext())
				{
					sdkData = new SdkData();
					mapItem = it.next();
					sdkData.sdk_id = mapItem.get(Common.SDK_ID);
					sdkData.sdk_os = mapItem.get(Common.SDK_OS);
					sdkData.sdk_owner = mapItem.get(Common.SDK_OWNER);
					sdkData.sdk_name = mapItem.get(Common.SDK_NAME);
					sdkData.sdk_desc = mapItem.getOrDefault(Common.SDK_DESC, "No Description");
					sdkData.sdk_file = mapItem.get(Common.SDK_FILE);
					sdkData.sdk_doc = mapItem.getOrDefault(Common.SDK_DOC, "");
					sdkData.create_date = mapItem.get(Common.CREATE_DATE);
					listSdk.add(sdkData);
					sdkData = null;
				}
				nCount = listSdk.size();
			}
		}
		catch (SQLException e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}

		return nCount;
	}

	public int queryApp(ArrayList<AppData> listApp, String strUserToken)
	{
		int nCount = 0;

		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);
			String strSQL = "select * from app where user_token = '" + strUserToken + "' order by create_date;";
			ArrayList<HashMap<String, String>> listData = new ArrayList<HashMap<String, String>>();
			sqlite.query(con, strSQL, Common.listAppField, listData);
			con.close();
			sqlite = null;

			if (0 < listData.size())
			{
				Iterator<HashMap<String, String>> it = null;
				HashMap<String, String> mapItem;
				it = listData.iterator();
				AppData appData = null;
				while (it.hasNext())
				{
					appData = new AppData();
					mapItem = it.next();
					appData.app_id = mapItem.get(Common.APP_ID);
					appData.app_name = mapItem.get(Common.APP_NAME);
					appData.app_category = mapItem.get(Common.APP_CATEGORY);
					appData.app_description = mapItem.get(Common.APP_DESC);
					appData.app_icon = mapItem.get(Common.APP_ICON);
					appData.app_os = mapItem.get(Common.APP_OS);
					appData.user_token = mapItem.get(Common.USER_TOKEN);
					appData.user_name = mapItem.get(Common.USER_NAME);
					appData.user_email = mapItem.get(Common.USER_EMAIL);
					appData.user_phone = mapItem.get(Common.USER_PHONE);
					appData.create_date = mapItem.get(Common.CREATE_DATE);
					listApp.add(appData);
					appData = null;
				}
				nCount = listApp.size();
			}
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}
		return nCount;
	}

	public void deleteApp(final String strAppId)
	{
		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);
			String strSQL = "delete from app where app_id = ?";
			PreparedStatement pst = null;
			pst = con.prepareStatement(strSQL);
			int idx = 1;
			pst.setString(idx++, strAppId);
			pst.executeUpdate();
			pst.close();
			con.close();
			sqlite = null;
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}
	}

	public void updateApp(final String strAppId, final String strAppIcon, final String strAppName,
			final String strAppOs, final String strAppCategory, final String strAppDesc)
	{
		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);

			String sql = null;
			if (null == strAppIcon)
			{
				sql = "update app set app_name = ? , app_os = ? , app_category = ? , app_description = ? where app_id = ?";
			}
			else
			{
				sql = "update app set app_icon = ?, app_name = ? , app_os = ? , app_category = ? , app_description = ? where app_id = ?";
			}

			PreparedStatement pst = null;
			pst = con.prepareStatement(sql);
			int idx = 1;

			if (null != strAppIcon)
			{
				pst.setString(idx++, strAppIcon);
			}
			pst.setString(idx++, strAppName);
			pst.setString(idx++, strAppOs);
			pst.setString(idx++, strAppCategory);
			pst.setString(idx++, strAppDesc);
			pst.setString(idx++, strAppId);
			pst.executeUpdate();
			pst.close();

			con.close();
			sqlite = null;
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}
	}

	public void updateUser(final String strAppId, final String strUserName, final String strUserPhone,
			final String strUserEmail)
	{
		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);

			String sql = "update app set user_name = ? , user_phone = ? , user_email = ? where app_id = ?";
			PreparedStatement pst = null;
			pst = con.prepareStatement(sql);
			int idx = 1;
			pst.setString(idx++, strUserName);
			pst.setString(idx++, strUserPhone);
			pst.setString(idx++, strUserEmail);
			pst.setString(idx++, strAppId);
			pst.executeUpdate();
			pst.close();

			con.close();
			sqlite = null;
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}
	}
}