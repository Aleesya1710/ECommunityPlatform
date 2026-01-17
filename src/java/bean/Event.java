/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Hp V
 */
public class Event {
    private int eventID;
    private String name;
    private String location;
    private LocalDateTime time;
    private String description;
    private int organizationId;
    
    public Event(){
        
    }
    
    public Event(String n, String loc, LocalDateTime t, String desc){
        name = n;
        location = loc;
        time = t;
        description = desc;
    }
    
    public int getId(){return eventID;}
    public String getName(){return name;}
    public String getLocation(){return location;}
    public LocalDateTime getTime(){return time;}
    public String getDescription(){return description;}
    public int getOrganizationId() {return organizationId;}
    public void setId(int id){eventID = id;}
    public void setName(String n){name = n;}
    public void setLocation(String loc){location = loc;}
    public void setTime(LocalDateTime t){time = t;}
    public void setDescription(String desc){description = desc;}
    public void setOrganizationId(int organizationId) {this.organizationId = organizationId;}
    public String getFormattedDate() { return time.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));}
    public String getFormattedTime12() {return time.format(DateTimeFormatter.ofPattern("h:mm a"));}
     public String getTimeFormattedForInput() {return time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm")); }

}
