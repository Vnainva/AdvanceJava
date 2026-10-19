<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings – CineBook Admin</title>
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
                <h2 class="fw-bold text-white mb-0 mt-1">All Customer Bookings</h2>
            </div>
            <span class="badge bg-secondary fs-6">${bookings.size()} Total Bookings</span>
        </div>

        <div class="card card-cinema p-3">
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle mb-0">
                    <thead>
                        <tr class="text-muted small">
                            <th>REF ID</th>
                            <th>CUSTOMER</th>
                            <th>MOVIE</th>
                            <th>THEATRE & TIME</th>
                            <th>SEATS</th>
                            <th>AMOUNT</th>
                            <th>PAYMENT</th>
                            <th>BOOKING TIME</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${bookings}">
                            <tr>
                                <td><span class="badge bg-danger">${b.bookingRef}</span></td>
                                <td>
                                    <div class="fw-bold text-white">${b.userName}</div>
                                    <div class="small text-muted">${b.userEmail}</div>
                                </td>
                                <td>
                                    <div class="fw-semibold text-white">${b.movieTitle}</div>
                                </td>
                                <td>
                                    <div>${b.theatreName}</div>
                                    <div class="small text-muted">${b.showDate} | ${b.showTime}</div>
                                </td>
                                <td>
                                    <span class="badge bg-success">${b.seats}</span>
                                    <span class="text-muted small">(${b.seatCount})</span>
                                </td>
                                <td class="fw-bold text-warning">₹ ${b.totalAmount}</td>
                                <td>
                                    <span class="badge bg-primary">${b.paymentStatus}</span>
                                    <div class="small text-muted">${b.paymentMode}</div>
                                </td>
                                <td class="small text-muted">${b.bookingTime}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bookings}">
                            <tr>
                                <td colspan="8" class="text-center text-muted py-4">No bookings found in the database.</td>
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
