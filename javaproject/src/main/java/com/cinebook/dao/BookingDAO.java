package com.cinebook.dao;

import com.cinebook.model.Booking;
import com.cinebook.util.DBUtil;
import com.cinebook.util.SeatAlreadyBookedException;

import java.sql.*;
import java.util.*;

public class BookingDAO {

    public Set<String> getBookedSeatNumbers(int showtimeId) {
        Set<String> bookedSeats = new HashSet<>();
        String sql = "SELECT seat_number FROM booked_seats WHERE showtime_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookedSeats.add(rs.getString("seat_number"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookedSeats;
    }

    /**
     * Atomically validates seat availability and creates the booking within a single JDBC transaction.
     * Prevents race conditions and duplicate bookings via DB-level transaction and unique constraint.
     */
    public boolean createBookingWithSeats(Booking booking, List<String> seatNumbers)
            throws SeatAlreadyBookedException, SQLException {

        if (seatNumbers == null || seatNumbers.isEmpty()) {
            return false;
        }

        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psBooking = null;
        PreparedStatement psSeats = null;
        ResultSet rsCheck = null;
        ResultSet rsKeys = null;

        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false); // Begin transaction

            // 1. Validate seat availability (Lock check)
            StringBuilder checkSql = new StringBuilder("SELECT seat_number FROM booked_seats WHERE showtime_id = ? AND seat_number IN (");
            for (int i = 0; i < seatNumbers.size(); i++) {
                checkSql.append(i == 0 ? "?" : ", ?");
            }
            checkSql.append(") FOR UPDATE");

            psCheck = conn.prepareStatement(checkSql.toString());
            psCheck.setInt(1, booking.getShowtimeId());
            for (int i = 0; i < seatNumbers.size(); i++) {
                psCheck.setString(i + 2, seatNumbers.get(i).trim());
            }

            rsCheck = psCheck.executeQuery();
            List<String> conflicts = new ArrayList<>();
            while (rsCheck.next()) {
                conflicts.add(rsCheck.getString("seat_number"));
            }

            if (!conflicts.isEmpty()) {
                conn.rollback();
                throw new SeatAlreadyBookedException("Seat(s) already booked: " + conflicts, conflicts);
            }

            // 2. Insert into bookings table
            String insertBookingSql = "INSERT INTO bookings (booking_ref, user_id, showtime_id, seats, seat_count, " +
                    "total_amount, payment_status, payment_mode) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            psBooking = conn.prepareStatement(insertBookingSql, Statement.RETURN_GENERATED_KEYS);
            psBooking.setString(1, booking.getBookingRef());
            psBooking.setInt(2, booking.getUserId());
            psBooking.setInt(3, booking.getShowtimeId());
            psBooking.setString(4, String.join(", ", seatNumbers));
            psBooking.setInt(5, seatNumbers.size());
            psBooking.setBigDecimal(6, booking.getTotalAmount());
            psBooking.setString(7, booking.getPaymentStatus() != null ? booking.getPaymentStatus() : "SUCCESS");
            psBooking.setString(8, booking.getPaymentMode() != null ? booking.getPaymentMode() : "CARD");

            int affected = psBooking.executeUpdate();
            if (affected == 0) {
                conn.rollback();
                return false;
            }

            rsKeys = psBooking.getGeneratedKeys();
            int bookingId;
            if (rsKeys.next()) {
                bookingId = rsKeys.getInt(1);
                booking.setId(bookingId);
            } else {
                conn.rollback();
                return false;
            }

            // 3. Insert each seat into booked_seats table
            String insertSeatsSql = "INSERT INTO booked_seats (showtime_id, seat_number, booking_id) VALUES (?, ?, ?)";
            psSeats = conn.prepareStatement(insertSeatsSql);
            for (String seat : seatNumbers) {
                psSeats.setInt(1, booking.getShowtimeId());
                psSeats.setString(2, seat.trim());
                psSeats.setInt(3, bookingId);
                psSeats.addBatch();
            }
            psSeats.executeBatch();

            // 4. Commit transaction
            conn.commit();
            return true;

        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            // Check for MySQL duplicate key error code 1062
            if (e.getErrorCode() == 1062) {
                throw new SeatAlreadyBookedException("One or more selected seats were concurrently booked.", seatNumbers);
            }
            throw e;
        } finally {
            DBUtil.close(rsCheck, rsKeys, psCheck, psBooking, psSeats, conn);
        }
    }

    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.id, b.booking_ref, b.user_id, b.showtime_id, b.seats, b.seat_count, b.total_amount, " +
                "b.payment_status, b.payment_mode, b.booking_time, " +
                "m.title AS movie_title, m.poster_url AS movie_poster_url, " +
                "t.name AS theatre_name, t.city AS theatre_city, " +
                "s.show_date, s.show_time " +
                "FROM bookings b " +
                "JOIN showtimes s ON b.showtime_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN theatres t ON s.theatre_id = t.id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Booking getBookingByRef(String bookingRef) {
        String sql = "SELECT b.id, b.booking_ref, b.user_id, b.showtime_id, b.seats, b.seat_count, b.total_amount, " +
                "b.payment_status, b.payment_mode, b.booking_time, " +
                "u.name AS user_name, u.email AS user_email, " +
                "m.title AS movie_title, m.poster_url AS movie_poster_url, " +
                "t.name AS theatre_name, t.city AS theatre_city, " +
                "s.show_date, s.show_time " +
                "FROM bookings b " +
                "JOIN users u ON b.user_id = u.id " +
                "JOIN showtimes s ON b.showtime_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN theatres t ON s.theatre_id = t.id " +
                "WHERE b.booking_ref = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, bookingRef);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Booking b = mapResultSetToBooking(rs);
                    b.setUserName(rs.getString("user_name"));
                    b.setUserEmail(rs.getString("user_email"));
                    return b;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.id, b.booking_ref, b.user_id, b.showtime_id, b.seats, b.seat_count, b.total_amount, " +
                "b.payment_status, b.payment_mode, b.booking_time, " +
                "u.name AS user_name, u.email AS user_email, " +
                "m.title AS movie_title, m.poster_url AS movie_poster_url, " +
                "t.name AS theatre_name, t.city AS theatre_city, " +
                "s.show_date, s.show_time " +
                "FROM bookings b " +
                "JOIN users u ON b.user_id = u.id " +
                "JOIN showtimes s ON b.showtime_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN theatres t ON s.theatre_id = t.id " +
                "ORDER BY b.booking_time DESC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking b = mapResultSetToBooking(rs);
                b.setUserName(rs.getString("user_name"));
                b.setUserEmail(rs.getString("user_email"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Booking mapResultSetToBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setBookingRef(rs.getString("booking_ref"));
        b.setUserId(rs.getInt("user_id"));
        b.setShowtimeId(rs.getInt("showtime_id"));
        b.setSeats(rs.getString("seats"));
        b.setSeatCount(rs.getInt("seat_count"));
        b.setTotalAmount(rs.getBigDecimal("total_amount"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setPaymentMode(rs.getString("payment_mode"));
        b.setBookingTime(rs.getTimestamp("booking_time"));
        b.setMovieTitle(rs.getString("movie_title"));
        b.setMoviePosterUrl(rs.getString("movie_poster_url"));
        b.setTheatreName(rs.getString("theatre_name"));
        b.setTheatreCity(rs.getString("theatre_city"));
        b.setShowDate(rs.getDate("show_date"));
        b.setShowTime(rs.getString("show_time"));
        return b;
    }
}
