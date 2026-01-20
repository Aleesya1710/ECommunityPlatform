/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.Event;
import util.DBConnection;
/**
 *
 * @author syazw
 */
public class AdminFormDao {
    public String addEvent(Event bean, int organizationId) {
        Connection con = null;
        PreparedStatement psEvent = null;
        PreparedStatement psEventOrg = null;
        ResultSet generatedKeys = null;
        
        try {
            con = DBConnection.createConnection();
            con.setAutoCommit(false);
            String eventQuery = "INSERT INTO event (name, time, location, description) VALUES (?, ?, ?, ?)";
            psEvent = con.prepareStatement(eventQuery, Statement.RETURN_GENERATED_KEYS);
            psEvent.setString(1, bean.getName());
            psEvent.setTimestamp(2, java.sql.Timestamp.valueOf(bean.getTime()));
            psEvent.setString(3, bean.getLocation());
            psEvent.setString(4, bean.getDescription());
            
            int rowsAffected = psEvent.executeUpdate();
            
            if (rowsAffected == 0) {
                con.rollback();
                return "FAIL: Event not inserted";
            }
            generatedKeys = psEvent.getGeneratedKeys();
            int eventId = 0;
            if (generatedKeys.next()) {
                eventId = generatedKeys.getInt(1);
            } else {
                con.rollback();
                return "FAIL: No event ID generated";
            }
            String eventOrgQuery = "INSERT INTO eventorg (eventid, organizationid) VALUES (?, ?)";
            psEventOrg = con.prepareStatement(eventOrgQuery);
            psEventOrg.setInt(1, eventId);
            psEventOrg.setInt(2, organizationId);
            
            int bridgeRowsAffected = psEventOrg.executeUpdate();
            
            if (bridgeRowsAffected == 0) {
                con.rollback();
                return "FAIL: Bridge table insert failed";
            }
            con.commit();
            return "SUCCESS";
            
        } catch (SQLException e) {
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return "SQL_ERROR: " + e.getMessage();
        } finally {
            try { if(generatedKeys != null) generatedKeys.close(); } catch(Exception e) {}
            try { if(psEventOrg != null) psEventOrg.close(); } catch(Exception e) {}
            try { if(psEvent != null) psEvent.close(); } catch(Exception e) {}
            try { 
                if(con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch(Exception e) {}
        }
    }

    public String updateEvent(Event bean, int organizationId) {
        Connection con = null;
        PreparedStatement psEvent = null;
        PreparedStatement psEventOrg = null;
        
        try {
            con = DBConnection.createConnection();
            con.setAutoCommit(false);

            String eventQuery = "UPDATE event SET name = ?, time = ?, location = ?, description = ? WHERE eventid = ?";
            psEvent = con.prepareStatement(eventQuery);
            psEvent.setString(1, bean.getName());
            psEvent.setTimestamp(2, java.sql.Timestamp.valueOf(bean.getTime()));
            psEvent.setString(3, bean.getLocation());
            psEvent.setString(4, bean.getDescription());
            psEvent.setInt(5, bean.getId());
            
            int rowsAffected = psEvent.executeUpdate();
            
            if (rowsAffected == 0) {
                con.rollback();
                return "NO_RECORD_FOUND";
            }
            
            String deleteEventOrgQuery = "DELETE FROM eventorg WHERE eventid = ?";
            psEventOrg = con.prepareStatement(deleteEventOrgQuery);
            psEventOrg.setInt(1, bean.getId());
            psEventOrg.executeUpdate();
            psEventOrg.close();

            String insertEventOrgQuery = "INSERT INTO eventorg (eventid, organizationid) VALUES (?, ?)";
            psEventOrg = con.prepareStatement(insertEventOrgQuery);
            psEventOrg.setInt(1, bean.getId());
            psEventOrg.setInt(2, organizationId);
            psEventOrg.executeUpdate();

            con.commit();
            return "SUCCESS";
            
        } catch (SQLException e) {
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return "SQL_ERROR: " + e.getMessage();
        } finally {
            try { if(psEventOrg != null) psEventOrg.close(); } catch(Exception e) {}
            try { if(psEvent != null) psEvent.close(); } catch(Exception e) {}
            try { 
                if(con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch(Exception e) {}
        }
    }
    public Event getEventById(int eventId) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Event event = null;
        
        try {
            con = DBConnection.createConnection();          
            String query = "SELECT e.eventid, e.name, e.time, e.location, e.description, eo.organizationid " +
                          "FROM event e " +
                          "LEFT JOIN eventorg eo ON e.eventid = eo.eventid " +
                          "WHERE e.eventid = ?";
            
            ps = con.prepareStatement(query);
            ps.setInt(1, eventId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                event = new Event();
                event.setId(rs.getInt("eventid"));
                event.setName(rs.getString("name"));
                event.setTime(rs.getTimestamp("time").toLocalDateTime());
                event.setLocation(rs.getString("location"));
                event.setDescription(rs.getString("description"));
                event.setOrganizationId(rs.getInt("organizationid"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
        
        return event;
    }
    public String deleteEvent(int eventId) {
        Connection con = null;
        PreparedStatement psEventOrg = null;
        PreparedStatement psEvent = null;
        System.out.print("Debug");
        try {
            con = DBConnection.createConnection();
            con.setAutoCommit(false);       
            String deleteEventOrgQuery = "DELETE FROM eventorg WHERE eventid = ?";
            psEventOrg = con.prepareStatement(deleteEventOrgQuery);
            psEventOrg.setInt(1, eventId);
            psEventOrg.executeUpdate();           
            String deleteEventQuery = "DELETE FROM event WHERE eventid = ?";
            psEvent = con.prepareStatement(deleteEventQuery);
            psEvent.setInt(1, eventId);
            int rowsAffected = psEvent.executeUpdate();
            
            if (rowsAffected > 0) {
                con.commit();
                return "SUCCESS";
            } else {
                con.rollback();
                return "NO_RECORD_FOUND";
            }
            
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return "SQL_ERROR: " + e.getMessage();
        } finally {
            try { if(psEvent != null) psEvent.close(); } catch(Exception e) {}
            try { if(psEventOrg != null) psEventOrg.close(); } catch(Exception e) {}
            try { 
                if(con != null) {
                    con.setAutoCommit(true);
                    con.close();
                }
            } catch(Exception e) {}
        }
    }
}
