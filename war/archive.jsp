<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>

<%@ page import="java.util.Collections"%>
<%@ page import="com.googlecode.objectify.*"%>
<%@ page import="weebloog.BlogPost"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" href="style.css" type="text/css" />
<title>Archive</title>
</head>
<body>
	<div class="wrapper">
		<h1>Posts</h1>
		<div class="rightalign">
			<a href="/">Home</a>
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
				for (BlogPost post : posts) {
					pageContext.setAttribute("titlePost", post.getTitle());
					pageContext.setAttribute("contentPost", post.getPost());
					pageContext.setAttribute("contentDate", post.getDate());
					pageContext.setAttribute("contentUser", post.getUser());
		%>
		<h2>${fn:escapeXml(titlePost)}</h2>
		<p>${fn:escapeXml(contentPost)}</p>
		<div class="datetime">${fn:escapeXml(contentUser)}|
			${fn:escapeXml(contentDate)}</div>

		<%
			//ObjectifyService.ofy().delete().entity(post);
				}
			}
		%>


	</div>
</body>
</html>