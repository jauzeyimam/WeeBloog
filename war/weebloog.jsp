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
<title>The Weblog of Jauzey Imam and Zander Smith</title>
</head>
<body>
	<%
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
	%>
	<div class="header">
		<a href="/"><img src="header.png" /></a>
		<div class="controlpanel">
			<h2>Control Panel</h2>
			<%
				if (user == null) {
			%>
			<a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				in to start posting!</a>
			</p>

			<%
				}

				else {
			%>
			<p>
				<a href="/makepost.jsp">Click here to make a post!</a>
			<p>
				<a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Sign
					out</a>
			</p>
			<%
				}
			%>

			<p>
				<a href="/subscribe.jsp">Subscribe here!</a>
			</p>
			<p>
				<a href="/unsubscribe.jsp">Unsubscribe here.</a>
			</p>



		</div>
	</div>

	<div class="wrapper">

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
					pageContext.setAttribute("contentDate",
							post.getDateString());
					pageContext.setAttribute("contentUser", post.getUser());
		%>
		<h2>${fn:escapeXml(titlePost)}</h2>
		${contentPost}
		<div class="datetime">
			${fn:escapeXml(contentUser)} <br> ${fn:escapeXml(contentDate)}
		</div>
		<p>

			<%
				//ObjectifyService.ofy().delete().entity(post);
					}
				}
			%>
		
	</div>
	<div class="authors">
		<b>
		jauzey imam<br>
		zander smith<br>
		nadeem zaki<br>
		mark judice</b>
	</div>


</body>
</html>