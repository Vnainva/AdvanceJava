package com.cinebook.service;

import com.cinebook.dao.BookingDAO;
import com.cinebook.dao.ShowtimeDAO;
import com.cinebook.model.Booking;
import com.cinebook.model.Showtime;
import com.cinebook.util.SeatAlreadyBookedException;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.*;

public class BookingService {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();

    public Set<String> getBookedSeats(int showtimeId) {
        return bookingDAO.getBookedSeatNumbers(showtimeId);
    }

    public Booking processBooking(int userId, int showtimeId, List<String> seatNumbers, String paymentMode)
            throws SeatAlreadyBookedException, SQLException {

        if (seatNumbers == null || seatNumbers.isEmpty()) {
            throw new IllegalArgumentException("No seats selected for booking.");
        }

        Showtime showtime = showtimeDAO.getShowtimeById(showtimeId);
        if (showtime == null) {
            throw new IllegalArgumentException("Invalid showtime ID.");
        }

        BigDecimal totalAmount = showtime.getTicketPrice().multiply(BigDecimal.valueOf(seatNumbers.size()));
        String bookingRef = "CBK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        Booking booking = new Booking();
        booking.setBookingRef(bookingRef);
        booking.setUserId(userId);
        booking.setShowtimeId(showtimeId);
        booking.setSeats(String.join(", ", seatNumbers));
        booking.setSeatCount(seatNumbers.size());
        booking.setTotalAmount(totalAmount);
        booking.setPaymentStatus("SUCCESS");
        booking.setPaymentMode(paymentMode != null ? paymentMode : "CARD");

        boolean success = bookingDAO.createBookingWithSeats(booking, seatNumbers);
        if (success) {
            return bookingDAO.getBookingByRef(bookingRef);
        }
        return null;
    }

    public List<Booking> getUserBookings(int userId) {
        return bookingDAO.getBookingsByUserId(userId);
    }

    public Booking getBookingByRef(String bookingRef) {
        return bookingDAO.getBookingByRef(bookingRef);
    }

    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }
}
