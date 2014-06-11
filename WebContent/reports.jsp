<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Reports</title>
<script>
//Referentce: http://www.jsmadeeasy.com/javascripts/Forms/Date%20Validation/template.htm
function validateDate()
{

		mydate = document.getElementById("date").value;
	// Checks for the following valid date formats:
	// MM/DD/YYYY

		var datePat = /^(\d{2})(\/)(\d{2})(\/)(\d{4})$/;

		var matchArray = mydate.match(datePat); // is the format ok?

		if (matchArray == null) 
		{
			//alert("Date Is Not In Proper Format\n\ne.g. MM/DD/YYYY");
			//return false;
			return true;
		}

		month = matchArray[1]; // parse date into variables
		day = matchArray[3];
		year = matchArray[5];

		if (month < 1 || month > 12)	// check month range
		{
			alert("Month Must Be Between 1 And 12");
			return false;
		}

		if (day < 1 || day > 31) 
		{
			alert("Day Must Be Between 1 And 31");
			return false;
		}

		if ((month==4 || month==6 || month==9 || month==11) && day==31) 
		{
			alert("Month "+month+" Doesn't Have 31 Days!");
			return false;
		}
	
		if (month == 2)	// check for february 29th
		{ 
			var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
			if (day>29 || (day==29 && !isleap)) 
			{
				alert("February " + year + " Doesn't Have " + day + " Days!");
				return false;
			}
		}

//		var now = new Date();
//		var dob = new Date(mydate);
//		if (dob > now)
//		{
//			alert("Future Dates Cannot Be The Date Of Birth!");
//			return false;
//		}
		
		return true;  // date is valid

}

</script>
</head>
<body>

<%
		String s = (String) session.getAttribute("status");
		String t = (String) session.getAttribute("type");

		if (s != null) {
			out.print("Welcome, " + session.getAttribute("user") + "!");
%>
	<form style="display: inline" name="logout" action="Logout"
		method="post">
		<input type="submit" value="logout">
	</form>

<%
		if ((t.equals("manager")) || (t.equals("administrator"))) {
	%>
	<h2>Get a Report</h2>
	<p>
	<form action="Report" method="post">
		Date: <input id="date" name="date" type="text" placeholder="MM/DD/YYYY"><p>
	
	<ul>
		<li>
			<input type="radio" checked="checked" name="reportType" value="dept"><b> Department Report</b>
		<p>
		
			<ul>
			<li>Department#: 
				<select id="deptNo" name="deptNo">
					<option>4231</option>
					<option>4321</option>
					<option>5551</option>
					<option>5561</option>
					<option>6441</option>
					<option>6541</option>
					<option>6711</option>
					<option>8211</option>
					<option>8321</option>
					<option>8441</option>
					<option>8671</option>
					<option>9671</option>
				</select>
			</li>
		</ul>
		
		<li>
			<input type="radio" name="reportType" value="empl"><b> Employee Report</b>
		<p>
			
			<ul>
				<li>Employee Serial: 
					<input type="text" name="eserial">
				
				<li>
					<input type="radio" checked="checked" name="etype" value="submitter"> Submitter
					<input type="radio" name="etype" value="recipient"> Recipient
				</li>
			</ul>
	
	</ul>
	<input type="submit" onclick="return validateDate()" value="Get Report">
	</form>
	
		<%} else {
%>
<p>Sorry, you don not have access to this page.
<br>Only administrators and managers are allowed to this section.

<%
		}

} else {%>
	<jsp:forward page="/entrance.jsp" />
<%
}
%><p><a href='entrance.jsp'>Home</a>


</body>
</html>