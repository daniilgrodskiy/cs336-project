<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.lang.Integer.*" %>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("admin")) {
	response.sendRedirect("../success.jsp");
}
%>


<%
	int month = Integer.parseInt(request.getParameter("month")); 

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
	
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select sum(total_fare) as sales from reservation where EXTRACT(month from date) ='" + month + "'");
	
	int sales = 0;
	if(rs.next()){
		sales = rs.getInt("sales");
	}
	
%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div id="content">
	<%if(sales == 0){ %>There were no sales in the selected month.
	<%} else {%><p>Total sales for the month amounted to $<%=sales%>. Good work!<%} %>
	</div>
	
		<div id="back" class="btn"><a href="salesReport.jsp">Go back</a></div>

	
	</body>


</html>
