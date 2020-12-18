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
	
	<h1>Add customer representative</h1>
	<form action="repEditSuccess.jsp" method="POST">
	First name: <input type="text" name="First Name" required/><br/>
	Last name: <input type="text" name="Last Name" required/><br/>
	Username: <input type="text" name="Username" required/><br/>
	Password: <input type="password" name="Password" required/><br/>
	Social Security Number: <input type="number" name="Social Security Number" required/><br/>
	<input type="hidden" name="operation" value="add"/>
	<input type="submit" class="btn" value="Create Customer Rep Account"/>
	
	</form>
	
	</div>
	
		<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
