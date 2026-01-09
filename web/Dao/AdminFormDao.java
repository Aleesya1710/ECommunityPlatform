/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
//import util.DBConnection;
import Bean.AdminFormBean;
/**
 *
 * @author syazw
 */
public class AdminFormDao {
    public String authenticateUser(AdminFormBean adminFormBean){
        String name = adminFormBean.getName();
        java.time.LocalDateTime time = adminFormBean.getTime();
        String description = adminFormBean.getDescription();
        
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        String nameDB = "";
        String timeDB = "";
        String descriptionDB = "";
        
        try{
            Connection con = DBConnection.createConnection();
            if (con == null){
                return "ERROR";
            }
            String query = "SELECT name, time, description FROM ? WHERE name = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, name);
            
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String nameDB = resultSet.getString("name");
                // Get timestamp from DB and convert to LocalDateTime
                java.sql.Timestamp ts = resultSet.getTimestamp("time");
                java.time.LocalDateTime timeDB = ts.toLocalDateTime();

                // 2. Logic for validation (Check if name and time match)
                if (name.equals(nameDB) && time.equals(timeDB)) {
                    return "SUCCESS";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL_ERROR";
        } finally {
            // 3. Always close connections to prevent memory leaks
            try { 
                if(resultSet != null) resultSet.close(); 
            } catch(Exception e){
            }
            try { 
                if(preparedStatement != null) preparedStatement.close(); 
            } catch(Exception e){}
            try { 
                if(con != null) con.close(); 
            } catch(Exception e){}
        return "Invalid user credentials";
    }
        
    }
    
}
