<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie.title} – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <!-- Movie Header Overview -->
        <div class="card card-cinema p-4 mb-5">
            <div class="row g-4">
                <div class="col-md-4 col-lg-3 text-center">
                    <img src="${movie.posterUrl}" class="img-fluid rounded shadow" alt="${movie.title}"
                         style="max-height: 420px; object-fit: cover;"
                         onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=60';">
                </div>
                <div class="col-md-8 col-lg-9 d-flex flex-column justify-content-center">
                    <div class="d-flex flex-wrap gap-2 mb-2">
                        <span class="badge bg-danger">${movie.genre}</span>
                        <span class="badge bg-secondary">${movie.language}</span>
                        <span class="badge bg-dark border border-secondary">${movie.formattedDuration}</span>
                    </div>

                    <h1 class="display-5 fw-bold text-white mb-2">${movie.title}</h1>

                    <p class="text-muted mb-4 lead fs-6">
                        ${movie.description}
                    </p>

                    <div class="row row-cols-2 row-cols-sm-3 g-3 small text-muted border-top border-secondary pt-3">
                        <div>
                            <div class="fw-bold text-white">Release Date</div>
                            <div>${movie.releaseDate}</div>
                        </div>
                        <div>
                            <div class="fw-bold text-white">Duration</div>
                            <div>${movie.durationMins} minutes</div>
                        </div>
                        <div>
                            <div class="fw-bold text-white">Experience</div>
                            <div>IMAX 2D, Dolby Atmos</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Showtimes Section -->
        <div class="mb-4">
            <h3 class="fw-bold text-white mb-1">Available Showtimes & Theatres</h3>
            <p class="text-muted small">Choose your preferred cinema and timing to select seats</p>
        </div>

        <c:choose>
            <c:when test="${empty showtimes}">
                <div class="card card-cinema p-5 text-center">
                    <span class="fs-2">📅</span>
                    <h5 class="text-white mt-2">No Showtimes Scheduled Yet</h5>
                    <p class="text-muted small">Please check back later or choose another movie.</p>
                    <div>
                        <a href="${pageContext.request.contextPath}/movies" class="btn btn-outline-cinema btn-sm">Explore Other Movies</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-3">
                    <c:forEach var="st" items="${showtimes}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card card-cinema p-3 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <h5 class="fw-bold text-white mb-0">${st.theatreName}</h5>
                                        <span class="badge bg-success">₹ ${st.ticketPrice}</span>
                                    </div>
                                    <p class="text-muted small mb-3">📍 ${st.theatreCity}</p>
                                    
                                    <div class="p-2 bg-dark rounded d-flex justify-content-between align-items-center mb-3">
                                        <div>
                                            <div class="small text-muted">Date & Time</div>
                                            <div class="fw-semibold text-white">📅 ${st.showDate} | ⏰ ${st.showTime}</div>
                                        </div>
                                        <div class="text-end">
                                            <div class="small text-muted">Availability</div>
                                            <span class="badge ${st.availableSeatsCount > 10 ? 'bg-info' : 'bg-warning'} text-dark">
                                                ${st.availableSeatsCount} / ${st.totalSeats} seats
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <c:choose>
                                        <c:when test="${st.availableSeatsCount > 0}">
                                            <a href="${pageContext.request.contextPath}/booking?action=select-seats&showtimeId=${st.id}"
                                               class="btn btn-cinema w-100">
                                                Select Seats
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-secondary w-100" disabled>Houseful</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
