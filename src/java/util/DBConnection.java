package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static String DB_URL = "jdbc:derby://localhost:1527/ecommunity";
    private static String DB_USER = "app";
    private static String DB_PASSWORD = "app";
    
    public static Connection createConnection() {
        Connection con = null;
        
        try {
          
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            System.out.println("Derby Driver loaded successfully");
            
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Connection established: " + con);
            
        } catch (ClassNotFoundException e) {
            System.err.println("Derby Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to connect to database!");
            System.err.println("URL: " + DB_URL);
            System.err.println("User: " + DB_USER);
            e.printStackTrace();
        }
        
        return con;
    }
    
    public static Connection getConnection() throws SQLException {
        return createConnection();
    }
}