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
	
	<h1>Delete</h1>
	<form action="repEditSuccess.jsp" method="POST">
	Social Security Number of representative you wish to delete: <input type="number" name="Social Security Number"/><br/>
	<input type="hidden" name="operation" value="delete"/>
	<input type="submit" class="btn" value="Edit Customer Rep Account"/>
	<p style="color:red;">Note: If you delete a customer representative, it cannot be undone.</p>
	</form>
	
	</div>

	<div id="back" class="btn"><a href="dashboard.jsp">Go back</a></div>
	
	</body>


</html>
