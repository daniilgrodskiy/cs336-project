<%@page import="java.security.spec.RSAPrivateCrtKeySpec"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="com.cs336.pkg.Trains" %>
<%@ page import ="com.cs336.pkg.Station" %>
<%
	int tid = Integer.parseInt(request.getParameter("tid")); 
	String tran = request.getParameter("tran"); 
	System.out.print("TRAN IS: " + tran + " TID IS: " + tid);
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    Statement st = con.createStatement();
  
    
    //gets the train meeting the search
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
    rs.close();
    
    
  //gets all station names
    ResultSet r; 
  	r = st.executeQuery("select sid, station_name from station");
    LinkedList<Station> stations = new LinkedList<Station>();
    while(r.next()){
    	int stid = r.getInt("sid");
    	String sname = r.getString("station_name");
    	Station temp = new Station(stid, sname);
    	stations.add(temp);
    }
    r.close();
  	
    //gets stops of the train
    ResultSet s;
    s = st.executeQuery("select sid from stop where tid = '" + t.getTid() + "' and transit_line_name ='" + t.getTran() + "' and arrival_time between'"+ t.getArriv() +"' and '" + t.getDepart() + "' ORDER BY arrival_time");
    
    LinkedList<Station> stops = new LinkedList<Station>();
    while(s.next()){
    	int sid = s.getInt("sid");
    	String station_name ="";
    	for(int i = 0; i < stations.size(); i++){
			if(stations.get(i).getSid() == sid){
				station_name = stations.get(i).getStationName();
			}
    	}
    	Station station = new Station(sid, station_name);
    	stops.add(station);
    }
    
    t.addStations(stops);
    System.out.println("No of stops is: " + stops.size());
    
    for(int i = 0; i < stops.size(); i++){
    	System.out.println(stops.get(i).getStationName());
    }
    ///
    

    

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
	
	<table style="text-align:left!important">
	<h1>Train Stops</h1>
	<% for(int i = 0; i < stops.size(); i++){%>
		<tr><td>
		<%=stops.get(i).getStationName()%>
		
		</td></tr>
	
	<% } %>
	</table>
	
	</div>
	<div id="back" class="btn"><a href="browse.jsp">Go back</a></div>
	</body>


</html>