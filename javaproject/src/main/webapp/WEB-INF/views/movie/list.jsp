<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movies Catalog – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4">
            <div>
                <h2 class="fw-bold text-white mb-1">
                    <c:choose>
                        <c:when test="${not empty searchQuery}">Search Results for "${searchQuery}"</c:when>
                        <c:otherwise>All Movies</c:otherwise>
                    </c:choose>
                </h2>
                <p class="text-muted small mb-0">Showing ${movies.size()} title(s) available in theatres</p>
            </div>
            <c:if test="${not empty searchQuery}">
                <a href="${pageContext.request.contextPath}/movies" class="btn btn-sm btn-outline-secondary mt-2 mt-md-0">Clear Search</a>
            </c:if>
        </div>

        <c:if test="${empty movies}">
            <div class="card card-cinema p-5 text-center my-4">
                <span class="fs-1">🎥</span>
                <h4 class="text-white mt-3">No Movies Found</h4>
                <p class="text-muted">Try searching with a different keyword or browse all available movies.</p>
                <div>
                    <a href="${pageContext.request.contextPath}/movies" class="btn btn-cinema btn-sm">View All Movies</a>
                </div>
            </div>
        </c:if>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
            <c:forEach var="m" items="${movies}">
                <div class="col">
                    <div class="card card-cinema h-100">
                        <img src="${m.posterUrl}" class="movie-poster" alt="${m.title}"
                             onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=60';">
                        <div class="card-body d-flex flex-column p-3">
                            <span class="badge bg-secondary mb-2 align-self-start">${m.genre}</span>
                            <h5 class="card-title text-white fw-bold mb-1">${m.title}</h5>
                            <p class="text-muted small mb-2">
                                <span>🗣️ ${m.language}</span> &bull; 
                                <span>⏱️ ${m.formattedDuration}</span>
                            </p>
                            <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                ${m.description}
                            </p>
                            <div class="mt-2">
                                <a href="${pageContext.request.contextPath}/movies?id=${m.id}" class="btn btn-cinema w-100">
                                    Showtimes & Seats
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
