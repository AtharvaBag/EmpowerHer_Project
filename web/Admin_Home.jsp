<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dto.Course_DTO"%>
<%@page import="dto.Trainer_DTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
       if(session.getAttribute("isAdminVerified") != null)
       {
            boolean isAdminVerified = (boolean)session.getAttribute("isAdminVerified");
            if(!isAdminVerified)
            {
                response.sendRedirect("home.html");
                return;
            }
        }
       else
       {
                response.sendRedirect("home.html");
                return;
       }
       boolean trainerverificationlist = false;
       boolean courseverificationlist = false;
       boolean studentdeletionrequests = false;
       
       if(session.getAttribute("trainerverificationlist") != null)
       {
           trainerverificationlist = (boolean)session.getAttribute("trainerverificationlist");
       }
       if(session.getAttribute("courseverificationlist") != null)
       {
           courseverificationlist = (boolean)session.getAttribute("courseverificationlist");
       }
       if(session.getAttribute("studentdeletionrequests") != null)
       {
           studentdeletionrequests = (boolean)session.getAttribute("studentdeletionrequests");
       }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Admin Page</title>
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
        body{
            background-image: url('images/EmpowerHer background Image.png');
             background-attachment: fixed; 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
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
            position: relative;
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
        .icons div {
            cursor: pointer;
            font-size: 2.5rem;
            color: var(--light-white);
            margin-left: 1.5rem;
        }
        .icons div:hover {
            color: var(--green);
        }
        #menu-btn {
            display: none;
        }
        .navbar form {
    display: inline-block;
    margin-right: 2rem;
}

.nav-btn {
    background: none;
    color: var(--light-white);
    font-size: 2rem;
    font-weight: bold;
    border: none;
    cursor: pointer;
    transition: color 0.4s;
}

.nav-btn:hover {
    color: var(--green);
}
h1 {
    color: var(--black);
    font-size: 3.8rem;
    text-align: center;
    padding-top: 2rem;
    margin-bottom: 0.5rem;
}
h2{
    font-size: 2.5rem;
    font-weight: bolder;
    text-align: left;
    color: var(--black);
    margin-left: 25%;
    padding-top: 1rem;
}

