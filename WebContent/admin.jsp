<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Administrator Functions</title>
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
	<center>
		<h2>Administration Page</h2>
	</center>
	
	<ul>
		<li>Access Control(N/A)
		<li>Award Data(N/A)
		<li>TQM Category(N/A)
		<li>News(N/A)
		<li>Change Max Submissions(N/A)
		<li><a href="search.jsp">Search</a>
		<li>Delete Old Data(N/A)
	</ul>
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
</body>
</html>