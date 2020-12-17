<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%	
 		if (session.getAttribute("user") == null) 
			response.sendRedirect("../success.jsp");
 
 		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
		
		// Create a SQL statement
		Statement stmt = con.createStatement();
		
		// Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String query = "select * from schedule;"; 
		
		// Run the query against the database.
		ResultSet result = stmt.executeQuery(query);
		
		SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm");
		SimpleDateFormat COMPARE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
		
		String filterOrigin = request.getParameter("filterOrigin");
		String filterDestination = request.getParameter("filterDestination");
		
		String filterDate = request.getParameter("filterDate");
		
		Timestamp filterDateTimestamp = Timestamp.valueOf("2020-12-20 10:10:10.0");
		if (filterDate != null) {
			filterDateTimestamp = new Timestamp(COMPARE_FORMAT.parse(filterDate).getTime());
		}
			
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="./schedules.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   		<div class="flex-nav">
   			<div>
   				<h1 id="title">Trainy </h1>
				<a class="navItem" href="./dashboard.jsp">Schedules</a>
				<a class="navItem" href="./faq.jsp">FAQ</a>
				<a class="navItem" href="./reservations.jsp">Reservations</a>
   			</div>
			<div class="userCard">
			 	<p id="userType">Customer Representative</p>
			 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
				<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
			</div>
   		</div>
   		
	   <div id="content">
	   
	   		
	   	   
	   </div>
   </body>
</html>