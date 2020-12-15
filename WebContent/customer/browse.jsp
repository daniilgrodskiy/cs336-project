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
	<h1>Browse Schedules</h1>
		<form action="searchResults.jsp" method="POST">
			<p><strong>Origin:</strong></p>
				<input type="radio" id="CAC Student Center" name="origin" value="4" required>
				<label for="CAC Student Center">CAC Student Center</label><br>
				<input type="radio" id="Red Oak Lane" name="origin" value="10" required>
				<label for="Red Oak Lane">Red Oak Lane</label><br>
			<p><strong>Destination:</strong></p>
				<input type="radio" id="The Quads" name="dest" value="3" required>
				<label for="The Quads">The Quads</label><br>
				<input type="radio" id="Public Safety Building South" name="dest" value="9" required>
				<label for="Public Safety Building South">Public Safety Building South</label><br>
			<p><strong>Date (YYYY-MM-DD)</strong></p>
				<input type="date" id="date" name="date" value="2020-12-14" required><br>
			<input type="hidden" id="sort" name="sort" value="none"><br>
			<input type="submit" class="btn"" value="Search">
		</form>
	
	</div>
	</body>


</html>
