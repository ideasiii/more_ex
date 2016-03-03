/**
 * AiPlug智慧插座API，主要呼叫台灣智慧AiPlug API
 * This for Web
 */
package sdk.ideas;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * @author Louis Ju
 * @since 2016-02-16
 */
public class AiPlug
{
	private final String TARGET_HOST = "http://testserver.tiscservice.com:8080";
	private final String PATH_API_REGISTER = "/AiPlugOpenAPI/Register";
	private final String PATH_API_VERIFY = "/AiPlugOpenAPI/Verify";
	private final String PATH_API_LIST = "/AiPlugOpenAPI/List";
	private final String PATH_API_CONFIGURE = "/AiPlugOpenAPI/Configure";

	private HttpsClient httpClient = null;
	private ArrayList<AiPlugResponseListener> listListener = null;

	private final int ID_REGISTER = 1;
	private final int ID_VERIFY = 2;
	private final int ID_LIST = 3;
	private final int ID_CONFIGURE = 4;

	public AiPlug()
	{
		httpClient = new HttpsClient();
	}

	public static interface AiPlugResponseListener
	{
		public void onResponse(final int nApiId, final int nCode, final String strContent);
	}

	/**
	 * Set callback
	 * 
	 * @param listener
	 */
	public void setAiPlugResponseListener(AiPlugResponseListener listener)
	{
		if (null != listener)
		{
			listListener.add(listener);
		}
	}

	private void callback(final int nApiId, final int nCode, final String strContent)
	{
		for (int i = 0; i < listListener.size(); ++i)
		{
			listListener.get(i).onResponse(nApiId, nCode, strContent);
		}
	}

	public int register(final String strOwner, final String strMail, HttpsClient.Response resp)
	{
		// HashMap<String, String> mapParam = new HashMap<String, String>();
		// mapParam.put("owner", strOwner);
		// mapParam.put("mail", strMail);
		String strParam = "owner=" + strOwner + "&mail=" + strMail;
		try
		{
			httpClient.sendPost(TARGET_HOST + PATH_API_REGISTER, strParam, resp);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			return -1;
		}
		return 0;
	}

	public int verify(final String strOwner, final String strSmsCode)
	{
		HashMap<String, String> mapParam = new HashMap<String, String>();
		mapParam.put("owner", strOwner);
		mapParam.put("smscode", strSmsCode);
		// httpClient.httpPost(ID_VERIFY, TARGET_HOST + PATH_API_VERIFY,
		// mapParam);
		return 0;
	}

	public int list(final String strOwner, final String strToken)
	{
		HashMap<String, String> mapParam = new HashMap<String, String>();
		mapParam.put("owner", strOwner);
		mapParam.put("token", strToken);
		// httpClient.httpPost(ID_LIST, TARGET_HOST + PATH_API_LIST, mapParam);
		return 0;
	}

	public int configure(final String strOutletId, final String strStatus, final String strOwner, final String strToken)
	{
		HashMap<String, String> mapParam = new HashMap<String, String>();
		mapParam.put("outletid", strOutletId);
		mapParam.put("status", strStatus);
		mapParam.put("owner", strOwner);
		mapParam.put("token", strToken);
		// httpClient.httpPost(ID_CONFIGURE, TARGET_HOST + PATH_API_CONFIGURE,
		// mapParam);
		return 0;
	}
}
