package com.cinebook.demo;

import java.io.*;
import java.net.*;

/**
 * Standalone TCP Socket Client Demo
 * Connects to SocketServerDemo, executes queries, and prints responses.
 */
public class SocketClientDemo {
    private static final String HOST = "localhost";
    private static final int PORT = 8088;

    public static void main(String[] args) {
        System.out.println("[SocketClient] Connecting to CineBook Server at " + HOST + ":" + PORT + "...");

        try (Socket socket = new Socket(HOST, PORT);
             BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter out = new PrintWriter(socket.getOutputStream(), true)) {

            // Read welcome banner
            System.out.println("SERVER: " + in.readLine());

            // 1. Send LIST command
            sendCommand(out, in, "LIST");

            // 2. Check seat availability for Oppenheimer
            sendCommand(out, in, "CHECK Oppenheimer");

            // 3. Book 2 tickets for Oppenheimer
            sendCommand(out, in, "BOOK Oppenheimer 2");

            // 4. Verify updated seats
            sendCommand(out, in, "CHECK Oppenheimer");

            // 5. Exit
            sendCommand(out, in, "EXIT");

        } catch (ConnectException e) {
            System.err.println("[SocketClient] Connection refused. Please start SocketServerDemo first!");
        } catch (IOException e) {
            System.err.println("[SocketClient] Network error: " + e.getMessage());
        }
    }

    private static void sendCommand(PrintWriter out, BufferedReader in, String command) throws IOException {
        System.out.println("\nCLIENT >>> " + command);
        out.println(command);
        String response = in.readLine();
        System.out.println("SERVER <<< " + response);
    }
}
