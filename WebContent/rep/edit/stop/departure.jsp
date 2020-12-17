<%@ page import="java.io.*,java.util.*, java.sql.*, daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%
	String name = request.getParameter("name"); 
	String tid = request.getParameter("tid");
	String sid = request.getParameter("sid");
	String oldArrival = request.getParameter("departure");
	
	SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm");
	Timestamp timestamp = new java.sql.Timestamp(DATE_FORMAT.parse(oldArrival).getTime());
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
				<a class="navItem" href="">FAQ</a>
				<a class="navItem" href="">Reservation</a>
   			</div>
			<div class="userCard">
			 	<p id="userType">Customer Representative</p>
			 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
				<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
			</div>
   		</div>
   			<form action="./updateStop.jsp">
				<div class="container">
					   <div class="heading">Changing departure:</div>
					   <div class="important"><b>Important: </b>Format must be 'MM/dd/yyyy HH:mm'</div>
					   <input type="text" name="name" value="<%=name%>" class="hide">
					   <input type="text" name="tid" value="<%=tid%>" class="hide">
					   <input type="text" name="sid" value="<%=sid%>" class="hide">					   
					   <input type="text" name="departure" value="<%=DATE_FORMAT.format(timestamp)%>">
					   <div class="original">Original departure: <%=DATE_FORMAT.format(timestamp)%></div>
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