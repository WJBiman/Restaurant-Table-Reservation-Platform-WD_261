package com.restaurant.servlet;

import com.restaurant.model.Table;
import com.restaurant.service.TableService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateTable")
public class UpdateTableServlet extends HttpServlet {
    private TableService tableService = new TableService();
}
