<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="com.cs336.pkg.Trains" %>


<%
	int origin = Integer.parseInt(request.getParameter("origin")); 
	int dest = Integer.parseInt(request.getParameter("dest")); 
    String date = request.getParameter("date");
    String sort = request.getParameter("sort");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    Statement st = con.createStatement();
    ResultSet rs;
    
    if(sort.equals("fare")){
    	rs = st.executeQuery("select *, CAST(arrival_datetime AS DATE) as d from schedule where origin='" + origin + "' and destination='" + dest + "' and CAST(arrival_datetime AS DATE)='" + date + "' ORDER BY fare");
    } else if (sort.equals("arriv")){
    	rs = st.executeQuery("select *, CAST(arrival_datetime AS DATE) as d from schedule where origin='" + origin + "' and destination='" + dest + "' and CAST(arrival_datetime AS DATE)='" + date + "' ORDER BY arrival_datetime");  
	} else if (sort.equals("depart")){
		rs = st.executeQuery("select *, CAST(arrival_datetime AS DATE) as d from schedule where origin='" + origin + "' and destination='" + dest + "' and CAST(arrival_datetime AS DATE)='" + date + "' ORDER BY departure_datetime");  
	} else{
    	rs = st.executeQuery("select *, CAST(arrival_datetime AS DATE) as d from schedule where origin='" + origin + "' and destination='" + dest + "' and CAST(arrival_datetime AS DATE)='" + date + "'");
	}
	
    LinkedList<Trains> ll = new LinkedList<Trains>();
	while(rs.next()) {
		int tid = rs.getInt("tid");
		String tran = rs.getString("transit_line_name");
		int og = rs.getInt("origin");
		int dst = rs.getInt("destination");
		Timestamp a = rs.getTimestamp("arrival_datetime");
		Date arriv = new Date(a.getTime());
		Timestamp d = rs.getTimestamp("departure_datetime");
		Date depart = new Date(d.getTime());
		int fare = rs.getInt("fare");
		
		Trains t = new Trains(tid, tran, og, dst, arriv, depart, fare, 0);
		ll.add(t);
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
	<h1>Trains</h1>
	<table id="table">
	<tr>
		<th>Train Number</th>
		<th>Train Line</th>
		<th>Train origin</th>
		<th>Train destination</th>
		<th>Train arrival time</th>
		<th>Train Departure Time</th>
		<th>Train fare</th>
	</tr>
	
	<% for(int i = 0; i < ll.size(); i++){  %>
	
	<tr>
		<td><%=String.valueOf(ll.get(i).getTid()) %></a></td>
		<td><%=ll.get(i).getTran() %></td>
		<td><%=String.valueOf(ll.get(i).getOrig()) %></td>
		<td><%=String.valueOf(ll.get(i).getDest()) %></td>
		<td><%=String.valueOf(ll.get(i).getArriv()) %></td>
		<td><%=String.valueOf(ll.get(i).getDepart()) %></td>
		<td><%=String.valueOf(ll.get(i).getFare()) %></td>
	</tr>
	

	
	<% } %>
	
	</table>
	
	<br/>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="text" id="origin" name="origin" value="<%=origin %>"><br>
	<input type="text" id="dest" name="dest" value="<%=dest %>"><br>
	<input type="date" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="fare">Sort by fare (low to high)</button>
	</form>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="hidden" id="origin" name="origin" value="<%=origin %>"><br>
	<input type="hidden" id="dest" name="dest" value="<%=dest %>"><br>
	<input type="hidden" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="depart">Sort by departure time (soonest to latest)</button>
	</form>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="hidden" id="origin" name="origin" value="<%=origin %>"><br>
	<input type="hidden" id="dest" name="dest" value="<%=dest %>"><br>
	<input type="hidden" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="arriv">Sort by arrival time (soonest to latest)</button>
	</form>
	
	
	
	<br/>
	<form action="moreInfo.jsp" method="POST" id="moreinfo" name="moreinfo">
	<p><strong>Get More Info</strong></p>
	What is the train number?<input type="number" id="tid" name="tid" required/><br/>
	What is the train line name?<input type="text" id="tran" name="tran" required/><br/>
	<input type="submit" class="btn" value="Search"/><br/>
	</form>
	
	</div>
	
	<div id="back" class="btn"><a href="browse.jsp">Go back</a></div>
	
	</body>



</html>
