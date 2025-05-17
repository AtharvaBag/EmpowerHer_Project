<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
        String trainerskill = (String)session.getAttribute("trainerskill");
        if(trainerskill==null)
        {
            response.sendRedirect("trainer_login.html");
            return;
        }     
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>EmpowerHer | Trainer Course Registration</title>
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
        #menu-btn {
            display: none;
        }
        .dropdown {
            display: none;
            position: absolute;
            right: 0;
            background: var(--white);
            box-shadow: var(--box-shadow);
            z-index: 100;
            flex-direction: column;
            min-width: 150px;
        }
        .dropdown div {
            color: var(--black);
        }
        .role-option {
            padding: 1rem;
            cursor: pointer;
            font-size: 1.6rem;
            color: var(--black);
            text-align: left;
        }
        .role-option:hover {
            background: var(--light-green);
        }
        .account-form {
            position: fixed;
            top: 0;
            right: -105%;
            width: 45rem;
            background: var(--white);
            display: flex;
            flex-flow: column;
            gap: 2rem;
            justify-content: center;
            height: 100%;
            z-index: 1200;
            padding: 2rem;
            text-align: center;
            overflow-y: hidden;
        }
        .account-form.active {
            right: 0;
            box-shadow: 0 0 0 100vw rgba(0, 0, 0, 0.8);
        }
        .account-form #close-form {
            position: absolute;
            top: 1.5rem;
            right: 2.5rem;
            font-size: 4rem;
            cursor: pointer;
            color: var(--black);
        }
        .account-form #close-form:hover {
            transform: rotate(90deg);
        }
        .account-form form {
            border: var(--border);
            border-radius: 8px;
            padding: 2rem;
            display: none;
        }
        .account-form form.active {
            display: block;
        }
        .account-form form h3 {
            font-size: 2.5rem;
            padding-bottom: .5rem;
            text-transform: uppercase;
        }
        .account-form form .box {
            width: 100%;
            padding: 1.2rem 1.4rem;
            border: var(--border);
            border-radius: 8px;
            font-size: 1.6rem;
            margin: .7rem 0;
        }
        .account-form form .btn {
            width: 100%;
        }
        .buttons {
            display: flex;
            justify-content: center;
        }
        .buttons .btn {
            margin: 0 .5rem;
        }
        h1 {
    color: var(--black);
    font-size: 3.5rem;
    text-align: center;
    padding-top: 1rem;
    margin-bottom: 0.5rem;
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
        h2 {
            text-align: left; 
            color: var(--white);
            margin-bottom: 1rem;
            font-size: 25px; 
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
            border: 2px solid var(--white);
            padding: 0.4rem 1rem; 
            cursor: pointer;
            border-radius: 25px;
            transition: background-color 0.3s;
            font-size: 20px; 
            width: 120px; 
            box-shadow: var(--box-shadow);
        }
        
        input[type="reset"]{
            margin-left: 75px;
            border: 0px;
        }
        
        input[type="submit"]{
            margin-left: 75px;
            border: 0px;
        }
        
        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: var(--black); 
        }
        h3 {
            text-align: center; 
            font-size: 1.4rem; 
            color: var(--white);
        }

        </style>

    </head>
    <body>
        <header class="header">
            <a href="index.html" class="logo">Empower<span>Her</span></a>
            <nav class="navbar">
                <a href="Trainer_Home_Page.jsp">Home</a>
                <a></a>
                <a href="Trainer_Profile_Delete.jsp">Delete Profile</a>
            </nav>
        </header>
        <br>
        <h1>Trainer Course Registration</h1>
        <div class="container">
        <h2>Enter the following details related to your course</h2>
        <br><br>
        <form action="TrainerCourse_Register" method="post">
            <table>
             <%
            if(trainerskill.trim().equals("+ Add Your Own Skill"))
            {
        %>
                        <h2 style="text-align: center; font-size: 20px; color: #90bcc4 ;">Register your unique skill here: </h2>
        
                        <td>Name of your skill: </td>
                        <td><input type="text" name="newskill" id="newskill" required="required"></td>
        
        <%
            }
            else
            {
        %>
        <h2 style="text-align: center; font-size: 20px;">Your Selected Skill: <span style="color: #90bcc4"><%=trainerskill%></span></h2>
        <%
            }
        %>
       
                <tr>
                    <td>Enter the name of your institute/class: </td>
                    <td><input type="text" name="courseclassname" id="courseclassname" required="required"></td>
                </tr>
                 <tr>
                    <td>Enter the contact number of your institute/class: </td>
                    <td><input type="tel" name="courseclasscontact" id="courseclasscontact" required="required" pattern="[0-9]{10}" placeholder="10 digit contact number"></td>
                </tr>
                   <tr>
                    <td>Enter the title of your course: </td>
                    <td><input type="text" name="coursetitle" id="coursetitle" required="required"></td>
                </tr>
                <tr>
                    <td>Select target students </td>
                    <td>
                    <input TYPE="Radio" name="courseviewers" value="Beginner"><Label for="Beginner"> Beginner Level Students</Label>
                    </br>
                    <INPUT TYPE="Radio" name="courseviewers" value="Intermediate"><Label for="Intermediate"> Intermediate Level Students</Label>
                    </br>
                    <INPUT TYPE="Radio" name="courseviewers" value="Advance"><Label for="Advance"> Advance Level Students</Label>
                    </td>
                </tr>
                <tr>
                    <td>Enter duration of course: </td>
                    <td><input type="text" name="courseduration" id="courseduration" required="required" placeholder="in months"></td>
                </tr>
                <tr>
                    <td>Enter number of days of classes: </td>
                    <td><input type="tel" name="coursedays" id="coursedays" required="required" placeholder="per week" pattern="[1-7]{1}"></td>
                </tr>
                <tr>
                    <td>Select mode of class: </td>
                    <td>
                    <input TYPE="Radio" name="coursemode" value="Online"><Label for="Online"> Online</Label>
                    </br>
                    <INPUT TYPE="Radio" name="coursemode" value="Offline"><Label for="Offline"> Offline</Label>
                    </br>
                    <INPUT TYPE="Radio" name="coursemode" value="Hybrid"><Label for="Hybrid"> Hybrid (Online + Offline)</Label>
                    </td>
                </tr>
                <tr>
                    <td>Enter address of your institute/class: </td>
                    <td><input type="text" name="courseclassaddress" id="courseclassaddress" placeholder="if available"></td>
                </tr>
                <tr>
                    <td>Enter city of your institute/class: </td>
                    <td><input type="text" name="courseclasscity" id="courseclasscity" placeholder="if available"></td>
                </tr>
                <tr>
                    <td>Enter state of your institute/class: </td>
                    <td><input type="text" name="courseclassstate" id="courseclassstate" placeholder="if available"></td>
                </tr>
                <tr>
                    <td>Enter description of your course: </td>
                    <td><textarea name="coursedescription" id="coursedescription" rows="4" cols="30" placeholder="in about 100 words"></textarea></td>
                </tr>
                <tr>
                    <td>Provides course completion certificate? </td>
                    <td>
                     <INPUT TYPE="Radio" name="coursecertificate" value="1"><Label for="1"> Yes</Label>
                    </br>
                    <INPUT TYPE="Radio" name="coursecertificate" value="0"><Label for="0"> No</Label>
                    </td>
                </tr>
                <tr>
                    <td>Total fees of course: </td>
                    <td><input type="text" name="coursefee" id="coursefee" placeholder="in INR"></td>
                </tr>
                <tr>
                    <td><input type="reset" value="Reset"></td>
                <td><input type="submit" value="Register"></td>
                </tr>
            </table>
        </form>
    </div>
    </body>
</html>
