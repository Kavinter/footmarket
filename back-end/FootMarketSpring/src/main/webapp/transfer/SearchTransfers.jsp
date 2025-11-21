<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Pretraga transfera</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f8;
    margin: 30px;
}
.form-container {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    width: 90%;
    max-width: 800px;
    margin: 0 auto;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    text-align: center;
}
input, select {
    padding: 8px;
    margin: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
}
button {
    padding: 8px 20px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}
button:hover {
    background-color: #0056b3;
}
table {
    width: 90%;
    max-width: 900px;
    margin: 30px auto;
    border-collapse: collapse;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}
th, td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: center;
}
th {
    background-color: #007bff;
    color: white;
}
td {
    background-color: #fff;
}
.page-container {
    text-align: center;
}
</style>
</head>
<body>
    <div class="page-container">
        <h2>Pretraga transfera</h2>

        <div class="form-container">
            <form method="get" action="/footmarket/transferController/transfer-search">
                <input type="text" name="playerName" placeholder="Ime igrača" value="${playerName}" />
                <select name="clubId">
                    <option value="">-- Izaberi klub --</option>
                    <c:forEach var="club" items="${clubs}">
                        <option value="${club.id}" ${selectedClub == club.id ? 'selected' : ''}>${club.name}</option>
                    </c:forEach>
                </select>
                <input type="text" name="season" placeholder="npr. 24/25" value="${season}" />
                <button type="submit">Pretraži</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Igrač</th>
                    <th>Iz kluba</th>
                    <th>U klub</th>
                    <th>Cena (€)</th>
                    <th>Datum</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="t" items="${transfers}">
                    <tr>
                        <td>${t.player.name}</td>
                        <td>${t.fromClub.name}</td>
                        <td>${t.toClub.name}</td>
                        <td>${t.transferFee}</td>
                        <td><fmt:formatDate value="${t.transferDate}" pattern="dd.MM.yyyy" /></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty transfers}">
                    <tr>
                        <td colspan="5">Nema pronađenih transfera.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <%@ include file="/common/BackToHome.jspf" %>
    </div>
</body>
</html>
