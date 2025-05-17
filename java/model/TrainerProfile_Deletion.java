package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class TrainerProfile_Deletion {
    private String trainerid;
    private Connection con = DBConnector.getConnection();
    
    public TrainerProfile_Deletion(String trainerid)
    {
        this.trainerid = trainerid;
    }
    public void deleteProfile()
    {
        String query = "DELETE FROM trainer_table WHERE trainer_id = ?";
        String query2 = "DELETE FROM trainer_verification_table WHERE trainer_id = ?";
        String query3 = "SELECT course_id FROM trainer_course_table WHERE trainer_id = ?";
        String query4 = "DELETE FROM trainer_course_table WHERE trainer_id = ?";
        List <String> courseIdList = new ArrayList<>();
        try
        {
            PreparedStatement pst = con.prepareStatement(query3);
            pst.setString(1, trainerid);
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                courseIdList.add(rs.getString(1));
            }
            System.out.println("Deleted courses: "+courseIdList);
            for(int i=0; i<courseIdList.size(); i++)
            {
                pst = con.prepareStatement("DELETE FROM course_table WHERE course_id = ?");
                pst.setString(1, courseIdList.get(i));
                pst.execute();
            }
            courseIdList.clear();
            
            pst = con.prepareStatement(query);
            pst.setString(1, trainerid);
            pst.execute();
            
            pst = con.prepareStatement(query2);
            pst.setString(1, trainerid);
            pst.execute();
            
            pst = con.prepareStatement(query4);
            pst.setString(1, trainerid);
            pst.execute();
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
    }
}
