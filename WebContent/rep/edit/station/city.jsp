<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%
	String sid = request.getParameter("sid");
	String oldCity = request.getParameter("oldCity");
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="../edit.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   		<div class="flex-nav">
   			<div>
   				<h1 id="title">Trainy </h1>
				<a class="navItem" href="../../dashboard.jsp">Schedules</a>
				<a class="navItem" href="../../faq.jsp">FAQ</a>
				<a class="navItem" href="../../reservations.jsp">Reservation</a>
   			</div>
			<div class="userCard">
			 	<p id="userType">Customer Representative</p>
			 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
				<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
			</div>
   		</div>
   			<form action="./updateStation.jsp">
				<div class="container">
					   <div class="heading">Changing city:</div>
					   <input type="text" name="sid" value="<%=sid%>" class="hide">
					   <input type="text" name="newCity" value="<%=oldCity%>">
					   <div class="original">Original city: <%=oldCity%></div>
					   <input type="submit" class="btn" value="Save">
				</div>
			</form>
			<form action="../../dashboard.jsp">
				<div class="container">
					<input type="submit" class="btn" value="Cancel">
				</div>
	   		</form>
   </body>
</html>