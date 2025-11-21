<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Moj omiljeni igrač</title>
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background-color: #f3f6fb;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #1a73e8;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th {
            background-color: #1a73e8;
            color: white;
            padding: 10px;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        button {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c62828;
        }
        p {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Moj omiljeni igrač</h2>

    <c:if test="${not empty message}">
        <p style="color:green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    <c:if test="${not empty info}">
        <p style="color:blue;">${info}</p>
    </c:if>

    <sec:authorize access="hasRole('ROLE_MANAGER')">
        <c:choose>
            <c:when test="${not empty favorite}">
                <table>
                    <tr>
                        <th>Ime</th>
                        <th>Pozicija</th>
                        <th>Godine</th>
                        <th>Klub</th>
                        <th>Market Value (€)</th>
                        <th>Akcija</th>
                    </tr>
                    <tr>
                        <td>${favorite.player.name}</td>
                        <td>${favorite.player.position}</td>
                        <td>${favorite.player.age}</td>
                        <td>${favorite.player.club.name}</td>
                        <td>${favorite.player.marketValue}</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/favoritePlayerController/remove/${favorite.player.id}" method="post">
                                <button type="submit">Ukloni</button>
                            </form>
                        </td>
                    </tr>
                </table>
            </c:when>
            <c:otherwise>
                <p>Trenutno nemate izabranog omiljenog igrača.</p>
            </c:otherwise>
        </c:choose>
    </sec:authorize>

    <sec:authorize access="!hasRole('ROLE_MANAGER')">
        <p>Morate biti prijavljeni kao menadžer da biste videli svog omiljenog igrača.</p>
    </sec:authorize>

    <%@ include file="/common/BackToHome.jspf" %>
</div>

</body>
</html>
