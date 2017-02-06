/**
 * This module is for MORE project.
 */
package morejava;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.MongoClient;

import java.io.File;

/**
 * @author Jugo
 */

public class More
{

	public final static int	MORE_ERR_SUCCESS			= 1;
	public final static int	MORE_ERR_FAIL				= 0;
	public final static int	MORE_ERR_EXCEPTION			= -1;
	public final static int	MORE_ERR_INVALID_PARAMETER	= -2;
	public final static int	MORE_ERR_MEMBER_EXIST		= -3;

	public static class MemberData
	{
		public int		member_id;
		public String	member_email;
		public String	member_password;
		public String	member_name;
		public String	member_company;
		public String	member_phone;
		public String	member_token;
		public int		member_auth_state;
		public int		member_group;
		public String	create_date;
	}

	public static class SdkData
	{
		public String	sdk_id;
		public String	sdk_os;
		public String	sdk_owner;
		public String	sdk_name;
		public String	sdk_desc;
		public String	sdk_file;
		public String	sdk_doc;
		public String	create_date;
	}

	public static class AppData
	{
		public String	app_id;
		public String	app_name;
		public String	app_category;
		public String	app_description;
		public String	app_icon;
		public String	app_os;
		public String	user_token;
		public String	user_name;
		public String	user_email;
		public String	user_phone;
		public String	create_date;
	}

	public More()
	{

	}

	public int queryMember(final String strEmail, MemberData memData)
	{
		int nCount = 0;

		try
		{
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_MORE_MEMBER);
			String strSQL = "select * from more_member where member_email = '" + strEmail + "';";

			Statement stat = null;
			ResultSet rs = null;
			stat = con.createStatement();
			rs = stat.executeQuery(strSQL);
			while (rs.next())
			{
				++nCount;
				memData.member_id = rs.getInt("member_id");
				memData.member_email = rs.getString("member_email");
				memData.member_password = rs.getString("member_password");
				memData.member_name = rs.getString("member_name");
				memData.member_company = rs.getString("member_company");
				memData.member_phone = rs.getString("member_phone");
				memData.member_token = rs.getString("member_token");
				memData.member_auth_state = rs.getInt("member_auth_state");
				memData.member_group = rs.getInt("member_group");
				memData.create_date = rs.getString("create_date");
				Logs.showTrace("Query member:" + memData.member_email + " create_date:" + memData.create_date);
			}
			rs.close();
			stat.close();
			con.close();
			sqlite = null;
		}
		catch (SQLException e)
		{
			Logs.showError(e.toString());
			e.printStackTrace();
		}

