<!DOCTYPE html>
<html>
	<head>
		<link href="../styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   
   		<div class="flex-nav">
   			<div>
   				<h1 id="title">Trainy </h1>
				<a class="navItem" href="./browse.jsp">Browse Trains</a>
				<a class="navItem" href="./reservationForm.jsp">Make a Reservation</a>
				<a class="navItem" href="./reservationView.jsp">My Reservations</a>
				<a class="navItem" href="./faq/faq.jsp">FAQ</a>
   			</div>
			<div class="userCard">
			 	<p id="userType">Customer Representative</p>
			 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
				<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
			</div>
   		</div>
   		
	   <div id="content">
	   	   <% 
	   	  		if (session.getAttribute("user") == null) 
	   				response.sendRedirect("../success.jsp");
	   	   %>
		   <p>What would you like to do?</p>
		   <p><a href="browse.jsp">Browse trains</a></p>
		   <p><a href="reservationForm.jsp">Make a reservation</a></p>
		   <p><a href="reservationView.jsp">View my reservations</a></p>
		   <p><a href="./faq/faq.jsp">View the FAQ</a></p>
		   <p><a href='../logout.jsp'>Log out</a></p>
	   </div>
   </body>
</html>