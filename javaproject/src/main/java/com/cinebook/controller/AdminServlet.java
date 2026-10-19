package com.cinebook.controller;

import com.cinebook.model.Booking;
import com.cinebook.model.Movie;
import com.cinebook.model.Showtime;
import com.cinebook.model.Theatre;
import com.cinebook.model.User;
import com.cinebook.service.BookingService;
import com.cinebook.service.MovieService;
import com.cinebook.service.ShowtimeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {
    private final MovieService movieService = new MovieService();
    private final ShowtimeService showtimeService = new ShowtimeService();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login?error=admin_required");
            return;
        }

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(req, resp);
                break;
            case "movies":
                showMovies(req, resp);
                break;
            case "movie-form":
                showMovieForm(req, resp);
                break;
            case "movie-delete":
                handleDeleteMovie(req, resp);
                break;
            case "showtimes":
                showShowtimes(req, resp);
                break;
            case "showtime-delete":
                handleDeleteShowtime(req, resp);
                break;
            case "bookings":
                showBookings(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/admin?action=dashboard");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");
        if ("movie-save".equalsIgnoreCase(action)) {
            handleSaveMovie(req, resp);
        } else if ("showtime-save".equalsIgnoreCase(action)) {
            handleSaveShowtime(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin");
        }
    }

    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            return user != null && user.isAdmin();
        }
        return false;
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Movie> movies = movieService.getAllMovies();
        List<Showtime> showtimes = showtimeService.getAllShowtimes();
        List<Booking> bookings = bookingService.getAllBookings();

        BigDecimal totalRevenue = BigDecimal.ZERO;
        for (Booking b : bookings) {
            if ("SUCCESS".equalsIgnoreCase(b.getPaymentStatus())) {
                totalRevenue = totalRevenue.add(b.getTotalAmount());
            }
        }

        req.setAttribute("movieCount", movies.size());
        req.setAttribute("showtimeCount", showtimes.size());
        req.setAttribute("bookingCount", bookings.size());
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("recentBookings", bookings.size() > 5 ? bookings.subList(0, 5) : bookings);

        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }

    private void showMovies(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Movie> movies = movieService.getAllMovies();
        req.setAttribute("movies", movies);
        req.getRequestDispatcher("/WEB-INF/views/admin/movies.jsp").forward(req, resp);
    }

    private void showMovieForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            Movie movie = movieService.getMovieById(Integer.parseInt(idParam));
            req.setAttribute("movie", movie);
        }
        req.getRequestDispatcher("/WEB-INF/views/admin/movie-form.jsp").forward(req, resp);
    }

    private void handleSaveMovie(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        String title = req.getParameter("title");
        String genre = req.getParameter("genre");
        int durationMins = Integer.parseInt(req.getParameter("durationMins"));
        String language = req.getParameter("language");
        String description = req.getParameter("description");
        String posterUrl = req.getParameter("posterUrl");
        String releaseDateStr = req.getParameter("releaseDate");

        Date releaseDate = (releaseDateStr != null && !releaseDateStr.isEmpty()) 
                ? Date.valueOf(releaseDateStr) 
                : new Date(System.currentTimeMillis());

        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            Movie movie = new Movie(id, title, genre, durationMins, language, description, posterUrl, releaseDate);
            movieService.updateMovie(movie);
        } else {
            Movie movie = new Movie(title, genre, durationMins, language, description, posterUrl, releaseDate);
            movieService.addMovie(movie);
        }
        resp.sendRedirect(req.getContextPath() + "/admin?action=movies&msg=saved");
    }

    private void handleDeleteMovie(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            movieService.deleteMovie(Integer.parseInt(idParam));
        }
        resp.sendRedirect(req.getContextPath() + "/admin?action=movies&msg=deleted");
    }

    private void showShowtimes(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Showtime> showtimes = showtimeService.getAllShowtimes();
        List<Movie> movies = movieService.getAllMovies();
        List<Theatre> theatres = showtimeService.getAllTheatres();

        req.setAttribute("showtimes", showtimes);
        req.setAttribute("movies", movies);
        req.setAttribute("theatres", theatres);
        req.getRequestDispatcher("/WEB-INF/views/admin/showtimes.jsp").forward(req, resp);
    }

    private void handleSaveShowtime(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int movieId = Integer.parseInt(req.getParameter("movieId"));
        int theatreId = Integer.parseInt(req.getParameter("theatreId"));
        Date showDate = Date.valueOf(req.getParameter("showDate"));
        String showTime = req.getParameter("showTime");
        BigDecimal ticketPrice = new BigDecimal(req.getParameter("ticketPrice"));
        int totalSeats = Integer.parseInt(req.getParameter("totalSeats"));

        Showtime showtime = new Showtime(0, movieId, theatreId, showDate, showTime, ticketPrice, totalSeats);
        showtimeService.addShowtime(showtime);
        resp.sendRedirect(req.getContextPath() + "/admin?action=showtimes&msg=saved");
    }

    private void handleDeleteShowtime(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idParam = req.getParameter("id");
        if (idParam != null) {
            showtimeService.deleteShowtime(Integer.parseInt(idParam));
        }
        resp.sendRedirect(req.getContextPath() + "/admin?action=showtimes&msg=deleted");
    }

    private void showBookings(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Booking> bookings = bookingService.getAllBookings();
        req.setAttribute("bookings", bookings);
        req.getRequestDispatcher("/WEB-INF/views/admin/bookings.jsp").forward(req, resp);
    }
}
