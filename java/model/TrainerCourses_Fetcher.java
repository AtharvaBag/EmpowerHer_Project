package model;

import db.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrainerCourses_Fetcher {
        
        private String trainerid;
        private String verified;
        private static Map <String, String> allCoursesMap = new HashMap<>();
        private static List <String> allCoursesList = new ArrayList<>();
        private static List <String> verifiedCoursesList = new ArrayList<>();
        private static List <String> unverifiedCoursesList = new ArrayList<>();
        private static List <String> verifiedCoursesNameList = new ArrayList<>();
        private static List <String> unverifiedCoursesNameList = new ArrayList<>();
        private static HashMap <String, String> verifiedCoursesHashMap = new HashMap<>();
        private static HashMap <String, String> unverifiedCoursesHashMap = new HashMap<>();
        private Connection con = DBConnector.getConnection();
        
        public TrainerCourses_Fetcher(String trainerid)
        {
            this.trainerid = trainerid;
        }
        public void getAllCourses()
        {
            String query = "SELECT course_id FROM trainer_course_table WHERE trainer_id= ?";
            
            try
            {
                    PreparedStatement pst = con.prepareStatement(query);
                    pst.setString(1, trainerid);
                    ResultSet rs = pst.executeQuery();
                    allCoursesList.clear();
                    while(rs.next())
                    {
                        allCoursesList.add((String)rs.getString(1));
                    }
                    allCoursesMap.clear();
                    for(int i=0; i<allCoursesList.size(); i++)
                    {
                        pst = con.prepareStatement("SELECT verified FROM trainer_course_table WHERE course_id= ?");
                        pst.setString(1, allCoursesList.get(i));
                        rs = pst.executeQuery();
                        if(rs.next())
                        {
                            if(rs.getString(1).equals("0"))
                                   verified = "0";
                            else if(rs.getString(1).equals("1"))
                                verified = "1";
                            else if(rs.getString(1).equals("2"))
                                verified="2";
                            allCoursesMap.put(allCoursesList.get(i), verified);
                        }
                    }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
            System.out.println(allCoursesMap);
        }
        
        public void filterCourses()
        {
            String isVerified;
            verifiedCoursesList.clear();
            unverifiedCoursesList.clear();
            for(int i=0; i<allCoursesMap.size(); i++)
            {
                isVerified = allCoursesMap.get(allCoursesList.get(i));
                if(isVerified=="1")
                    verifiedCoursesList.add(allCoursesList.get(i));
                else if(isVerified=="0" || isVerified=="2")
                    unverifiedCoursesList.add(allCoursesList.get(i));
            }
        }
        
        public HashMap mapVerifiedCourseName()
        {
            try
            {
                verifiedCoursesNameList.clear();
                for(int i=0; i<verifiedCoursesList.size(); i++)
                {
                    PreparedStatement pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id= ?");
                    pst.setString(1, verifiedCoursesList.get(i));
                    ResultSet rs = pst.executeQuery();
                    if(rs.next())
                    {
                        verifiedCoursesNameList.add(rs.getString(1));
                    }
                }
                verifiedCoursesHashMap.clear();
                for(int i=0; i<verifiedCoursesNameList.size(); i++)
                {
                    verifiedCoursesHashMap.put(verifiedCoursesList.get(i), verifiedCoursesNameList.get(i));
                }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
            System.out.println(verifiedCoursesHashMap);
            return verifiedCoursesHashMap;
        }
        
        public HashMap mapUnverifiedCourseName()
        {
             try
            {
                unverifiedCoursesNameList.clear();
                for(int i=0; i<unverifiedCoursesList.size(); i++)
                {
                    PreparedStatement pst = con.prepareStatement("SELECT course_title FROM course_table WHERE course_id= ?");
                    pst.setString(1, unverifiedCoursesList.get(i));
                    ResultSet rs = pst.executeQuery();
                    if(rs.next())
                    {
                        unverifiedCoursesNameList.add(rs.getString(1));
                    }
                }
                unverifiedCoursesHashMap.clear();
                for(int i=0; i<unverifiedCoursesNameList.size(); i++)
                {
                    unverifiedCoursesHashMap.put(unverifiedCoursesList.get(i), unverifiedCoursesNameList.get(i));
                }
            }
            catch(SQLException e)
            {
                System.out.println(e);
            }
            System.out.println(unverifiedCoursesHashMap);
            return unverifiedCoursesHashMap;
        }
}
