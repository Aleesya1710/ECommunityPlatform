package dao;

//import java.awt.Event;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import util.DBConnection;
import bean.Event;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ApplicationDao {

    public boolean insertRegistration(String name, String phoneNum,
                                      String ICnum, Integer userID, int eventID) {

        boolean result = false;

        String sql = "INSERT INTO registration " +
                     "(name, phoneNum, ICnum, userID, eventID) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, phoneNum);
            ps.setString(3, ICnum);

            if (userID != null) {
                ps.setInt(4, userID);
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }

            ps.setInt(5, eventID);

            result = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public List<Event> getAllEvent(){
        List<Event> eventList = new ArrayList<>();     
        String sql = "Select * from event";
        
        try (Connection con = DBConnection.createConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
           System.out.println("Connection: " + (con != null ? "SUCCESS" : "FAILED"));
             ResultSet rs = ps.executeQuery();
             while(rs.next()){
                 Event event = new Event();
                 int id = rs.getInt("EventID");
                 String name = rs.getString("name");
                 LocalDateTime time = rs.getTimestamp("time").toLocalDateTime();
                 String location = rs.getString("location");
                 String description = rs.getString("description");
                 event.setId(id);
                 event.setName(name);
                 event.setTime(time);
                 event.setLocation(location);
                 event.setDescription(description);
                 
                 eventList.add(event);
             }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return eventList; 
    }
   public int getTotalEvent() {

    int total = 0;
    String sql = "SELECT COUNT(eventid) AS total FROM event";

    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        System.out.println("Connection: " + (con != null ? "SUCCESS" : "FAILED"));

        if (rs.next()) {
            total = rs.getInt("total"); // or rs.getInt(1)
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return total;
}
      public Map<String, Integer> getVolunteerCountPerEvent() {
        Map<String, Integer> eventStats = new HashMap<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.createConnection();
            
            // Query to count volunteers per event
            String query = "SELECT e.name AS eventName, COUNT(r.registrationid) AS volunteerCount " +
                          "FROM event e " +
                          "LEFT JOIN registration r ON e.eventid = r.eventid " +
                          "GROUP BY e.eventid, e.name " +
                          "ORDER BY volunteerCount DESC";
            
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                String eventName = rs.getString("eventName");
                int volunteerCount = rs.getInt("volunteerCount");
                eventStats.put(eventName, volunteerCount);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
        
        return eventStats;
    }
    
    /**
     * Get detailed event statistics
     * Returns array of objects for easier JSON conversion
     */
    public String getEventStatisticsJSON() {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        StringBuilder json = new StringBuilder("[");
        
        try {
            con = DBConnection.createConnection();
            
            String query = "SELECT e.name AS eventName, COUNT(r.registrationid) AS volunteerCount " +
                          "FROM event e " +
                          "LEFT JOIN registration r ON e.eventid = r.eventid " +
                          "GROUP BY e.eventid, e.name " +
                          "ORDER BY e.name";
            
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            
            boolean first = true;
            while (rs.next()) {
                if (!first) json.append(",");
                
                json.append("{");
                json.append("\"eventName\":\"").append(rs.getString("eventName").replace("\"", "\\\"")).append("\",");
                json.append("\"volunteerCount\":").append(rs.getInt("volunteerCount"));
                json.append("}");
                
                first = false;
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return "[]"; // Return empty array on error
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
        
        json.append("]");
        return json.toString();
    }

}
