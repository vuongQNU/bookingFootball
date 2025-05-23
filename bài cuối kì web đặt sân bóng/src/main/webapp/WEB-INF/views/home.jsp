<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>Welcome to BongDaDemo</h2>
<p>Hello, ${username}! You have successfully logged in.</p>
<p>Explore the application or <a href="<c:url value='/logout'/>">logout</a>.</p>