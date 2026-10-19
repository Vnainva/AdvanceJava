<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/common/navbar.jsp"/>

<main class="d-flex align-items-center py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-5 col-lg-4">
                <div class="card card-cinema p-4 shadow">
                    <div class="text-center mb-4">
                        <span class="fs-1">🍿</span>
                        <h3 class="fw-bold text-white mt-2">Welcome Back</h3>
                        <p class="text-muted small">Sign in to your CineBook account</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger py-2 small" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${param.error eq 'admin_required'}">
                        <div class="alert alert-warning py-2 small" role="alert">
                            Admin access required. Please log in with administrator credentials.
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/auth" method="POST">
                        <input type="hidden" name="action" value="login">
                        <input type="hidden" name="redirect" value="${not empty redirect ? redirect : param.redirect}">

                        <div class="mb-3">
                            <label class="form-label text-muted small">Email Address</label>
                            <input type="email" name="email" class="form-control form-control-dark"
                                   placeholder="name@example.com" value="${email}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-muted small">Password</label>
                            <input type="password" name="password" class="form-control form-control-dark"
                                   placeholder="Enter password" required>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-cinema">Sign In</button>
                        </div>
                    </form>

                    <div class="mt-4 pt-3 border-top border-secondary text-center small text-muted">
                        Don't have an account?
                        <a href="${pageContext.request.contextPath}/register" class="text-danger fw-semibold">Sign Up</a>
                    </div>

                    <div class="mt-3 p-2 bg-dark rounded small text-muted">
                        <div class="fw-bold text-white mb-1">Quick Demo Logins:</div>
                        <div>Customer: <code class="text-info">john@example.com / password123</code></div>
                        <div>Admin: <code class="text-warning">admin@cinebook.com / admin123</code></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>
