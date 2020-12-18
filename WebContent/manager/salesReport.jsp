<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("admin")) {
	response.sendRedirect("../success.jsp");
}
%>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div class="flex-nav">
  		<div>
  			<h1 id="title">Trainy </h1>
  		</div>
		<div class="userCard">
		 	<p id="userType">Customer</p>
		 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
			<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
		</div>
   	</div>
	
	<div id="content">
	
	<!-- TODO: MAKE IT SO SSN CAN ONLY BE 9 DIGITS -->
	<h1>Obtain monthly sales report</h1>
	<form action="reportContent.jsp" method="POST">
	<p>Which month would you like the report for?</p>
	
	<input type="radio" name="month" id="jan" value="1" required>
			<label for="jan">January</label> 
	<input type="radio" name="month" id="feb" value="2" required>
			<label for="feb">February</label>
	<input type="radio" name="month" id="mar" value="3" required>
			<label for="mar">March</label><br>
	<input type="radio" name="month" id="apr" value="4" required>
			<label for="apr">April</label> 
	<input type="radio" name="month" id="may" value="5" required>
			<label for="may">May</label> 
	<input type="radio" name="month" id="june" value="6" required>
			<label for="june">June</label><br>
	<input type="radio" name="month" id="jul" value="7" required>
			<label for="jul">July</label> 
	<input type="radio" name="month" id="aug" value="8" required>
			<label for="aug">August</label> 
	<input type="radio" name="month" id="sep" value="9" required>
			<label for="sep">September</label><br>
	<input type="radio" name="month" id="oct" value="10" required>
			<label for="oct">October</label> 
	<input type="radio" name="month" id="nov" value="11" required>
			<label for="nov">November</label> 
	<input type="radio" name="month" id="dec" value="12" required>
			<label for="dec">December</label><br>
	
	
	<input type="submit" class="btn"/>
	
	</form>
	
	</div>
	
		<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
