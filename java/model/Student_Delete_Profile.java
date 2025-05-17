package model;

import db.DBConnector;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Student_Delete_Profile {

    private Student_DTO studentDetails;
    private Connection con = DBConnector.getConnection();
    public Student_Delete_Profile(Student_DTO studentDetails)
    {
        this.studentDetails = studentDetails;
    }
    
    public void deleteProfile()
    {
        try
        {
            String query = "DELETE FROM student_table WHERE student_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentDetails.getStudentid());
            System.out.println(query);
            pst.executeUpdate();
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
