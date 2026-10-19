package com.cinebook.listener;

import com.cinebook.util.DBUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("==================================================");
        System.out.println("  CineBook System Initializing (Tomcat 11)");
        System.out.println("==================================================");

        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("[CineBook] Database connected successfully to cinebook_db.");
            }
        } catch (Exception e) {
            System.err.println("[CineBook] Warning: Could not connect to database on startup. Please ensure MySQL is running.");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("==================================================");
        System.out.println("  CineBook System Shutdown Cleanly");
        System.out.println("==================================================");
    }
}
