<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-dark navbar-cinebook sticky-top">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <span class="fs-4 me-2">🎬</span>
            <span>CINE<span class="brand-red">BOOK</span></span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain"
                aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/movies">Movies</a>
                </li>
                <c:if test="${not empty sessionScope.user and not sessionScope.user.admin}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/booking?action=history">My Bookings</a>
                    </li>
                </c:if>
                <c:if test="${not empty sessionScope.user and sessionScope.user.admin}">
                    <li class="nav-item">
                        <a class="nav-link text-warning font-weight-bold" href="${pageContext.request.contextPath}/admin?action=dashboard">
                            🛡️ Admin Panel
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- Search Form -->
            <form class="d-flex me-3" action="${pageContext.request.contextPath}/movies" method="GET">
                <div class="input-group input-group-sm">
                    <input class="form-control form-control-dark" type="search" name="q" placeholder="Search movies, genre..." aria-label="Search" value="${param.q}">
                    <button class="btn btn-outline-secondary" type="submit">🔍</button>
                </div>
            </form>

            <!-- User Auth Links -->
            <ul class="navbar-nav mb-2 mb-lg-0 align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white d-flex align-items-center" href="#" id="userDrop" role="button" data-bs-toggle="dropdown">
                                <span class="badge bg-secondary me-2">${sessionScope.user.role}</span>
                                <span>${sessionScope.user.name}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end" aria-labelledby="userDrop">
                                <c:if test="${sessionScope.user.admin}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=dashboard">Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=movies">Manage Movies</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=showtimes">Manage Showtimes</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin?action=bookings">All Bookings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <c:if test="${not sessionScope.user.admin}">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking?action=history">My Bookings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-2">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-cinema btn-sm" href="${pageContext.request.contextPath}/register">Register</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
