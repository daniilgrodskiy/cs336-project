<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	// Schedule/Station properties
	String tid = request.getParameter("tid");   
    String name = request.getParameter("name");
    String sid = request.getParameter("sid");
    
    // Do arrival and departure
    String arrival = request.getParameter("arrival");
    String departure = request.getParameter("departure");
    
    SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy HH:mm");

    if (arrival != null) {
    	// Update stop    	
    	Timestamp arrivalTimestamp = new java.sql.Timestamp(DATE_FORMAT.parse(arrival).getTime());
    	
    	String update = 
  			"update stop" +
  			" set arrival_time = '" + arrivalTimestamp + "'" + 
  			" where transit_line_name = '" + name + "'" + 
  		  	" and tid = " +  tid +
    		" and sid = " +  sid;
    	
    	stmt.executeUpdate(update);    	
    } else if (departure != null) {
    	// Update stop
    	Timestamp departureTimestamp = new java.sql.Timestamp(DATE_FORMAT.parse(departure).getTime());
    	
    	String update = 
  			"update stop" +
  			" set departure_time = '" + departureTimestamp + "'" + 
  			" where transit_line_name = '" + name + "'" + 
  		  	" and tid = " +  tid +
    		" and sid = " +  sid;
    	
    	stmt.executeUpdate(update);
    } 
 
	response.sendRedirect("../../dashboard.jsp");
} catch(Exception e) {
	System.out.println(e);
	response.sendRedirect("../../dashboard.jsp");
}


%>