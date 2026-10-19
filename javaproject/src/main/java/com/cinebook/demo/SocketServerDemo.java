package com.cinebook.demo;

import java.io.*;
import java.net.*;
import java.util.concurrent.*;

/**
 * Standalone TCP Socket Server Demo
 * Simulates real-time seat queries and bookings over TCP sockets.
 */
public class SocketServerDemo {
    private static final int PORT = 8088;
    private static final ConcurrentHashMap<String, Integer> movieSeats = new ConcurrentHashMap<>();

    static {
        movieSeats.put("Oppenheimer", 40);
        movieSeats.put("Interstellar", 35);
        movieSeats.put("Inception", 25);
        movieSeats.put("Dark_Knight", 30);
    }

    public static void main(String[] args) {
        System.out.println("[SocketServer] CineBook Live Seat Server started on port " + PORT);
        ExecutorService pool = Executors.newCachedThreadPool();

        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("[SocketServer] Client connected: " + clientSocket.getRemoteSocketAddress());
                pool.execute(new ClientHandler(clientSocket));
            }
        } catch (IOException e) {
            System.err.println("[SocketServer] Server exception: " + e.getMessage());
        }
    }

    private static class ClientHandler implements Runnable {
        private final Socket socket;

        public ClientHandler(Socket socket) {
            this.socket = socket;
        }

        @Override
        public void run() {
            try (BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                 PrintWriter out = new PrintWriter(socket.getOutputStream(), true)) {

                out.println("200 WELCOME to CineBook Live Ticket Protocol. Commands: LIST, CHECK <movie>, BOOK <movie> <qty>, EXIT");

                String line;
                while ((line = in.readLine()) != null) {
                    line = line.trim();
                    if (line.equalsIgnoreCase("EXIT")) {
                        out.println("200 BYE");
                        break;
                    }

                    if (line.equalsIgnoreCase("LIST")) {
                        out.println("200 MOVIES: " + movieSeats.toString());
                    } else if (line.toUpperCase().startsWith("CHECK ")) {
                        String movie = line.substring(6).trim();
                        Integer seats = movieSeats.get(movie);
                        if (seats != null) {
                            out.println("200 OK " + movie + " has " + seats + " seats available.");
                        } else {
                            out.println("404 NOT_FOUND Movie not found in directory.");
                        }
                    } else if (line.toUpperCase().startsWith("BOOK ")) {
                        String[] parts = line.split("\\s+");
                        if (parts.length == 3) {
                            String movie = parts[1];
                            int qty = Integer.parseInt(parts[2]);
                            Integer current = movieSeats.get(movie);
                            if (current == null) {
                                out.println("404 NOT_FOUND Movie not found.");
                            } else if (current >= qty) {
                                movieSeats.put(movie, current - qty);
                                out.println("201 BOOKED Successfully booked " + qty + " seat(s) for " + movie + ". Remaining: " + (current - qty));
                            } else {
                                out.println("409 INSUFFICIENT Only " + current + " seats available.");
                            }
                        } else {
                            out.println("400 BAD_REQUEST Format: BOOK <movie> <qty>");
                        }
                    } else {
                        out.println("400 UNKNOWN_COMMAND Use LIST, CHECK <movie>, BOOK <movie> <qty>, EXIT");
                    }
                }
            } catch (IOException e) {
                System.out.println("[SocketServer] Connection dropped: " + e.getMessage());
            } finally {
                try {
                    socket.close();
                } catch (IOException ignored) {}
            }
        }
    }
}
