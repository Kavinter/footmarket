<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menadžer - FootMarket</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #F9FAFB;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #2563EB;
            color: white;
            padding: 15px 30px;
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
        }

        h2 {
            text-align: center;
            margin: 30px 0 20px;
            color: #2563EB;
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
            background-color: #3B82F6;
            color: white;
            text-decoration: none;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        a:hover {
            background-color: #1D4ED8;
            transform: translateY(-2px);
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
    <header>FootMarket - Menadžerski panel</header>

    <h2>Dobrodošli, <sec:authentication property="name" />!</h2>

    <ul>
        <li><a href="${pageContext.request.contextPath}/playerController/player-add">Dodaj igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/player-search">Pregled igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/playerController/edit-search">Izmeni igrača</a></li>
        <li><a href="${pageContext.request.contextPath}/watchlistController/my-watchlist">Moja Watchlista</a></li>
        <li><a href="${pageContext.request.contextPath}/favoritePlayerController/my-favorite">Moj Omiljeni Igrač</a></li>
        <li><a href="${pageContext.request.contextPath}/clubController/club-search" class="button">Pregled klubova</a></li>
        <li><a href="${pageContext.request.contextPath}/transferController/transfer-search">Pregled transfera</a></li>
        <li><a href="${pageContext.request.contextPath}/userController/logout">Odjava</a></li>
    </ul>

    <footer>© 2025 FootMarket</footer>
</body>
</html>
