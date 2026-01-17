/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

/**
 *
 * @author Hp V
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import bean.Organization;
import util.DBConnection;

public class OrganizationDao {
    

    public List<Organization> getAllOrganizations() {
        List<Organization> organizations = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.createConnection();
            String query = "SELECT organizationid, organizationname, contactemail FROM organization ORDER BY organizationname";
            
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Organization org = new Organization();
                org.setOrganizationId(rs.getInt("organizationid"));
                org.setOrganizationName(rs.getString("organizationname"));
                org.setOrganizationEmail(rs.getString("contactemail"));
                organizations.add(org);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
        
        return organizations;
    }
    
    public Organization getOrganizationById(int orgId) {
        Organization org = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.createConnection();
            String query = "SELECT * FROM organization WHERE organizationid = ?";
            
            ps = con.prepareStatement(query);
            ps.setInt(1, orgId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                org = new Organization();
                org.setOrganizationId(rs.getInt("organizationid"));
                org.setOrganizationName(rs.getString("organizationname"));
                org.setOrganizationEmail(rs.getString("contactemail"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(Exception e) {}
            try { if(ps != null) ps.close(); } catch(Exception e) {}
            try { if(con != null) con.close(); } catch(Exception e) {}
        }
        
        return org;
    }
    public int getTotalOrganizations() {

    int total = 0;
    String sql = "SELECT COUNT(organizationid) AS total FROM organization";

    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        System.out.println("Connection: " + (con != null ? "SUCCESS" : "FAILED"));

        if (rs.next()) {
            total = rs.getInt("total"); 
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return total;
}
    public boolean addOrganization(Organization org) {
    String sql = "INSERT INTO organization (organizationname, contactemail) VALUES (?, ?)";
    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, org.getOrganizationName());
        ps.setString(2, org.getOrganizationEmail());
        int rows = ps.executeUpdate();

        return rows > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
    public boolean updateOrganization(Organization org) {
    String sql = "UPDATE organization SET organizationname = ?, contactemail = ? WHERE organizationid = ?";
    try (Connection con = DBConnection.createConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, org.getOrganizationName());
        ps.setString(2, org.getOrganizationEmail());
        ps.setInt(3, org.getOrganizationId());

        int rows = ps.executeUpdate();
        return rows > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}