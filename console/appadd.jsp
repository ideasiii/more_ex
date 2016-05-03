<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="sdk.ideas.Common"%>
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
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="sdk.ideas.StringUtility"%>
<%@ page import="sdk.ideas.sqliteClient"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="sdk.ideas.Logs"%>

<HTML>
<head>
<LINK REL="SHORTCUT ICON" HREF="img/favicon.ico">
<title>MORE</title>
<!-- Javascript -->
<script src="js/utility.js"></script>
</head>
<body>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">&nbsp;</p>
	<p style="text-align: center;">
		<img alt="Loading" src="img/map_loading.gif" style="width: 260px; height: 260px;" />
	</p>
	<%
		//Check that we have a file upload request
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

			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if (item.isFormField()) {
					String strName = item.getFieldName();
					String strValue = item.getString();
					strValue = new String(strValue.getBytes("ISO-8859-1"), "UTF-8");
					mapData.put(strName.trim(), strValue.trim());
				} else {
					itemUploadFile = item;
				}
			} // while

			long timeNow = System.currentTimeMillis();
			String strAppId = String.valueOf(timeNow);
			mapData.put(Common.APP_ICON, Common.UPLOAD_FILE_PATH + "/app_icon.png");

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
			/*
						for (Object key : mapData.keySet()) {
							out.println(key + " : " + mapData.get(key) + "<br/>");
						}
			*/
			final String strToken = mapData.get(Common.USER_TOKEN);

			Logs.showTrace("Insert App Data to Database, token:" + strToken);
			sqliteClient sqlite = new sqliteClient();
			Connection con = sqlite.getConnection(Common.DB_PATH_IDEAS);
			mapData.put(Common.APP_ID, strAppId);
			sqlite.insert(con, "app", mapData);
			con.close();
			sqlite = null;
	%>
	<form action="moresdk.jsp" method="post" name="FormAppManager" id="FormAppManager">
		<input name="<%=Common.USER_TOKEN%>" type="hidden" value="<%=strToken%>" />
	</form>

	<script>
		formSubmit('FormAppManager');
	</script>

	<%
		return;
		}
		response.sendRedirect("index.jsp");
	%>
</body>
</HTML>