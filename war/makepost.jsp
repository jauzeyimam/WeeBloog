<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="com.googlecode.objectify.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Insert title here</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();

		if (user == null) {
	%>

	<p>
		Hello! <a
			href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
			in</a> to start posting!
	</p>

	<%
		} else {
	%>

	<div class="wrapper">
		<h1>Create a post!</h1>
		<br>
		<form action="/blogpost" method="post">
			<div>
				<textarea name="title" rows="1" cols="100">Title!</textarea>
			</div>
			<div>
				<textarea name="post" rows="20" cols="100">Write your post here!</textarea>
			</div>
			<div>
				<input type="submit" value="Submit" />
			</div>
		</form>
		<button type="button" onclick="javascript:window.location='/'";">Cancel</button>
		<%
			}
		%>
	</div>	
</body>
</html>