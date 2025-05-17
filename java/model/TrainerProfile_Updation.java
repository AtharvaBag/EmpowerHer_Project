package model;

import db.DBConnector;
import dto.Trainer_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class TrainerProfile_Updation {
        private String trainerid;
        private Trainer_DTO updateProfile;
        private Connection con = DBConnector.getConnection();
        
        public TrainerProfile_Updation(String trainerid, Trainer_DTO updateProfile)
        {
            this.trainerid = trainerid;
            this.updateProfile = updateProfile;
        }
        public boolean checkMailid()
        {
             if(updateProfile.getTraineremailid().contains("@") && (updateProfile.getTraineremailid().contains(".com") || updateProfile.getTraineremailid().contains(".org") || updateProfile.getTraineremailid().contains(".edu")))
            {
                return true;
            }
            System.out.println("Invalid mail id");
            return false;
        }
        public boolean checkContact()
        {
            if(updateProfile.getTrainercontact().length()==10)
                return true;
            return false;
        }
        public boolean checkAdharCardNumber()
        {
            if(updateProfile.getTraineradharnumber().length()==12)
                return true;
            return false;
        }
        public void updateProfile()
        {
            String trainername = updateProfile.getTrainerfirstname().trim().toUpperCase()+" "+updateProfile.getTrainerlastname().trim().toUpperCase();
            String query = "UPDATE trainer_table SET trainer_first_name= ?, trainer_middle_name= ?, "
                    + "trainer_last_name = ?, trainer_birth_date = ?, trainer_address = ?,"
                    + "trainer_city = ?, trainer_state = ?, trainer_contact= ?, trainer_email_id = ?, "
                    + "trainer_adhar_card_number = ?,"
                    + "trainer_name= ? WHERE trainer_id = ?";
            
            String query2 = "UPDATE trainer_verification_table SET verified='2' WHERE trainer_id= ?";
            
            try
            {
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, updateProfile.getTrainerfirstname().toUpperCase());
                pst.setString(2, updateProfile.getTrainermiddlename().toUpperCase());
                pst.setString(3, updateProfile.getTrainerlastname().toUpperCase());
                pst.setString(4, updateProfile.getTrainerdob());
                pst.setString(5, updateProfile.getTraineraddress().toUpperCase());
                pst.setString(6, updateProfile.getTrainercity().toUpperCase());
                pst.setString(7, updateProfile.getTrainerstate().toUpperCase());
                pst.setString(8, updateProfile.getTrainercontact());
                pst.setString(9, updateProfile.getTraineremailid().toLowerCase());
                pst.setString(10, updateProfile.getTraineradharnumber());
                pst.setString(11, trainername.toUpperCase());
                pst.setString(12, trainerid);
                
                pst.execute();
                
                pst = con.prepareStatement(query2);
                pst.setString(1, trainerid);
                pst.execute();
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
        }
}
