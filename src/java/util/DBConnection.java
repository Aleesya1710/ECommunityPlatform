/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;
import java.sql.*;

/**
 *
 * @author Hp V
 */
public class DBConnection {
    public static Connection createConnection() throws SQLException{
        Connection conn = null;
      
        try{
        try{
            Class.forName("com.mysql.jdbc.Driver");
        }catch(ClassNotFoundException e){
            e.printStackTrace();
        }
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/ecommunity", "app", "app");
        System.out.println("Printing connection object" +conn);
    }catch(Exception e){
        e.printStackTrace();
    }
        return conn;
    }
}

