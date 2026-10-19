<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Showtimes – CineBook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <a href="${pageContext.request.contextPath}/admin" class="text-muted small">&larr; Back to Dashboard</a>
                <h2 class="fw-bold text-white mb-0 mt-1">Showtime Scheduling</h2>
            </div>
        </div>

        <c:if test="${param.msg eq 'saved'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Showtime added successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg eq 'deleted'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                Showtime deleted successfully.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Add Showtime Form Column -->
            <div class="col-lg-4">
                <div class="card card-cinema p-4">
                    <h5 class="fw-bold text-white mb-3">+ Schedule New Showtime</h5>

                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="showtime-save">

                        <div class="mb-3">
                            <label class="form-label text-muted small">Select Movie</label>
                            <select name="movieId" class="form-select form-select-dark" required>
                                <c:forEach var="m" items="${movies}">
                                    <option value="${m.id}">${m.title} (${m.language})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Select Theatre</label>
                            <select name="theatreId" class="form-select form-select-dark" required>
                                <c:forEach var="t" items="${theatres}">
                                    <option value="${t.id}">${t.name} - ${t.city}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Show Date</label>
                            <input type="date" name="showDate" class="form-control form-control-dark" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Show Time</label>
                            <input type="text" name="showTime" class="form-control form-control-dark"
                                   placeholder="e.g. 07:30 PM" required>
                        </div>

                        <div class="row g-2 mb-3">
                            <div class="col-6">
                                <label class="form-label text-muted small">Price (₹)</label>
                                <input type="number" step="0.50" name="ticketPrice" class="form-control form-control-dark"
                                       value="250.00" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label text-muted small">Capacity</label>
                                <input type="number" name="totalSeats" class="form-control form-control-dark"
                                       value="40" required min="10" max="100">
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-cinema">Create Showtime</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Existing Showtimes List Column -->
            <div class="col-lg-8">
                <div class="card card-cinema p-3">
                    <h5 class="fw-bold text-white mb-3 px-2">Active Schedule</h5>
                    <div class="table-responsive">
                        <table class="table table-dark table-hover align-middle mb-0">
                            <thead>
                                <tr class="text-muted small">
                                    <th>MOVIE</th>
                                    <th>THEATRE</th>
                                    <th>DATE & TIME</th>
                                    <th>PRICE</th>
                                    <th>BOOKED</th>
                                    <th class="text-end">ACTION</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="st" items="${showtimes}">
                                    <tr>
                                        <td class="fw-bold text-white">${st.movieTitle}</td>
                                        <td>
                                            <div>${st.theatreName}</div>
                                            <div class="small text-muted">${st.theatreCity}</div>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-white">${st.showDate}</div>
                                            <div class="small text-muted">${st.showTime}</div>
                                        </td>
                                        <td class="text-warning">₹ ${st.ticketPrice}</td>
                                        <td>
                                            <span class="badge ${st.availableSeatsCount > 5 ? 'bg-success' : 'bg-danger'}">
                                                ${st.bookedSeatsCount} / ${st.totalSeats}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <a href="${pageContext.request.contextPath}/admin?action=showtime-delete&id=${st.id}"
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Delete this showtime? Associated customer bookings will also be deleted.')">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty showtimes}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">No showtimes found. Add one using the form on the left!</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
