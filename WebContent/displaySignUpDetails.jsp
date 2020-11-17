<%@ page import ="java.sql.*" %>
<%

try {
    String newUsername = request.getParameter("newUsername");   
    String newPassword = request.getParameter("newPassword");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    
  	// insert statement for the users table:
	String insert = "INSERT INTO users "
			+ "VALUES (?, ?)";
  	
	// prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	// parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, newUsername);
	ps.setString(2, newPassword);
	
	// run the query against the DB
	ps.executeUpdate();

	// close the connection; don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	
	// the username will now be stored in the session
	session.setAttribute("user", newUsername); 

	response.sendRedirect("success.jsp");
} catch(Exception e) {
	out.print(e);
	out.print("Insert failed. <a href='login.jsp'>Try again.</a>");
}
    
    
    
    
    /* 
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("insert into users values ('" + newUsername + "', '" + newPassword + "'");
    if (rs.next()) {
        session.setAttribute("user", newUsername); // the username will be stored in the session
        out.println("Welcome " + newUsername);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    } */
%>