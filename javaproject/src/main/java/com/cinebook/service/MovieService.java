package com.cinebook.service;

import com.cinebook.dao.MovieDAO;
import com.cinebook.model.Movie;

import java.util.List;

public class MovieService {
    private final MovieDAO movieDAO = new MovieDAO();

    public List<Movie> getAllMovies() {
        return movieDAO.getAllMovies();
    }

    public Movie getMovieById(int id) {
        return movieDAO.getMovieById(id);
    }

    public List<Movie> searchMovies(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return movieDAO.getAllMovies();
        }
        return movieDAO.searchMovies(keyword.trim());
    }

    public boolean addMovie(Movie movie) {
        if (movie == null || movie.getTitle() == null || movie.getTitle().trim().isEmpty()) {
            return false;
        }
        return movieDAO.addMovie(movie);
    }

    public boolean updateMovie(Movie movie) {
        if (movie == null || movie.getId() <= 0) {
            return false;
        }
        return movieDAO.updateMovie(movie);
    }

    public boolean deleteMovie(int id) {
        if (id <= 0) {
            return false;
        }
        return movieDAO.deleteMovie(id);
    }
}
