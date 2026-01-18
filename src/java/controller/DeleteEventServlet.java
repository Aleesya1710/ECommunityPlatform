package controller;

import dao.AdminFormDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        int eventId = Integer.parseInt(idParam);

        AdminFormDao dao = new AdminFormDao();
        String result = dao.deleteEvent(eventId);

        if ("SUCCESS".equals(result)) {
            response.sendRedirect("listForm.jsp?deleted=true");
        } else if ("NO_RECORD_FOUND".equals(result)) {
            response.sendRedirect("listForm.jsp?error=No record found");
        } else {
            response.sendRedirect("listForm.jsp?error=" + result);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If you want POST to behave the same as GET:
        doGet(request, response);
    }
}
