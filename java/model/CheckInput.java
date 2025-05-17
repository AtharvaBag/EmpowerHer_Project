package model;

import db.DBConnector;
import dto.Course_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class CheckInput {
    
    private String searchquery;
    private Connection con = DBConnector.getConnection();
    private  ArrayList <Course_DTO> courseBasicDetails = new ArrayList <>();
    private  ArrayList <String> coursesList = new ArrayList<>();
    private   ArrayList <String> verifiedCoursesList = new ArrayList<>();
    private  ArrayList <String> trainerList = new ArrayList<>();
    
    public CheckInput(String searchquery)
    {
        this.searchquery = searchquery;
    }
    
    public boolean isValid()
    {
        if(searchquery.length() == 0)
        {    
            return false;
        }
        return true;
    }
    
    public String domainSelector()
    {
       return searchquery;
    }
    
    public ArrayList getCourses()
    {
      String []input =  searchquery.split("[ ]");
      Set<String> set = new HashSet<>(Arrays.asList(input));
      input = set.toArray(new String[0]);
      for(String x: input)
      {
          System.out.print(x+" ");
      }
      System.out.println();
        if(searchquery.toLowerCase().contains("music") || searchquery.toLowerCase().contains("guitar") || searchquery.toLowerCase().contains("flute") || searchquery.toLowerCase().contains("ukelele") || searchquery.toLowerCase().contains("tabla"))
                searchquery = "musician";
        else if(searchquery.toLowerCase().contains("gaana") || searchquery.toLowerCase().contains("bhajan") || searchquery.toLowerCase().contains("sing") || searchquery.toLowerCase().contains("bhajan") || searchquery.toLowerCase().contains("classical singing") || searchquery.toLowerCase().contains("song") || searchquery.toLowerCase().contains("western singing") || searchquery.toLowerCase().contains("opera"))
                searchquery = "singing";
        else if(searchquery.toLowerCase().contains("cook") || searchquery.toLowerCase().contains("food") || searchquery.toLowerCase().contains("baking"))
                searchquery = "cooking";
        else if(searchquery.toLowerCase().contains("dance") || searchquery.toLowerCase().contains("folk dance") || searchquery.toLowerCase().contains("classical dance"))
                searchquery = "dancing";
        else if(searchquery.toLowerCase().contains("drama") ||searchquery.toLowerCase().contains("act") || searchquery.toLowerCase().contains("mimicry") || searchquery.toLowerCase().contains("theater"))
                searchquery = "acting";
        
        System.out.println(searchquery);
        
        for(int i=0; i<input.length; i++)
        {
            System.out.println(input[i]);
        }
        
        String query = "SELECT course_id FROM course_table WHERE course_title= ? "
                                    + "OR course_skill_domain= ?"
                                    + " OR course_institute_name = ?";
        
        int i=0;
        
        String query2 = "SELECT trainer_id FROM trainer_table WHERE trainer_name LIKE '%"+input[i].toLowerCase().trim()+"%' OR trainer_first_name LIKE '%"+input[i].toLowerCase().trim()+"%'"
                + " OR trainer_last_name='%"+input[i].toLowerCase().trim()+"%' OR trainer_middle_name LIKE '%"+input[i].toLowerCase().trim()+"%' OR trainer_first_name LIKE '%"+input[i].toLowerCase().trim() +"%'" ;
        
          String query3 = "SELECT course_id FROM course_table WHERE course_title LIKE '%"+input[i].toLowerCase().trim() +"%' OR course_skill_domain LIKE '%"+input[i].toLowerCase().trim() +"%'"
                + " OR course_institute_name LIKE '%"+input[i].toLowerCase().trim()+"%'";
        
        
        try
        {
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, searchquery);
            pst.setString(2, searchquery);
            pst.setString(3, searchquery);
            ResultSet rs = pst.executeQuery();
            coursesList.clear();
            while(rs.next())
            {
                coursesList.add(rs.getString(1));
            }
            System.out.println("Query 1 executed");
             for(i=0; i<input.length; i++)
            {
                if(input[i].length()>=3)
                {
                        pst = con.prepareStatement("SELECT course_id FROM course_table WHERE course_title LIKE CONCAT( '%',?,'%') OR course_skill_domain LIKE CONCAT( '%',?,'%')"
                        + " OR course_institute_name LIKE CONCAT( '%',?,'%') OR course_title LIKE CONCAT( '%',?,'%')");
                        pst.setString(1, input[i].toLowerCase().trim());
                        pst.setString(2, input[i].toLowerCase().trim());
                        pst.setString(3, input[i].toLowerCase().trim());
                        pst.setString(4, input[i].toLowerCase().trim().substring(0,3));
                        rs = pst.executeQuery();
                         while(rs.next())
                        {
                            coursesList.add(rs.getString(1));
                        }
                }
            }
            System.out.println("Query 2 executed");
             trainerList.clear();
            for(i=0; i<input.length; i++)
            {
                if(input[i].length() >= 3)
                {
                    pst = con.prepareStatement("SELECT trainer_id FROM trainer_table WHERE trainer_name LIKE CONCAT( '%',?,'%') OR trainer_first_name LIKE CONCAT( '%',?,'%')"
                    + " OR trainer_last_name LIKE CONCAT( '%',?,'%') OR trainer_middle_name LIKE CONCAT( '%',?,'%') OR trainer_first_name LIKE CONCAT( '%',?,'%')");
                    pst.setString(1, input[i].toLowerCase().trim());
                    pst.setString(2, input[i].toLowerCase().trim());
                    pst.setString(3, input[i].toLowerCase().trim());
                    pst.setString(4, input[i].toLowerCase().trim());
                    pst.setString(5, input[i].toLowerCase().trim().substring(0,3));
                    rs = pst.executeQuery();
                    while(rs.next())
                    {
                        trainerList.add(rs.getString(1));
                    }
                }
            }
            
            verifiedCoursesList.clear();
           
            for(i=0; i<trainerList.size(); i++)
            {
                pst = con.prepareStatement("SELECT course_id FROM trainer_course_table WHERE trainer_id = ? AND verified='1'");
                pst.setString(1, trainerList.get(i));
                 rs = pst.executeQuery();
                 if(rs.next())
                 {
                     if(!verifiedCoursesList.contains(rs.getString(1)))
                     {
                         verifiedCoursesList.add(rs.getString(1));
                     }
                 }
            }
            
            
            for(i=0; i<coursesList.size(); i++)
            {
                pst = con.prepareStatement("SELECT course_id FROM trainer_course_table WHERE course_id= ? AND verified='1'");
                pst.setString(1, coursesList.get(i));
                rs = pst.executeQuery();
                if(rs.next())
                {
                    if(!verifiedCoursesList.contains(rs.getString(1)))
                     {
                         verifiedCoursesList.add(rs.getString(1));
                     }
                }
            }
            
             for(int j=0; j<verifiedCoursesList.size(); j++)
            {
                System.out.println("Flow Check: "+verifiedCoursesList.get(j));
            }
            Set <String> set2 = new HashSet<>(verifiedCoursesList);
            verifiedCoursesList = new ArrayList<>(set2);
            for(int j=0; j<verifiedCoursesList.size(); j++)
            {
                System.out.println("After removing duplicates: "+verifiedCoursesList.get(j));
            }
        }
        catch(SQLException e)
        {
            System.out.println(e);
        }
        HashSet <String> removeDuplicate = new HashSet<>(verifiedCoursesList);
        verifiedCoursesList = new ArrayList<>(removeDuplicate);
        System.out.println(verifiedCoursesList);
        return verifiedCoursesList;
    }
    
    public ArrayList getCourseDetails()
    {
        try
        {
            courseBasicDetails.clear();
              HashSet <String> removeDuplicate = new HashSet<>(verifiedCoursesList);
              verifiedCoursesList = new ArrayList<>(removeDuplicate);
            for(int i=0; i<verifiedCoursesList.size(); i++)
            {
                PreparedStatement pst = con.prepareStatement("SELECT course_title, course_institute_name, course_viewers, course_mode, course_description, course_annual_fee FROM course_table WHERE course_id = ?");
                pst.setString(1, verifiedCoursesList.get(i));
                ResultSet rs = pst.executeQuery();
                while(rs.next())
                {
                    Course_DTO details = new Course_DTO();
                    details.setCourseid(verifiedCoursesList.get(i));
                    details.setCoursetitle(rs.getString(1));
                    details.setCourseclassname(rs.getString(2));
                    details.setCourseviewers(rs.getString(3));
                    details.setCoursemode(rs.getString(4));
                    details.setCoursedescription(rs.getString(5));
                    details.setCoursefee(rs.getString(6));
                    courseBasicDetails.add(details);
                }
            }
        }
        catch(SQLException e)
        {
               System.out.println(e);
        }
        return courseBasicDetails;
    }   
}
