<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%	
	if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("rep")) {
		response.sendRedirect("../success.jsp");
	}
 
 		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
		
		SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");
		SimpleDateFormat COMPARE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
		
		String filterTrain = request.getParameter("filterTrain");		
		String filterDate = request.getParameter("filterDate");
		
		Timestamp filterDateTimestamp = Timestamp.valueOf("2020-12-20 10:10:10.0");
		if (filterDate != null) {
			filterDateTimestamp = new Timestamp(COMPARE_FORMAT.parse(filterDate).getTime());
		}
			
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="./reservations.css" type="text/css" rel="stylesheet" />
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
	   		<form action="./reservations.jsp">
		        <input class="btn" type=submit value="Show All Reservations">
	        </form>
        </div>
   		
   		
	   <div id="content">
	   
	   		<%
				// Reservation
				Statement stmt = con.createStatement();
				String reservationQuery = "select * from reservation";
				ResultSet reservationResult = stmt.executeQuery(reservationQuery);
				
				List<Reservation> reservations = new ArrayList<Reservation>();
				HashSet<Integer> trains = new HashSet<Integer>();
				
				while (reservationResult.next()) {

					// Has
					String hasQuery = "select * from has where rid = " + reservationResult.getInt("rid");
					
					stmt = con.createStatement();
					ResultSet hasResult = stmt.executeQuery(hasQuery);
					while(hasResult.next()){
					
					// Makes
					String makesQuery = "select * from makes where rid = " + hasResult.getInt("rid");
					
					stmt = con.createStatement();
					ResultSet makesResult = stmt.executeQuery(makesQuery);
					makesResult.next();
					
					// Customer
					String customerQuery = "select * from customer where email = '" + makesResult.getString("email") + "'";
					
					stmt = con.createStatement();
					ResultSet customerResult = stmt.executeQuery(customerQuery);
					while(customerResult.next()){
					//customerResult.next();
					
					Customer customer = new Customer(
						customerResult.getString("email"),
						customerResult.getString("username"),
						customerResult.getString("first_name"),
						customerResult.getString("last_name")
					);
					
					Reservation reservation = new Reservation(
						reservationResult.getInt("rid"),
						hasResult.getInt("tid"),
						reservationResult.getTimestamp("date"),
						reservationResult.getDouble("total_fare"),
						customer
					);
					
					reservations.add(reservation);
					trains.add(hasResult.getInt("tid"));
					}//if customerResult
					}//if makesResult
					
				}
				
				
				
		        
		        // FILTER BAR
		        %>
		        <div class="filter-bar" >
			        <form action="./reservations.jsp">
				        <div class="filters">			        	

				        	<div>
					        	<div class="filter-heading">Train:</div>
					        		<select name="filterTrain" selected="">
					        		 	<%for (int train: trains) {%>
					        				<option><%=train%></option>
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
			    
		<%
		for (Reservation r : reservations) {
			String firstName = r.getCustomer().getFirstName();
			String lastName = r.getCustomer().getLastName();
			int train = r.getTid();
			double fare = r.getTotalFare();
			Timestamp date = r.getDate();
			
			if (filterTrain != null && Integer.parseInt(filterTrain) != train) {
				continue;
			}
			
			if (filterDate != null && !COMPARE_FORMAT.format(filterDateTimestamp).equals(COMPARE_FORMAT.format(date))) {
				continue;
			}
		%>
			<div class="card">
				<div class="flex">
					<div class="name">
						<%=firstName%> <%=lastName%>
					</div>
					<div class="train">
						Train: <%=train%>
					</div>
				</div>
				<div class="date">
					Date: <%=DATE_FORMAT.format(date)%>
				</div>
				<div class="fare">
					Total fare: $<%=fare%>
				</div>
				
			</div>
			
		<%
		}
		
		con.close();
		%>   	   
	   </div>
   </body>
</html>