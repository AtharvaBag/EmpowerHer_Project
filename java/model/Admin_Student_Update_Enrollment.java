package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Admin_Student_Update_Enrollment {

    private Course_DTO courseDetails;
    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    public Admin_Student_Update_Enrollment(Student_DTO studentDetails, Course_DTO courseDetails)
    {
        this.courseDetails = courseDetails;
        this.studentDetails = studentDetails;
    }
    
    public boolean removeStudent()
    {
        try
        {
            String query = "DELETE FROM student_course_table WHERE student_id = ? AND course_id = ?";
            System.out.println(query);
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentid());
            pst.setString(2, courseDetails.getCourseid());
            int i = pst.executeUpdate();
            if(i>0)
            {
                System.out.println("Student deleted from course");
                return true;
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
    
    public boolean reenrollStudent()
    {
        String query = "UPDATE student_course_table SET enrolled='1' WHERE student_id= ? AND course_id= ?";
        System.out.println(query);
        try
        {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentid());
            pst.setString(2, courseDetails.getCourseid());
            int i = pst.executeUpdate();
            if(i>0)
            {
                System.out.println("Student reenrolled to course successfully");
                return true;
            }
        }
       catch(SQLException e)
       {
           System.out.println(e);
       }
        return false;
   }
}
