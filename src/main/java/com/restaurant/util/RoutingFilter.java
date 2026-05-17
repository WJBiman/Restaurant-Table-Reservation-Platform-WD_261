package com.restaurant.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class RoutingFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // Redirect legacy path and load custom account dashboard
        if (uri.endsWith("/my_account.jsp")) {
            res.sendRedirect(req.getContextPath() + "/myAccount");
            return;
        }

        chain.doFilter(request, response);
    }
}
