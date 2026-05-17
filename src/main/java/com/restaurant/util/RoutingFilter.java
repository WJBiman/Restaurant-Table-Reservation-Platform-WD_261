package com.restaurant.util;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class RoutingFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();

        // Catch any attempts to access the old legacy path and redirect to the new servlet
        if (uri.endsWith("/my_account.jsp")) {
            res.sendRedirect(req.getContextPath() + "/myAccount");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
