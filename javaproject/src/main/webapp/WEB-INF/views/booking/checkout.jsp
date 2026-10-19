<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout & Payment – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card card-cinema p-4">
                    <h3 class="fw-bold text-white mb-1">Confirm & Pay</h3>
                    <p class="text-muted small mb-4">Review your reservation details and complete simulated payment</p>

                    <div class="row g-4">
                        <!-- Order Summary Left Column -->
                        <div class="col-md-6 border-end border-secondary">
                            <h5 class="fw-bold text-white mb-3">Order Details</h5>
                            
                            <div class="mb-3">
                                <div class="text-muted small">Movie</div>
                                <div class="fw-bold fs-5 text-white">${showtime.movieTitle}</div>
                            </div>

                            <div class="mb-3">
                                <div class="text-muted small">Cinema & Hall</div>
                                <div class="fw-semibold text-white">${showtime.theatreName}</div>
                                <div class="text-muted small">${showtime.theatreCity}</div>
                            </div>

                            <div class="mb-3">
                                <div class="text-muted small">Date & Time</div>
                                <div class="fw-semibold text-white">${showtime.showDate} at ${showtime.showTime}</div>
                            </div>

                            <div class="p-3 bg-dark rounded mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="text-muted small">Selected Seats:</span>
                                    <span class="fw-bold text-success">${selectedSeats}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="text-muted small">Ticket Count:</span>
                                    <span class="fw-bold text-white">${seatCount}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="text-muted small">Price per Ticket:</span>
                                    <span class="fw-bold text-white">₹ ${showtime.ticketPrice}</span>
                                </div>
                                <div class="d-flex justify-content-between border-top border-secondary pt-2 mt-2">
                                    <span class="fw-bold text-white fs-5">Total Payable:</span>
                                    <span class="fw-bold text-warning fs-5">₹ ${totalAmount}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Method Right Column -->
                        <div class="col-md-6">
                            <h5 class="fw-bold text-white mb-3">Simulated Payment</h5>

                            <form action="${pageContext.request.contextPath}/booking" method="POST">
                                <input type="hidden" name="action" value="pay">
                                <input type="hidden" name="showtimeId" value="${showtime.id}">
                                <input type="hidden" name="seats" value="${selectedSeats}">

                                <div class="mb-3">
                                    <label class="form-label text-muted small">Customer Name</label>
                                    <input type="text" class="form-control form-control-dark" value="${sessionScope.user.name}" readonly>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-muted small">Customer Email</label>
                                    <input type="email" class="form-control form-control-dark" value="${sessionScope.user.email}" readonly>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-muted small">Payment Mode</label>
                                    <select name="paymentMode" class="form-select form-select-dark" id="paymentModeSelect">
                                        <option value="CARD">Credit / Debit Card</option>
                                        <option value="UPI">UPI (Google Pay / PhonePe)</option>
                                        <option value="NETBANKING">Net Banking</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-muted small">Card / UPI Reference</label>
                                    <input type="text" class="form-control form-control-dark" placeholder="e.g. 4111-XXXX-XXXX-1111 or user@upi" value="4242-XXXX-XXXX-4242">
                                    <div class="form-text text-muted small">Simulated environment: No actual charge occurs.</div>
                                </div>

                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-cinema btn-lg">
                                        Pay ₹ ${totalAmount} & Confirm
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
