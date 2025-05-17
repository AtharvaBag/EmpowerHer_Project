package model;

import db.DBConnector;
import dto.Student_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Student_Data_Update {

    private Student_DTO updatedDetails;
    private Connection con = DBConnector.getConnection();
    public Student_Data_Update(Student_DTO updatedDetails)
    {
        this.updatedDetails = updatedDetails;
    }
    
    public void updateProfile()
    {
        try
        {
            String query = "UPDATE student_table SET student_name = ?, student_contact = ?, student_mailid = ? WHERE student_id = ?";
            System.out.println(query);
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, updatedDetails.getStudentname().trim().toUpperCase());
            pst.setString(2, updatedDetails.getStudentcontact().trim());
            pst.setString(3, updatedDetails.getStudentmailid().trim());
            pst.setString(4, updatedDetails.getStudentid());
            pst.executeUpdate();
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
