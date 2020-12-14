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
       Username: <input type="text" name="newUsername"/> <br/>
       Password: <input type="password" name="newPassword"/> <br/>
       Email: <input type="text" name="newEmail"/> <br/>
       First Name: <input type="text" name="newFirstName"/> <br/>
       Last Name: <input type="text" name="newLastName"/> <br/>
       <button class="btn">Sign up</button>
     </form>
     <a href="login.jsp">I already have an account</a>
     </div>
   </body>
</html>
