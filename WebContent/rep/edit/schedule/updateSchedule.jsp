<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	String oldTid = request.getParameter("oldTid");   
    String newTid = request.getParameter("newTid");
    
    String oldName = request.getParameter("oldName");
    String newName = request.getParameter("newName");
    
    String newFare = request.getParameter("newFare");
    
    if (newTid != null) {
    	// Update tid
    	// Update train
    	String update = 
  			"update train" +
  			" set tid = " + newTid +
  			" where tid = " + oldTid;
    	
    	stmt.executeUpdate(update);
    			
    	// Update schedule
    	update = 
  			"update schedule" +
  			" set tid = " + newTid +
  			" where transit_line_name = '" + oldName + "'" + 
  			" and tid = " +  oldTid;
    	
    	stmt.executeUpdate(update);
    			
    	// Update stop
    	update = 
  			"update stop" +
  			" set tid = '" + newTid +
  			" where transit_line_name = '" + oldName + "'" + 
  		  	" and tid = " +  oldTid;
    	
    	stmt.executeUpdate(update);    	
    } else if (newName != null) {
    	// Update name
    	// Update schedule
    	String update = 
  			"update schedule" +
  			" set transit_line_name = '" + newName + "'" +
  			" where transit_line_name = '" + oldName + "'" + 
  			" and tid = " + oldTid;
    	
    	stmt.executeUpdate(update);
    			
    	// Update stop
    	update = 
  			"update stop" +
  			" set transit_line_name = '" + newName + "'" +
  			" where transit_line_name = '" + oldName + "'" + 
  			" and tid = " + oldTid;
    	
    	stmt.executeUpdate(update);
    } else if (newFare != null) {
    	// Update schedule
    	String update = 
  			"update schedule" +
  			" set fare = " + newFare +
  			" where transit_line_name = '" + oldName + "'" + 
  			" and tid = " + oldTid;
    	
    	stmt.executeUpdate(update);
    	stmt.executeUpdate(update);
    }
 
	response.sendRedirect("../../dashboard.jsp");
} catch(Exception e) {
	System.out.println(e);
	response.sendRedirect("../../dashboard.jsp");
}


%>