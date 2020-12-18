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
   	 <h1>Sign up</h1>
     <form action="displaySignUpDetails.jsp" method="POST">
       Username: <input type="text" name="newUsername" required/> <br/>
       Password: <input type="password" name="newPassword" required/> <br/>
       Email: <input type="text" name="newEmail" required/> <br/>
       First Name: <input type="text" name="newFirstName" required/> <br/>
       Last Name: <input type="text" name="newLastName" required /> <br/>
       <button class="btn">Sign up</button>
     </form>
     <a href="login.jsp">I already have an account</a>
     </div>
   </body>
</html>
