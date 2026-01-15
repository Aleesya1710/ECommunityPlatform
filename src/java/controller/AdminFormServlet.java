/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;
import java.io.IOException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.AdminFormBean;
import dao.AdminFormDao;

/**
 *
 * @author syazw
 */
public class AdminFormServlet extends HttpServlet{
    
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    // 1. Get Parameters
    String idString = request.getParameter("id"); // Needed for Edit
    String name = request.getParameter("name");
    String timeString = request.getParameter("time");
    String description = request.getParameter("description");

    // 2. Handle Date/Time (Adding a default time if only date is provided)
    // If the input is just "2026-01-11", LocalDateTime needs "T00:00:00"
    java.time.LocalDateTime time = java.time.LocalDateTime.parse(timeString + "T00:00:00");

    // 3. Populate the Bean
    AdminFormBean adminFormBean = new AdminFormBean();
    adminFormBean.setName(name);
    adminFormBean.setTime(time);
    adminFormBean.setDescription(description);
    
    if(idString != null && !idString.isEmpty()) {
        adminFormBean.setId(Integer.parseInt(idString));
    }

    // 4. Call DAO (Pass the BEAN, not the DAO)
    AdminFormDao adminFormDao = new AdminFormDao();
    String result;
    
    // Logic to differentiate: If ID exists, it's an UPDATE. Otherwise, it's an INSERT.
    if (idString == null || idString.isEmpty()) {
        result = adminFormDao.addProgram(adminFormBean); 
    } else {
        result = adminFormDao.updateProgram(adminFormBean);
    }

    // 5. Navigation
    if ("SUCCESS".equals(result)) {
        request.setAttribute("Name", name); 
        request.getRequestDispatcher("/listForm.jsp").forward(request, response);
    } else {
        request.setAttribute("errMessage", "Database operation failed: " + result); 
        request.getRequestDispatcher("/adminForm.html").forward(request, response);
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
    

