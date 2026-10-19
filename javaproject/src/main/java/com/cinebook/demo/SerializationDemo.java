package com.cinebook.demo;

import java.io.*;
import java.util.Arrays;
import java.util.List;

/**
 * Standalone Java Serialization Demo
 * Demonstrates object persistence, ObjectOutputStream, ObjectInputStream,
 * serialVersionUID, and transient keyword behavior.
 */
public class SerializationDemo {

    public static class Ticket implements Serializable {
        private static final long serialVersionUID = 2026101901L;

        private String bookingReference;
        private String movieTitle;
        private String theatreName;
        private List<String> seats;
        private double totalPaid;

        // The transient keyword prevents sensitive fields from being serialized to disk
        private transient String paymentCardCVV;

        public Ticket(String bookingReference, String movieTitle, String theatreName,
                      List<String> seats, double totalPaid, String paymentCardCVV) {
            this.bookingReference = bookingReference;
            this.movieTitle = movieTitle;
            this.theatreName = theatreName;
            this.seats = seats;
            this.totalPaid = totalPaid;
            this.paymentCardCVV = paymentCardCVV;
        }

        @Override
        public String toString() {
            return "Ticket {" +
                    "\n  bookingReference = '" + bookingReference + '\'' +
                    ",\n  movieTitle       = '" + movieTitle + '\'' +
                    ",\n  theatreName      = '" + theatreName + '\'' +
                    ",\n  seats            = " + seats +
                    ",\n  totalPaid        = INR " + totalPaid +
                    ",\n  paymentCardCVV   = '" + paymentCardCVV + "' (transient: excluded from disk)" +
                    "\n}";
        }
    }

    public static void main(String[] args) {
        String filename = "ticket_saved.ser";

        System.out.println("==================================================");
        System.out.println("     JAVA OBJECT SERIALIZATION DEMO (CINEBOOK)    ");
        System.out.println("==================================================");

        // 1. Create original ticket object
        Ticket originalTicket = new Ticket(
                "CBK-SERIAL-9921",
                "Oppenheimer (IMAX 70mm)",
                "PVR Grand Cineplex",
                Arrays.asList("A1", "A2", "A3"),
                750.00,
                "982" // Sensitive CVV
        );

        System.out.println("\n[1] Original Ticket in memory before serialization:");
        System.out.println(originalTicket);

        // 2. Serialize object to file
        System.out.println("\n[2] Serializing Ticket object to file: " + filename + "...");
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(filename))) {
            oos.writeObject(originalTicket);
            System.out.println(">>> Ticket successfully serialized to disk!");
        } catch (IOException e) {
            System.err.println("Serialization failed: " + e.getMessage());
            return;
        }

        // 3. Deserialize object from file
        System.out.println("\n[3] Deserializing Ticket object from file: " + filename + "...");
        try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(filename))) {
            Ticket restoredTicket = (Ticket) ois.readObject();
            System.out.println(">>> Ticket successfully deserialized from disk!");
            System.out.println("\n[4] Restored Ticket contents:");
            System.out.println(restoredTicket);

            System.out.println("\nNotice: paymentCardCVV restored as null because it was marked transient!");
        } catch (IOException | ClassNotFoundException e) {
            System.err.println("Deserialization failed: " + e.getMessage());
        } finally {
            // Clean up temporary demo file
            new File(filename).delete();
        }

        System.out.println("\nSerialization Demo Completed Successfully.");
    }
}
