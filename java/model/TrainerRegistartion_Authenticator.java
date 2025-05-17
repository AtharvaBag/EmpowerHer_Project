package model;

import db.DBConnector;
import dto.Trainer_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TrainerRegistartion_Authenticator 
{
    private String trainerpassword, trainerconfirmpassword, traineremailid, traineradharnumber;
    private Connection con = DBConnector.getConnection();
    
    public TrainerRegistartion_Authenticator(String trainerpassword, String trainerconfirmpassword, String traineremailid, String traineradharnumber)
    {
        this.trainerpassword = trainerpassword;
        this.trainerconfirmpassword = trainerconfirmpassword;
        this.traineremailid = traineremailid;
        this.traineradharnumber = traineradharnumber;
    }
    
    public boolean isTrainerPasswordValid()
    {
        if(trainerpassword.equals(trainerconfirmpassword) && trainerpassword.length()>=8)
        {
            return true;
        }
        System.out.println("Invalid password");
        return false;
    }
    
    public boolean isMailIdValid()
    {
        if(traineremailid.contains("@") && (traineremailid.contains(".com") || traineremailid.contains(".org") || traineremailid.contains(".edu")))
        {
            return true;
        }
        System.out.println("Invalid mail id");
        return false;
    }
    
    public boolean isAdharNumberValid()
    {
        if(traineradharnumber.length()==12)
        {
            return true;
        }
        System.out.println("Invalid Adhar Card Number");
        return false;
    }
    public void registerTrainer(Trainer_DTO trainerDetails)
    {
        String trainername = trainerDetails.getTrainerfirstname().toUpperCase().trim() + " " + trainerDetails.getTrainerlastname().toUpperCase().trim();
        
        String query = "INSERT INTO trainer_table (trainer_first_name, trainer_middle_name, trainer_last_name, trainer_name, trainer_birth_date, trainer_address, trainer_city, trainer_state, trainer_contact, trainer_email_id, trainer_adhar_card_number, trainer_password) "
                + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        System.out.println(query);
        
        
        
        System.out.println("SELECT trainer_id FROM trainer_table WHERE trainer_name = '"+trainerDetails.getTrainername()+"' AND trainer_contact = '"+trainerDetails.getTrainercontact()+"'");
        
        try
        {
            
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, trainerDetails.getTrainerfirstname().toUpperCase());
            pst.setString(2, trainerDetails.getTrainermiddlename().toUpperCase());
            pst.setString(3, trainerDetails.getTrainerlastname().toUpperCase());
            pst.setString(4, trainername);
            pst.setString(5, trainerDetails.getTrainerdob());
            pst.setString(6, trainerDetails.getTraineraddress().toUpperCase());
            pst.setString(7, trainerDetails.getTrainercity().toUpperCase());
            pst.setString(8, trainerDetails.getTrainerstate().toUpperCase());
            pst.setString(9, trainerDetails.getTrainercontact());
            pst.setString(10, trainerDetails.getTraineremailid().toLowerCase());
            pst.setString(11, trainerDetails.getTraineradharnumber());
            pst.setString(12, trainerDetails.getTrainerpassword());
            
            int i = pst.executeUpdate();
            if(i>0)
            {
                System.out.println("Trainer Registered Succesfully!");
                pst = con.prepareStatement("SELECT trainer_id FROM trainer_table WHERE trainer_name = ? AND trainer_contact = ?");
                pst.setString(1, trainerDetails.getTrainername());
                pst.setString(2, trainerDetails.getTrainercontact());
                ResultSet rs = pst.executeQuery();
               if(rs.next())
                {
                    trainerDetails.setTrainerid(rs.getString(1));
                    System.out.println(trainerDetails.getTrainerid());
                    pst = con.prepareStatement("INSERT INTO trainer_verification_table (trainer_id, verified) VALUES(?, '0')");
                    pst.setString(1, trainerDetails.getTrainerid());
                    pst.executeUpdate();
                    trainerDetails.setTrainerverificationstatus("0");
                }
            }
            else
            {
                System.out.println("Trainer Registration Failed!");
            }
            
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        return;
    }
}
