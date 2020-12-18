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
	
	<h1>Delete</h1>
	<form action="repEditSuccess.jsp" method="POST">
	Social Security Number of representative you wish to delete: <input type="number" name="Social Security Number"/><br/>
	<input type="hidden" name="operation" value="delete"/>
	<input type="submit" class="btn" value="Delete Customer Rep Account"/>
	<p style="color:red;">Note: If you delete a customer representative, it cannot be undone.</p>
	</form>
	
	</div>

	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
	
	</body>


</html>
