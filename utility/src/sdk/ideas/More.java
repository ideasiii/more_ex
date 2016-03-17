/**
 * This module is for MORE project.
 */
package sdk.ideas;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * @author Louis Ju
 */
public class More
{
	public final static int MORE_ERR_SUCCESS = 1;
	public final static int MORE_ERR_FAIL = 0;
	public final static int MORE_ERR_EXCEPTION = -1;
	public final static int MORE_ERR_INVALID_PARAMETER = -2;
	public final static int MORE_ERR_MEMBER_EXIST = -3;

	public static class MemberData
	{
		public int member_id;
		public String member_email;
		public String member_password;
		public String member_name;
		public String member_company;
		public String member_phone;
		public String member_token;
		public int member_auth_state;
		public int member_group;
		public String create_date;
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
			{ // changed from a while loop
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

}
