<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty movie ? 'Add Movie' : 'Edit Movie'} – CineBook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card card-cinema p-4 shadow">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <a href="${pageContext.request.contextPath}/admin?action=movies" class="text-muted small">&larr; Back to Movies</a>
                            <h3 class="fw-bold text-white mb-0 mt-1">${empty movie ? 'Add New Movie' : 'Edit Movie Details'}</h3>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin" method="POST">
                        <input type="hidden" name="action" value="movie-save">
                        <c:if test="${not empty movie}">
                            <input type="hidden" name="id" value="${movie.id}">
                        </c:if>

                        <div class="row g-3">
                            <div class="col-md-8">
                                <label class="form-label text-muted small">Movie Title</label>
                                <input type="text" name="title" class="form-control form-control-dark"
                                       placeholder="e.g. Dune: Part Two" value="${movie.title}" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label text-muted small">Language</label>
                                <input type="text" name="language" class="form-control form-control-dark"
                                       placeholder="e.g. English, Hindi" value="${not empty movie ? movie.language : 'English'}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label text-muted small">Genre</label>
                                <input type="text" name="genre" class="form-control form-control-dark"
                                       placeholder="e.g. Action / Sci-Fi" value="${movie.genre}" required>
                            </div>

                            <div class="col-md-3">
                                <label class="form-label text-muted small">Duration (Minutes)</label>
                                <input type="number" name="durationMins" class="form-control form-control-dark"
                                       placeholder="120" value="${not empty movie ? movie.durationMins : 120}" required min="30">
                            </div>

                            <div class="col-md-3">
                                <label class="form-label text-muted small">Release Date</label>
                                <input type="date" name="releaseDate" class="form-control form-control-dark"
                                       value="${movie.releaseDate}" required>
                            </div>

                            <div class="col-12">
                                <label class="form-label text-muted small">Poster Image URL</label>
                                <input type="url" name="posterUrl" class="form-control form-control-dark"
                                       placeholder="https://..." value="${movie.posterUrl}">
                                <div class="form-text text-muted small">Direct image link (Unsplash, IMDb, or web URL)</div>
                            </div>

                            <div class="col-12">
                                <label class="form-label text-muted small">Synopsis / Description</label>
                                <textarea name="description" class="form-control form-control-dark" rows="4"
                                          placeholder="Movie summary..." required>${movie.description}</textarea>
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2 mt-4 pt-3 border-top border-secondary">
                            <a href="${pageContext.request.contextPath}/admin?action=movies" class="btn btn-outline-secondary">Cancel</a>
                            <button type="submit" class="btn btn-cinema px-4">Save Movie</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
