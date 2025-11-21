<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="sr">
<head>
<meta charset="UTF-8">
<title>Obriši Transfer</title>
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
select, input {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}
button {
    width: 100%;
    padding: 10px;
    background: #dc3545;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}
button:hover {
    background-color: #b02a37;
}
.success {
    color: green;
    text-align: center;
    margin-bottom: 15px;
}
.error {
    color: red;
    text-align: center;
    margin-bottom: 15px;
}
</style>
</head>
<body>

	<h2>Obriši Transfer</h2>

	<c:if test="${not empty successMessage}">
		<div class="success">${successMessage}</div>
	</c:if>
	<c:if test="${not empty errorMessage}">
		<div class="error">${errorMessage}</div>
	</c:if>

	<form method="post" action="/footmarket/transferController/delete">
		<label>Ime igrača:</label>
		<input type="text" name="playerName" placeholder="Unesi ime igrača" required />

		<label>Datum transfera:</label>
		<input type="date" name="transferDate" required />

		<button type="submit">Obriši Transfer</button>
	</form>

	<%@ include file="/common/BackToHome.jspf"%>

</body>
</html>
