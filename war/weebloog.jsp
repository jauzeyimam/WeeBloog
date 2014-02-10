<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>

<%@ page import="java.util.List"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="java.util.Collections"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ page import="weebloog.BlogPost"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="style.css" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>The Ultimate Weblog</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
	%>

	<div class="wrapper">
		<a href="/"><img src="header.png" /></a>

		<h1>Posts</h1>
		<div class="rightalign">
			<a href="archive.jsp">Archive</a>
		</div>

		<%
			ObjectifyService.register(BlogPost.class);
			List<BlogPost> posts = ObjectifyService.ofy().load()
					.type(BlogPost.class).list();
			Collections.sort(posts);

			if (posts.isEmpty()) {
		%>
		<p>There are no posts to display!</p>
		<%
			} else {
				int count = 0;
				if (posts.size() > 5) {
					count = 5;
				} else {
					count = posts.size();
				}
				for (int i = 0; i < count; i++) {
					BlogPost post = posts.get(i);
					pageContext.setAttribute("titlePost", post.getTitle());
					pageContext.setAttribute("contentPost", post.getPost());
					pageContext.setAttribute("contentDate", post.getDate());
					pageContext.setAttribute("contentUser", post.getUser());
		%>
		<h2>${fn:escapeXml(titlePost)}</h2>
		<p>${fn:escapeXml(contentPost)}</p>
		<div class="datetime">
			${fn:escapeXml(contentUser)} <br>
			${fn:escapeXml(contentDate)}
		</div>
		<p>

			<%
				//ObjectifyService.ofy().delete().entity(post);
					}
				}
			%>
		
		<h1>Control Panel</h1>
		<%
			if (user == null) {
		%>
		<a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
			in</a> to start posting!
		</p>

		<%
			}

			else {
		%>
		<p>
			Click <a href="/makepost.jsp">here</a> to make a post!
		<p>
			<a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign
				out</a>.
		</p>
		<%
			}
		%>

		<p>
			Subscribe <a href="/subscribe.jsp">here!</a>
		</p>

	</div>

</body>
</html>