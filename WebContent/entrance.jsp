<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="shortcut icon" href="images/icon/meng_full.ico"/>
	<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
	<title>Entrance Page</title>
	<style>
	
	</style>
</head>
<body>

<%

String s = (String)session.getAttribute("status");
//String v = (String)session.getAttribute("recipient");
String t = (String)session.getAttribute("type");

if (s != null) {
	out.print("Welcome, " + session.getAttribute("user") + "!");
%>
	<form style="display: inline" name="logout" action="Logout" method="post">
		<input type="submit" value="logout">
	</form>
	
	<center><h1>Welcome to YEA! Award!</h1></center>
	<ul>
		<li>
			<h3>Program Guidelines</h3>
				<p>
				Current YEA! Process is for an employee to print a copy of the Word form off the web.
				Fill in and hand it to the recipient, usually in front of the recipient's manager. 
				The recipient fills out what certificate they would like and mails or hand carries the
				form to the YEA! Administrator. The Administrator then manually processes the award by 
				making a copy of the submission to mail to the recipient's manager and mails back the 
				award form with the award certificate to the recipient.
				</p>
		</li>
		<li><h3><a href="submitAward.jsp">Submit an Award</a></h3></li>
	<%
//	if(v == "true") {
	%>
		<li><h3><a href="viewAward.jsp">View and Select Awards</a></h3></li>
	<%
//	}
	if((t.equals("manager"))||(t.equals("administrator"))) {
	%>
		<li><h3><a href="reports.jsp">Reports</a></h3></li>
	<%
	}
	if((t.equals("administrator"))) {
	%>
		<li><h3><a href="admin.jsp">Administrator Function</a></h3></li>
	<%
	}
	%>
	</ul>
<%
} else {
%>
	<form name="login" action="Login" method="post">
		Username: <input type="text" name="username">
		Password: <input type="password" name="password">
		<input type="submit" value="login">
	
		<input readonly style="border-style:none;" type="text" name="result" value="<%if(request.getAttribute("result") != null){out.print(request.getAttribute("result"));} %>">
	</form>
	
	<center><h1>Welcome to YEA! Award!</h1></center>
		<ul>
		<li>
			<h3>Program Guidelines</h3>
				<p>
				Current YEA! Process is for an employee to print a copy of the Word form off the web.
				Fill in and hand it to the recipient, usually in front of the recipient's manager. 
				The recipient fills out what certificate they would like and mails or hand carries the
				form to the YEA! Administrator. The Administrator then manually processes the award by 
				making a copy of the submission to mail to the recipient's manager and mails back the 
				award form with the award certificate to the recipient.
				</p>
		</li>
		</ul>
<%
}
%>

</body>
</html>