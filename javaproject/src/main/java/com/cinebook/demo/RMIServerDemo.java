package com.cinebook.demo;

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.*;

/**
 * Standalone RMI Server Demo
 * Hosts MovieBookingRemote implementation over Java RMI
 */
public class RMIServerDemo extends UnicastRemoteObject implements MovieBookingRemote {
    private static final long serialVersionUID = 1L;

    public RMIServerDemo() throws RemoteException {
        super();
    }

    @Override
    public List<String> getAvailableMovies() throws RemoteException {
        System.out.println("[RMIServer] Client requested available movies list.");
        return Arrays.asList(
                "Oppenheimer - IMAX 70mm (INR 350.00)",
                "Interstellar - Sci-Fi Experience (INR 300.00)",
                "Inception - Mind-Bending Thriller (INR 250.00)",
                "The Dark Knight - Ultimate Action (INR 280.00)"
        );
    }

    @Override
    public double calculateCost(String movieTitle, int ticketCount) throws RemoteException {
        System.out.println("[RMIServer] Calculating cost for: " + movieTitle + " (" + ticketCount + " tickets)");
        double basePrice = 250.0;
        if (movieTitle != null && movieTitle.toLowerCase().contains("oppenheimer")) {
            basePrice = 350.0;
        } else if (movieTitle != null && movieTitle.toLowerCase().contains("interstellar")) {
            basePrice = 300.0;
        }
        return basePrice * ticketCount;
    }

    @Override
    public String bookTicket(String customerName, String movieTitle, int ticketCount) throws RemoteException {
        String bookingId = "RMI-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        double total = calculateCost(movieTitle, ticketCount);
        System.out.println("[RMIServer] Created booking " + bookingId + " for " + customerName);
        return String.format("SUCCESS: Booking ID [%s] created for %s (%d tickets for %s, Total: INR %.2f)",
                bookingId, customerName, ticketCount, movieTitle, total);
    }

    public static void main(String[] args) {
        try {
            int port = 1099;
            Registry registry;
            try {
                registry = LocateRegistry.createRegistry(port);
                System.out.println("[RMIServer] Created RMI Registry on port " + port);
            } catch (Exception e) {
                registry = LocateRegistry.getRegistry(port);
                System.out.println("[RMIServer] Using existing RMI Registry on port " + port);
            }

            RMIServerDemo server = new RMIServerDemo();
            registry.rebind("MovieBookingService", server);
            System.out.println("[RMIServer] MovieBookingService successfully bound to RMI Registry.");
            System.out.println("[RMIServer] Server is ready to receive remote client invocations.");

        } catch (Exception e) {
            System.err.println("[RMIServer] Failure during RMI Server startup: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
