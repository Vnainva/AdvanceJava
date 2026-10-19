<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="d-flex align-items-center py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">
                <div class="card card-cinema p-4 shadow">
                    <div class="text-center mb-4">
                        <span class="fs-1">🎟️</span>
                        <h3 class="fw-bold text-white mt-2">Create an Account</h3>
                        <p class="text-muted small">Join CineBook for seamless movie reservations</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth" method="POST">
                        <input type="hidden" name="action" value="register">

                        <div class="mb-3">
                            <label class="form-label text-muted small">Full Name</label>
                            <input type="text" name="name" class="form-control form-control-dark"
                                   placeholder="e.g. John Doe" value="${name}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Email Address</label>
                            <input type="email" name="email" class="form-control form-control-dark"
                                   placeholder="name@example.com" value="${email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Mobile Phone</label>
                            <input type="tel" name="phone" class="form-control form-control-dark"
                                   placeholder="e.g. 9876543210" value="${phone}">
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Password</label>
                            <input type="password" name="password" class="form-control form-control-dark"
                                   placeholder="At least 6 characters" required minlength="6">
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-cinema">Sign Up & Start Booking</button>
                        </div>
                    </form>

                    <div class="mt-4 pt-3 border-top border-secondary text-center small text-muted">
                        Already have an account?
                        <a href="${pageContext.request.contextPath}/login" class="text-danger fw-semibold">Sign In</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
