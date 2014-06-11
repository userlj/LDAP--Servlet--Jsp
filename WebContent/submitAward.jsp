<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="domain.LoginUserBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Submit Award</title>
<script>

	function autoFillSub(chosenIndex) {
		scn = document.getElementById("scn"+chosenIndex).innerHTML;
		sdept = document.getElementById("sdept"+chosenIndex).innerHTML;
		suid = document.getElementById("suid"+chosenIndex).innerHTML;
		document.getElementById("scn").value = scn;
		document.getElementById("sdept").value = sdept;
		document.getElementById("suid").value = suid;
	}
	
	function autoFillRec(chosenIndex) {
		rcn = document.getElementById("rcn"+chosenIndex).innerHTML;
		rdept = document.getElementById("rdept"+chosenIndex).innerHTML;
		rmail = document.getElementById("rmail"+chosenIndex).innerHTML;
		ruid = document.getElementById("ruid"+chosenIndex).innerHTML;
		document.getElementById("rcn").value = rcn;
		document.getElementById("rdept").value = rdept;
		document.getElementById("rmail").value = rmail;
		document.getElementById("ruid").value = ruid;
	}
	
	function myreset() {
		//alert(document.cookie);
		document.cookie= "scn=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "suid=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "rdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "rmail=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "ruid=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		/*document.getElementById("scn").value = "";
		document.getElementById("sdept").value = "";
		document.getElementById("rcn").value = "";
		document.getElementById("rdept").value = "";
		document.getElementById("rmail").value = "";*/
		document.getElementById('submitForm').reset();
	}
	
	
	function mysubmit() {
		document.cookie= "scn=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "suid=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "rdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "rmail=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "sdept=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		document.cookie= "ruid=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
	}
	function setCookieSub(chosenIndex) {
		
		sCn = document.getElementById("scn"+chosenIndex).innerHTML;
		sDept = document.getElementById("sdept"+chosenIndex).innerHTML;
		sUid = document.getElementById("suid"+chosenIndex).innerHTML;
		/*rCn = document.getElementById("rcn").innerHTML;
		rDept = document.getElementById("rdept").innerHTML;
		rMail = document.getElementById("rmail").innerHTML;*/
		
		document.cookie= "scn=" + sCn + ";";
		document.cookie= "sdept=" + sDept + ";";
		document.cookie= "suid=" + sUid + ";";
		/*document.cookie= "rcn=" + rCn + ";";
		document.cookie= "rdept=" + rDept + ";";
		document.cookie= "rmail=" + rMail + ";";*/
		//alert(document.cookie);
		//document.cookie = "name=; expires=Thu, 01 Jan 1970 00:00:01 GMT;";
		//document.cookie= "scn=hello0;";
		/*document.cookie= "sdept=hello1;";
		document.cookie= "rcn=hello2;";
		document.cookie= "rdept=hello3;";
		document.cookie= "rmail=hello4;";*/
		
		//value = document.getElementById(name).innerHTML;
		//document.cookie= name + "=" + value;
		//alert(document.cookie);
	}

	function getCookie(attr) {
		//alert(document.cookie);
		var name = attr + "=";
		var ca = document.cookie.split(';');
		//alert(ca[0] + ca[1] + ca[2] + ca[3] + ca[4]);
		for(var i=0; i<ca.length; i++) {
		  	var c = ca[i].trim();
		  	if (c.indexOf(name)==0) {
		  		//alert(c.substring(name.length,c.length));
		  		return c.substring(name.length,c.length);
			}
		 }
		return "";
	}
	
	function reFill() {
		document.getElementById("scn").value = getCookie("scn");
		document.getElementById("sdept").value = getCookie("sdept");
		document.getElementById("suid").value = getCookie("suid");
		document.getElementById("rcn").value = getCookie("rcn");
		document.getElementById("rdept").value = getCookie("rdept");
		document.getElementById("rmail").value = getCookie("rmail");
		document.getElementById("ruid").value = getCookie("ruid");
	}
	
