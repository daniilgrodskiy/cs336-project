<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.text.SimpleDateFormat"  %>
<%@ page import ="java.time.format.DateTimeFormatter.*" %>
<%@ page import ="com.cs336.eliza.Trains" %>
<%@ page import ="com.cs336.eliza.Station" %>


<%
	String originName = request.getParameter("origin");
	String destName = request.getParameter("dest");
    String date = request.getParameter("date");
    String sort = request.getParameter("sort");
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    //returns all trains that match the search and sort conditions
    Statement st = con.createStatement();
    ResultSet temp1 = st.executeQuery("select * from station where station_name = '" + originName + "'");
    int origin = -1;
    if(temp1.next()){
    	origin = temp1.getInt("sid");
    }
    temp1.close();
    
    ResultSet temp2 = st.executeQuery("select * from station where station_name = '" + destName + "'");
    int dest = -1;
    if(temp2.next()){
    	dest = temp2.getInt("sid");
    }
    temp2.close();
    
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
	
    //creates a ll of all trains
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
		int travel = rs.getInt("travel_time");
		
		Trains t = new Trains(tid, tran, og, dst, arriv, depart, fare, travel);
		ll.add(t);
	}
	
	rs.close();
	
	 
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
    for(int k = 0;  k < ll.size(); k++){
        ResultSet s;
        Trains t = ll.get(k);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
        String d = sdf.format(t.getArriv());
        
        s = st.executeQuery("select station.sid, station_name from stop join station where stop.sid = station.sid and tid = '" + t.getTid() + "' and transit_line_name ='" + t.getTran() + "' and arrival_time between'"+ sdf.format(t.getArriv()) +"' and '" + sdf.format(t.getDepart()) + "' ORDER BY arrival_time");      
        LinkedList<Station> stops = new LinkedList<Station>();

        while(s.next()){
        	int sid = s.getInt("sid");
        	String station_name = s.getString("station_name");
        	Station station = new Station(sid, station_name);
        	stops.add(station);
        }
        
        t.addStations(stops);
        s.close();
    }
    
    System.out.println("\n\n\n\n----------\nOrig is " + origin + "\n Dest is " + dest);

    
%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div id="content" style="width:90%!important">
	<h1>Browse Schedules</h1>
	
	<!-- 
		<% if(ll.size() < 1){ %>
		<p>There are no trains with these specifications.</p>
	
	<%} else{%>
	 -->

	<% for(int i = 0; i < ll.size(); i++){  %>
	<p><strong>Train <%=String.valueOf(ll.get(i).getTid()) %></strong></p>
	
	<table>
	<tr>
		<th>Train Line</th>
		<th>Train origin</th>
		<th>Train destination</th>
		<th>Train arrival time</th>
		<th>Train Departure Time</th>
		<th>Train fare</th>
		<th>Travel time (hours)</th>
		<th>Train stations</th>
	</tr>
	
	<tr>
		<td><%=ll.get(i).getTran() %></td>
		
		<!-- Gets station names from ints -->
		<%
		String orig_name ="";
		String dest_name="";
    	for(int h = 0; h < stations.size(); h++){
			if(stations.get(h).getSid() == ll.get(i).getOrig()){
				orig_name = stations.get(h).getStationName();
			} else if (stations.get(h).getSid() == ll.get(i).getDest()){
				dest_name = stations.get(h).getStationName();
			}
    	} %>
		
		<td><%=orig_name%></td>
		<td><%=dest_name %></td>
		<td><%=String.valueOf(ll.get(i).getArriv()) %></td>
		<td><%=String.valueOf(ll.get(i).getDepart()) %></td>
		<td><%=String.valueOf(ll.get(i).getFare()) %></td>
		<td><%=String.valueOf(ll.get(i).getTravel()) %></td>
		<td>
		<% int size = ll.get(i).getStations().size();
		for(int j = 0; j < size; j++){%>
		<%=ll.get(i).getStations().get(j).getStationName()%>
		<% if(j < size - 1){%>, <%} %>
		<%} %>
		
		</td>
	</tr>

	
	</table>
	
	
	<%} %>
	
	

	<br/>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="text" id="origin" name="origin" value="<%=originName %>"><br>
	<input type="text" id="dest" name="dest" value="<%=destName %>"><br>
	<input type="date" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="fare">Sort by fare (low to high)</button>
	</form>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="hidden" id="origin" name="origin" value="<%=originName %>"><br>
	<input type="hidden" id="dest" name="dest" value="<%=destName %>"><br>
	<input type="hidden" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="depart">Sort by departure time (soonest to latest)</button>
	</form>
	
	<form action="searchResults.jsp" method="POST">
	<div style="display:none">
	<input type="hidden" id="origin" name="origin" value="<%=originName %>"><br>
	<input type="hidden" id="dest" name="dest" value="<%=destName %>"><br>
	<input type="hidden" id="date" name="date" value="<%=date %>"><br>
	</div>
	<button type="submit" name="sort" value="arriv">Sort by arrival time (soonest to latest)</button>
	</form>
	
	
	
	<br/>
	
	<!--  <%} %>-->
	
	</div>
	
	<div id="back" class="btn"><a href="browse.jsp">Go back</a></div>
	
	</body>



</html>
