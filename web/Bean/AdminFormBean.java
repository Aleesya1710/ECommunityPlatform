/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Bean;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 *
 * @author syazw
 */
public class AdminFormBean implements Serializable{
    private String name;
    private LocalDateTime time;
    private String description;
    
    public AdminFormBean(){
        
    }
    
    public AdminFormBean(String name, LocalDateTime time, String description){
        this.name = name;
        this.time = time;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
