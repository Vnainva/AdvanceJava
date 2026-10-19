<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-white mb-1">My Booking History</h2>
                <p class="text-muted small mb-0">View all your confirmed movie tickets and receipts</p>
            </div>
            <a href="${pageContext.request.contextPath}/movies" class="btn btn-cinema btn-sm">Book New Movie</a>
        </div>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="card card-cinema p-5 text-center my-4">
                    <span class="fs-1">🎟️</span>
                    <h4 class="text-white mt-3">No Bookings Yet</h4>
                    <p class="text-muted small">You haven't booked any movie tickets yet. Explore our featured films!</p>
                    <div>
                        <a href="${pageContext.request.contextPath}/movies" class="btn btn-cinema btn-sm">Explore Movies</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-3">
                    <c:forEach var="b" items="${bookings}">
                        <div class="col-12">
                            <div class="card card-cinema p-3">
                                <div class="row align-items-center gy-3">
                                    <div class="col-md-2 text-center text-md-start">
                                        <img src="${b.moviePosterUrl}" class="rounded" alt="${b.movieTitle}"
                                             style="height: 110px; width: 85px; object-fit: cover;"
                                             onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=60';">
                                    </div>
                                    <div class="col-md-4">
                                        <div class="badge bg-danger mb-1">${b.bookingRef}</div>
                                        <h5 class="fw-bold text-white mb-1">${b.movieTitle}</h5>
                                        <p class="text-muted small mb-0">
                                            📍 ${b.theatreName} (${b.theatreCity})
                                        </p>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="small text-muted">Showtime</div>
                                        <div class="fw-semibold text-white">📅 ${b.showDate}</div>
                                        <div class="small text-muted">⏰ ${b.showTime}</div>
                                        <div class="small mt-1"><span class="text-muted">Seats:</span> <strong class="text-success">${b.seats}</strong></div>
                                    </div>
                                    <div class="col-md-3 text-md-end">
                                        <div class="small text-muted">Amount Paid</div>
                                        <div class="fw-bold text-warning fs-5">₹ ${b.totalAmount}</div>
                                        <span class="badge bg-success mb-2">${b.paymentStatus} (${b.paymentMode})</span>
                                        <div>
                                            <a href="${pageContext.request.contextPath}/booking?action=confirmation&ref=${b.bookingRef}"
                                               class="btn btn-sm btn-outline-light">
                                                View Receipt
                                            </a>
                                        </div>
                                    </div>
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
