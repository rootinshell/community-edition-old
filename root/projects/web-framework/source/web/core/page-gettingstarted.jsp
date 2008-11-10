<%@ page import="org.alfresco.web.framework.render.*" %>
<%@ page import="org.alfresco.web.site.*" %>
<%@ page buffer="0kb" autoFlush="true" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="/WEB-INF/tlds/alf.tld" prefix="alf" %>
<%
	RenderContext context = RenderUtil.getContext(request);

	String bgImageUrl = org.alfresco.web.site.URLUtil.browser(context, "/images/logo/AlfrescoFadedBG.png");
	String logoImageUrl = org.alfresco.web.site.URLUtil.browser(context, "/images/logo/AlfrescoLogo200.png");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Getting Started</title>
    <alf:head/>
</head>
<body>
<table width="100%" height="100%" border="0" style="background-image:url('<%=bgImageUrl%>'); background-repeat:no-repeat;">
	<tr>
		<td valign="center" align="middle">
			<img src="<%=logoImageUrl%>"/>
			<br/>
			<b><%=FrameworkHelper.getFrameworkTitle()%> <%=FrameworkHelper.getFrameworkVersion()%></b>
			<br/>
			<br/>
			<br/>
			<%=FrameworkHelper.getFrameworkTitle()%> has been installed at this location.
			<br/>
			A home page has not been defined.
			<br/>

		</td>
	</tr>
</table>

</body>
</html>