<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	String tid = request.getParameter("tid");   
    String name = request.getParameter("name");
   
  	String update = 
			"delete from schedule" +
			" where tid = " + tid +
			" and transit_line_name = '" + name + "'";
  	
  	stmt.executeUpdate(update);
    con.close();

	response.sendRedirect("../../dashboard.jsp");
} catch(Exception e) {
	System.out.println(e);
	response.sendRedirect("../../dashboard.jsp");
}


%>