package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class Request_Deletion {
    
    private String trainercourseid;
    private String studentid;
    private Connection con = DBConnector.getConnection();
    public Request_Deletion(String trainercourseid, String studentid)
    {
        this.trainercourseid = trainercourseid;
        this.studentid = studentid;
    }
    
    public boolean requestDeletion()
    {
        try
        {
            String query = "UPDATE student_course_table SET enrolled='2' WHERE student_id = ? AND course_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentid);
            pst.setString(2, trainercourseid);
            System.out.println(query);
            int i = pst.executeUpdate();
            if(i>0)
            {
                return true;
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return false;
    }
    
    public boolean cancelStudentDeletion()
    {
        try
        {
            String query = "UPDATE student_course_table SET enrolled='1' WHERE student_id = ? AND course_id = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, studentid);
            pst.setString(2, trainercourseid);
            System.out.println(query);
            int i = pst.executeUpdate();
            if(i>0)
            {
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
