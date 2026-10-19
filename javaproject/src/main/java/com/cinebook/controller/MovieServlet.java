package com.cinebook.controller;

import com.cinebook.model.Movie;
import com.cinebook.model.Showtime;
import com.cinebook.service.MovieService;
import com.cinebook.service.ShowtimeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "MovieServlet", urlPatterns = {"/movies"})
public class MovieServlet extends HttpServlet {
    private final MovieService movieService = new MovieService();
    private final ShowtimeService showtimeService = new ShowtimeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        String search = req.getParameter("q");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int movieId = Integer.parseInt(idParam.trim());
                Movie movie = movieService.getMovieById(movieId);
                if (movie != null) {
                    List<Showtime> showtimes = showtimeService.getShowtimesByMovieId(movieId);
                    req.setAttribute("movie", movie);
                    req.setAttribute("showtimes", showtimes);
                    req.getRequestDispatcher("/WEB-INF/views/movie/detail.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException ignored) {
            }
            resp.sendRedirect(req.getContextPath() + "/movies");
            return;
        }

        List<Movie> movies;
        if (search != null && !search.trim().isEmpty()) {
            movies = movieService.searchMovies(search);
            req.setAttribute("searchQuery", search);
        } else {
            movies = movieService.getAllMovies();
        }

        req.setAttribute("movies", movies);
        req.getRequestDispatcher("/WEB-INF/views/movie/list.jsp").forward(req, resp);
    }
}
