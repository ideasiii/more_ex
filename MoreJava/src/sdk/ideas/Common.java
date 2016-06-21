package sdk.ideas;

import java.util.ArrayList;
import java.util.Arrays;

public abstract class Common
{
	final public static String UPLOAD_FILE_PATH = "/uploadfile";
	final public static String DB_PATH_IDEAS = "/data/sqlite/ideas.db";
	final public static String DB_PATH_MORE_MEMBER = "/data/sqlite/more_member.db";
	final public static String PATH_DOWNLOAD_LIB_ANDROID = "/ideas/sdk/download/libs/android";
	final public static String PATH_DOWNLOAD_LIB_IOS = "/ideas/sdk/download/libs/ios";
	final public static String PATH_DOWNLOAD_DOC_ANDROID = "/ideas/sdk/download/doc/android";
	final public static String PATH_DOWNLOAD_DOC_IOS = "/ideas/sdk/download/doc/ios";

	/** Sqlite table: app **/
	final public static String APP_ID = "app_id";
	final public static String APP_NAME = "app_name";
	final public static String APP_CATEGORY = "app_category";
	final public static String APP_DESC = "app_description";
	final public static String APP_ICON = "app_icon";
	final public static String APP_OS = "app_os";
	final public static String USER_TOKEN = "user_token";
	final public static String USER_NAME = "user_name";
	final public static String USER_EMAIL = "user_email";
	final public static String USER_PHONE = "user_phone";

	/** Sqlite table: sdk **/
	final public static String SDK_ID = "sdk_id";
	final public static String SDK_OS = "sdk_os";
	final public static String SDK_OWNER = "sdk_owner";
	final public static String SDK_NAME = "sdk_name";
	final public static String SDK_DESC = "sdk_desc";
	final public static String SDK_FILE = "sdk_file";
	final public static String SDK_DOC = "sdk_doc";
	final public static String CREATE_DATE = "create_date";

	final public static ArrayList<String> listAppField = new ArrayList<>(Arrays.asList(APP_ID, APP_NAME, APP_CATEGORY,
			APP_DESC, APP_ICON, APP_OS, USER_TOKEN, USER_NAME, USER_EMAIL, USER_PHONE));

	final public static ArrayList<String> listSdkField = new ArrayList<>(
			Arrays.asList(SDK_ID, SDK_OS, SDK_OWNER, SDK_NAME, SDK_DESC, SDK_FILE, SDK_DOC, CREATE_DATE));

	final public static String APP_EDIT = "app_edit";

	/** Device Type **/
	final public static String ANDROID = "Android";
	final public static String IOS = "IOS";
	final public static String APPLIANCE = "家電";
	final public static String TOY = "玩具";
	final public static String IOT = "物聯網";

	final public static ArrayList<String> listDeviceType = new ArrayList<String>(
			Arrays.asList(ANDROID, IOS, APPLIANCE, TOY, IOT));
}
