<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="sr">
<head>
<meta charset="UTF-8">
<title>Izveštaj o transferima</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f8;
    margin: 30px;
}
form {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    width: 420px;
    margin: 0 auto;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
h2 {
    text-align: center;
    color: #333;
}
input {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}
button {
    width: 100%;
    padding: 10px;
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
.error {
    color: red;
    text-align: center;
    margin-bottom: 15px;
    font-weight: bold;
}
</style>
</head>
<body>

<h2 style="text-align:center;">Izveštaj o transferima po sezoni</h2>

<c:if test="${not empty errorMessage}">
    <div class="error">${errorMessage}</div>
</c:if>

<form action="/footmarket/transferController/report" method="get" target="_blank">
    <label for="season">Unesi sezonu (npr. 24/25):</label>
    <input type="text" name="season" id="season" required placeholder="npr. 25/26">
    <button type="submit">Prikaži izveštaj</button>
</form>

<%@ include file="/common/BackToHome.jspf"%>

</body>
</html>