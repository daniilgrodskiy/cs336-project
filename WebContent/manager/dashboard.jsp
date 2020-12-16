<!DOCTYPE html>
<html>
	<head>
		<link href="../styles.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
	   <div id="content">
		   <p>Welcome, manager <%=session.getAttribute("user")%>!</p>
		   <p><a href="addCustomerRep.jsp">Add customer representative information</a></p>
		   <p><a href="editCustomerRep.jsp">Edit customer representative information</a></p>
		   <p><a href="deleteCustomerRep.jsp">Delete customer representative information</a></p>
		   <p><a href="salesReport.jsp">Obtain monthly sales report</a></p>
		   <p><a href="reservationList.jsp">Obtain list of reservations</a></p>
		   <p><a href='../logout.jsp'>Log out</a></p>
	   </div>
   </body>
</html>