<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="<c:url value='/admin'/>">Admin Panel</a>
            <div class="d-flex align-items-center">
                <span class="me-3 text-white">Welcome, ${username}</span>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/logout'/>">Logout</a>
            </div>
        </div>
    </nav>

    <main class="container my-4">
        <jsp:include page="/WEB-INF/views/${contentPage}.jsp"/>
    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
