package com.cinebook.dao;

import com.cinebook.model.Showtime;
import com.cinebook.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeDAO {

    public List<Showtime> getShowtimesByMovieId(int movieId) {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT s.id, s.movie_id, s.theatre_id, s.show_date, s.show_time, s.ticket_price, s.total_seats, " +
                     "m.title AS movie_title, m.poster_url AS movie_poster_url, t.name AS theatre_name, t.city AS theatre_city, " +
                     "(SELECT COUNT(*) FROM booked_seats bs WHERE bs.showtime_id = s.id) AS booked_count " +
                     "FROM showtimes s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN theatres t ON s.theatre_id = t.id " +
                     "WHERE s.movie_id = ? " +
                     "ORDER BY s.show_date ASC, s.show_time ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToShowtime(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Showtime getShowtimeById(int id) {
        String sql = "SELECT s.id, s.movie_id, s.theatre_id, s.show_date, s.show_time, s.ticket_price, s.total_seats, " +
                     "m.title AS movie_title, m.poster_url AS movie_poster_url, t.name AS theatre_name, t.city AS theatre_city, " +
                     "(SELECT COUNT(*) FROM booked_seats bs WHERE bs.showtime_id = s.id) AS booked_count " +
                     "FROM showtimes s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN theatres t ON s.theatre_id = t.id " +
                     "WHERE s.id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShowtime(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Showtime> getAllShowtimes() {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT s.id, s.movie_id, s.theatre_id, s.show_date, s.show_time, s.ticket_price, s.total_seats, " +
                     "m.title AS movie_title, m.poster_url AS movie_poster_url, t.name AS theatre_name, t.city AS theatre_city, " +
                     "(SELECT COUNT(*) FROM booked_seats bs WHERE bs.showtime_id = s.id) AS booked_count " +
                     "FROM showtimes s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN theatres t ON s.theatre_id = t.id " +
                     "ORDER BY s.show_date DESC, s.show_time ASC";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToShowtime(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addShowtime(Showtime showtime) {
        String sql = "INSERT INTO showtimes (movie_id, theatre_id, show_date, show_time, ticket_price, total_seats) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, showtime.getMovieId());
            ps.setInt(2, showtime.getTheatreId());
            ps.setDate(3, showtime.getShowDate());
            ps.setString(4, showtime.getShowTime());
            ps.setBigDecimal(5, showtime.getTicketPrice());
            ps.setInt(6, showtime.getTotalSeats() > 0 ? showtime.getTotalSeats() : 40);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        showtime.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteShowtime(int id) {
        String sql = "DELETE FROM showtimes WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Showtime mapResultSetToShowtime(ResultSet rs) throws SQLException {
        Showtime s = new Showtime();
        s.setId(rs.getInt("id"));
        s.setMovieId(rs.getInt("movie_id"));
        s.setTheatreId(rs.getInt("theatre_id"));
        s.setShowDate(rs.getDate("show_date"));
        s.setShowTime(rs.getString("show_time"));
        s.setTicketPrice(rs.getBigDecimal("ticket_price"));
        s.setTotalSeats(rs.getInt("total_seats"));
        s.setMovieTitle(rs.getString("movie_title"));
        s.setMoviePosterUrl(rs.getString("movie_poster_url"));
        s.setTheatreName(rs.getString("theatre_name"));
        s.setTheatreCity(rs.getString("theatre_city"));
        s.setBookedSeatsCount(rs.getInt("booked_count"));
        return s;
    }
}
