<%@ page import="java.io.*,java.util.*,java.sql.*,daniil.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>


<%
if (session.getAttribute("user") == null || session.getAttribute("userType") == null || !session.getAttribute("userType").equals("customer")) {
	response.sendRedirect("../../success.jsp");
}
%>
<%
 		if (session.getAttribute("user") == null) {
			response.sendRedirect("../success.jsp");
 		}
 
 		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://trainappdb.cmeqwsu4k6hd.us-east-2.rds.amazonaws.com:3306/project", "admin", "Rutgers1");
		
		String filterQuery = request.getParameter("filterQuery");
		
		if (filterQuery == null) {
			filterQuery = "";
		}
			
%>

<!DOCTYPE html>
<html>
	<head>
		<link href="./faq.css" type="text/css" rel="stylesheet" />
		<title>Train App</title>
	</head>
   <body>
   		<div class="flex-nav">
   			<div>
   				<h1 id="title">Trainy </h1>
				<a class="navItem" href="../browse.jsp">Browse Trains</a>
				<a class="navItem" href="../reservationForm.jsp">Make a Reservation</a>
				<a class="navItem" href="../reservationView.jsp">My Reservations</a>
				<a class="navItem" href="../faq/faq.jsp">FAQ</a>
   			</div>
			<div class="userCard">
			 	<p id="userType">Customer</p>
			 	<p id="username">Hello, <%=session.getAttribute("user")%>!</p>
				<p><a id="logOut" href='../../logout.jsp'>Log out</a></p>
			</div>
   		</div>
   
   		<div style="text-align:center;">
	   		<form action="./faq.jsp">
		        <input class="btn" type=submit value="Show All Questions">
	        </form>
        </div> 
       
   		
	   <div id="content">
	   
	   		<%
				// FAQ
				Statement stmt = con.createStatement();
				String faqQuery = "select * from faq";
				ResultSet faqResult = stmt.executeQuery(faqQuery);
				
				List<Faq> faqs = new ArrayList<Faq>();
				
				while (faqResult.next()) {
					// Customer
					String customerQuery = 
					  			"select * from customer" +
					  			" where email = '" + faqResult.getString("email") + "'";
					
					stmt = con.createStatement();
					ResultSet customerResult = stmt.executeQuery(customerQuery);
					customerResult.next();
					
					Customer customer = new Customer(
						customerResult.getString("email"),
						customerResult.getString("username"),
						customerResult.getString("first_name"),
						customerResult.getString("last_name")
					);
					
					Faq faq = new Faq(
						faqResult.getInt("fid"),
						customer,
						faqResult.getString("question"),
						faqResult.getString("answer")
					);
					
					faqs.add(faq);
				}
				
		        // FILTER BAR
		        %>
		        <div class="filter-bar" >
			        <form action="./faq.jsp">
				        <div class="search-bar flex">
				        	<input type="text" name="filterQuery" placeholder="Search questions...">
				        	<input class="btn" type=submit value="Search">
				        </div>
			        </form>
			    </div>
			    
			    
				<form action="./addNewQuestion.jsp">
				    <div class="new-question">
				     		<input type="text" name="email" value="<%=session.getAttribute("userEmail")%>" class="hide">
				     		<div style="font-size: 30px; font-weight: 200;">Question:</div>
				        	<textArea name="question" placeholder="What is your question?"></textArea>
				        	<input type=submit value="Add New Question">
				    </div>
			    </form>
		       
			    
		<%
		for (Faq f : faqs) {
			int fid = f.getFid();
			String firstName = f.getCustomer().getFirstName();
			String lastName = f.getCustomer().getLastName();
			String question = f.getQuestion();
			String answer = f.getAnswer();
			
			if (filterQuery != null && !filterQuery.equals("") && !question.contains(filterQuery)) {
				continue;
			}
		%>
			<form action="./updateFaq.jsp">
				<div class="card">
					<input type="text" name="fid" value="<%=fid%>" class="hide">
					<div class="question">
						<b>Question:</b>
					</div>
					<div class="question">
						<%=question%><span class="name"> - <%=firstName%> <%=lastName%></span>
					</div>
					
					<div style="margin-top:20px;"class="answer">
					<b>Answer:</b>
					</div>
					<div>
						<div class="question"><%=answer%></div>
					</div>
				</div>
				
			</form>
			
		<%
		}
		
		con.close();
		%>   	   
	   </div>
   </body>
</html>