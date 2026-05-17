package com.restaurant.servlet;

import com.restaurant.dao.TableDAO;
import com.restaurant.model.Table;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/adminTablePost")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
    maxFileSize = 1024 * 1024 * 5,      // 5 MB
    maxRequestSize = 1024 * 1024 * 10   // 10 MB
)
public class AdminTablePostServlet extends HttpServlet {
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String tableId = request.getParameter("tableId");
        String capacityStr = request.getParameter("capacity");
        String location = request.getParameter("location");
        String availabilityStatus = request.getParameter("availabilityStatus");
        String action = request.getParameter("action"); // "add" or "edit"
        
        // Handle availability checkbox/toggle
        if (availabilityStatus == null) {
            availabilityStatus = "Occupied";
        } else {
            availabilityStatus = "Available";
        }

        int capacity = 0;
        try {
            capacity = Integer.parseInt(capacityStr);
        } catch (NumberFormatException e) {
            capacity = 4;
        }

        Table table = new Table(tableId, capacity, availabilityStatus, location);

        if ("edit".equals(action)) {
            tableDAO.updateTable(table);
        } else {
            // Check if exists
            if (tableDAO.getTableById(tableId) == null) {
                tableDAO.addTable(table);
            } else {
                tableDAO.updateTable(table);
            }
        }

        // Handle Image Upload
        Part filePart = request.getPart("tableImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = "table_" + tableId.toLowerCase() + ".png";
            
            // 1. Save to the live Tomcat webapps folder so it shows immediately
            String tomcatPath = request.getServletContext().getRealPath("") + File.separator + "images";
            File tomcatDir = new File(tomcatPath);
            if (!tomcatDir.exists()) tomcatDir.mkdir();
            
            // 2. Save to the project src folder so it persists after maven rebuilds
            String projectPath = request.getServletContext().getRealPath("/").split("target")[0] + "src" + File.separator + "main" + File.separator + "webapp" + File.separator + "images";
            File projectDir = new File(projectPath);
            if (!projectDir.exists()) projectDir.mkdirs();
            
            try (InputStream input = filePart.getInputStream()) {
                File tomcatFile = new File(tomcatDir, fileName);
                Files.copy(input, tomcatFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                
                // Copy the saved file to the project src folder as well
                File projectFile = new File(projectDir, fileName);
                Files.copy(tomcatFile.toPath(), projectFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("adminTables");
    }
}
