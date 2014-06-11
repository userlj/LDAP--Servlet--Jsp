<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Delete</title>
</head>
<body>

<%

String s = (String)session.getAttribute("status");
String t = (String)session.getAttribute("type");

if (s != null) {
	out.print("Welcome, " + session.getAttribute("user") + "!");
%>
	<form style="display: inline" name="logout" action="Logout" method="post">
		<input type="submit" value="logout">
	</form>
	
<%
	if((t.equals("administrator"))) {
%>
	<p>
	<form action="Delete" method="post">
		Award ID: <input type="text" name="delId">
		<input type="submit" value="delete">
	</form>
<%
	} else {
%><p><b>"Access denied. Contact the YEA! Administrator at x3301."</b>
<%	}
} else {
%>
	<jsp:forward page="entrance.jsp"/>
<%
}
%>

<p><a href='entrance.jsp'>Home</a>
<a href='search.jsp'>Back</a>
</body>
</html>