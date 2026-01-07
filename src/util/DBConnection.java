package util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection createConnection()
    {
        Connection con = null;
        String url = "jdbc:mysql://localhost:3306/ecommunity";
        String username = "root";
        String password = "root123";

    try{
        try{
            Class.forName("");
        }
        catch (ClassNotFoundException e)
        {
            e.printStackTrace();
        }
        con = DriverManager.getConnection(url, username, password);
        System.out.println("Printing connection object"+con);
    }
    catch (Exception e){
        e.printStackTrace();
    }
    return con;
    }
}
        