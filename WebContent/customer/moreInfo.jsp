<%@page import="java.security.spec.RSAPrivateCrtKeySpec"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="com.cs336.pkg.Trains" %>
<%
	int tid = Integer.parseInt(request.getParameter("tid")); 
	String tran = request.getParameter("tran"); 
	System.out.print("TRAN IS: " + tran + " TID IS: " + tid);
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from schedule where tid='" + tid + "' and transit_line_name='" + tran+ "'");
    
    Trains t;
    if(rs.next()) {
		int trainid = rs.getInt("tid");
		String transitline = rs.getString("transit_line_name");
		int og = rs.getInt("origin");
		int dst = rs.getInt("destination");
		Timestamp arriv = rs.getTimestamp("arrival_datetime");
		Timestamp depart = rs.getTimestamp("departure_datetime");
		int travel = rs.getInt("travel_time");
		int fare = rs.getInt("fare");
		t = new Trains(tid, tran, og, dst, arriv, depart, fare, travel);
    } else{
    	t = new Trains();
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
	<% if (t.getTid() == 0) { %>
		<p>There are no trains with that information.</p>
	<% } 
	else {%>
	<h1>Train Details</h1>
	<table style="text-align:left!important">
	<tr><td>Train Id: <%=t.getTid()%></td></tr>
	<tr><td>Train Transit Line Name: <%=t.getTran()%></td></tr>
	<tr><td>Train Origin: Station <%=t.getOrig()%></td></tr>
	<tr><td>Train Destination: Station <%=t.getDest()%></td></tr>
	<tr><td>Train Arrival Time: <%=t.getArriv()%></td></tr>
	<tr><td>Train Departure Time: <%=t.getDepart()%></td></tr>
	<tr><td>Fare: $<%=t.getFare()%></td></tr>
	<tr><td>Travel Time: <%=t.getTravel()%> hours</td></tr>

	<% }%>
	
	</table>
	
	</div>
	<div id="back" class="btn"><a href="browse.jsp">Go back</a></div>
	</body>


</html>