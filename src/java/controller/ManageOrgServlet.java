/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.Organization;
import dao.OrganizationDao;
import java.util.List;
import javax.servlet.annotation.WebServlet;
/**
 *
 * @author Hp V
 */
@WebServlet("/manageOrganizations")
public class ManageOrgServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        OrganizationDao orgDao = new OrganizationDao();

        // Check if this is an add or edit request
        String action = request.getParameter("action");

        if("add".equalsIgnoreCase(action)) {
            // --- ADD ---
            String name = request.getParameter("organizationName");
            String email = request.getParameter("organizationEmail");

            if(name != null && email != null) {
                Organization org = new Organization();
                org.setOrganizationName(name);
                org.setOrganizationEmail(email);

                boolean added = orgDao.addOrganization(org);
                request.setAttribute("message", added ? "Organization added successfully" : "Failed to add organization");
            }

        } else if("edit".equalsIgnoreCase(action)) {
            // --- EDIT ---
            String idStr = request.getParameter("organizationId");
            String name = request.getParameter("organizationName");
            String email = request.getParameter("organizationEmail");

            if(idStr != null && name != null && email != null) {
                int id = Integer.parseInt(idStr);
                Organization org = new Organization();
                org.setOrganizationId(id);
                org.setOrganizationName(name);
                org.setOrganizationEmail(email);

                boolean updated = orgDao.updateOrganization(org);
                request.setAttribute("message", updated ? "Organization updated successfully" : "Failed to update organization");
            }
        }

        // Fetch all organizations to display
        List<Organization> organizationList = orgDao.getAllOrganizations();
        request.setAttribute("organizations", organizationList);

        // Forward to JSP
        request.getRequestDispatcher("manageOrganizations.jsp").forward(request, response);
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
