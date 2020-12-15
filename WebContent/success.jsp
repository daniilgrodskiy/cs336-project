<!DOCTYPE html>
<html>
	<head>
		<link href="${pageContext.request.contextPath}/styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   <div id="content">

<% if ((session.getAttribute("user") == null)) {%>

<p>You are not logged in</p>

<p><a href="login.jsp">Please Login</a></p>

<%} else {
 	System.out.println(session.getAttribute("userType"));
	 if (session.getAttribute("userType").equals("customer")) {
		// Redirect to customer page
		response.sendRedirect("./customer/dashboard.jsp");
	} else if (session.getAttribute("userType").equals("rep")) {
		// Redirect to rep page
		response.sendRedirect("./rep/dashboard.jsp");
	} else {
		// Redirect to manager page
		response.sendRedirect("./manager/dashboard.jsp");
	}
}%>

   </div>
   </body>
</html>
