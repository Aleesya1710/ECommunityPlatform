/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package userBean;

/**
 *
 * @author Hp V
 */
public class User {
    private String username;
    private String password;
    
    public User(){
        
    }
    
    public User(String name, String pass){
        username = name;
        password = pass;
    }
    
    public String getUsername(){return username;}
    public String getPassword(){return password;}
    public void setUsername(String name){username = name;}
    public void setPassword(String pass){password = pass;}
}
