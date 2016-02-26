<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page import="sdk.ideas.Common"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.Logs"%>
<%@ page import="sdk.ideas.SerSdk"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="java.io.File"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.sqliteClient"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%
	String strToken = null;
	String strAppId = null;
	String strAppName = null;
	String strAppOs = null;
	String strAppCategory = null;
	String strAppDesc = null;

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (isMultipart) {
		String saveDirectory = application.getRealPath(Common.UPLOAD_FILE_PATH);
		// Create a factory for disk-based file items
		FileItemFactory factory = new DiskFileItemFactory();
		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		// Parse the request
		@SuppressWarnings("unchecked")
		List<FileItem> items = upload.parseRequest(request);

		// Process the uploaded items
		Iterator<FileItem> iter = items.iterator();
		HashMap<String, String> mapData = new HashMap<String, String>();
		FileItem itemUploadFile = null;

		String strName = null;
		String strValue = null;
		while (iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (item.isFormField()) {
				strName = item.getFieldName();
				strValue = new String(item.getString().getBytes("ISO-8859-1"), "UTF-8");
				mapData.put(strName.trim(), strValue.trim());
				Logs.showTrace("POST Name:" + strName + "  Value:" + strValue);
				strName = null;
				strValue = null;
			} else {
				itemUploadFile = item;
			}
		} // while

		mapData.put(Common.APP_ICON, Common.UPLOAD_FILE_PATH + "/app_icon.png");
		strToken = mapData.get(Common.USER_TOKEN);
		strAppId = mapData.get(Common.APP_ID);
		strAppName = mapData.get(Common.APP_NAME);
		strAppOs = mapData.get(Common.APP_OS);
		strAppCategory = mapData.get(Common.APP_CATEGORY);
		strAppDesc = mapData.get(Common.APP_DESC);
		Logs.showTrace(Common.USER_TOKEN + " = " + strToken);
		Logs.showTrace(Common.APP_ID + " = " + strAppId);

		if (null != itemUploadFile) {
			// Process a file upload
			String fieldName = itemUploadFile.getFieldName();
			String fileName = itemUploadFile.getName();
			String contentType = itemUploadFile.getContentType();
			//boolean isInMemory = itemUploadFile.isInMemory();
			long sizeInBytes = itemUploadFile.getSize();

			if (fileName != null && !"".equals(fileName) && 0 < sizeInBytes) {
				String strPath = saveDirectory + "/" + mapData.get(Common.USER_TOKEN);
				String strFileName = null;
				if (contentType.trim().equals("image/png")) {
					strFileName = strAppId + ".png";
				}
				if (contentType.trim().equals("image/jpeg")) {
					strFileName = strAppId + ".jpg";
				}
				if (contentType.trim().equals("image/bmp")) {
					strFileName = strAppId + ".bmp";
				}
				if (null != strFileName) {
					new File(strPath).mkdirs();
					File uploadedFile = new File(strPath, strFileName);
					itemUploadFile.write(uploadedFile);
					mapData.put(Common.APP_ICON,
							Common.UPLOAD_FILE_PATH + "/" + mapData.get(Common.USER_TOKEN) + "/" + strFileName);
				}
			}
		}
	}
%>

<HTML>
<HEAD>
<TITLE>SER SDK Console | APP Update</TITLE>

<!-- Javascript -->
<script src="js/utility.js"></script>

</HEAD>
<BODY>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="img/loading.gif" style="width: 160px; height: 160px;" />
	</p>

	<form action="applist.jsp" method="post" name="FormAppList" id="FormAppList">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

</BODY>
</HTML>

<%
	SerSdk serSdk = new SerSdk();
	if (StringUtility.isValid(strToken) && StringUtility.isValid(strAppId)) {
		serSdk.updateApp(strAppId, strAppName, strAppOs, strAppCategory, strAppDesc);
	}

	serSdk = null;
%>
<script>
	setTimeout("formSubmit('FormAppList')", 3);
	//	formSubmit('FormAppList');
</script>