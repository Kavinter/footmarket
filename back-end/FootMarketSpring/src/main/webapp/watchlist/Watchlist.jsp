<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
<title>My Watchlist</title>
<link rel="stylesheet" href="/css/style.css" />
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f8;
    margin: 30px;
}

h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
}

table {
    width: 90%;
    max-width: 900px;
    margin: 0 auto;
    border-collapse: collapse;
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

th, td {
    padding: 12px;
    text-align: center;
    border-bottom: 1px solid #ddd;
}

th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

td {
    background-color: #fff;
    color: #333;
}

tr:hover td {
    background-color: #f1f5fb;
}

button {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}

button:hover {
    background-color: #b02a37;
}

p {
    text-align: center;
    font-size: 16px;
    color: #555;
    margin-top: 40px;
}

.watchlist-container {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    width: 95%;
    max-width: 950px;
    margin: 0 auto;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
</style>
</head>
<body>

    <h2>My Player Watchlist</h2>

    <sec:authorize access="hasRole('ROLE_MANAGER')">
        <div class="watchlist-container">
            <c:if test="${not empty watchlist}">
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Position</th>
                        <th>Age</th>
                        <th>Club</th>
                        <th>Market Value (€)</th>
                        <th>Action</th>
                    </tr>

                    <c:forEach var="entry" items="${watchlist}">
                        <tr>
                            <td>${entry.player.name}</td>
                            <td>${entry.player.position}</td>
                            <td>${entry.player.age}</td>
                            <td>${entry.player.club.name}</td>
                            <td>${entry.player.marketValue}</td>
                            <td>
                                <form
                                    action="${pageContext.request.contextPath}/watchlistController/remove/${entry.player.id}"
                                    method="post">
                                    <button type="submit">Remove</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>

            <c:if test="${empty watchlist}">
                <p>Your watchlist is currently empty.</p>
            </c:if>
        </div>
    </sec:authorize>

    <sec:authorize access="!hasRole('ROLE_MANAGER')">
        <p>You must be logged in as a Manager to view your watchlist.</p>
    </sec:authorize>

    <%@ include file="/common/BackToHome.jspf" %>

</body>
</html>
