<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${empty movies}">
    <c:redirect url="/home"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineBook – Movie Ticket Booking System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main>
    <!-- Hero Banner -->
    <section class="hero-banner text-center">
        <div class="container py-4">
            <span class="badge bg-danger mb-2 px-3 py-2 text-uppercase letter-spacing">Now Showing</span>
            <h1 class="display-4 fw-bold text-white mb-3">Immerse Yourself in the Cinema</h1>
            <p class="lead text-muted mx-auto" style="max-width: 650px;">
                Book tickets for the biggest blockbusters in Dolby Cinema and IMAX. Easy seat selection, instant confirmation.
            </p>
            <div class="mt-4">
                <a href="#now-showing" class="btn btn-cinema btn-lg me-2">Browse Movies</a>
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-lg">Create Account</a>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Notification Alert -->
    <div class="container mt-4">
        <c:if test="${param.msg eq 'registered'}">
            <div class="alert alert-success alert-dismissible fade show bg-success text-white" role="alert">
                Account created successfully! Welcome to CineBook.
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg eq 'logged_out'}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                You have been logged out safely. See you soon!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
    </div>

    <!-- Movies Grid Section -->
    <section class="container py-4" id="now-showing">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-white mb-0">Featured Movies</h2>
                <p class="text-muted small">Select a movie to check available showtimes and book seats</p>
            </div>
            <a href="${pageContext.request.contextPath}/movies" class="btn btn-sm btn-outline-cinema">View All</a>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <c:forEach var="m" items="${movies}">
                <div class="col">
                    <div class="card card-cinema h-100">
                        <img src="${m.posterUrl}" class="movie-poster" alt="${m.title}"
                             onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=60';">
                        <div class="card-body d-flex flex-column p-3">
                            <span class="badge bg-secondary mb-2 align-self-start">${m.genre}</span>
                            <h5 class="card-title text-white fw-bold mb-1">${m.title}</h5>
                            <p class="text-muted small mb-3">
                                <span>🗣️ ${m.language}</span> &bull; 
                                <span>⏱️ ${m.formattedDuration}</span>
                            </p>
                            <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                ${m.description}
                            </p>
                            <div class="mt-2">
                                <a href="${pageContext.request.contextPath}/movies?id=${m.id}" class="btn btn-cinema w-100">
                                    Book Tickets
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
