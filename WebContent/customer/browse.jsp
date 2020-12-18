<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("customer")) {
	response.sendRedirect("../success.jsp");
}
%>
<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from station");
	
	LinkedList<String> ll = new LinkedList<String>();
	while(rs.next()){
		String station = rs.getString("station_name");
		ll.add(station);
	}

%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<div class="flex-nav">
  		<div>
  			<h1 id="title">Trainy </h1>
			<a class="navItem" href="./browse.jsp">Browse Trains</a>
			<a class="navItem" href="./reservationForm.jsp">Make a Reservation</a>
			<a class="navItem" href="./reservationView.jsp">My Reservations</a>
			<a class="navItem" href="./faq/faq.jsp">FAQ</a>
  			</div>
		<div class="userCard">
		 	<p id="userType">Customer</p>
		 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
			<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
		</div>
   	</div>
	
	<body>
	<div id="content">
	<h1>Browse Schedules</h1>
		<form action="searchResults.jsp" method="POST">
		
		
		
			<p><strong>Origin:</strong></p>
				<select name="origin" id="origin" value="<ll.get(i)>">
					<% for(int i = 0; i < ll.size(); i++){  %>
	
						<option><%=ll.get(i) %></option>
						
						<% } %>
				</select>
				
				
			<p><strong>Destination:</strong></p>
				<select name="dest" id="dest">
					<% for(int i = 0; i < ll.size(); i++){  %>
	
						<option><%=ll.get(i) %></option>
						
						<% } %>
				</select>
			
			<p><strong>Date(YYYY-MM-DD):</strong></p>
				<input type="date" id="date" name="date" value="2020-12-14" required><br>
			<input type="hidden" id="sort" name="sort" value="none"><br>
			<input type="submit" class="btn"" value="Search">
		</form>
	
	</div>
	
	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
	
	</body>


</html>
