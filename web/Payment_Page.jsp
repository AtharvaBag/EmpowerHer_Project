<%@page import="java.util.ArrayList"%>
<%@page import="dto.Course_DTO"%>
<%@page import="dto.Student_DTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        Student_DTO studentDetails = (Student_DTO)session.getAttribute("studentDetails");
        Course_DTO courseDetails = (Course_DTO)session.getAttribute("courseDetails");
        boolean isStudentWishlisted = false;
        System.out.println(courseDetails.getCourseid());
        System.out.println(studentDetails.getStudentid());
        
        if(courseDetails == null || studentDetails == null)
        {
            System.out.println("Redirecting from Payment_Page");
            response.sendRedirect("home.html");
            return;
        }
        
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Payment Page</title>
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
            background-size: cover;
            background-attachment: fixed;
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
    margin-top: 25px;
    text-align: center; 
    color: var(--black);
    margin-bottom: 1rem;
    font-size: 35px; 
}
span{
    color: #507484;
}
h2 {
    text-align: left; 
    color: var(--black);
    margin-bottom: 1rem;
    font-size: 25px; 
}

             table {
    width: 100%; 
    max-width: 1100px;
    margin-left: 15%;
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

input[type="text"]{
    width: 90%;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 40px;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
    
}
input[type="tel"]{
    width: 90%;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 40px;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
}
input[type="password"]{
    width: 90%;
    padding: 0.4rem; 
    font-size: 20px; 
    border-radius: 20px;
    text-align: center;
    margin-left: 40px;
    box-shadow: var(--box-shadow);
    margin-bottom: 0.5rem; 
    background: var(--light-green);
    color: var(--black);
    
}
.btn {
            display: flex;
            justify-content: center;
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
        .btn:hover {
            background: transparent;
            color: var(--white);
        }
        </style>
    </head>
    <body>
        <header class="header">
            <a href="Student_Home.jsp" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <form action="home.html" method="get" style="display: inline;">
                    <input type="submit" value="Search Courses" class="nav-btn">
                </form>
                <form>
                </form>
                <form action="Student_Details" method="POST" style="display: inline;">
                    <input type="submit" value="My Profile" class="nav-btn">
                </form>
            </nav>
        </header>

        <h1>Hi <span><%=studentDetails.getStudentname().toUpperCase()%></span>!</h1>
        <%
            boolean flag = false;
            if(session.getAttribute("studentEnrolledCourseDetails") != null)
            {
                ArrayList <Course_DTO> studentEnrolledCourseDetails = new ArrayList<>((ArrayList) session.getAttribute("studentEnrolledCourseDetails"));
                for(int i=0; i<studentEnrolledCourseDetails.size(); i++)
                {
                     if(studentEnrolledCourseDetails.get(i).getCourseid().equals(courseDetails.getCourseid()))
                    {
                        flag = true;
                        break;
                    }
                }
            }
            if(flag)
            {
                %>
                <H2 style="text-align: center">You are already enrolled in this course, <%=courseDetails.getCoursetitle().trim() %></H2>
                <%
            }
            
        else 
        {
            if(session.getAttribute("studentWishlistCourseDetails")!=null)
            {
                ArrayList <Course_DTO> studentWishlistCourseDetails = new ArrayList<>((ArrayList)session.getAttribute("studentWishlistCourseDetails"));
                for(int i=0; i<studentWishlistCourseDetails.size(); i++)
                {
                    if(studentWishlistCourseDetails.get(i).getCourseid().equals(courseDetails.getCourseid()))
                    {
                        isStudentWishlisted = true;
                        session.setAttribute("isStudentWishlisted", isStudentWishlisted);
                    }
                }
            }
        
%>
      
         <table>
            <tr>
                <!-- <td>Selected Course Name: </td> -->
                <td><%=courseDetails.getCoursetitle().replace("*", "'")%></td>
            </tr>
            <tr>
                <td>Total Fees:  Rs.<%=courseDetails.getCoursefee().trim()%></td>
            </tr>
        </table>
            </BR>
       <h2 style="text-align: center">Select a payment mode!</h2>
     
     <table>  
            <td>
            <form action="Enroll_To_Course" method="POST">
            <tr>
                <td><input TYPE="Radio" name="paymentmode"  value="creditcard"  style=" font-size: 25px;  font-weight: bold;"><Label for="creditcard"> Credit Card</Label></td>
            </tr>
            <tr>
               <td>Card number: </td>
               <td><input type="tel"pattern="[0-9]{16}" placeholder="16 digit number" ><td>
            </tr> 
            <tr>
               <td>CVV: </td>
               <td><input type="tel"pattern="[0-9]{3}" placeholder="3 digit number" ><td>
            </tr>
            <tr>
               <td>Card PIN: </td>
               <td><input type="password"pattern="[0-9]{4}" ><td>
            </tr>
            <tr>
                <td></td>
               <td><input type="Submit" class="btn"  value="Confirm Payment"></td>
            </tr>
                <tr>
                    <td><input TYPE="Radio" name="paymentmode" value="netbanking"  style=" font-size: 25px;  font-weight: bold;"><Label for="netbanking"> Net Banking</Label></td>
                </tr>
                    <tr><td></td></tr>
                <tr>
                    <td>Bank Account number: </td>
                    <td><input type="tel"pattern="[0-9]{16}"  placeholder="16 digit account number"><td>
                </tr> 
                <tr>
                    <td>Bank name: </td>
                    <td><input type="text" ><td>
                 </tr>
                 <tr>
                     <td>User id: </td>
                     <td><input type="text" ><td>
                    </tr>
                    <tr>
                         <td>Password: </td>
                         <td><input type="password" ><td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" class="btn" value="Confirm Payment"></td>
                    </tr>
                    <tr><td></td></tr>
                <tr>
                    <td><input TYPE="Radio" name="paymentmode" value="upipayment"  style=" font-size: 25px;  font-weight: bold;"><Label for="upipayment"> UPI Payment</Label></td>
                </tr>   
                <tr>
                    <td>UPI Id: </td>
                    <td><input type="text" ><td>
                </tr> 
                <tr>
                    <td>UPI Pin: </td>
                    <td><input type="password"><td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="Submit" class="btn" value="Confirm Payment"></td>
                </tr>
                </from>
                </td>
             </table>
       <%
       }
       %>
    </body>
</html>
