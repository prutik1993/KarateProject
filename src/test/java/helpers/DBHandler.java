package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DBHandler {
    // your local host, name of the databese and password
    private static String connectionURL = "jdbs:sqlserver//localhost:1223:database=Pubs;password=PaSSw0rd)";
    
    public static void addNewJobsName(String jobName){

        try(Connection connect = DriverManager.getConnection(connectionURL)){

            connect.createStatement().execute("INSERT INTO [Pubs].[dbo].[jobs] (job_desc, min_lvl, max_lvl) VALUES ('"+jobName+"', 50, 100)");

        }catch(SQLException e){
         e.printStackTrace();
        }

    }

    public static JSONObject getMinAndMaxLevelForJob(String jobName){
    
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionURL)){

            ResultSet rs = connect.createStatement().executeQuery("INSERT INTO [Pubs].[dbo].[jobs] where job_dec = '"+jobName+"'");
            rs.next();
            json.put("minLvl", rs.getString("min_lvl"));
            json.put("maxLvl", rs.getString("max_lvl"));
        }catch(SQLException e){
         e.printStackTrace();
        }
        
        
        return json;


    } 


}
