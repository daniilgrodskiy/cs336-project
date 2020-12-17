<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>

<%
	String operation = request.getParameter("operation"); 
	System.out.println("\n\n\n\n\n\n\n----------\nOperation is: " + operation + "\n------\n\n\n\n");
	int ssn = Integer.parseInt(request.getParameter("Social Security Number"));
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
    
    Statement st = con.createStatement();
    
    //checks success
    //-1 means nothing happened
    //1 means success
    //2 means duplicate item
    //3 means rep does not exist to be edited
    //4 means attempted to change ssn to an ssn already in db
    int success = -1;
    if(operation.equals("delete")){
    	st.executeUpdate("delete from reps where ssn='" + ssn + "'");
    	System.out.println("\n\n\n\n-----------Attempted: delete from reps where ssn='" + ssn + "'");
    	success = 1;
    } else if(operation.equals("add")){
    	ResultSet rs;
    	rs = st.executeQuery("select * from reps where ssn='" + ssn + "'");
    	if(rs.next()){
    		success = 2;
    		System.out.println("value already in db");
    	} else{
    	String fname = request.getParameter("First Name"); 
		String lname = request.getParameter("Last Name"); 
		String user = request.getParameter("Username"); 
		String pass = request.getParameter("Password"); 
    	st.executeUpdate("insert into reps values ('" + lname + "', '" + user + "', '" + pass + "', '" + fname + "', '"+ssn+"')");
		System.out.println("\n\n\n\n-----------Attempted: insert into reps values ('" + lname + "', '" + user + "', '" + pass + "', '" + fname + "', '"+ssn+"')"); 
    	success = 1;
    	}
    } else if(operation.equals("edit")){
    	ResultSet rs;
    	rs = st.executeQuery("select * from reps where ssn='" + ssn + "'");
    	if(!rs.next()){
    		System.out.println("value not in db");
    		success = 3;
    		rs.close();
    	} else{
    		rs.close();
    		System.out.println("value in db");
    	String fname = request.getParameter("First Name"); 
		String lname = request.getParameter("Last Name"); 
		String user = request.getParameter("Username"); 
		String pass = request.getParameter("Password"); 
		String newssn = request.getParameter("editssn");
		if(newssn.length() > 0){
			int editssn = Integer.parseInt(newssn);
			ResultSet r;
			r = st.executeQuery("select * from reps where ssn='" + newssn + "'");
	    	if(r.next()){
	    		System.out.println("cannot edit to existing ssn");
	    		success = 4;
	    	}else{
				st.executeUpdate("update reps set ssn ='" + editssn + "' where (ssn ='" + ssn + "')");
				System.out.println("\n\n\n\n-----------Attempted: update reps set ssn ='" + editssn + "' where (ssn ='" + ssn + "')");
				success = 1;
			}
		}
		if(fname.length() > 0){
			st.executeUpdate("update reps set first_name ='" + fname + "' where (ssn ='" + ssn + "')");
			System.out.println("\n\n\n\n-----------Attempted: update reps set first_name ='" + fname + "' where (ssn ='" + ssn + "')");
			success = 1;
		}
		if(lname.length() > 0){
			st.executeUpdate("update reps set last_name ='" +lname + "' where (ssn ='" + ssn + "')");	
			System.out.println("\n\n\n\n-----------Attempted: update reps set last_name ='" +lname + "' where (ssn ='" + ssn + "')");
			success = 1;
		}
		if(user.length() > 0){
			st.executeUpdate("update reps set username ='" + user+ "' where (ssn ='" + ssn + "')");
			System.out.println("\n\n\n\n-----------Attempted: update reps set username ='" + user+ "' where (ssn ='" + ssn + "')");
			success = 1;
		}
		if(pass.length() > 0){
			st.executeUpdate("update reps set password ='" + pass+ "' where (ssn ='" + ssn + "')");
			System.out.println("\n\n\n\n-----------Attempted: update reps set password ='" + pass+ "' where (ssn ='" + ssn + "')");
			success = 1;
		}
		}
    }


    
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="../styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
	   <div id="content">
	   <%if(success == 1){ %>
			<p>Successfully <%=operation %><% if(operation.equals("edit")){ %>e<%}%>d Customer representative with social security number <%=ssn %></p>
	   <%} else if(success == 2){ %>
	   		<p>There already exists a customer representative with social security number <%=ssn %>. Please try with another social security number.</p>
	   <%} else if(success == 3){ %>
	   		<p>There exists no customer representative with social security number <%=ssn %>. Please try with another social security number.</p>
	   <%} else if(success == 4){ %>
	   		<p>There already exists a customer representative with that social security number. You cannot change a user's social security number to be the same as someone else's. Please try with another social security number.</p>
	   <%} %>
	   </div>
	   
	   	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
   </body>
</html>