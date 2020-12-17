<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%
/* 	try {

 */		
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
	/* } catch (Exception e) {
		System.out.println(e);
	} */
		/* boolean originAll = false;
		String origin = request.getParameter("origin");
		if (origin == null) {
			originAll = true;
		} */
		
		SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm");
		SimpleDateFormat COMPARE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
		
		String filterOrigin = request.getParameter("filterOrigin");
		String filterDestination = request.getParameter("filterDestination");
		
		String filterDate = request.getParameter("filterDate");
		Timestamp filterDateTimestamp = Timestamp.valueOf("2020-12-20 10:10:10.0");
		if (filterDate != null) {
			filterDateTimestamp = new Timestamp(COMPARE_FORMAT.parse(filterDate).getTime());
		}
		

/* 		Timestamp filterDateTimestamp = new java.sql.Timestamp(DATE_FORMAT_COMPARE.parse(filterDate).getTime());
 */		
		

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
   		
   		<div style="text-align:center;">
	   		<form action="./dashboard.jsp">
		        <input class="btn" type=submit value="Show All Schedules">
	        </form>
        </div>
   		
   		
	   <div id="content">
	   	   		   
		   <%
		   		ArrayList<Schedule> schedules = new ArrayList<Schedule>();
		   		HashSet<String> origins = new HashSet<String>();
		   		HashSet<String> destinations = new HashSet<String>();

				while (result.next()) {
					// Select all stations that match with the schedule
					stmt = con.createStatement();
					query = 
							"select * from stop where transit_line_name = '" + result.getString("transit_line_name") + "' and tid = " + result.getInt("tid"); 
					ResultSet r2 = stmt.executeQuery(query);
					
					ArrayList<Stop> stops = new ArrayList<Stop>();
					
					while (r2.next()) {
						// Find stops
						stmt = con.createStatement();
						query = 
								"select * from station where sid = '" + r2.getString("sid") + "'";
						ResultSet r3 = stmt.executeQuery(query);
						r3.next();
						
						
						Station station = new Station(
							r3.getInt("sid"), 
							r3.getString("station_name"),
							r3.getString("city_name"),
							r3.getString("state")
						);
						
						stops.add(new Stop(
							station,
							new Train(r2.getInt("tid")),
							r2.getTimestamp("arrival_time"), 
							r2.getTimestamp("departure_time")
						));
						
					}
					
					Collections.sort(stops, new Comparator<Stop>() {
			            public int compare(Stop o1, Stop o2) {
			                return o1.getArrivalTime().compareTo(o2.getArrivalTime());
			            }
			        });

					origins.add(stops.get(0).getStation().getStationName()); 
					destinations.add(stops.get(stops.size() - 1).getStation().getStationName()); 
		            
										 
					schedules.add(new Schedule(
								new Train(result.getInt("tid")), 
								result.getString("transit_line_name"), 
								result.getFloat("fare"), 
								/* origin,
								destination, */
								/* result.getTimestamp("arrival_datetime"), 
								result.getTimestamp("departure_datetime"),  */
								result.getInt("travel_time"),
								stops
							));

				}
		        
		        // FILTER BAR
		        %>
		        <div class="filter-bar" >
			        <form action="./dashboard.jsp">
				        <div class="filters">
				        	<div>
				        		<div class="filter-heading">Origin:</div>
				        		<select name="filterOrigin">
				        		 	<%for (String origin: origins) {%>
				        				<option <%if (filterOrigin != null && filterOrigin.equals(origin)){%> selected <%}%>><%=origin%></option>
				        		 	<%}%>
				        		 </select>				        		
				        	</div>
				        	
				        	<div>
					        	<div class="filter-heading">Destination:</div>
					        		<select name="filterDestination" selected="<%=filterDestination%>">
					        		 	<%for (String destination: destinations) {%>
					        				<option <%if (filterDestination != null && filterDestination.equals(destination)){%> selected <%}%>><%=destination%></option>
					        		 	<%}%>
					        		 </select>
					        </div>
				        	<div>
				        		<div class="filter-heading">Date:</div>
				        		<input type="date" name="filterDate" value="<%if (filterDate != null) {%><%=filterDate%><%} else {%>2020-12-14<%}%>">
				        	</div>
				        </div>
				        <input class="btn" type=submit value="Filter">
			        </form>
			    </div>
			    
			    <div>
		        
		        <div id="editHeading">
		   			Click on any property below to edit it!
		   		</div>
		        
				<%
				// SCHEDULES
				int resultsAmount = 0;
				
				for (Schedule s : schedules) {
					
					if (filterOrigin != null && !s.getStops().get(0).getStation().getStationName().equals(filterOrigin)) {
						continue;
					}
					
					if (filterDestination != null && !s.getStops().get(s.getStops().size() - 1).getStation().getStationName().equals(filterDestination)) {
						continue;
					}
										
					if (filterDate != null && !COMPARE_FORMAT.format(filterDateTimestamp).equals(COMPARE_FORMAT.format(s.getStops().get(0).getArrivalTime()))) {
						continue;
					}
					
					
					resultsAmount++;
					%>
					<div class="card">
					  	<div class="flex">
					  		<div class="transitLineName">	  			
					  			<a 
					  				href="./edit/schedule/name.jsp?name=<%=s.getTransitLineName()%>&tid=<%=s.getTrain().getTid()%>">
					  			<%=(s.getTransitLineName())%>
					  			</a>
					  			
					  		</div>
					   		<div class="trainId">
					   			<a 
					  				href="./edit/schedule/train.jsp?name=<%=s.getTransitLineName()%>&tid=<%=s.getTrain().getTid()%>">
					  			Train: <%=s.getTrain().getTid()%>
					  			</a>
					   		</div>
					  	</div>
					   	<div class="stopsHeading">Stops:</div>
					   	<table>
						   	<tr>
						   		<th>Station</th>
								<th>City, State</th>
								<th>Arrival</th>
								<th>Departure</th>
							</tr>
							
						   	<%
						   	for (int i = 0; i < s.getStops().size(); i++) {
						   		Stop stop = s.getStops().get(i);
								%>
								<tr>
								 	<td>
								 		<%if (i == 0)
								    		out.print("<b>Origin: </b>");
								    	%>
								    	<%if (i == s.getStops().size() - 1)
								    		out.print("<b>Destination: </b>");
								    	%>
								    	<a href="./edit/station/stationName.jsp?sid=<%=stop.getStation().getSid()%>&oldStationName=<%=stop.getStation().getStationName()%>">
								    	
								    	<%=stop.getStation().getStationName()%>
								    	</a>
								    	
								    </td>
								    <td>
								    	<a href="./edit/station/city.jsp?sid=<%=stop.getStation().getSid()%>&oldCity=<%=stop.getStation().getCityName()%>">
								    	<%=stop.getStation().getCityName()%>
								    	</a>,
								    	<a href="./edit/station/state.jsp?sid=<%=stop.getStation().getSid()%>&oldState=<%=stop.getStation().getState()%>">
								    	<%=stop.getStation().getState()%>
								    	</a>
								    </td>
								    <td>
								    	<a href="./edit/stop/arrival.jsp?arrival=<%=DATE_FORMAT.format(stop.getArrivalTime())%>&name=<%=s.getTransitLineName()%>&tid=<%=s.getTrain().getTid()%>&sid=<%=stop.getStation().getSid()%>">
								    	<%=DATE_FORMAT.format(stop.getArrivalTime())%></td>
								    	</a>
								    <td>
								    	<a href="./edit/stop/departure.jsp?departure=<%=DATE_FORMAT.format(stop.getDepartureTime())%>&name=<%=s.getTransitLineName()%>&tid=<%=s.getTrain().getTid()%>&sid=<%=stop.getStation().getSid()%>">
								    	<%=DATE_FORMAT.format(stop.getDepartureTime())%>
								    	</a>				
								    </td>			    
								</tr>
								<%
							}
						   	%>
						 
						</table>
					   	<div class="fare">
						   	<a 
								href="./edit/schedule/fare.jsp?name=<%=s.getTransitLineName()%>&tid=<%=s.getTrain().getTid()%>&oldFare=<%=s.getFare()%>">
						  		Fare: <%=s.getFare()%>
						  	</a>
					   	</div>
					  </div>
					  
					<%
				}
				if (resultsAmount == 0) {%>
					<div class="no-results">No results found!</div>
					
				<%}
			   
			   con.close();
		   %>
	   </div>
   </body>
</html>