<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>


<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	
	<body>
	
	<div id="content">
	
	<h1>Add customer representative</h1>
	<form action="repEditSuccess.jsp" method="POST">
	First name: <input type="text" name="First Name"/><br/>
	Last name: <input type="text" name="Last Name"/><br/>
	Username: <input type="text" name="Username"/><br/>
	Password: <input type="password" name="Password"/><br/>
	Social Security Number: <input type="number" name="Social Security Number"/><br/>
	<input type="hidden" name="operation" value="add"/>
	<input type="submit" class="btn" value="Create Customer Rep Account"/>
	
	</form>
	
	</div>
	
		<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>

	
	</body>


</html>
