package com.cinebook.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

@WebFilter(filterName = "LoggingFilter", urlPatterns = {"/*"})
public class LoggingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
        System.out.println("[LoggingFilter] Initialized request logging filter.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        long startTime = System.currentTimeMillis();

        chain.doFilter(request, response);

        long duration = System.currentTimeMillis() - startTime;
        String uri = req.getRequestURI();
        if (!uri.contains("/assets/")) {
            System.out.println(String.format("[CineBook Access Log] %s %s - %d ms",
                    req.getMethod(), uri, duration));
        }
    }

    @Override
    public void destroy() {
        System.out.println("[LoggingFilter] Destroyed.");
    }
}
