/**
 * AiPlug智慧插座API，主要呼叫台灣智慧AiPlug API
 * This for Web
 */
package morejava;

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

	public AiPlug()
	{
		httpClient = new HttpsClient();
	}

	@Override
	protected void finalize() throws Throwable
	{
		httpClient = null;
		super.finalize();
	}

	public int register(final String strOwner, final String strMail, HttpsClient.Response resp)
	{
		String strParam = "owner=" + strOwner + "&mail=" + strMail;
		try
		{
			httpClient.sendPost(TARGET_HOST + PATH_API_REGISTER, strParam, resp);
		}
		catch (Exception e)
		{
			resp.mnCode = -1;
			resp.mstrContent = e.getMessage();
			Logs.showError(e.toString());
		}
		return resp.mnCode;
	}

	public int verify(final String strOwner, final String strSmsCode, HttpsClient.Response resp)
	{
		String strParam = "owner=" + strOwner + "&smscode=" + strSmsCode;
		try
		{
			httpClient.sendPost(TARGET_HOST + PATH_API_VERIFY, strParam, resp);
		}
		catch (Exception e)
		{
			resp.mnCode = -1;
			resp.mstrContent = e.getMessage();
			Logs.showError(e.toString());
		}
		return resp.mnCode;
	}

	public int list(final String strOwner, final String strToken, HttpsClient.Response resp)
	{
		String strParam = "owner=" + strOwner + "&token=" + strToken;
		try
		{
			httpClient.sendPost(TARGET_HOST + PATH_API_LIST, strParam, resp);
		}
		catch (Exception e)
		{
			resp.mnCode = -1;
			resp.mstrContent = e.getMessage();
			Logs.showError(e.toString());
		}
		return resp.mnCode;
	}

	public int configure(final String strOutletId, final String strStatus, final String strOwner, final String strToken,
			HttpsClient.Response resp)
	{
		String strParam = "outletid=" + strOutletId + "&status=" + strStatus + "&owner=" + strOwner + "&token="
				+ strToken;
		try
		{
			httpClient.sendPost(TARGET_HOST + PATH_API_CONFIGURE, strParam, resp);
		}
		catch (Exception e)
		{
			resp.mnCode = -1;
			resp.mstrContent = e.getMessage();
			Logs.showError(e.toString());
		}
		return resp.mnCode;
	}
}
