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

<%} else {%>

<p>Welcome <%=session.getAttribute("user")%> </p>

<p><a href='logout.jsp'>Log out</a></p>

<%}%>

   </div>
   </body>
</html>