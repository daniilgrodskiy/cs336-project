<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.LinkedList" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="java.util.ArrayList" %>
<%@ page import ="com.cs336.pkg.gwm.ReservationStop" %>

<% 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	String rid = request.getParameter("IDForDelete");

	
	Statement st = con.createStatement();
	
	st.executeUpdate("delete from makes where rid=" + rid);
	st.executeUpdate("delete from has where rid=" + rid);
	st.executeUpdate("delete from reservation where rid=" + rid);
	
%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   <div id="content">
		<p>Your reservation has been deleted</p>
		
		<p><a href="./reservationView.jsp">Continue</a></p>

   </div>
   </body>
</html>
