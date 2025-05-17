package model;

import db.DBConnector;
import dto.Course_DTO;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Remove_Wishlisted_Course {

    private Course_DTO courseDetails;
    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    public Remove_Wishlisted_Course(Course_DTO courseDetails, Student_DTO studentDetails)
    {
        this.courseDetails = courseDetails;
        this.studentDetails = studentDetails;
    }
    
    public boolean removeCourse()
    {
        try
        {
            String query = "DELETE FROM student_course_table WHERE student_id = ? AND course_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentid());
            pst.setString(2, courseDetails.getCourseid());
            System.out.println(query);
            int j = pst.executeUpdate();
            if(j>0)
            {
                return true;
            }
            return false;
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
}
