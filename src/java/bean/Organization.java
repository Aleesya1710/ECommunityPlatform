/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author Hp V
 */

public class Organization {
    private int organizationId;
    private String organizationName;
    private String contactemail;
    
    public Organization() {}
    
    public Organization(int id, String name, String email) {
        this.organizationId = id;
        this.organizationName = name;
        this.contactemail = email;
    }
    
    public int getOrganizationId() {
        return organizationId;
    }
    
    public void setOrganizationId(int organizationId) {
        this.organizationId = organizationId;
    }
    
    public String getOrganizationName() {
        return organizationName;
    }
    
    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }
    
    public String getOrganizationEmail() {
        return contactemail;
    }
    
    public void setOrganizationEmail(String contactemail) {
        this.contactemail = contactemail;
    }
}