<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
	<body>
	<div id="content">
		<h1>Log in</h1>
		<form action="displayLoginDetails.jsp" method="POST">
			Username: <input type="text" name="username"/> <br/>
			Password: <input type="password" name="password"/> <br/>
			<input type="submit" class="btn" value="Log in">
		</form>
	     <a href="signUpPage.jsp">Don't have an account? Sign up!</a>
	</div>
	</body>

</html>
