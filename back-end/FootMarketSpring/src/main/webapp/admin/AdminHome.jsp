<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Administrator - FootMarket</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #F1F5F9;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #1E3A8A;
            color: white;
            padding: 15px 30px;
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
        }

        h2 {
            text-align: center;
            margin: 30px 0 20px;
            color: #1E3A8A;
        }

        ul {
            list-style-type: none;
            padding: 0;
            max-width: 400px;
            margin: 0 auto;
        }

        li {
            margin: 10px 0;
        }

        a {
            display: block;
            background-color: #2563EB;
            color: white;
            text-decoration: none;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        a:hover {
            background-color: #1E40AF;
        }

        footer {
            text-align: center;
            margin-top: 40px;
            color: #64748B;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <header>FootMarket - Administratorski panel</header>

    <h2>Dobrodošli, <sec:authentication property="name" />!</h2>

    <ul>
        <li><a href="${pageContext.request.contextPath}/clubController/add-club">Dodaj klub</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/player-add">Dodaj igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/clubController/club-search">Pregled klubova</a></li>
        <li><a href="${pageContext.request.contextPath}/clubController/delete-club">Obriši klub</a></li>
        <li><a href="${pageContext.request.contextPath}/clubController/edit-club">Izmeni klub</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/player-search">Pregled igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/delete-player">Obriši igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/edit-search">Izmeni igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/transferController/transfer-search">Pregled transfera</a></li>
        <li><a href="${pageContext.request.contextPath}/transferController/new">Dodaj transfer</a></li>
        <li><a href="${pageContext.request.contextPath}/transferController/delete">Obriši transfer</a></li>
        <li><a href="${pageContext.request.contextPath}/transferController/report-form">Izveštaj transfera</a></li>
        <li><a href="${pageContext.request.contextPath}/userController/logout">Odjava</a></li>
    </ul>

    <footer>© 2025 FootMarket</footer>
</body>
</html>
