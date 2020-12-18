<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="com.cs336.pkg.gwm.ReservationStop" %>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("customer")) {
	response.sendRedirect("../success.jsp");
}
%>
<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select max(rid) from reservation");
	rs.next();
	int id = rs.getInt("max(rid)")+1;
	
	String line = request.getParameter("line");
	int end = 8;
	while(line.charAt(end) != ')'){
		end++;
	}
	int selected = (Integer.parseInt(line.substring(7, end)))-1;
	
	ArrayList<ArrayList<ReservationStop>> routes = (ArrayList<ArrayList<ReservationStop>>)session.getAttribute("routesForReservation");
	ReservationStop res = routes.get(selected).get(0);
	Timestamp insertDate = (Timestamp) res.getDepartureTime();
	
	end = line.length();
	while(line.charAt(end-1) != ':'){
		end--;
	}
	int fare = Integer.parseInt(line.substring(end, line.length()));
	
	rs.close();
	
	String originName=request.getParameter("origin");
	ResultSet temp1 = st.executeQuery("select * from station where station_name = '" + originName + "'");
    int origin = -1;
    if(temp1.next()){
    	origin = temp1.getInt("sid");
    }
    temp1.close();
    
	String destName = request.getParameter("dest");
	ResultSet temp2 = st.executeQuery("select * from station where station_name = '" + destName + "'");
    int dest = -1;
    if(temp2.next()){
    	dest = temp2.getInt("sid");
    }
    temp2.close();
	
	st.executeUpdate("insert into `reservation` (`rid`,`date`,`total_fare`) VALUES (" + id + ",'" + insertDate + "'," + fare + ")");
	st.executeUpdate("insert into `makes` (`rid`,`is_past`,`email`) VALUES (" + id + ",'" + 0 + "','" + session.getAttribute("userEmail") + "')");
	st.executeUpdate("insert into `has` (`rid`,`tid`) VALUES (" + id + "," + res.getTrain() + ")");
	st.executeUpdate("insert into origin(departure_time, rid, sid) values ('2000-12-12', '" + id +"', '" + origin + "')");
	st.executeUpdate("insert into destination(arrival_time, rid, sid) values ('2000-12-12', '" + id +"', '" + dest + "')");
	
%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   <div id="content">
		<p>Your reservation has been made</p>
		
		<p><a href="./dashboard.jsp">Continue</a></p>

   </div>
   </body>
</html>
