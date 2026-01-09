/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.*;
import util.DBConnection;
import bean.User;

/**
 *
 * @author Hp V
 */
public class registerDao {
    Connection conn = DBConnection.createConnection();
    boolean result = false;
    PreparedStatement ps = null;
    public boolean registerUser(User user) throws SQLException{
        String name = user.getUsername();
        String password = user.getPassword();
        
        String query = "Insert into users(username, password) values (?,?)";
        
        try{
             ps = conn.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, password);
            result = ps.executeUpdate() > 0;
        }catch (Exception e) {
            e.printStackTrace();
        }
        
        return result;
    }
    
    public boolean isUsernameExists(String username) throws SQLException{
        String name = username;
        
        String query = "select username from users where username = ?";
        ps = conn.prepareStatement(query);
        ps.setString(1,name);
        ResultSet rs = ps.executeQuery();     
        return rs.next();
    }
}
