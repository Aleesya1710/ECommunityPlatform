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
public class Event {
    private int eventID;
    private String name;
    private String location;
    private String time;
    private String description;
    
    public Event(){
        
    }
    
    public Event(String n, String loc, String t, String desc){
        name = n;
        location = loc;
        time = t;
        description = desc;
    }
    
    public int getId(){return eventID;}
    public String getName(){return name;}
    public String getLocation(){return location;}
    public String getTime(){return time;}
    public String getDescription(){return description;}
    public void setId(int id){eventID = id;}
    public void setName(String n){name = n;}
    public void setLocation(String loc){location = loc;}
    public void setTime(String t){time = t;}
    public void setDescription(String desc){description = desc;}
}
