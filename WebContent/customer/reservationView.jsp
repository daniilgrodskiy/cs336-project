<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.Date" %>
<%@ page import ="com.cs336.eliza.Reservation" %>

<%

	//get sort param, if exists
	//can be either trans (sort by transit line) or name (sort by customer last name)
	String sort = "";
	try {
		sort = request.getParameter("sort"); 
	} catch (Exception e) {
	} finally{
		if(sort == null){sort = "trans";}
	}
	

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	//get all reservations, including transit line name
	Statement st = con.createStatement();
	Statement stt = con.createStatement();
	ResultSet rs;
	
	String transSort = "select rid, t2.tid, email, first_name, last_name, date, total_fare, transit_line_name from schedule s join (select h.rid, tid, email, first_name, last_name, date, total_fare from has h join (select email, first_name, last_name, t2.rid, date, total_fare from (select m.email, first_name, last_name, m.rid from makes m join customer c where m.email = c.email)t2 join reservation r where t2.rid = r.rid)t2 where h.rid = t2.rid)t2 where s.tid = t2.tid and email='" + session.getAttribute("userEmail") + "' order by transit_line_name";
	
	
	rs = st.executeQuery(transSort);
	
	
	LinkedList<Reservation> reservations = new LinkedList<Reservation>();
	LinkedList<Reservation> pastReservations = new LinkedList<Reservation>();
	
	long millis=System.currentTimeMillis();  
	java.util.Date today=new java.util.Date(millis);
	
	while(rs.next()){
		int id = rs.getInt("rid");
		String e = rs.getString("email");
		String fn = rs.getString("first_name");
		String ln = rs.getString("last_name");
		String t = rs.getString("transit_line_name");
		int f = rs.getInt("total_fare");
		Date d = rs.getDate("date");
		Reservation r = new Reservation(id, f, e, fn, ln, t, d);
		if(d.compareTo(today)>=0){
			stt.executeUpdate("update makes set is_past=1 where rid=" + id);
			reservations.add(r);
		} else if(d.compareTo(today)<0){
			stt.executeUpdate("update makes set is_past=0 where rid=" + id);
			pastReservations.add(r);
		}
		
	}
	
	rs.close();
	
	
	
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div id="content">
	<h1>Current Reservations</h1>
	<table>
	<tr>
		<th>Reservation ID</th>
		<th>Customer Email</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Transit Line Name</th>
		<th>Total fare</th>
		<th>Reservation Origin</th>
		<th>Reservation Destination</th>
		<th>Date</th>
	</tr>
	
	<%for (int i = 0; i < reservations.size(); i++){
	
	//gets origin and destination station names
		ResultSet o = st.executeQuery("select station_name from origin o join station s where o.sid = s.sid and o.rid = '" + reservations.get(i).getRid() + "';");
		String origin = "";
		if(o.next()){
			origin = o.getString("station_name");
		}
		o.close();
		
		ResultSet d = st.executeQuery("select station_name from destination d join station s where d.sid = s.sid and d.rid = '" + reservations.get(i).getRid() + "';");
		String dest = "";
		if(d.next()){
			dest = d.getString("station_name");
		}
		d.close();
	//
	
	
	%>
		<tr>
		<td><%=reservations.get(i).getRid() %></td>
		<td><%=reservations.get(i).getEmail() %></td>
		<td><%=reservations.get(i).getFname() %></td>
		<td><%=reservations.get(i).getLname() %></td>
		<td><%=reservations.get(i).getTrans() %></td>
		<td><%=reservations.get(i).getFare() %></td>
		<td><%=origin %></td>
		<td><%=dest %></td>
		<td><%=reservations.get(i).getDate() %></td>
		</tr>
	<%} %>
	</table>
	
	<h1>Past Reservations</h1>
	<table>
	<tr>
		<th>Reservation ID</th>
		<th>Customer Email</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Transit Line Name</th>
		<th>Total fare</th>
		<th>Reservation Origin</th>
		<th>Reservation Destination</th>
		<th>Date</th>
	</tr>
	
	<%for (int i = 0; i < pastReservations.size(); i++){
	
		//gets origin and destination station names
		ResultSet o = st.executeQuery("select station_name from origin o join station s where o.sid = s.sid and o.rid = '" + pastReservations.get(i).getRid() + "';");
		String origin = "";
		if(o.next()){
			origin = o.getString("station_name");
		}
		o.close();
		
		ResultSet d = st.executeQuery("select station_name from destination d join station s where d.sid = s.sid and d.rid = '" + pastReservations.get(i).getRid() + "';");
		String dest = "";
		if(d.next()){
			dest = d.getString("station_name");
		}
		d.close();
	//
	
	%>
		<tr>
		<td><%=pastReservations.get(i).getRid() %></td>
		<td><%=pastReservations.get(i).getEmail() %></td>
		<td><%=pastReservations.get(i).getFname() %></td>
		<td><%=pastReservations.get(i).getLname() %></td>
		<td><%=pastReservations.get(i).getTrans() %></td>
		<td><%=pastReservations.get(i).getFare() %></td>
		<td><%=origin %></td>
		<td><%=dest %></td>
		<td><%=pastReservations.get(i).getDate() %></td>
		</tr>
	<%} %>
	</table>
	
	<form action="reservationDelete.jsp" method="POST">
		<input type="text" name="IDForDelete" id="IDForDelete" placeholder="Enter Reservation ID" required></input>
		<input type="submit" class="btn" value="Delete Reservation">
	</form>
	
	</div>
	
	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
