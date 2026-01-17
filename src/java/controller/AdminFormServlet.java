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
import bean.Event;
import dao.AdminFormDao;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author syazw
 */
@WebServlet("/AdminFormServlet")
public class AdminFormServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String eventIdString = request.getParameter("eventId");
            String title = request.getParameter("title");
            String dateString = request.getParameter("date");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String organizationIdString = request.getParameter("organizationId");
            

            if (title == null || title.trim().isEmpty() ||
                dateString == null || dateString.trim().isEmpty() ||
                location == null || location.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                organizationIdString == null || organizationIdString.trim().isEmpty()) {
                
                request.setAttribute("errMessage", "All fields are required!");
                request.getRequestDispatcher("/adminForm.jsp").forward(request, response);
                return;
            }
            
            java.time.LocalDateTime time = java.time.LocalDateTime.parse(dateString);
            int organizationId = Integer.parseInt(organizationIdString);
            
            Event eventBean = new Event();
            eventBean.setName(title);
            eventBean.setTime(time);
            eventBean.setLocation(location);
            eventBean.setDescription(description);
            
            if (eventIdString != null && !eventIdString.isEmpty()) {
                eventBean.setId(Integer.parseInt(eventIdString));
            }
            
            AdminFormDao adminFormDao = new AdminFormDao();
            String result;
            
 
            if (eventIdString == null || eventIdString.isEmpty()) {
                result = adminFormDao.addEvent(eventBean, organizationId);
            } else {
                result = adminFormDao.updateEvent(eventBean, organizationId);
            }
            
            // 6. Navigation based on result
            if ("SUCCESS".equals(result)) {
                response.sendRedirect("listForm.jsp?success=true");
            } else {
                request.setAttribute("errMessage", "Operation failed: " + result);
                request.getRequestDispatcher("/adminForm.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("errMessage", "Invalid number format: " + e.getMessage());
            request.getRequestDispatcher("/adminForm.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("/adminForm.jsp").forward(request, response);
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
    