h3{
    font-size: 2.0rem;
    text-align: center;
    color: var(--black);
    margin-left: 50%;
    padding-top: 1rem;
}
.btn-container {
    display: flex;
    justify-content: center; 
    gap: 2rem; 
    margin-top: 2rem;
}
        .btn {
            margin-top: 0;
            padding: 1rem 3rem;
            font-size: 2rem;
            font-weight: bolder;
            border: var(--border);
            border-radius: 8px;
            color: var(--black);
            cursor: pointer;
            text-transform: capitalize;
            background-color: transparent;
            height: 70px;
            width: 300px;
            box-shadow: var(--box-shadow);
        }
        .btn:hover {
            background: #507484;
            color: var(--white);
        }
        table {
    width: 100%; 
    max-width: 1100px;
    border-collapse: collapse; 
    margin-left: 12%;
    margin-bottom: 1rem; 
    background: var(--black);
    opacity: 0.7;
    border-radius: 10px;
    box-shadow: var(--box-shadow);
}
table td {
    padding: 1rem; 
    font-size: 20px; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
input[type="text"] {
    width: 90%;
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
.btn-details {
            display: inline-block;
            font-size: 2rem;
            font-weight: bolder;
            border-radius: 30px;
            color: var(--white);
            cursor: pointer;
            text-transform: capitalize;
            width: 200px;
            height: 35px;
            background: #507484;
            box-shadow: var(--box-shadow);
        }
        .btn-details:hover {
            background: transparent;
            color: var(--white);
        }
        .main-content {
            width: 100%; 
            margin: auto;
            padding: 4rem;
        }
       
        </style>
    </head>
    <body>
        <header class="header">
            <a href="Admin_Home.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <form action="Admin_Payment_Details.jsp" method="get">
                    <input type="submit" value="Payment Details" class="nav-btn">
                </form>
                <form>
                </form>
                <form action="Admin_Logout.jsp" method="get">
                    <input type="submit" value="Logout" class="nav-btn">
                </form>
            </nav>
        </header>

        </BR>
        </BR>
        <h1>Welcome Admin!</h1>
        
    <div class="main-content">
        <div class="btn-container">
        <form action="Admin_Options_Selector" method="POST">
            <input type="Submit" value="Teacher Verification List" name="adminoption" class="btn">
        </form>
        <br>
        
        <form action="Admin_Options_Selector" method="POST">
            <input type="Submit" value="Course Verification List" name="adminoption" class="btn">
        </form>
        <br>
        
        <form action="Admin_Options_Selector" method="POST">
            <input type="Submit" value="Student Deletion Requests" name="adminoption" class="btn">
        </form>
        </div>

        <br>
        <br>
        
        
        <%
                if(trainerverificationlist)
                {
        %>
                    
        <H2 style="margin-left: 43%; color: #507484">Verified Trainers</H2>
                    </BR>
                    <table>
                        <tr>
                            <td>Trainer ID</td>
                            <td>Trainer Name</td>
                        </tr>
          <%
                    ArrayList <Trainer_DTO> verifiedTrainers = new ArrayList <>((ArrayList)session.getAttribute("verifiedTrainers"));
                    if(!verifiedTrainers.isEmpty())
                    {
                        for(int i=0; i<verifiedTrainers.size(); i++)
                        {
          %>          
                        <form action="Admin_Trainer_Details" method="POST">
                            <tr>
                                <td><input type="text" value="<%=verifiedTrainers.get(i).getTrainerid()%>" name="verifiedtrainerid" readonly></td>
                                <td><input type="text" value="<%=verifiedTrainers.get(i).getTrainername()%>" name="verifiedtrainername" readonly></td>
                                <td><input type="submit" value="Show Details" class="btn-details"></td>
                            </tr>
                        </form>
        <%
                        }
                    }
                    else
                    {
          %>
                      <tr>
                        <td><input type="text" value="No Data Found" readonly></td>
                        <td><input type="text" value="No Data Found" readonly></td>
                      </tr>
           <%   
                    }
            %>
                     </table> 
                    <H2 style="margin-left: 43%">Unverified Trainers</H2>
                    </BR>
            <table>
                        <tr>
                            <td>Trainer ID</td>
                            <td>Trainer Name</td>
                        </tr>
          <%
                    ArrayList <Trainer_DTO> unverifiedTrainers = new ArrayList <>((ArrayList)session.getAttribute("unverifiedTrainers"));
                    if(!unverifiedTrainers.isEmpty())
                    {
                        for(int i=0; i<unverifiedTrainers.size(); i++)
                        {
          %>          
                        <form action="Admin_Trainer_Details" method="POST">
                            <tr>
                                <td><input type="text" value="<%=unverifiedTrainers.get(i).getTrainerid()%>" name = "unverifiedtrainerid" readonly></td>
                                <td><input type="text" value="<%=unverifiedTrainers.get(i).getTrainername()%>" name = "unverifiedtrainername" readonly></td>
                                <td><input type="submit" value="Show Details" class="btn-details"></td>
                            </tr>
                        </form>
        <%
                        }
                    }
                    else
                    {
          %>
                      <tr>
                        <td><input type="text" value="No Data Found" readonly></td>
                        <td><input type="text" value="No Data Found" readonly></td>
                      </tr>
           <%   
                    }
                }

            if(courseverificationlist)
            {
        %>
                    
                    <H2 style="margin-left: 43%; color: #507484">Verified Courses</H2>
                    </BR>
                    <table>
                         <tr>
                             <td>Course Id</td>
                             <td>Course Title</td>
                             <td>Trainer ID</td>
                             <td>Trainer Name</td>
                         </tr>
         <%
                    Map <Course_DTO, Trainer_DTO> verifiedCourseTrainer = new HashMap<>((Map)session.getAttribute("verifiedCourseTrainer"));
                    if(!verifiedCourseTrainer.isEmpty())
                    {
                        for(Map.Entry<Course_DTO, Trainer_DTO> entry : verifiedCourseTrainer.entrySet())
                        {
         %>          
                        <form action="Admin_Course_Details" method="POST">
                                <tr>
                                    <td><input style="width: 100px" type="text" value="<%=entry.getKey().getCourseid()%>" name="verifiedcourseid" readonly></td>
                                    <td><input style="width: 400px" type="text" value="<%=entry.getKey().getCoursetitle().replace("*", "'")%>" name="verifiedcoursename" readonly></td>
                                    <td><input style="width: 100px" type="text" value="<%=entry.getValue().getTrainerid()%>" name="verifiedtrainerid" readonly></td>
                                    <td><input style="width: 300px"type="text" value="<%=entry.getValue().getTrainername()%>" name="verifiedtrainername" readonly></td>
                                    <td><input style="width: 200px"type="Submit" value="Show Details" class="btn-details"></td>
                                </tr>
                        </form>
        <%
                        }
                    }
                    else
                    {
         %>
                         <tr>
                                    <td><input type="text" value="No data Found" readonly></td>
                                    <td><input type="text" value="No data Found" readonly></td>
                                    <td><input type="text" value="No data Found" readonly></td>
                                    <td><input type="text" value="No data Found" readonly></td>
                         </tr>
                    <%
                    }
                    %>
                    
                    </table>
                    <BR>
                    <BR>
                    <H2 style="margin-left: 43%">Unverified Courses</H2>
                    <BR>
                     <table>
                         <tr>
                             <td>Course Id</td>
                             <td>Course Title</td>
                             <td>Trainer ID</td>
                             <td>Trainer Name</td>
                         </tr>
         <%
                    Map <Course_DTO, Trainer_DTO> unverifiedCourseTrainer = new HashMap<>((Map)session.getAttribute("unverifiedCourseTrainer"));
                    if(!unverifiedCourseTrainer.isEmpty())
                    {
                        for(Map.Entry<Course_DTO, Trainer_DTO> entry : unverifiedCourseTrainer.entrySet())
                        {
         %>          
                        <form action="Admin_Course_Details" method="POST">
                                <tr>
                                    <td><input style="width: 100px" type="text" value="<%=entry.getKey().getCourseid()%>" name="unverifiedcourseid" readonly></td>
                                    <td><input style="width: 400px" type="text" value="<%=entry.getKey().getCoursetitle().replace("*", "'")%>" name="unverifiedcoursename" readonly></td>
                                    <td><input style="width: 100px" type="text" value="<%=entry.getValue().getTrainerid()%>" name="unverifiedtrainerid" readonly></td>
                                    <td><input style="width: 300px" type="text" value="<%=entry.getValue().getTrainername()%>" name="unverifiedtrainername" readonly></td>
                                    <td><input style="width: 200px" type="Submit" value="Show Details" class="btn-details"></td>
                                </tr>
                        </form>
        <%
                        }
                    }
                    else
                    {
         %>
                    <tr>
                        <td><input type="text" value="No data found" readonly></td>
                        <td><input type="text" value="No data found" readonly></td>
                        <td><input type="text" value="No data found" readonly></td>
                        <td><input type="text" value="No data found" readonly></td>
                    </tr>
        <%
                    }
            }
            if(studentdeletionrequests)
                {
        %>
            
                  </table>        
                    <H2 style="margin-left: 43%">Courses List</H2>
                    </BR>
                    <table>
                        <tr>
                            <td>Course ID</td>
                            <td>Course Name</td>
                            <td>Action</td>
                        </tr>
        <%
                ArrayList <Course_DTO> deletetionRequestCourses = new ArrayList<>((ArrayList)session.getAttribute("deletetionRequestCourses"));
                    if(!deletetionRequestCourses.isEmpty())
                    {
                        for(int i=0; i<deletetionRequestCourses.size(); i++)
                        {
        %>
                    <form method="POST" action="Admin_Delete_Students_List">
                            <tr>
                                <td><input type="text" value="<%=deletetionRequestCourses.get(i).getCourseid()%>" name="courseid" readonly></td>
                                <td><input type="text" value="<%=deletetionRequestCourses.get(i).getCoursetitle()%>" name="coursename" readonly></td>
                                <td><input type="Submit" value="Show Students" class="btn-details"></td>
                            </tr>
                    </form>
        <%
                        }
                    }
                }
        %>
             
                    </table>          
    </div>   
    </body>
</html>
