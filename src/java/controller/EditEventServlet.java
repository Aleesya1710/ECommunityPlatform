package controller;

import bean.Event;
import bean.Organization;
import dao.AdminFormDao;
import dao.OrganizationDao;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "EditEventServlet", urlPatterns = {"/EditEventServlet"})
public class EditEventServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdminFormDao dao = new AdminFormDao();
        OrganizationDao orgDao = new OrganizationDao();     

        try {
            if ("GET".equalsIgnoreCase(request.getMethod())) {
                int eventId = Integer.parseInt(request.getParameter("id"));
                Event event = dao.getEventById(eventId);
                List<Organization> organizations = orgDao.getAllOrganizations();
                request.setAttribute("event", event);
                request.setAttribute("organizations", organizations);
                request.getRequestDispatcher("editEvent.jsp") 
                       .forward(request, response);
            } else if ("POST".equalsIgnoreCase(request.getMethod())) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String location = request.getParameter("location");
                int organizationId = Integer.parseInt(request.getParameter("organizationId"));

                String timeStr = request.getParameter("time"); 
                timeStr = timeStr.replace("T", " ") + ":00"; 
                Timestamp time = Timestamp.valueOf(timeStr);
                Event event = new Event();
                event.setId(id);
                event.setName(name);
                event.setDescription(description);
                event.setLocation(location);
                event.setTime(time.toLocalDateTime());
                event.setOrganizationId(organizationId);

                String result = dao.updateEvent(event, organizationId);

                if ("SUCCESS".equals(result)) {
                    response.sendRedirect("listForm.jsp?updated=true");
                } else {
                    response.sendRedirect("editEvent.jsp?id=" + id + "&error=" + result);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editEvent.jsp?error=EditFailed");
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
