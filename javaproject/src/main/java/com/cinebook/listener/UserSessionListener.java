package com.cinebook.listener;

import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.concurrent.atomic.AtomicInteger;

@WebListener
public class UserSessionListener implements HttpSessionListener {
    private static final AtomicInteger activeSessions = new AtomicInteger(0);

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        int current = activeSessions.incrementAndGet();
        System.out.println("[SessionListener] New session created: " + se.getSession().getId() + " | Active sessions: " + current);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        int current = activeSessions.decrementAndGet();
        System.out.println("[SessionListener] Session expired: " + se.getSession().getId() + " | Active sessions: " + current);
    }

    public static int getActiveSessionsCount() {
        return activeSessions.get();
    }
}
