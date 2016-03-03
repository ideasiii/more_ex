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
	
	
}
