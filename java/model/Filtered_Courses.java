package model;

import db.DBConnector;
import dto.Course_DTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Filtered_Courses {
        private Course_DTO filteredCourseChoice;
        private String inputcourse;
        private Connection con = DBConnector.getConnection();
        public Filtered_Courses(Course_DTO filteredCourseChoice, String inputcourse)
        {
            this.filteredCourseChoice = filteredCourseChoice;
            this.inputcourse = inputcourse;
        }
        
        public boolean noData()
        {
            if(filteredCourseChoice.getCoursemode().equals("")  && filteredCourseChoice.getCoursecertification().equals("") && 
                    filteredCourseChoice.getCourseduration().equals("") && filteredCourseChoice.getCoursefee().equals("") && 
                    filteredCourseChoice.getCourseviewers().equals(""))
            {
                return true;
            }
            return false;
        }
        
        public ArrayList getCourses()
        {
                ArrayList <Course_DTO> filteredCourses = new ArrayList<>();
                filteredCourses.clear();
                String inputcourses[] = inputcourse.split("[ ]");
                 Set<String> set = new HashSet<>(Arrays.asList(inputcourses));
                inputcourses = set.toArray(new String[0]);
                for(String x: inputcourses)
                    System.out.print(x+" ");
                 ArrayList <String> filteredCourseIdList = new ArrayList<>();
                 filteredCourseIdList.clear();
                 ArrayList <String> filteredVerifiedCourseIdList = new ArrayList<>();
                 filteredVerifiedCourseIdList.clear();
                for(int j=0; j<inputcourses.length; j++)
                {
                            if(inputcourses[j].length()>=3)
                            {
                                try
                                {    

                                    ArrayList <String> parameters = new ArrayList<>();
                                    String query = "SELECT course_id FROM course_table WHERE (course_skill_domain LIKE CONCAT( '%',?,'%') "
                                                            + "OR course_skill_domain LIKE CONCAT( '%',?,'%')"
                                                            + " OR course_title LIKE CONCAT( '%',?,'%') "
                                                            + "OR course_title LIKE CONCAT( '%',?,'%'))";

                                    parameters.add(inputcourses[j].trim().toUpperCase());
                                    parameters.add(inputcourses[j].trim().toUpperCase().substring(0,3));
                                    parameters.add(inputcourses[j].trim().toUpperCase());
                                    parameters.add(inputcourses[j].trim().toUpperCase().substring(0,3));

                                     if(!filteredCourseChoice.getCoursemode().equals(""))
                                    {
                                        query = query + " AND (course_mode = ?)";
                                        parameters.add(filteredCourseChoice.getCoursemode().trim().toUpperCase());
                                    }
                                    if(!filteredCourseChoice.getCoursecertification().equals(""))
                                    {
                                        query = query + " AND (course_certification = ?)";
                                        parameters.add(filteredCourseChoice.getCoursecertification().trim());
                                    }
                                    if(!filteredCourseChoice.getCourseviewers().equals(""))
                                    {
                                        query = query + " AND (course_viewers = ?)";
                                        parameters.add(filteredCourseChoice.getCourseviewers().trim().toUpperCase());
                                    }
                                if(!filteredCourseChoice.getCoursefee().equals(""))
                                {
                                    if(filteredCourseChoice.getCoursefee().equalsIgnoreCase("fee1"))
                                    {
                                        query = query + " AND (course_annual_fee <= 500)";
                                    }
                                    else if(filteredCourseChoice.getCoursefee().equalsIgnoreCase("fee2"))
                                    {
                                        query = query + " AND (course_annual_fee <= 1500 AND course_annual_fee > 500)";
                                    }
                                    else if(filteredCourseChoice.getCoursefee().equalsIgnoreCase("fee3"))
                                    {
                                        query = query + " AND (course_annual_fee <= 2500 AND course_annual_fee > 1500)";
                                    }
                                    else if(filteredCourseChoice.getCoursefee().equalsIgnoreCase("fee4"))
                                    {
                                        query = query + " AND (course_annual_fee <= 3500 AND course_annual_fee > 2500)";
                                    }
                                    else if(filteredCourseChoice.getCoursefee().equalsIgnoreCase("fee5"))
                                    {
                                        query = query + " AND (course_annual_fee > 3500)";
                                    }
                                }
                                if(!filteredCourseChoice.getCourseduration().equals(""))
                                {
                                    if(filteredCourseChoice.getCourseduration().equals("1"))
                                    {
                                        query = query + " AND (course_duration <= '1')";
                                    }
                                    else if(filteredCourseChoice.getCourseduration().equals("2"))
                                    {
                                        query = query + " AND (course_duration <= '2' AND course_duration>'1')";
                                    }
                                    else if(filteredCourseChoice.getCourseduration().equals("3"))
                                    {
                                        query = query + " AND (course_duration <= '3' AND course_duration>'2')";
                                    }
                                    else if(filteredCourseChoice.getCourseduration().equals("4"))
                                    {
                                        query = query + " AND (course_duration <= '4' AND course_duration>'3')";
                                    }
                                    else if(filteredCourseChoice.getCourseduration().equals("5"))
                                    {
                                        query = query + " AND (course_duration <= '5' AND course_duration>'4')";
                                    }
                                    else
                                    {
                                        query = query + "AND (course_duration>'5')";
                                    }
                                }
                                System.out.println(query);
                                PreparedStatement pst = con.prepareStatement(query);
                                for(int i=0; i<parameters.size(); i++)
                                {
                                    pst.setString(i+1, parameters.get(i));
                                }

                                    ResultSet rs = pst.executeQuery();
                                    while(rs.next())
                                    {
                                        filteredCourseIdList.add(rs.getString(1));
                                    }
                                    System.out.println(filteredCourseIdList);
                                    HashSet <String> removeDuplicates2 = new HashSet<>(filteredCourseIdList);
                                    filteredCourseIdList.clear();
                                    filteredCourseIdList = new ArrayList<>(removeDuplicates2);
                                    System.out.println(filteredCourseIdList);

                                    for(int i=0; i<filteredCourseIdList.size(); i++)
                                    {
                                        System.out.println("Query Exec "+i);
                                        pst = con.prepareStatement("SELECT course_id FROM trainer_course_table WHERE course_id = ? AND verified = '1'");
                                        pst.setString(1, filteredCourseIdList.get(i));
                                        rs = pst.executeQuery();
                                        if(rs.next())
                                        {
                                            filteredVerifiedCourseIdList.add(rs.getString(1));
                                        }
                                    }
                                    System.out.println(filteredVerifiedCourseIdList);

                                }
                                catch(SQLException e)
                                {
                                    System.out.println(e);
                                }
                            }
                }
                        HashSet <String> removeDuplicates = new HashSet<>(filteredVerifiedCourseIdList);
                        filteredVerifiedCourseIdList.clear();
                        filteredVerifiedCourseIdList = new ArrayList<>(removeDuplicates);
                        System.out.println("After removing duplicates: "+filteredVerifiedCourseIdList);
                        
                        for(int i=0; i<filteredVerifiedCourseIdList.size(); i++)
                        {
                            System.out.println("exec: "+i);
                            Course_DTO filteredCourseDetails = new Course_DTO();
                            filteredCourseDetails.setCourseid(filteredVerifiedCourseIdList.get(i));
                            Course_Details_Fetcher courseDetails = new Course_Details_Fetcher(filteredCourseDetails);
                            System.out.println(courseDetails.getDetails());
                            filteredCourses.add(courseDetails.getDetails());
                        }
                        for(int i=0; i<filteredCourses.size(); i++)
                        {
                            System.out.println(filteredCourses);
                            System.out.println(filteredCourses.get(i).getCoursetitle());
                        }
                        return filteredCourses;
        }
}
                   
                
            
        
        

