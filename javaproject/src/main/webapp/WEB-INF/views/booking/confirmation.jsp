<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        @media print {
            .no-print, nav, footer { display: none !important; }
            body { background-color: white !important; color: black !important; }
            .ticket-receipt { border: 2px solid black !important; background: white !important; color: black !important; }
            .text-white, .text-muted, .fw-bold { color: black !important; }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="ticket-receipt shadow-lg">
                    <!-- Success Header -->
                    <div class="text-center mb-4">
                        <span class="fs-1 text-success">🎉</span>
                        <h2 class="fw-bold text-white mt-2">Booking Confirmed!</h2>
                        <p class="text-muted small">Your movie ticket has been booked and reserved successfully.</p>
                        <span class="badge bg-danger fs-6 px-3 py-2">REF: ${booking.bookingRef}</span>
                    </div>

                    <div class="p-3 bg-dark rounded mb-4">
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <div class="text-muted small">Movie</div>
                                <div class="fw-bold fs-5 text-white">${booking.movieTitle}</div>
                            </div>
                            <div class="col-sm-6">
                                <div class="text-muted small">Cinema Hall</div>
                                <div class="fw-bold text-white">${booking.theatreName}</div>
                                <div class="text-muted small">${booking.theatreCity}</div>
                            </div>
                            <div class="col-sm-6">
                                <div class="text-muted small">Show Date & Time</div>
                                <div class="fw-semibold text-white">📅 ${booking.showDate} | ⏰ ${booking.showTime}</div>
                            </div>
                            <div class="col-sm-6">
                                <div class="text-muted small">Reserved Seats (${booking.seatCount})</div>
                                <div class="fw-bold text-success fs-5">${booking.seats}</div>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex justify-content-between align-items-center border-top border-secondary pt-3 mb-4">
                        <div>
                            <div class="text-muted small">Payment Status</div>
                            <span class="badge bg-success">${booking.paymentStatus} (${booking.paymentMode})</span>
                        </div>
                        <div class="text-end">
                            <div class="text-muted small">Total Paid</div>
                            <div class="fw-bold text-warning fs-4">₹ ${booking.totalAmount}</div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex flex-wrap gap-2 justify-content-center no-print">
                        <button onclick="window.print()" class="btn btn-outline-light">
                            🖨️ Print Ticket
                        </button>
                        <a href="${pageContext.request.contextPath}/booking?action=history" class="btn btn-secondary">
                            View My Bookings
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-cinema">
                            Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
