package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Student_Login_Check {
    
    private Student_DTO studentLoginDetails;
    private static ArrayList <Course_DTO> studentEnrolledCourseDetails = new ArrayList<>();
    private static ArrayList <Course_DTO> studentWishlistCourseDetails = new ArrayList<>();
    private Connection con = DBConnector.getConnection();
    
    public Student_Login_Check(Student_DTO studentLoginDetails)
    {
        this.studentLoginDetails = studentLoginDetails;
    }
    
    public boolean studentAuthentication()
    {
        if(studentLoginDetails.getStudentcontact().trim().equals("") || studentLoginDetails.getStudentpassword().trim().equals(""))
        {
            return false;
        }
        try
        {
            PreparedStatement pst = con.prepareStatement("SELECT student_password  FROM student_table WHERE student_contact= ?");
            pst.setString(1, studentLoginDetails.getStudentcontact().trim());
            String table_password = new String();
            ResultSet rs = pst.executeQuery();
            if(rs.next())
            {
                table_password = rs.getString(1);
            }
            if(table_password.equals(studentLoginDetails.getStudentpassword()))
            {
                pst = con.prepareStatement("SELECT student_name, student_id FROM student_table WHERE student_contact= ?");
                pst.setString(1, studentLoginDetails.getStudentcontact().trim());
                rs = pst.executeQuery();
                if(rs.next())
                {
                    studentLoginDetails.setStudentname(rs.getString(1));
                    studentLoginDetails.setStudentid(rs.getString(2));
                }
                return true;
            }
            
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
    
    public ArrayList enrolledCourses()
    {
        studentEnrolledCourseDetails.clear();
        try
        {
            PreparedStatement pst = con.prepareStatement("SELECT course_id FROM student_course_table WHERE student_id= ? AND (enrolled='1' OR enrolled='2')");
            pst.setString(1, studentLoginDetails.getStudentid().trim());
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                Course_DTO enrolledCourseDetails = new Course_DTO();
                enrolledCourseDetails.setCourseid(rs.getString(1).trim());
                studentEnrolledCourseDetails.add(enrolledCourseDetails);
            }
            
            if(!studentEnrolledCourseDetails.isEmpty())
            {
                for(int i=0; i<studentEnrolledCourseDetails.size(); i++)
                {
                    pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id= ?");
                    pst.setString(1, studentEnrolledCourseDetails.get(i).getCourseid());
                    rs = pst.executeQuery();
                    if(rs.next())
                    {
                        studentEnrolledCourseDetails.get(i).setCoursetitle(rs.getString(1));
                    }
                }
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return studentEnrolledCourseDetails;
    }
    
    public ArrayList wishlistCourses()
    {
        studentWishlistCourseDetails.clear();
        try
        {
            PreparedStatement pst = con.prepareStatement("SELECT course_id FROM student_course_table WHERE student_id= ? AND enrolled='0'");
            pst.setString(1, studentLoginDetails.getStudentid().trim());
             ResultSet rs = pst.executeQuery();
             while(rs.next())
             {
                 Course_DTO wishlistCourseDetails = new Course_DTO();
                 wishlistCourseDetails.setCourseid(rs.getString(1).trim());
                 studentWishlistCourseDetails.add(wishlistCourseDetails);
             }
             
             if(!studentWishlistCourseDetails.isEmpty())
             {
                 for(int i=0; i<studentWishlistCourseDetails.size(); i++)
                 {
                     pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id= ?");
                     pst.setString(1, studentWishlistCourseDetails.get(i).getCourseid());
                     rs = pst.executeQuery();
                     if(rs.next())
                     {
                         studentWishlistCourseDetails.get(i).setCoursetitle(rs.getString(1));
                     }
                 }
             }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return studentWishlistCourseDetails;
    }
}
