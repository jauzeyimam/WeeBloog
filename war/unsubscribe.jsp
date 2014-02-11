<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>UnSubscribe</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		if (user != null) {
			pageContext.setAttribute("email", user.getEmail());
		}
	%>

	<div class="wrapper">
		<h1>We're sorry to see you go!</h1>
		<br>
		<form action="/removesubscriber" method="post">
			<div>
				<textarea name="email" rows="1" cols="40"><%
						if (user != null) {
					%>${fn:escapeXml(email)}<%
						} else {
					%>Email<%
						}
					%></textarea>
			</div>
			<div>
				<input type="submit" value="Submit" />
			</div>
		</form>
		<button type="button" onclick="javascript:window.location='/'";">Cancel</button>
	</div>

</body>
</html>