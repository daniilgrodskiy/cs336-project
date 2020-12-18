<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="com.cs336.pkg.gwm.Schedule" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="java.time.LocalDateTime" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.util.Collections" %>
<%@ page import ="com.cs336.pkg.gwm.*" %>
<%@ page import ="java.text.DecimalFormat" %>

<%
	String origin = request.getParameter("origin");
	String dest = request.getParameter("dest");
	String date = request.getParameter("date");
	String age = request.getParameter("age");
	String disabled = request.getParameter("disabled");
	String round = request.getParameter("round");



	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");

	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from station");
	int originNum = 0;
	int destNum = 0;
	while(rs.next()){
		if(rs.getString("station_name").equals(origin)){
			originNum = rs.getInt("sid");
		}
		else if(rs.getString("station_name").equals(dest)){
			destNum = rs.getInt("sid");
		}
	}

	if(originNum == destNum){
		response.sendRedirect("reservationForm.jsp");
	}

	rs= st.executeQuery("select transit_line_name, CAST(arrival_datetime AS DATE) as d from schedule where origin='" + origin + "' and destination='" + dest + "' and CAST(arrival_datetime AS DATE)='" + date + "'");

	LinkedList<String> transitLines = new LinkedList<String>();
	while(rs.next()){
		transitLines.add(rs.getString("transit_line_name"));
	}

	rs = st.executeQuery("select * from schedule");

	ArrayList<String> line = new ArrayList<String>();
	ArrayList<Integer> fare = new ArrayList<Integer>();
	while(rs.next()){
		line.add(rs.getString("transit_line_name"));
		fare.add(rs.getInt("fare"));
	}


	rs = st.executeQuery("select * from stop where CAST(arrival_time AS DATE)='" + date + "'");

	ArrayList<ReservationStop> route = new ArrayList<ReservationStop>();
	ArrayList<ArrayList<ReservationStop>> routes = new ArrayList<ArrayList<ReservationStop>>();
	ArrayList<Integer> routeOriginIndexes = new ArrayList<Integer>();
	int trainNum = -1;
	while(rs.next()){
		if(trainNum == -1){
			trainNum = rs.getInt("tid");
		}
		if(rs.getInt("tid") != trainNum){
			ReservationStop temp = new ReservationStop();

			for (int i = 0; i < route.size()-1; i++) {
		        if (route.get(i).getArrivalTimeNum() > route.get(i+1).getArrivalTimeNum()) {
		            temp = route.get(i);
		            route.set(i, route.get(i + 1));
		            route.set(i + 1, temp);
		        }
		    }
			boolean afterOrigin = false;
			boolean foundDest = false;
			int c = 0;
			int index = 0;
			for(int j = 0; j < route.size(); j++){
				if(route.get(j).getStation() == originNum){
					afterOrigin = true;
					index = j;

				}
				if(afterOrigin == true){
					c++;
				}
				if(route.get(j).getStation() == destNum && afterOrigin){
					foundDest = true;
					break;
				}
			}
			if(foundDest){
				route.get(0).setTotalStops(route.size());
				route.get(0).setNumStops(c);
				routes.add(route);
				routeOriginIndexes.add(index);
			}
			trainNum = rs.getInt("tid");
			route = new ArrayList<ReservationStop>();
		}
		ReservationStop temp = new ReservationStop();
		temp.setStation(rs.getInt("sid"));
		temp.setTrain(rs.getInt("tid"));
		temp.setArrivalTime((Date)rs.getTimestamp("arrival_time"));
		temp.setDepartureTime((Date)rs.getTimestamp("departure_time"));
		for(int i = 0; i < line.size();i++){
			if(rs.getString("transit_line_name").equals(line.get(i))){
				temp.setTotalFare(fare.get(i));
				temp.setLineName(rs.getString("transit_line_name"));
			}
		}
		route.add(temp);
	}

	ReservationStop temp = new ReservationStop();


	for (int i = 0; i < route.size()-1; i++) {
        if (route.get(i).getArrivalTimeNum() > route.get(i+1).getArrivalTimeNum()) {
            temp = route.get(i);
            route.set(i, route.get(i + 1));
            route.set(i + 1, temp);
        }
    }
	boolean afterOrigin = false;
	boolean foundDest = false;
	int c = 0;
	int index = 0;
	for(int j = 0; j < route.size(); j++){
		if(route.get(j).getStation() == originNum){
			afterOrigin = true;
			index = j;

		}
		if(afterOrigin == true){
			c++;
		}
		if(route.get(j).getStation() == destNum && afterOrigin){
			foundDest = true;
			break;
		}
	}
	if(foundDest){
		route.get(0).setTotalStops(route.size());
		route.get(0).setNumStops(c);
		routes.add(route);
		routeOriginIndexes.add(index);
	}



	ArrayList<String> display = new ArrayList<String>();
	String build;
	int originIndex;
	for(int i = 0; i < routes.size(); i++){
		originIndex = routeOriginIndexes.get(i);
		build ="Departure:" + routes.get(i).get(originIndex).getDepartureTime() + "   |";
		build += "   Arrival:" + (routes.get(i).get(originIndex+routes.get(i).get(0).getNumStops()-1).getArrivalTime()) + "   |";
		Double total = new Double(routes.get(i).get(0).getTotalFare());
		Double cost = (total/routes.get(i).get(0).getTotalStops());
		cost *= routes.get(i).get(0).getNumStops();
		if(age.equals("child")){
			cost *= 0.75;
		}
		else if(age.equals("senior")){
			cost *= 0.65;
		}
		if(disabled.equals("yes")){
			cost *= 0.50;
		}if(round.equals("round trip")){
			cost*=2;
		}
		DecimalFormat numberFormat = new DecimalFormat("#");
		build += "   Fare:" + numberFormat.format(cost);
		display.add(build);
	}

	session.setAttribute("routesForReservation", routes);
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet"/>
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
	<%if(display.size()>0){ %><h1>Select an Available time</h1>
	<%} else {%><h1>No available times</h1><%} %>
		<form action="reservationConfirm.jsp" method="POST">
			<p><strong>Transit Lines:</strong></p>
				<select name="line" id="line">
					<% for(int i = 0; i < display.size(); i++){  %>

						<option><%="Option " + (i+1) + ") " + display.get(i) %></option>

						<% } %>
				</select>
				<input type="hidden" name="origin" value="<%=origin %>"/>
				<input type="hidden" name="dest" value="<%=dest %>"/>
			
			<%if(display.size()>0) %><br><input type="submit" class="btn" value="Confirm Reservation">

		</form>

	</div>

	<div id="back" class="btn"><a href="reservationForm.jsp">Go back</a></div>

	</body>

</html>