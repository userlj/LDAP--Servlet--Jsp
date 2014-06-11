<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Search</title>
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
		<h2>Search Page</h2>
	</center>
	<h3>Enter zero or more criteria:</h3>
	<form action="Search" method="post">
	<ul>
	
		<li>Submit Date: 
			<p>From <input type="text" name="sDateFrom"> To <input type="text" name="sDateTo">
		<li>Chosen Date:
			<p>From <input type="text" name="cDateFrom"> To <input type="text" name="cDateTo">
			

		<li>Submitter Serial: <input type="text" name="suid">
		<li>Submitter Last Name: <input type="text" name="slname">
		<li>Recipient Serial: <input type="text" name="ruid">
		<li>Recipient Last Name: <input type="text" name="rlname">
		<li>Submitter Department#: 
			<select name="sdept">
				<option></option>
				<option value="4231">4231</option>
				<option value="4321">4321</option>
				<option value="5551">5551</option>
				<option value="5561">5561</option>
				<option value="6441">6441</option>
				<option value="6541">6541</option>
				<option value="6711">6711</option>
				<option value="8211">8211</option>
				<option value="8321">8321</option>
				<option value="8441">8441</option>
				<option value="8671">8671</option>
				<option value="9671">9671</option>
			</select>
		</li>
		<li>Recipient Department#: 
			<select name="rdept">
				<option></option>
				<option value="4231">4231</option>
				<option value="4321">4321</option>
				<option value="5551">5551</option>
				<option value="5561">5561</option>
				<option value="6441">6441</option>
				<option value="6541">6541</option>
				<option value="6711">6711</option>
				<option value="8211">8211</option>
				<option value="8321">8321</option>
				<option value="8441">8441</option>
				<option value="8671">8671</option>
				<option value="9671">9671</option>
			</select>
		</li>
		<li>Award Selection
			<select name="award">
				<option></option>
				<option value="award1">Award1</option>
				<option value="award2">Award2</option>
				<option value="award3">Award3</option>
				<option value="award4">Award4</option>
			</select>

			<li>Number of results that come back per page(1-100)<input type="text" name="numOfPage">
	</ul>
	<input type="submit" value="search">
	</form>
	<p>
	<a href="delete.jsp">Delete Awards</a>
	<a href="update.jsp">Update Awards</a>
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
<a href='admin.jsp'>Back</a>
</body>
</html>