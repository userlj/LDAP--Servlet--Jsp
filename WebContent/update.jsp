<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Update</title>
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
		<form action="Update" method="post">
			Award ID: <input type="text" name="delId">
			Attribute: 
			<select name="attr">
				<option value="valid">validation</option>
				<option value="suid">submitter ID</option>
				<option value="submitterN">submitter name</option>
				<option value="submitterD">submitter department</option>
				<option value="ruid">recipient ID</option>
				<option value="recipientN">recipient name</option>
				<option value="recipientD">recipient department</option>
				<option value="recipientM">recipient mail</option>
				<option value="awardType">award type</option>
				<option value="description">description</option>
				<option value="submitDate">submit date</option>
				<option value="chosenDate">chosen date</option>
			</select>
			Value: <input type="text" name="value">
			<input type="submit" value="update">
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
<a href='admin.jsp'>Back</a>
</body>
</html>