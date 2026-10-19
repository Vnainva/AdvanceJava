package com.cinebook.demo;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.List;

/**
 * Standalone RMI Client Demo
 * Connects to RMIServerDemo via RMI Registry and calls remote methods.
 */
public class RMIClientDemo {
    public static void main(String[] args) {
        System.out.println("[RMIClient] Connecting to RMI Registry on localhost:1099...");

        try {
            Registry registry = LocateRegistry.getRegistry("localhost", 1099);
            MovieBookingRemote service = (MovieBookingRemote) registry.lookup("MovieBookingService");

            System.out.println("[RMIClient] Remote reference acquired successfully!");

            // 1. Remote call: getAvailableMovies
            System.out.println("\n--- Step 1: Querying Remote Movie Catalog ---");
            List<String> movies = service.getAvailableMovies();
            for (String m : movies) {
                System.out.println("  * " + m);
            }

            // 2. Remote call: calculateCost
            System.out.println("\n--- Step 2: Inquiring Ticket Price Remotely ---");
            String chosenMovie = "Oppenheimer - IMAX 70mm";
            int seats = 3;
            double estimatedCost = service.calculateCost(chosenMovie, seats);
            System.out.printf("  Calculated Cost for %d seats of %s = INR %.2f%n", seats, chosenMovie, estimatedCost);

            // 3. Remote call: bookTicket
            System.out.println("\n--- Step 3: Executing Remote Booking Transaction ---");
            String confirmation = service.bookTicket("Alice Johnson", chosenMovie, seats);
            System.out.println("  " + confirmation);

            System.out.println("\n[RMIClient] RMI Demo finished successfully!");

        } catch (Exception e) {
            System.err.println("[RMIClient] RMI invocation error: " + e.getMessage());
            System.err.println("[RMIClient] Make sure RMIServerDemo is running before launching RMIClientDemo.");
        }
    }
}
