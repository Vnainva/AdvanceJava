package com.cinebook.service;

import com.cinebook.dao.ShowtimeDAO;
import com.cinebook.dao.TheatreDAO;
import com.cinebook.model.Showtime;
import com.cinebook.model.Theatre;

import java.util.List;

public class ShowtimeService {
    private final ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    private final TheatreDAO theatreDAO = new TheatreDAO();

    public List<Showtime> getShowtimesByMovieId(int movieId) {
        return showtimeDAO.getShowtimesByMovieId(movieId);
    }

    public Showtime getShowtimeById(int id) {
        return showtimeDAO.getShowtimeById(id);
    }

    public List<Showtime> getAllShowtimes() {
        return showtimeDAO.getAllShowtimes();
    }

    public boolean addShowtime(Showtime showtime) {
        if (showtime == null || showtime.getMovieId() <= 0 || showtime.getTheatreId() <= 0) {
            return false;
        }
        return showtimeDAO.addShowtime(showtime);
    }

    public boolean deleteShowtime(int id) {
        if (id <= 0) {
            return false;
        }
        return showtimeDAO.deleteShowtime(id);
    }

    public List<Theatre> getAllTheatres() {
        return theatreDAO.getAllTheatres();
    }
}
