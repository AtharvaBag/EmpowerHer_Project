<%@page import="dto.Payment_DTO"%>
<%@page import="dto.Course_DTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        Course_DTO courseDetails = (Course_DTO)session.getAttribute("courseDetails");
        String studentcourseid = (String)session.getAttribute("studentcourseid");
        boolean isStudentEnrolled = (boolean)session.getAttribute("isStudentEnrolled");
        if(courseDetails == null || studentcourseid == null)
        {
            response.sendRedirect("home.html");
            return;
        }
         boolean showPaymentDetailsToStudent = false;
         Payment_DTO paymentDetails = new Payment_DTO();
        if(session.getAttribute("showPaymentDetailsToStudent")!=null)
        {
           showPaymentDetailsToStudent = (boolean)session.getAttribute("showPaymentDetailsToStudent");
           paymentDetails = (Payment_DTO)session.getAttribute("paymentDetails");
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Course Details</title>
        <style>
            * {
            font-family: 'Nunito', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            border: none;
            outline: none;
            text-decoration: none;
            transition: all .4s linear;
        }
        :root {
            --green: #90bcc4;
            --light-green: #f0fdfa;
            --light-color: #777;
            --light-white: #eee;
            --black: #444;
            --white: #fff;
            --border: .2rem solid var(--black);
            --box-shadow: 0 0.8rem 1rem rgba(0, 0, 0, .5);
        }
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        body {
            background-image: url('images/EmpowerHer background Image.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: 100vh;
        }
        html {
            font-size: 62.5%;
            overflow-x: hidden;
        }
       
        .home {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .header {
            position: sticky;
            top: 0;
            left: 0;
            right: 0;
            background-color: var(--black);
            box-shadow: var(--box-shadow);
            padding: 2rem 10%;
            display: flex;
            align-items: center;
            z-index: 1000;
        }
        .header .logo {
            color: var(--light-white);
            margin-right: auto;
            font-size: 2.5rem;
            font-weight: bolder;
        }
        .header .logo span {
            color: var(--green);
        }
        .navbar {
    display: flex;
    gap: 2rem; 
    align-items: center;
}
        .navbar #close-navbar {
            position: absolute;
            top: 1.5rem;
            right: 2rem;
            font-size: 4rem;
            cursor: pointer;
            color: var(--black);
            display: none;
        }
        .navbar #close-navbar:hover {
            transform: rotate(90deg);
        }
        .navbar a {
            color: var(--light-white);
            margin-right: 2rem;
            font-size: 2rem;
            font-weight: bold;
        }
        .navbar a:hover {
            color: var(--green);
        }
        .nav-btn {
            background: none;
            border: none;
            color: var(--light-white);
            font-size: 2rem;
            font-weight: bold;
            cursor: pointer;
            padding: 1rem 1rem;
            transition: color 0.4s, background-color 0.4s;
}

.nav-btn:hover {
    color: var(--green);
}
table {
    width: 100%; 
    max-width: 1200px;
    border-collapse: collapse; 
    margin-bottom: 1rem; 
    background: var(--black);
    opacity: 0.7;
    border-radius: 10px;
    box-shadow: var(--box-shadow);
    margin-left: 10%;
}
table td {
    padding: 1rem; 
    font-size: 20px; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
input[type="text"] {
    width: 350px;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 10px;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
}
h2{
    font-size: 2.5rem;
    font-weight: bolder;
    text-align: center;
    color: var(--black);
    padding-top: 1rem;
}

.main-content {
            width: 100%; 
            margin: auto;
            padding: 4rem;
        }
        .btn{
            display: inline-block;
            font-size: 2rem;
            font-weight: bolder;
            border-radius: 30px;
            color: var(--white);
            cursor: pointer;
            text-transform: capitalize;
            width: 250px;
            height: 35px;
            background: #507484;
            box-shadow: var(--box-shadow);
        }
        .btn:hover {
            background: transparent;
            color: var(--white);
        }
         textarea {
    width: 60%;
    padding: 1.2rem;
    font-size: 1.6rem;
    color: var(--black);
    background-color: var(--white);
    border: var(--border);
    border-radius: 20px;
    box-sizing: border-box;
    box-shadow: var(--box-shadow);
    resize: none;
         }
       
        </style>
    </head>
    <body>
        <header class="header">
            <a href="Student_Home.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <form action="Student_Home.jsp" method="POST" style="display: inline;">
                    <input type="submit" value="Back" class="nav-btn">
                </form>
                <form></form>
                 <%
        if(isStudentEnrolled)
        {
    %>
        <form method="POST" action="Student_Payment_Details">
           <input  type="submit" value="Payment Details" class="nav-btn">
        </form>
        <BR>
        <BR>
       <%
        }
        %>
            </nav>
        </header>
        <br><br>

        <h2>Details of course: <span style="color: #507484;"><%=courseDetails.getCoursetitle().trim().replace("*", "'")%></span></h2>
       <div class="main-content">
           <%
       if(showPaymentDetailsToStudent  && isStudentEnrolled)
       {
       %>
       <table>
           <tr>
               <td>Payment Mode:</td>
               <td><input type="text" value="<%=paymentDetails.getPaymentmode()%>" readonly></td>
           </tr>
           <tr>
               <td>Transaction Date and Time:</td>
               <td><input type="text" value="<%=paymentDetails.getCurrentdatetime()%>" readonly></td>
           </tr>
           <tr>
               <td>Amount Paid:</td>
               <td><input type="text" value="<%=paymentDetails.getCoursefee()%>/-" readonly></td>
           </tr>
       </table>
       <%
       }
       %>
        <table>
            <form method="post" action="Payment_Page.jsp">
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            <tr>
                <td>Skill Domain: </td>
                <td><input type="text" value="<%=courseDetails.getTrainerskill()%>" name="courseskill" id="courseskill" readonly></td>
            </tr>
            <tr>
                <td>Name of class/institute: </td>
                <td><input type="text" value="<%=courseDetails.getCourseclassname().replace("*", "'")%>" name="courseclassname" id="courseclassname" readonly></td>
            </tr>
            <tr>
                <td>Contact number of class/institute: </td>
                <td><input type="text" value="<%=courseDetails.getCourseclasscontact()%>" name="courseclasscontact" id="courseclasscontact" readonly></td>
            </tr>
            <tr>
                <td>Title of course: </td>
                <td><input type="text" value="<%=courseDetails.getCoursetitle().replace("*", "'")%>" name="coursetitle" id="coursetitle" readonly></td>
            </tr>
             <tr>
                    <td>Course Level: </td>
                    <td>
                    <input TYPE="Radio" name="courseviewers" value="Beginner" disabled="true"<%if(courseDetails.getCourseviewers().equalsIgnoreCase("beginner")){ %> checked="true"<%}%>><Label for="Beginner" > Beginner Level Students</Label>
                    </br>
                    <INPUT TYPE="Radio" name="courseviewers" value="Intermediate" disabled="true"<%if(courseDetails.getCourseviewers().equalsIgnoreCase("intermediate")){ %> checked="true" <%}%>><Label for="Intermediate" > Intermediate Level Students</Label>
                    </br>
                    <INPUT TYPE="Radio" name="courseviewers" value="Advance" disabled="true"<%if(courseDetails.getCourseviewers().equalsIgnoreCase("advance")){ %> checked="true" <%}%>><Label for="Advance" > Advance Level Students</Label>
                    </td>
            </tr>
            <tr>
                <td>Course Duration (in months): </td>
                <td><input type="text" value="<%=courseDetails.getCourseduration() %>" name="courseduration" id="courseduration" placeholder="in months" readonly></td>
            </tr>
            <tr>
                <td>Number of class days (per week): </td>
                <td><input type="text" value="<%=courseDetails.getCoursedays() %>" name="coursedays" id="coursedays" readonly></td>
            </tr>
             <tr>
                   <td>Mode of class: </td>
                   <td>
                   <input TYPE="Radio" name="coursemode" value="Online" disabled="true"<%if(courseDetails.getCoursemode().equalsIgnoreCase("Online")){ %> checked="true" <%}%>><Label for="Online"> Online</Label>
                   </br>
                   <INPUT TYPE="Radio" name="coursemode" value="Offline" disabled="true"<%if(courseDetails.getCoursemode().equalsIgnoreCase("Offline")){ %> checked="true" <%}%>><Label for="Offline"> Offline</Label>
                   </br>
                   <INPUT TYPE="Radio" name="coursemode" value="Hybrid" disabled="true"<%if(courseDetails.getCoursemode().equalsIgnoreCase("Hybrid")){ %> checked="true" <%}%>><Label for="Hybrid"> Hybrid (Online + Offline)</Label>
                   </td>
             </tr>
             
             <%
                    if(!courseDetails.getCoursemode().equalsIgnoreCase("Online"))
                    {
             %>
             <tr>
                    <td>Address of institute/class: </td>
                    <td><input type="text" name="courseclassaddress" id="courseclassaddress" placeholder="if available" value="<%=courseDetails.getCourseclassaddress().replace("*", "'")%>"></td>
                </tr>
                <tr>
                    <td>City of institute/class: </td>
                    <td><input type="text" name="courseclasscity" id="courseclasscity" placeholder="if available" value="<%=courseDetails.getCourseclasscity()%>"></td>
                </tr>
                <tr>
                    <td>State of institute/class: </td>
                    <td><input type="text" name="updatedcourseclassstate" id="updatedcourseclassstate" placeholder="if available" value="<%=courseDetails.getCourseclassstate()%>"></td>
                </tr>
                <%
                }
                %>
                <tr>
                    <td>Course Description: </td>
                    <td><textarea name="coursedescription" id="coursedescription" rows="2" cols="20" placeholder="in about 100 words" readonly><%=courseDetails.getCoursedescription().replace("*", "'")%></textarea></td>
                </tr>
                <tr>
                    <td>Provides course completion certificate? </td>
                    <td>
                        <INPUT TYPE="Radio" name="coursecertificate" value="1" disabled="true" <%if(courseDetails.getCoursecertification().equals("1")){ %> checked="true" <%}%>><Label for="1"> Yes</Label>
                    </br>
                    <INPUT TYPE="Radio" name="coursecertificate" value="0" disabled="true" <%if(courseDetails.getCoursecertification().equals("0")){ %> checked="true" <%}%>><Label for="0"> No</Label>
                    </td>
                </tr>
                <tr>
                    <td>Total fees of course: </td>
                    <td><input type="text" name="coursefee" id="coursefee" placeholder="in INR" value="<%=courseDetails.getCoursefee() %>" readonly></td>
                </tr>
                <tr>
        <%
            if(isStudentEnrolled)
            {
        %>
        
        <td colspan="2"><input type="button" value="OK" onclick="location.href='Student_Home.jsp'" class="btn"></td>
        <%
            }
            else
            {
        %>
                              <td><input type="Submit" value="Enroll Now!" class="btn"></td>
        <%
        }
        %>
              </form>
                <BR>
          <%
              if(!isStudentEnrolled)
              {
          %>
            <form action="Remove_From_Wishlist" method="POST">
                <td><input type="submit" value="Remove From Wishlist" class="btn"></td>
            </form>
            <%
            }
            %>
        </tr>
        </table>
        <BR>
       
       </div>
       
        
      
    </body>
</html>