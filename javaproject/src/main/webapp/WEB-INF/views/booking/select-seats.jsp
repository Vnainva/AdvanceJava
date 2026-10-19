<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <!-- Error Alert (e.g. duplicate seat conflict) -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <strong>Booking Conflict!</strong> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Seat Matrix Map -->
            <div class="col-lg-8">
                <div class="card card-cinema p-4 text-center">
                    <div class="d-flex justify-content-between align-items-center mb-4 text-start">
                        <div>
                            <h4 class="fw-bold text-white mb-0">${showtime.movieTitle}</h4>
                            <p class="text-muted small mb-0">${showtime.theatreName} (${showtime.theatreCity}) &bull; ${showtime.showDate} at ${showtime.showTime}</p>
                        </div>
                        <span class="badge bg-danger fs-6">₹ ${showtime.ticketPrice} / seat</span>
                    </div>

                    <!-- Screen Representation -->
                    <div class="theatre-screen-container">
                        <div class="theatre-screen"></div>
                        <div class="screen-text">All eyes this way • Screen</div>
                    </div>

                    <!-- Seats Grid (4 Rows: A, B, C, D - 10 Seats Each) -->
                    <div class="seat-grid" data-unit-price="${showtime.ticketPrice}">
                        <c:forEach var="rowLetter" items="${['A', 'B', 'C', 'D']}">
                            <div class="seat-row">
                                <span class="row-label">${rowLetter}</span>
                                <c:forEach var="colNum" begin="1" end="10">
                                    <c:set var="seatId" value="${rowLetter}${colNum}"/>
                                    <c:set var="isBooked" value="${bookedSeats.contains(seatId)}"/>

                                    <div class="seat ${isBooked ? 'booked' : ''}"
                                         data-seat="${seatId}"
                                         title="${isBooked ? 'Already Booked' : 'Seat ' += seatId}">
                                        ${colNum}
                                    </div>
                                </c:forEach>
                                <span class="row-label">${rowLetter}</span>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Seat Legend -->
                    <div class="seat-legend">
                        <div class="legend-item">
                            <div class="legend-box legend-available"></div>
                            <span>Available</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box legend-selected"></div>
                            <span>Selected</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-box legend-booked"></div>
                            <span>Booked</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Summary Sidebar -->
            <div class="col-lg-4">
                <div class="card card-cinema p-4">
                    <h5 class="fw-bold text-white border-bottom border-secondary pb-3 mb-3">Booking Summary</h5>

                    <div class="mb-3">
                        <div class="small text-muted">Movie</div>
                        <div class="fw-bold text-white">${showtime.movieTitle}</div>
                    </div>

                    <div class="mb-3">
                        <div class="small text-muted">Cinema & Showtime</div>
                        <div class="fw-semibold text-white">${showtime.theatreName}</div>
                        <div class="small text-muted">${showtime.showDate} | ${showtime.showTime}</div>
                    </div>

                    <div class="mb-3 p-3 bg-dark rounded">
                        <div class="d-flex justify-content-between mb-1">
                            <span class="text-muted small">Selected Seats:</span>
                            <span class="fw-bold text-success" id="selectedSeatsDisplay">None</span>
                        </div>
                        <div class="d-flex justify-content-between mb-1">
                            <span class="text-muted small">Tickets Count:</span>
                            <span class="fw-bold text-white" id="selectedCountDisplay">0</span>
                        </div>
                        <div class="d-flex justify-content-between border-top border-secondary pt-2 mt-2">
                            <span class="fw-bold text-white">Total Amount:</span>
                            <span class="fw-bold text-warning fs-5" id="totalPriceDisplay">₹ 0.00</span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/booking" method="POST">
                        <input type="hidden" name="action" value="checkout">
                        <input type="hidden" name="showtimeId" value="${showtime.id}">
                        <input type="hidden" name="selectedSeats" id="selectedSeatsInput" value="">

                        <div class="d-grid mt-3">
                            <button type="submit" id="btnProceedCheckout" class="btn btn-cinema btn-lg" disabled>
                                Proceed to Checkout
                            </button>
                        </div>
                    </form>

                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/movies?id=${showtime.movieId}" class="text-muted small">
                            &larr; Choose different showtime
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<script src="${pageContext.request.contextPath}/assets/js/seat-selection.js"></script>
</body>
</html>
