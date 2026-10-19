package com.cinebook.demo;

import javax.swing.*;
import java.awt.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Standalone Swing GUI Demo: Quick Ticket Booking Counter
 * Run this directly via `java com.cinebook.demo.SwingDemo`
 */
public class SwingDemo extends JFrame {
    private final JComboBox<String> movieCombo;
    private final JComboBox<String> timeCombo;
    private final JSpinner ticketSpinner;
    private final JTextArea receiptArea;
    private final JLabel totalLabel;

    private static final double TICKET_PRICE = 250.00;

    public SwingDemo() {
        super("CineBook - Box Office Counter (Swing Demo)");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(550, 520);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout(10, 10));

        // Header Panel
        JPanel headerPanel = new JPanel();
        headerPanel.setBackground(new Color(20, 24, 33));
        JLabel headerLabel = new JLabel("CINEBOOK BOX OFFICE DESKTOP");
        headerLabel.setForeground(new Color(229, 9, 20));
        headerLabel.setFont(new Font("Arial", Font.BOLD, 18));
        headerPanel.add(headerLabel);
        add(headerPanel, BorderLayout.NORTH);

        // Input Form Panel
        JPanel formPanel = new JPanel(new GridLayout(5, 2, 10, 10));
        formPanel.setBorder(BorderFactory.createEmptyBorder(15, 20, 15, 20));

        formPanel.add(new JLabel("Select Movie:"));
        movieCombo = new JComboBox<>(new String[]{
                "Oppenheimer (IMAX 2D)",
                "Interstellar (Re-Release)",
                "Inception (Special Screening)",
                "The Dark Knight (4K Remaster)"
        });
        formPanel.add(movieCombo);

        formPanel.add(new JLabel("Select Showtime:"));
        timeCombo = new JComboBox<>(new String[]{"10:30 AM", "02:45 PM", "06:15 PM", "09:30 PM"});
        formPanel.add(timeCombo);

        formPanel.add(new JLabel("Number of Tickets:"));
        ticketSpinner = new JSpinner(new SpinnerNumberModel(1, 1, 10, 1));
        formPanel.add(ticketSpinner);

        formPanel.add(new JLabel("Total Price:"));
        totalLabel = new JLabel("INR 250.00");
        totalLabel.setFont(new Font("Arial", Font.BOLD, 14));
        totalLabel.setForeground(new Color(34, 139, 34));
        formPanel.add(totalLabel);

        JButton calculateBtn = new JButton("Calculate Total");
        JButton bookBtn = new JButton("Confirm & Print Ticket");
        bookBtn.setBackground(new Color(229, 9, 20));
        bookBtn.setForeground(Color.BLACK);

        formPanel.add(calculateBtn);
        formPanel.add(bookBtn);

        add(formPanel, BorderLayout.CENTER);

        // Receipt Output Panel
        receiptArea = new JTextArea(10, 40);
        receiptArea.setEditable(false);
        receiptArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
        receiptArea.setBackground(new Color(245, 245, 245));
        JScrollPane scrollPane = new JScrollPane(receiptArea);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Ticket Receipt Preview"));
        add(scrollPane, BorderLayout.SOUTH);

        // Listeners
        calculateBtn.addActionListener(e -> updatePrice());

        bookBtn.addActionListener(e -> {
            updatePrice();
            int tickets = (Integer) ticketSpinner.getValue();
            double total = tickets * TICKET_PRICE;
            String movie = (String) movieCombo.getSelectedItem();
            String time = (String) timeCombo.getSelectedItem();
            String ref = "SWG-" + System.currentTimeMillis() % 100000;
            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());

            StringBuilder sb = new StringBuilder();
            sb.append("=========================================\n");
            sb.append("           CINEBOOK TICKET RECEIPT       \n");
            sb.append("=========================================\n");
            sb.append(" Reference ID : ").append(ref).append("\n");
            sb.append(" Date & Time  : ").append(timestamp).append("\n");
            sb.append(" Movie        : ").append(movie).append("\n");
            sb.append(" Showtime     : ").append(time).append("\n");
            sb.append(" Quantity     : ").append(tickets).append(" ticket(s)\n");
            sb.append(" Amount Paid  : INR ").append(String.format("%.2f", total)).append(" [CASH/POS]\n");
            sb.append(" Status       : CONFIRMED\n");
            sb.append("=========================================\n");
            sb.append(" Enjoy your movie! Powered by Swing.\n");

            receiptArea.setText(sb.toString());
            JOptionPane.showMessageDialog(this, "Ticket " + ref + " issued successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
        });
    }

    private void updatePrice() {
        int tickets = (Integer) ticketSpinner.getValue();
        double total = tickets * TICKET_PRICE;
        totalLabel.setText(String.format("INR %.2f", total));
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            SwingDemo app = new SwingDemo();
            app.setVisible(true);
        });
    }
}
