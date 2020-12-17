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
	
	Statement st = con.createStatement();
	ResultSet maxFidResult = st.executeQuery("select max(fid) from faq");
	maxFidResult.next();
	int fid = maxFidResult.getInt("max(fid)") + 1;
	
	String email = request.getParameter("email");
	String question = request.getParameter("question");
	String answer = "";
	

	if (email.equals("null")) {
		System.out.println("EMAIL IS NULL");
		response.sendRedirect("./faq.jsp");
	}
	
	st.executeUpdate("insert into `faq` (`fid`, `email`, `question`,`answer`) VALUES (" + 
			fid + ", '" + 
			email + "', '" +
			question + "', '"  + 
			answer + "')"
		);
	
	response.sendRedirect("./faq.jsp");
%>