</script>
</head>
<body onload="reFill();">
	<%
		String s = (String) (session.getAttribute("status"));
	%>

	<%
		if (s != null) {
			out.print("Welcome, " + session.getAttribute("user") + "!");
	%>
	<form style="display: inline" name="logout" action="Logout"
		method="post">
		<input type="submit" value="logout">
	</form>
	<p>

		<%
			} else {
		%>
		<jsp:forward page="/entrance.jsp" />
		<%
			}
		%>
	
	<fieldset>
		<legend>Award Form</legend>
		<p>
		<form action="DirectorySearch" method="post">
			Please enter submitter's last name to search: <input type="text"
				name="slname"> <input type="submit" value="search">
			<p>
				<%
					ArrayList<LoginUserBean> srchUsersList = (ArrayList<LoginUserBean>) request
							.getAttribute("srchSubResults");

					if ((srchUsersList != null) && (srchUsersList.size() != 0)) {
						//out.print(request.getAttribute("name"));
						for (int i = 0; i < srchUsersList.size(); i++) {
							LoginUserBean srchUser = srchUsersList.get(i);
				%>
			
			<table>
				<tr>
					<td id="scn<%=i%>"
						onclick="autoFillSub(<%=i%>);setCookieSub(<%=i%>);"><%=srchUser.getCn()%></td>
					<td hidden id="suid<%=i%>"><%=srchUser.getUid()%></td>
					<td hidden id="sdept<%=i%>"><%=srchUser.getDeptNo()%></td>
					<td hidden><%=srchUser.getMail()%></td>
				</tr>
			</table>
			<%
				}
				} else {
					//out.println("<font color='red'>No matching results, please again.</font>");
				}
			%>
		</form>

		<form action="DirectorySearch2" method="post">
			Please enter recipient's last name to search: <input type="text"
				name="slname"> <input type="submit" value="search">
			<p>
				<%
					ArrayList<LoginUserBean> srchUsersList2 = (ArrayList<LoginUserBean>) request
							.getAttribute("srchRecResults");

					if ((srchUsersList2 != null) && (srchUsersList2.size() != 0)) {
						//out.print(request.getAttribute("name"));
						for (int i = 0; i < srchUsersList2.size(); i++) {
							LoginUserBean srchUser = srchUsersList2.get(i);
				%>
			
			<table>
				<tr>
					<td id="rcn<%=i%>" onclick="autoFillRec(<%=i%>);setCookie();"><%=srchUser.getCn()%></td>
					<td hidden id="ruid<%=i%>"><%=srchUser.getUid()%></td>
					<td hidden id="rdept<%=i%>"><%=srchUser.getDeptNo()%></td>
					<td hidden id="rmail<%=i%>"><%=srchUser.getMail()%></td>
				</tr>
			</table>
			<%
				}
				} else {
					//out.println("<font color='red'>No matching results, please again.</font>");
				}
			%>
		</form>


		<form id="submitForm" action="submitAward" method="post">

			Submitter:
			<ul>
				<li>Name: <input id="scn" name="scn" readonly type="text"></li>
				<li>Department#: <input id="sdept" name="sdept" readonly
					type="text"></li>
			</ul>
			<input type="hidden" id="suid" name="suid">
			Recipient:
			<ul>
				<li>Name: <input id="rcn" name="rcn" readonly type="text"></li>
				<li>Department#: <input id="rdept" name="rdept" readonly
					type="text"></li>
				<li>Mail: <input id="rmail" name="rmail" readonly type="text"></li>
			</ul>
			<input type="hidden" id="ruid" name="ruid">

			<textarea id="desc" name="desc" rows="4" cols="50" placeholder="You have made a difference..."></textarea>
			<p>
				<input type="button" onclick="myreset();" value="clear"> 
				<input type="submit" onclick="mysubmit();" value="save">
		</form>
	</fieldset>
	<p><a href='entrance.jsp'>Home</a>
</body>
</html>