<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>

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
	
	<body>
	<div id="content">
	<h1>Browse Schedules</h1>
		<form action="reservationDetails.jsp" method="POST">
			<p><strong>Origin:</strong></p>
				<select name="origin" id="origin">
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
				<input type="date" name="date" id="reservationDate" placeholder="YYYY-MM-DD"></input>
			<p><strong>Age of Rider:</strong></p>
				<select name="age" id="age">
						<option>adult</option>
						<option>child</option>
						<option>senior</option>
				</select>
			<p><strong>Is the rider disabled?:</strong></p>
				<select name="disabled" id="disabled">
						<option>no</option>
						<option>yes</option>
				</select>
			<br><input type="submit" class="btn" value="Find Routes">
		</form>
	
	</div>
	
	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
	
	</body>
	
	


</html>


