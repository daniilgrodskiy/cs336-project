<!DOCTYPE html>
<html>
	<head>
		<link href="../styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
	   <div id="content">
	   	   <% 
	   	  		if (session.getAttribute("user") == null) 
	   				response.sendRedirect("../success.jsp");
	   	   %>
		   <p>Welcome, customer representative! <%=session.getAttribute("user")%></p>
		   <p><a href='../logout.jsp'>Log out</a></p>
	   </div>
   </body>
</html>