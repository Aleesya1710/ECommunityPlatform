/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;
import java.io.IOException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Bean.AdminFormBean;
import Dao.AdminFormDao;

/**
 *
 * @author syazw
 */
public class AdminFormServlet extends HttpServlet{
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        
        String name = request.getParameter("name");
        String timeString = request.getParameter("time");
        String description = request.getParameter("description");
        
        java.time.LocalDateTime time = java.time.LocalDateTime.parse(timeString);
        
        AdminFormBean adminFormBean = new AdminFormBean();
        
        adminFormBean.setName(name);
        adminFormBean.setTime(time);
        adminFormBean.setDescription(description);
        
        AdminFormDao adminFormDao = new AdminFormDao();
        
        String userValidate = adminFormDao.authenticateName(adminFormDao);
        
            if (userValidate.equals("SUCCESS")) {
       // 1. Create or get the session
       javax.servlet.http.HttpSession session = request.getSession(); 
    
       // 2. Store the username in the session so it persists across multiple pages
       request.setAttribute("Name", name); 
    
       // 3. Redirect to Home
       request.getRequestDispatcher("/home.jsp").forward(request, response);
    }else{
       request.setAttribute("errMessage", userValidate); 
       request.getRequestDispatcher("/crud.html").forward(request, response);
    }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    }
    

