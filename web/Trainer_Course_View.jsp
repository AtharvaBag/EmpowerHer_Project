<%@page import="dto.Course_DTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        String isCourseVerified = (String)session.getAttribute("isCourseVerified");
        Course_DTO registeredCourseDetails = (Course_DTO)session.getAttribute("registeredCourseDetails");
        if(registeredCourseDetails==null)
        {
            response.sendRedirect("trainer_login.html");
            return;
        }
        String trainername = (String)session.getAttribute("trainername");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Trainer Course Details</title>
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
        .btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 1rem 3rem;
            font-size: 1.8rem;
            border: var(--border);
            border-radius: 8px;
            color: var(--green);
            cursor: pointer;
            text-transform: capitalize;
        }
        .btn:hover {
            background: var(--green);
            color: var(--white);
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
            position: relative;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            flex: 1;
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
        .icons div {
            cursor: pointer;
            font-size: 2.5rem;
            color: var(--light-white);
            margin-left: 1.5rem;
        }
        .icons div:hover {
            color: var(--green);
        }
        h1 {
    color: var(--black);
    font-size: 3.5rem;
    text-align: center;
    padding-top: 1rem;
    margin-bottom: 0.5rem;
    }
    h2 {
            text-align: left; 
            color: var(--black);
            margin-bottom: 1rem;
            font-size: 25px; 
        }
        h3 {
            text-align: center; 
            font-size: 20px; 
            color: var(--black);
        }
        .container {
            margin-top: 30px; 
            max-width: 1200px;
            margin-left: 150px;
            height: 500px;
            padding: 1rem; 
            background: var(--black);
            opacity: 0.7;
            border-radius: 10px;
            box-shadow: var(--box-shadow);
            display: flex;
            flex-direction: column; 
            align-items: center; 
            overflow-y: auto;
        }
        form {
            width: 100%; 
        }
        table {
            width: 100%; 
            max-width: 1200px;
            border-collapse: collapse; 
            margin-bottom: 1rem; 
        }
        table td {
            padding: 1rem; 
            font-size: 20px; 
            color: var(--white);
            vertical-align: top; 
            text-align: center;
        }
        textarea {
    width: 100%;
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
input[type="text"],
        input[type="tel"],
        input[type="date"] {
            width: 100%;
            padding: 0.4rem; 
            font-size: 20px; 
            border-radius: 20px;
            text-align: center;
            box-shadow: var(--box-shadow);
            margin-bottom: 0.5rem; 
        }
        input[type="submit"],
        input[type="reset"] {
            background-color: #507484;
            color: var(--white);
            padding: 0.4rem 1rem; 
            cursor: pointer;
            border-radius: 25px;
            transition: background-color 0.3s;
            font-size: 20px; 
            width: 200px; 
            box-shadow: var(--box-shadow);
        }
        
        input[type="reset"]{
            margin-left: 75px;
        }
        
        input[type="submit"]{
            margin-left: 75px;
        }
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: var(--black); 
        }
        </style>
    </head>
    <body>
        <header class="header">
            <a href="Trainer_Home_Page.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <a href="Trainer_Home_Page.jsp">Home</a>
                <a></a>
                <a href="Trainer_Course_Delete.jsp">Delete Course</a>
            </nav>
        </header>
        <BR>
        <BR>
        <h1 style="text-align: center">Course Details</h1>
        <h2 style="text-align: center">Course ID: <%=registeredCourseDetails.getCourseid()%></h2>
        <h3>Verification Status: <% if(isCourseVerified=="1") {%> <span style="color: #507484">Verified and Registered <% } else if(isCourseVerified=="0") { %> Registered, under verification process </span><%}%> </h3>
        
        
       
        
        <br>
        <div class="container">
            <form method="post" action="TrainerCourse_Update">
                <table>
            
                    <tr>
                        <td>Skill Domain: </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getTrainerskill().replace("*", "'")%>" name="updatedcourseskill" id="updatedcourseskill"></td>
                    </tr>
                    <tr>
                        <td>Name of class/institute: </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getCourseclassname().replace("*", "'")%>" name="updatedcourseclassname" id="updatedcourseclassname"></td>
                    </tr>
                    <tr>
                        <td>Contact number of class/institute: </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getCourseclasscontact()%>" name="updatedcourseclasscontact" id="updatedcourseclasscontact"></td>
                    </tr>
                    <tr>
                        <td>Title of course: </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getCoursetitle().replace("*", "'")%>" name="updatedcoursetitle" id="updatedcoursetitle"></td>
                    </tr>
                     <tr>
                            <td>Course Level: </td>
                            <td>
                            <input TYPE="Radio" name="updatedcourseviewers" value="Beginner" <%if(registeredCourseDetails.getCourseviewers().equalsIgnoreCase("beginner")){ %> checked="true" <%}%>><Label for="Beginner" > Beginner Level Students</Label>
                            </br>
                            <INPUT TYPE="Radio" name="updatedcourseviewers" value="Intermediate" <%if(registeredCourseDetails.getCourseviewers().equalsIgnoreCase("intermediate")){ %> checked="true" <%}%>><Label for="Intermediate" > Intermediate Level Students</Label>
                            </br>
                            <INPUT TYPE="Radio" name="updatedcourseviewers" value="Advance" <%if(registeredCourseDetails.getCourseviewers().equalsIgnoreCase("advance")){ %> checked="true" <%}%>><Label for="Advance" > Advance Level Students</Label>
                            </td>
                    </tr>
                    <tr>
                        <td>Course Duration (in months): </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getCourseduration() %>" name="updatedcourseduration" id="updatedcourseduration" placeholder="in months"></td>
                    </tr>
                    <tr>
                        <td>Number of class days (per week): </td>
                        <td><input type="text" value="<%=registeredCourseDetails.getCoursedays() %>" name="updatedcoursedays" id="updatedcoursedays"></td>
                    </tr>
                     <tr>
                           <td>Select mode of class: </td>
                           <td>
                           <input TYPE="Radio" name="updatedcoursemode" value="Online" <%if(registeredCourseDetails.getCoursemode().equalsIgnoreCase("Online")){ %> checked="true" <%}%>><Label for="Online"> Online</Label>
                           </br>
                           <INPUT TYPE="Radio" name="updatedcoursemode" value="Offline" <%if(registeredCourseDetails.getCoursemode().equalsIgnoreCase("Offline")){ %> checked="true" <%}%>><Label for="Offline"> Offline</Label>
                           </br>
                           <INPUT TYPE="Radio" name="updatedcoursemode" value="Hybrid" <%if(registeredCourseDetails.getCoursemode().equalsIgnoreCase("Hybrid")){ %> checked="true" <%}%>><Label for="Hybrid"> Hybrid (Online + Offline)</Label>
                           </td>
                     </tr>
                     <tr>
                            <td>Address of your institute/class: </td>
                            <td><input type="text" name="updatedcourseclassaddress" id="updatedcourseclassaddress" placeholder="if available" value="<%=registeredCourseDetails.getCourseclassaddress().replace("*", "'")%>"></td>
                        </tr>
                        <tr>
                            <td>City of your institute/class: </td>
                            <td><input type="text" name="updatedcourseclasscity" id="updatedcourseclasscity" placeholder="if available" value="<%=registeredCourseDetails.getCourseclasscity()%>"></td>
                        </tr>
                        <tr>
                            <td>State of your institute/class: </td>
                            <td><input type="text" name="updatedcourseclassstate" id="updatedcourseclassstate" placeholder="if available" value="<%=registeredCourseDetails.getCourseclassstate() %>"></td>
                        </tr>
                        <tr>
                            <td>Description of your course: </td>
                            <td><textarea name="updatedcoursedescription" id="updatedcoursedescription" rows="2" cols="20" placeholder="in about 100 words"><%=registeredCourseDetails.getCoursedescription().replace("*", "'")%></textarea></td>
                        </tr>
                        <tr>
                            <td>Provides course completion certificate? </td>
                            <td>
                                <INPUT TYPE="Radio" name="updatedcoursecertificate" value="1" <%if(registeredCourseDetails.getCoursecertification().equals("1")){ %> checked="true" <%}%>><Label for="1"> Yes</Label>
                            </br>
                            <INPUT TYPE="Radio" name="updatedcoursecertificate" value="0" <%if(registeredCourseDetails.getCoursecertification().equals("0")){ %> checked="true" <%}%>><Label for="0"> No</Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Total fees of course: </td>
                            <td><input type="text" name="updatedcoursefee" id="updatedcoursefee" placeholder="in INR" value="<%=registeredCourseDetails.getCoursefee() %>"></td>
                        </tr>
                        <tr>
                           <td><input type="reset" value="Reset" style="margin: 30px;"></td>
                            <td><input type="submit" value="Update" style="margin: 30px;"></td>
                        </tr>
                </table>
            </form>
        </div>
       <BR>
        <%
            if(isCourseVerified=="1")
            {
        %>
        <h3>*If you will update course details, then you will loose verified status and re-verification process will start!</h3>
        <%
            }
        %>
          <BR>
                        <div style="text-align: center;">
                    <form action="Trainer_Course_Enrolled_Students" method="post">
                        <input type="submit" value="Enrolled Students">
                    </form>
                            </div>
          <BR>

    </body>
</html>
