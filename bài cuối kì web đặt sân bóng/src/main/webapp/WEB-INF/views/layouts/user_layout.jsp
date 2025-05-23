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
    <header class="bg-primary text-white py-3 px-4 d-flex justify-content-between align-items-center">
    <h2 class="mb-0">BongDaDemo</h2>
    <div class="d-flex align-items-center">
                <span class="me-3 text-white">Welcome, ${username}</span>
                <a class="btn btn-outline-light btn-sm" href="<c:url value='/logout'/>">Logout</a>
            </div>
</header>


    <main class="container my-4">
        <jsp:include page="/WEB-INF/views/${contentPage}.jsp"/>
    </main>

    <footer class="bg-light text-center py-3 mt-auto">
        <p class="mb-0">BongDaDemo © 2025</p>
    </footer>

    <!-- Bootstrap JS (tùy chọn nếu cần interactivity) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
