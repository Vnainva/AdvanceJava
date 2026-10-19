<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <span class="badge bg-danger mb-1">CineBook Admin</span>
                <h2 class="fw-bold text-white mb-0">System Control Center</h2>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/admin?action=movie-form" class="btn btn-cinema btn-sm">
                    + Add New Movie
                </a>
                <a href="${pageContext.request.contextPath}/admin?action=showtimes" class="btn btn-outline-light btn-sm">
                    + Schedule Showtime
                </a>
            </div>
        </div>

        <!-- Metric Stat Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="card card-cinema p-3">
                    <div class="text-muted small">Total Movies</div>
                    <div class="fs-2 fw-bold text-white mt-1">${movieCount}</div>
                    <a href="${pageContext.request.contextPath}/admin?action=movies" class="small text-danger mt-2 text-decoration-none">Manage Movies &rarr;</a>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card card-cinema p-3">
                    <div class="text-muted small">Active Showtimes</div>
                    <div class="fs-2 fw-bold text-white mt-1">${showtimeCount}</div>
                    <a href="${pageContext.request.contextPath}/admin?action=showtimes" class="small text-danger mt-2 text-decoration-none">Manage Schedule &rarr;</a>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card card-cinema p-3">
                    <div class="text-muted small">Total Bookings</div>
                    <div class="fs-2 fw-bold text-white mt-1">${bookingCount}</div>
                    <a href="${pageContext.request.contextPath}/admin?action=bookings" class="small text-danger mt-2 text-decoration-none">View All Bookings &rarr;</a>
                </div>
            </div>
            <div class="col-sm-6 col-lg-3">
                <div class="card card-cinema p-3">
                    <div class="text-muted small">Total Revenue (Simulated)</div>
                    <div class="fs-2 fw-bold text-warning mt-1">₹ ${totalRevenue}</div>
                    <div class="small text-muted mt-2">All completed transactions</div>
                </div>
            </div>
        </div>

        <!-- Navigation Tabs / Shortcuts -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin?action=movies" class="card card-cinema p-3 text-decoration-none d-block">
                    <h5 class="fw-bold text-white mb-1">🎬 Movie Catalog</h5>
                    <p class="text-muted small mb-0">Add, edit, or remove movies from the listing.</p>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin?action=showtimes" class="card card-cinema p-3 text-decoration-none d-block">
                    <h5 class="fw-bold text-white mb-1">🕒 Showtime Scheduling</h5>
                    <p class="text-muted small mb-0">Assign movies to theatres, dates, and times.</p>
                </a>
            </div>
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/admin?action=bookings" class="card card-cinema p-3 text-decoration-none d-block">
                    <h5 class="fw-bold text-white mb-1">📑 Customer Bookings</h5>
                    <p class="text-muted small mb-0">Audit seat reservations, payment statuses, and history.</p>
                </a>
            </div>
        </div>

        <!-- Recent Bookings Table -->
        <div class="card card-cinema p-4">
            <h5 class="fw-bold text-white mb-3">Recent Bookings</h5>
            <div class="table-responsive">
                <table class="table table-dark table-hover mb-0">
                    <thead>
                        <tr class="text-muted small">
                            <th>REF</th>
                            <th>CUSTOMER</th>
                            <th>MOVIE</th>
                            <th>SEATS</th>
                            <th>AMOUNT</th>
                            <th>STATUS</th>
                            <th>TIME</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${recentBookings}">
                            <tr>
                                <td><span class="badge bg-secondary">${b.bookingRef}</span></td>
                                <td>${b.userName}</td>
                                <td>${b.movieTitle}</td>
                                <td><span class="text-success fw-bold">${b.seats}</span></td>
                                <td class="text-warning">₹ ${b.totalAmount}</td>
                                <td><span class="badge bg-success">${b.paymentStatus}</span></td>
                                <td class="small text-muted">${b.bookingTime}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentBookings}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-3">No bookings recorded yet.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
