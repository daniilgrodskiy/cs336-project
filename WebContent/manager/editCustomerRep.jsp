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
	
	<h1>Edit customer representative</h1>
	<form action="repEditSuccess.jsp" method="POST">
	Social Security Number of representative you wish to edit: <input type="number" name="Social Security Number"/><br/>
	
	<Strong>Input below any changes. If you do not want to change something, leave it blank.</Strong><br/><br/><br/>
	First name: <input type="text" name="First Name" value=""/><br/>
	Last name: <input type="text" name="Last Name" value=""/><br/>
	Username: <input type="text" name="Username" value=""/><br/>
	Password: <input type="password" name="Password" value=""/><br/>
	Social Security Number: <input type="number" name="editssn" value=""/><br/>
	<input type="hidden" name="operation" value="edit"/>
	<input type="submit" class="btn" value="Edit Customer Rep Account"/>
	
	</form>
	
	</div>

	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
	
	</body>


</html>
