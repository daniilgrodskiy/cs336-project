<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("admin")) {
	response.sendRedirect("../success.jsp");
}
%>



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
  		</div>
		<div class="userCard">
		 	<p id="userType">Customer</p>
		 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
			<p><a id="logOut" href='../logout.jsp'>Log out</a></p>
		</div>
   	</div>
	   <div id="content">
		   <p>Welcome, manager <%=session.getAttribute("user")%>!</p>
		   <p><a href="addCustomerRep.jsp">Add customer representative information</a></p>
		   <p><a href="editCustomerRep.jsp">Edit customer representative information</a></p>
		   <p><a href="deleteCustomerRep.jsp">Delete customer representative information</a></p>
		   <p><a href="salesReport.jsp">Obtain monthly sales report</a></p>
		   <p><a href="reservationList.jsp">Obtain list of reservations</a></p>
		   <p><a href="revenueListing.jsp">Listing of revenue</a></p>
		   <p><a href="bestCustomer.jsp">Find Best Customer</a></p>
		   <p><a href="topFiveLines.jsp">Top Five Lines</a></p>
		   <p><a href='../logout.jsp'>Log out</a></p>
	   </div>
   </body>
</html>