package com.cinebook.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {
    private static String url = "jdbc:mysql://localhost:3306/cinebook_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static String user = "root";
    private static String password = "password"; // default fallback
    private static String driver = "com.mysql.cj.jdbc.Driver";

    static {
        try (InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                Properties props = new Properties();
                props.load(in);
                driver = props.getProperty("db.driver", driver);
                url = props.getProperty("db.url", url);
                user = props.getProperty("db.user", user);
                password = props.getProperty("db.password", password);
            }
            Class.forName(driver);
        } catch (Exception e) {
            System.err.println("[DBUtil] Warning: could not load db.properties, using defaults: " + e.getMessage());
            try {
                Class.forName(driver);
            } catch (ClassNotFoundException ex) {
                throw new RuntimeException("MySQL JDBC Driver not found", ex);
            }
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    public static void close(AutoCloseable... closeables) {
        for (AutoCloseable c : closeables) {
            if (c != null) {
                try {
                    c.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}
