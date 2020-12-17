<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<%

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	// Create a SQL statement
	Statement stmt = con.createStatement();
	
	String fid = request.getParameter("fid");   
    String answer = request.getParameter("answer");
    
    if (answer != null) {
    	// Update train
    	String update = 
  			"update faq" +
  			" set answer = '" + answer + "'" +
  			" where fid = " + fid;
    	
    	stmt.executeUpdate(update);	
    } 
    
	response.sendRedirect("./faq.jsp");
} catch(Exception e) {
	System.out.println(e);
	response.sendRedirect("./faq.jsp");
}


%>