<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Movies – CineBook Admin</title>
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
                <h2 class="fw-bold text-white mb-0 mt-1">Manage Movies Catalog</h2>
            </div>
            <a href="${pageContext.request.contextPath}/admin?action=movie-form" class="btn btn-cinema">
                + Add New Movie
            </a>
        </div>

        <c:if test="${param.msg eq 'saved'}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                Movie saved successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${param.msg eq 'deleted'}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                Movie deleted from catalog.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card card-cinema p-3">
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle mb-0">
                    <thead>
                        <tr class="text-muted small">
                            <th>POSTER</th>
                            <th>TITLE</th>
                            <th>GENRE</th>
                            <th>LANGUAGE</th>
                            <th>DURATION</th>
                            <th>RELEASE DATE</th>
                            <th class="text-end">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${movies}">
                            <tr>
                                <td style="width: 70px;">
                                    <img src="${m.posterUrl}" class="rounded" style="width: 50px; height: 65px; object-fit: cover;"
                                         onerror="this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800&auto=format&fit=crop&q=60';">
                                </td>
                                <td>
                                    <div class="fw-bold text-white">${m.title}</div>
                                    <div class="small text-muted" style="max-width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                        ${m.description}
                                    </div>
                                </td>
                                <td><span class="badge bg-secondary">${m.genre}</span></td>
                                <td>${m.language}</td>
                                <td>${m.formattedDuration}</td>
                                <td>${m.releaseDate}</td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/admin?action=movie-form&id=${m.id}"
                                       class="btn btn-sm btn-outline-info me-1">Edit</a>
                                    <a href="${pageContext.request.contextPath}/admin?action=movie-delete&id=${m.id}"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Are you sure you want to delete this movie? Associated showtimes will also be removed.')">
                                        Delete
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty movies}">
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No movies available. Click "+ Add New Movie" to add one!</td>
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
