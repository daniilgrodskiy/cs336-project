<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
   		<link href="./css/styles.css" rel="stylesheet" type="text/css">
	</head>
   <body>
   	 <h1>Trainy</h1>
   	 <h2>Sign up</h2>
     <form action="displaySignUpDetails.jsp" method="POST">
       Username: <input type="text" name="newUsername"/> <br/>
       Password:<input type="password" name="newPassword"/> <br/>
       <button>Sign up</button>
     </form>
     <a href="login.jsp">I already have an account</a>
   </body>
</html>
