/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.DBConnection;
import bean.LoginBean;
/**
 *
 * @author syazw
 */
public class LoginDao {
    public String authenticateUser(LoginBean loginBean){
        String userName = loginBean.getUsername();
        String password = loginBean.getPassword();
        
    if (userName.equals("staff") && password.equals("123")) {
        return "SUCCESS"; 
    } else if (userName.equals("user") && password.equals("123")) {
        return "USER_SUCCESS"; // Or whatever you'd like to return
    }        
    
        Connection conn = null;
        Statement statement = null;
        ResultSet resultSet = null;
        
        String userNameDB = "";
        String passwordDB = "";
        
        try{
            Connection con = DBConnection.createConnection();
            if (con == null){
                return "ERROR";
            }
            statement = con.createStatement();
            resultSet = statement.executeQuery ("Select username, password from customers");
            while (resultSet.next()){
                userNameDB = resultSet.getString("username");
                passwordDB = resultSet.getString("password");
                if (userName.equals(userNameDB) && password.equals(passwordDB)){
                    return "SUCCESS";
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return "Invalid user credentials";
    }
}
