<%@ page import ="java.sql.*" %>
<%

try {
    String newUsername = request.getParameter("newUsername");
    String newPassword = request.getParameter("newPassword");
    String newEmail = request.getParameter("newEmail");
    String newFirstName = request.getParameter("newFirstName");
    String newLastName = request.getParameter("newLastName");
    int k = 0;
    if(newUsername.equals("")) k = 1/0;
    if(newPassword.equals("")) k = 1/0;
    if(newEmail.equals("")) k = 1/0;
    if(newUsername.equals("")) k = 1/0;
    if(newFirstName.equals("")) k = 1/0;
    if(newLastName.equals("")) k = 1/0;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    
  	// insert statement for the customer table:
	String insert = "INSERT INTO customer "
			+ "VALUES (?,?,?,?,?)";
  	
	// prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	// parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, newEmail);
	ps.setString(2, newUsername);
	ps.setString(3, newPassword);
	ps.setString(4, newFirstName);
	ps.setString(5, newLastName);
	
	// run the query against the DB
	ps.executeUpdate();

	// close the connection; don't forget to do it, otherwise you're keeping the resources of the server allocated.
	con.close();
	
	// the username will now be stored in the session
	session.setAttribute("user", newUsername); 

	response.sendRedirect("success.jsp");
} catch(Exception e) {
	//out.print(e);
	out.print("Invalid Sign up. <a href='login.jsp'>Try again.</a>");
}
    
    
    
    
    /* 
    
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("insert into customer values ('" + newUsername + "', '" + newPassword + "'");
    if (rs.next()) {
        session.setAttribute("user", newUsername); // the username will be stored in the session
        out.println("Welcome " + newUsername);
        out.println("<a href='logout.jsp'>Log out</a>");
        response.sendRedirect("success.jsp");
    } else {
        out.println("Invalid password <a href='login.jsp'>try again</a>");
    } */
%>