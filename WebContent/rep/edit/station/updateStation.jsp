<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	// Station properties
    String newStation = request.getParameter("newStationName");
    String newCity = request.getParameter("newCity");
    String newState = request.getParameter("newState");
	
    String sid = request.getParameter("sid");
    
    // Do arrival and departure
    
    if (newStation != null) {
    	// Update station
    	String update = 
  			"update station" +
  			" set station_name = '" + newStation + "'" +
  			" where sid = " + sid; 
    	
    	stmt.executeUpdate(update);    	
    } else if (newCity != null) {
    	String update = 
   			"update station" +
   			" set city_name = '" + newCity + "'" +
   			" where sid = " + sid; 
        	
        stmt.executeUpdate(update); 
    } else if (newState != null) {
    	String update = 
   			"update station" +
   			" set state = '" + newState + "'" +
   			" where sid = " + sid; 
        	
        stmt.executeUpdate(update); 
    }
 
	response.sendRedirect("../../dashboard.jsp");
} catch(Exception e) {
	System.out.println(e);
	response.sendRedirect("../../dashboard.jsp");
}


%>