		return nCount;
	}

	public int memberAdd(final String strEmail, final String strPassword, final String strName, final String strCompany,
			final String strPhone, final String strToken)
	{
		if (!StringUtility.isValid(strEmail) || !StringUtility.isValid(strPassword))
		{
			return MORE_ERR_INVALID_PARAMETER;
		}

		try
		{
			MemberData memData = new MemberData();
			int nCount = queryMember(strEmail, memData);
			if (0 < nCount)
				return MORE_ERR_MEMBER_EXIST;

			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_MORE_MEMBER);

			String sql = "insert into more_member(member_email,member_password,member_name,member_company,member_phone,member_token) values ( ?,?,?,?,?,?)";

			PreparedStatement pst = null;
			pst = con.prepareStatement(sql);
			int idx = 1;
			pst.setString(idx++, strEmail);
			pst.setString(idx++, strPassword);
			pst.setString(idx++, strName);
			pst.setString(idx++, strCompany);
			pst.setString(idx++, strPhone);
			pst.setString(idx++, strToken);
			pst.executeUpdate();
			pst.close();
			con.close();
			sqlite = null;
		}
		catch (Exception e)
		{
			Logs.showError(e.toString());
			return MORE_ERR_EXCEPTION;
		}

		return MORE_ERR_SUCCESS;
	}

	public synchronized String generateToken(String msg, boolean timeChange)
	{
		long current = System.currentTimeMillis();
		try
		{
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(msg.getBytes());
			if (timeChange)
			{
				byte now[] = (new Long(current)).toString().getBytes();
				md.update(now);
			}
			return toHex(md.digest());
		}
		catch (NoSuchAlgorithmException e)
		{
			Logs.showError(e.toString());
		}

		return String.valueOf(current);
	}

	private String toHex(byte buffer[])
	{
		StringBuffer sb = new StringBuffer(buffer.length * 2);
		for (int i = 0; i < buffer.length; i++)
		{
			sb.append(Character.forDigit((buffer[i] & 240) >> 4, 16));
			sb.append(Character.forDigit(buffer[i] & 15, 16));
		}

		return sb.toString();
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

	public void SendingEmail(String Email, String Body)
	{
		try
		{
			String host = "smtp.gmail.com";
			String from = "louis.ju.tw@gmail.com"; // Your mail id
			String pass = "Immortal-666"; // Your Password
			Properties props = System.getProperties();
			props.put("mail.smtp.starttls.enable", "true"); // added this line
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.user", from);
			props.put("mail.smtp.password", pass);
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.ssl.trust", host);
			String[] to = { Email }; // To Email address
			Session session = Session.getDefaultInstance(props, null);
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			InternetAddress[] toAddress = new InternetAddress[to.length];
			// To get the array of addresses
			for (int i = 0; i < to.length; i++)
			{ // changed from a while loop
				toAddress[i] = new InternetAddress(to[i]);
			}
			System.out.println(Message.RecipientType.TO);
			for (int j = 0; j < toAddress.length; j++)
			{ // changed from a while
					// loop
				message.addRecipient(Message.RecipientType.TO, toAddress[j]);
			}
			message.setSubject("Email from MORE");

			message.setContent(Body, "text/html");
			Transport transport = session.getTransport("smtp");
			transport.connect(host, from, pass);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
		}
		catch (Exception e)
		{
			System.out.println("MORE Send Mail Exception:" + e.toString());
		}
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

			// Query APP Icon File Path
			String strSQL = "select app_icon from app where app_id = '" + strAppId + "'";
			Statement stat = null;
			ResultSet rs = null;
			stat = con.createStatement();
			rs = stat.executeQuery(strSQL);
			String strAppIcon = null;
			if (rs.next())
			{
				strAppIcon = rs.getString("app_icon");
			}
			rs.close();
			stat.close();

			// Delete DB data
			strSQL = "delete from app where app_id = ?";
			PreparedStatement pst = null;
			pst = con.prepareStatement(strSQL);
			int idx = 1;
			pst.setString(idx++, strAppId);
			pst.executeUpdate();
			pst.close();
			con.close();
			sqlite = null;

			// Delete local file
			if (null != strAppIcon)
			{
				File file = new File("/data/opt/tomcat/webapp/more" + strAppIcon);
				if (null != file)
				{

					String absolutePath = file.getAbsolutePath();
					String filePath = absolutePath.substring(0, absolutePath.lastIndexOf(File.separator));

					if (file.delete())
					{
						System.out.println(file.getName() + " is deleted!");
					}
					else
					{
						System.out.println("Delete operation is failed.");
					}

					File folderPath = new File(filePath);

					if (folderPath.isDirectory())
					{

						if (folderPath.list().length <= 0)
						{

							System.out.println("Directory is empty!");
							folderPath.delete();
						}
					}
				}
			}

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

	static public String getClientIP(HttpServletRequest request)
	{
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
		{
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	static public String getDateTime()
	{
		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date current = new Date();
		return sdFormat.format(current);
	}

	@SuppressWarnings("deprecation")
	static public int insert(String strIP, int nPort, final String strDB, final String strCollection,
			final HashMap<String, String> mapData)
	{
		int nResult = 0;

		if (null == mapData || 0 >= mapData.size())
			return -1;

		try
		{
			MongoClient mongo = new MongoClient(strIP, nPort);
			// get database
			// if database doesn't exists, mongodb will create it for you
			DB db = mongo.getDB(strDB);

			// get collection
			// if collection doesn't exists, mongodb will create it for you
			DBCollection collection = db.getCollection(strCollection);

			/**** Insert ****/
			// create a document to store key and value

			BasicDBObject document = new BasicDBObject();

			for (Object key : mapData.keySet())
			{
				document.append((String) key, mapData.get(key));
			}
			collection.insert(document);
			if (null != mongo)
				mongo.close();

		}
		catch (Exception e)
		{
			nResult = -1;
			System.out.println("Mongo Exception: " + e.toString());
		}
		return nResult;
	}

	static public void webTracker(HttpServletRequest request, String strAction, String strEvent)
	{
		HashMap<String, String> mapData = new HashMap<String, String>();
		mapData.put("client", getClientIP(request));
		mapData.put("host", request.getRequestURL().toString());
		mapData.put("create_date", getDateTime());
		mapData.put("action", strAction);
		mapData.put("event", strEvent);
		insert("127.0.0.1", 27017, "website", "more", mapData);
		mapData.clear();
	}
}
