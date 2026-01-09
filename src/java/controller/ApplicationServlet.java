package controller;

import dao.ApplicationDao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ApplyProgramServlet")
public class ApplicationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String phoneNum = request.getParameter("phoneNum");
        String ICnum = request.getParameter("ICnum");
        int eventID = Integer.parseInt(request.getParameter("eventID"));

        HttpSession session = request.getSession(false);
        Integer userID = null;

        if (session != null && session.getAttribute("userID") != null) {
            userID = (Integer) session.getAttribute("userID");
        }

        //DAO
        ApplicationDao dao = new ApplicationDao();
        boolean success = dao.insertRegistration(
                name, phoneNum, ICnum, userID, eventID
        );

        if (success) {
            response.sendRedirect("application.jsp?status=success");
        } else {
            response.sendRedirect("application.jsp?status=error");
        }
    }
}
