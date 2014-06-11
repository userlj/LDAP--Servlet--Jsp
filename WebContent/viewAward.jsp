<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>View and Select Award</title>
<script>
	function test() {
		document.getElementById("test0").innerHTML = document.getElementById("awardType").value;
	}
</script>
</head>
<body>

	<%
		String s = (String) (session.getAttribute("status"));
	
		if (s != null) {
			out.print("Welcome, " + session.getAttribute("user") + "!");
	%>

	<form style="display: inline" name="logout" action="Logout"
		method="post">
		<input type="submit" value="logout">
	</form>

	<p>
	<center>
		<h2>Awards Given:</h2>
	</center>
	<%
		try {
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				String url = "jdbc:mysql://bigyellowcat.cs.binghamton.edu/meng";
				Connection con = DriverManager.getConnection(url, "meng",
						"meng7842");
				// create sql statement
				String qs = "SELECT * FROM Award_Submitted WHERE "
						+ "suid='" + session.getAttribute("user") + "'"
						+ "AND valid='true' AND chosenDate IS NOT NULL";

				Statement stmt = con.createStatement();
				// execute the statement
				ResultSet rs = stmt.executeQuery(qs);
				// get an output stream to send back the data

				// process the result set
				out.println("<center><table border='1px'>");
				out.println("<th>recipient</th><th>award type</th><th>submit date</th><th>chosen date</th>");
				out.println("<tr>");
				while (rs.next()) {
					String recipientN = rs.getString("recipientN");
					String awardType = rs.getString("awardType");
					String submitDate = rs.getString("submitDate");
					String chosenDate = rs.getString("chosenDate");
					out.println("<td>" + recipientN + "</td><td>"
							+ awardType + "</td><td>" + submitDate 
							+"</td><td>" + chosenDate + "</td></tr>");
				}
				out.println("</table></center>");
	%>
	<p>
	<center>
		<h2>Awards Received:</h2>
	</center>
	<p>
		<%
			String qs2 = "select * from Award_Submitted WHERE "
							+ "ruid='" + session.getAttribute("user") + "'"
							+ "AND valid='true' AND chosenDate IS NOT NULL";
					ResultSet rs2 = stmt.executeQuery(qs2);
					// get an output stream to send back the data

					// process the result set
					out.println("<center><table border='1px'>");
					out.println("<th>submitter</th><th>award type</th><th>submit date</th><th>chosen date</th>");
					out.println("<tr>");
					while (rs2.next()) {
						String submitterN = rs2.getString("submitterN");
						String awardType = rs2.getString("awardType");
						String submitDate = rs2.getString("submitDate");
						String chosenDate = rs2.getString("chosenDate");
						out.println("<td>" + submitterN + "</td><td>"
								+ awardType + "</td><td>" + submitDate 
								+"</td><td>" + chosenDate + "</td></tr>");
					}
					out.println("</table></center>");

					String qs3 = "SELECT * FROM Award_Submitted WHERE "
							+ "ruid='" + session.getAttribute("user") + "'"
							+ "AND valid='true' AND awardType='N/A'";
					
					ResultSet rs3 = stmt.executeQuery(qs3);
					// get an output stream to send back the data

					// process the result set
					String a = "";
					String d = "";
					String asid = "";
%>					
					<p>
					<textarea readonly style="border-style:none;width:300px;color:blue;bold:true;" name="msg">
<%if(request.getAttribute("msg") != null){out.print(request.getAttribute("msg"));} %>
					</textarea>
					<h3>Please select your awards:</h3>
					<br>Details of awards:
					<ul>
						<li>award1: introduction of award1...</li>
						<li>award2: introduction of award2...</li>
						<li>award3: introduction of award3...</li>
						<li>award3: introduction of award4...</li>
					</ul>
<%
					while (rs3.next()) {	
						
						a = rs3.getString("submitterN");
						d = rs3.getString("submitDate");
						asid = rs3.getString("asid");
%>

					<p>
					Submitter: <%=a %>
					<br>
					Submit Date: <%=d %>
					<form action="selectAward" method="post">
					<input type="hidden" name="asid" value=<%=asid %>>
						<select id="awardType" name="awardType">
							<option value="award1">award1</option>
							<option value="award2">award2</option>
							<option value="award3">award3</option>
							<option value="award4">award4</option>
						</select>
						<input type="submit" value="save">
					</form>
<%
					}%>

<%				}

				catch (SQLException se) {
					se.printStackTrace();
				}

		} else {
%>
	<jsp:forward page="/entrance.jsp" />
<%
		}
%>
<br><a href='entrance.jsp'>Home</a>
</body>
</html>