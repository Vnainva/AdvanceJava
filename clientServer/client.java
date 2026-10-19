import java.io.*;
import java.net.*;

public class client {

    public static void main(String[] args) {

        try {
            // Connect to server at localhost, port 5000
            Socket socket = new Socket("localhost", 5000);

            System.out.println("Connected to server.");

            // Input stream: receive message from server
            BufferedReader input = new BufferedReader(
                    new InputStreamReader(socket.getInputStream())
            );

            // Output stream: send message to server
            PrintWriter output = new PrintWriter(
                    socket.getOutputStream(), true
            );

            // Send message to server
            output.println("Hello Server");

            // Receive response from server
            String response = input.readLine();

            System.out.println("Server says: " + response);

            // Close connection
            socket.close();

            System.out.println("Connection closed.");

        } catch (IOException e) {
            System.out.println(e);
        }
    }
}

