package com.cinebook.controller;

import com.cinebook.model.Booking;
import com.cinebook.model.Showtime;
import com.cinebook.model.User;
import com.cinebook.service.BookingService;
import com.cinebook.service.ShowtimeService;
import com.cinebook.util.SeatAlreadyBookedException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService();
    private final ShowtimeService showtimeService = new ShowtimeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "select-seats";
        }

        switch (action) {
            case "select-seats":
                showSeatSelection(req, resp);
                break;
            case "confirmation":
                showConfirmation(req, resp);
                break;
            case "history":
                showHistory(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/movies");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("checkout".equalsIgnoreCase(action)) {
            handleCheckout(req, resp);
        } else if ("pay".equalsIgnoreCase(action)) {
            handlePayment(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/movies");
        }
    }

    private void showSeatSelection(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String showtimeIdParam = req.getParameter("showtimeId");
        if (showtimeIdParam == null) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        try {
            int showtimeId = Integer.parseInt(showtimeIdParam.trim());
            Showtime showtime = showtimeService.getShowtimeById(showtimeId);
            if (showtime == null) {
                resp.sendRedirect(req.getContextPath() + "/movies");
                return;
            }

            Set<String> bookedSeats = bookingService.getBookedSeats(showtimeId);
            req.setAttribute("showtime", showtime);
            req.setAttribute("bookedSeats", bookedSeats);

            String error = req.getParameter("error");
            if ("conflict".equals(error)) {
                req.setAttribute("errorMessage", "Some of the selected seats were just booked by another customer! Please choose available seats.");
            }

            req.getRequestDispatcher("/WEB-INF/views/booking/select-seats.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/movies");
        }
    }

    private void handleCheckout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        String showtimeIdParam = req.getParameter("showtimeId");
        String selectedSeatsStr = req.getParameter("selectedSeats");

        if (showtimeIdParam == null || selectedSeatsStr == null || selectedSeatsStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        int showtimeId = Integer.parseInt(showtimeIdParam.trim());
        Showtime showtime = showtimeService.getShowtimeById(showtimeId);
        if (showtime == null) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        List<String> seatList = parseSeats(selectedSeatsStr);
        if (seatList.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/booking?action=select-seats&showtimeId=" + showtimeId);
            return;
        }

        // If user not logged in, redirect to login with callback
        if (user == null) {
            String returnUrl = req.getContextPath() + "/booking?action=select-seats&showtimeId=" + showtimeId;
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + returnUrl);
            return;
        }

        BigDecimal totalAmount = showtime.getTicketPrice().multiply(BigDecimal.valueOf(seatList.size()));

        req.setAttribute("showtime", showtime);
        req.setAttribute("selectedSeats", String.join(", ", seatList));
        req.setAttribute("seatCount", seatList.size());
        req.setAttribute("totalAmount", totalAmount);

        req.getRequestDispatcher("/WEB-INF/views/booking/checkout.jsp").forward(req, resp);
    }

    private void handlePayment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String showtimeIdParam = req.getParameter("showtimeId");
        String seatsStr = req.getParameter("seats");
        String paymentMode = req.getParameter("paymentMode");

        if (showtimeIdParam == null || seatsStr == null) {
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        int showtimeId = Integer.parseInt(showtimeIdParam.trim());
        List<String> seatList = parseSeats(seatsStr);

        try {
            Booking booking = bookingService.processBooking(user.getId(), showtimeId, seatList, paymentMode);
            if (booking != null) {
                resp.sendRedirect(req.getContextPath() + "/booking?action=confirmation&ref=" + booking.getBookingRef());
            } else {
                req.setAttribute("errorMessage", "Failed to process booking. Please try again.");
                resp.sendRedirect(req.getContextPath() + "/booking?action=select-seats&showtimeId=" + showtimeId);
            }
        } catch (SeatAlreadyBookedException e) {
            // Seat availability validation triggered!
            resp.sendRedirect(req.getContextPath() + "/booking?action=select-seats&showtimeId=" + showtimeId + "&error=conflict");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/booking?action=select-seats&showtimeId=" + showtimeId);
        }
    }

    private void showConfirmation(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ref = req.getParameter("ref");
        if (ref == null || ref.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        Booking booking = bookingService.getBookingByRef(ref.trim());
        if (booking == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        req.setAttribute("booking", booking);
        req.getRequestDispatcher("/WEB-INF/views/booking/confirmation.jsp").forward(req, resp);
    }

    private void showHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + req.getContextPath() + "/booking?action=history");
            return;
        }

        List<Booking> bookings = bookingService.getUserBookings(user.getId());
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/WEB-INF/views/booking/history.jsp").forward(req, resp);
    }

    private List<String> parseSeats(String raw) {
        List<String> list = new ArrayList<>();
        if (raw == null) return list;
        String[] tokens = raw.split(",");
        for (String t : tokens) {
            String trimmed = t.trim();
            if (!trimmed.isEmpty()) {
                list.add(trimmed);
            }
        }
        return list;
    }
}
