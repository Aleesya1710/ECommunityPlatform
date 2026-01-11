/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import util.DBConnection;
import bean.AdminFormBean;
/**
 *
 * @author syazw
 */
public class AdminFormDao {
    // ADD THIS METHOD TO YOUR DAO CLASS
public String addProgram(AdminFormBean bean) {
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = DBConnection.createConnection();
        
        // Use INSERT for creating new records
        String query = "INSERT INTO programs (name, time, description) VALUES (?, ?, ?)";
        
        ps = con.prepareStatement(query);
        ps.setString(1, bean.getName());
        ps.setTimestamp(2, java.sql.Timestamp.valueOf(bean.getTime()));
        ps.setString(3, bean.getDescription());

        int rowsAffected = ps.executeUpdate();
        
        if (rowsAffected > 0) {
            return "SUCCESS";
        }
        return "FAIL";

    } catch (SQLException e) {
        e.printStackTrace();
        return "SQL_ERROR";
    } finally {
        try { if(ps != null) ps.close(); } catch(Exception e) {}
        try { if(con != null) con.close(); } catch(Exception e) {}
    }
}

// This method handles the SAVING of the Edit form
    public String updateProgram(AdminFormBean bean) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.createConnection();
            
            // We use the ID to differentiate WHICH program to update
            String query = "UPDATE programs SET name = ?, time = ?, description = ? WHERE id = ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, bean.getName());
            
            // Converting LocalDateTime to SQL Timestamp
            ps.setTimestamp(2, java.sql.Timestamp.valueOf(bean.getTime()));
            ps.setString(3, bean.getDescription());
            ps.setInt(4, bean.getId()); // You need an getId() in your bean!

            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                return "SUCCESS";
            }
            return "NO_RECORD_FOUND";

        } catch (SQLException e) {
            e.printStackTrace();
            return "SQL_ERROR";
        } finally {
            // Close resources
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
    }
}
