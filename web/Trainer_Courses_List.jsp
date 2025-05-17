<%@page import="model.TrainerCourses_Fetcher"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        String trainerid = (String)session.getAttribute("trainerid");
        if(trainerid==null)
        {
            response.sendRedirect("Trainer_Home_page.jsp");
            return;
        }
        HashMap <String, String> verifiedCoursesHashMap = new HashMap<>();
        HashMap <String, String> unverifiedCoursesHashMap = new HashMap<>();
        verifiedCoursesHashMap.clear();
        unverifiedCoursesHashMap.clear();
        TrainerCourses_Fetcher courses = (TrainerCourses_Fetcher)session.getAttribute("courses");
        courses.getAllCourses();
        courses.filterCourses();
        verifiedCoursesHashMap = courses.mapVerifiedCourseName();
        unverifiedCoursesHashMap = courses.mapUnverifiedCourseName();
        
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Trainer Courses</title>
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
        html::-webkit-scrollbar {
            width: 1rem;
        }
        html::-webkit-scrollbar-track {
            background: transparent;
        }
        html::-webkit-scrollbar-thumb {
            background: #507484;
        }
        .home {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .container {
    padding: 2rem 5%;
    margin: auto;
    max-width: 1200px;
    overflow-y: auto; 
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
            flex: 1; /* Take full width */
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
        h1 {
    margin-top: 30px;
    text-align: center; 
    color: var(--black);
    margin-bottom: 2rem;
    font-size: 35px; 
}
h2 {
    text-align: center; 
    color: var(--black);
    margin-bottom: 1rem;
    font-size: 25px; 
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
}
table td {
    padding: 1rem; 
    font-size: 20px; 
    color: var(--white);
    vertical-align: top; 
    text-align: center;
}
input[type="text"] {
    width: 95%;
    padding: 0.4rem; 
    font-size: 18px; 
    border-radius: 20px;
    text-align: center;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
    margin-left: 10px;
}
input[type="submit"] {
    background-color: #507484;
    color: var(--white);
    border: 0px;
    padding: 0.4rem 1rem; 
    cursor: pointer;
    border-radius: 25px;
    transition: background-color 0.3s;
    font-size: 20px; 
    width: 200px;
    opacity: 1;
    box-shadow: var(--box-shadow);
}
input[type="submit"]:hover {
    background-color: var(--black); 
    color: var(--white);
}
        </style>
    </head>
    <body>
         <!-- Header Section Starts -->
         <header class="header">
            <a href="Student_Home_Page.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <a href="Trainer_Home_Page.jsp">Home</a>
                <a></a>
                <a href="Trainer_Profile_Delete.jsp">Delete Profile</a>
                <a></a>
                <a href="Trainer_Logout.jsp">Logout</a>
                
            </nav>
        </header>
        <!-- Header Section Ends -->

        <div class="container">
        <h1>Your Courses</h1>
        </BR>
        <h2>List of your <span style="color: #507484">Verified</span> and <span style="color: #507484">Registered</span> Courses</h2>
       
            
        <%
            if(!verifiedCoursesHashMap.isEmpty())
            {
         %>
          <table>
         
         <tr>
                <td>Course Id</td>
                <td>Course Name</td>    
            </tr>
         <%
                 for(String i: verifiedCoursesHashMap.keySet())
                {
                 %>
                 <form action="Trainer_Get_Verified_Course_Details" method="post">   
                 <tr>
                     <td><input type = "text" name="trainercourseid" id = "trainercourseid" value="<%=i%>" readonly ></td>
                    <td><input type="text" name = "trainercoursename" id="trainercoursename" value="<%=verifiedCoursesHashMap.get(i)%>" readonly></td>
                    <td><input type="submit" value="Show Details"></td>
                 </tr>
                 </form>
                 <%
                }
                %>
          </table>
                <%
            }
            else
            {
                %>
                        <table>
                            <tr>
                                <td>Course Id</td>
                                <td>Course Name</td>
                            <tr>
                            
                            <tr>
                                <td><input type="text" value="No data found" readonly></td>
                                <td><input type="text" value="No data found" readonly></td>
                            <tr>
                                
                        </table>
                <%
            
            }
            %>    
            
            </BR>
            </BR>
            <H2>List of your <span style="color: #507484">Registered</span> Courses</H2>
          
           <%
            if(!unverifiedCoursesHashMap.isEmpty())
            {
             %>
             <table> 
            <tr>
                <td>Course Id</td>
                <td>Course Name</td>    
            </tr>
          <%
                for(String i : unverifiedCoursesHashMap.keySet())
                {
                 %>
                 
               <form action="Trainer_Get_Course_Details" method="post">    
                 <tr>   
                     <td><input type="text" name="trainercourseid" id="trainercourseid" value="<%=i%>" readonly></td>
                     <td><input type="text" name="trainercoursename" id="trainercoursename" value="<%=unverifiedCoursesHashMap.get(i).replace("*", "'")%>" readonly></td>
                    <td><input type="submit" value="Show Details"></td>
                  </tr>
               </form>
                 <%
                }
                  %>
           
             </table>
                  <%
            } 
            else
            {
                %>
                        <table>
                            <tr>
                                <td>Course Id</td>
                                <td>Course Name</td>
                            <tr>
                            
                            <tr>
                                <td><input type="text" value="No data found" readonly=""></td>
                                <td><input type="text" value="No data found" readonly=""></td>
                            <tr>
                                
                        </table>
                <%
            }
            %>
        </div>
    </body>
</html>
