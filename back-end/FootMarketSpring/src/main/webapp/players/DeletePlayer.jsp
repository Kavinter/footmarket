<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Obriši igrača</title>
<style>
body {
	font-family: "Segoe UI", Arial, sans-serif;
	background: #f4f6f9;
	color: #333;
	margin: 0;
	padding: 20px;
}

h2 {
	text-align: center;
	color: #1a73e8;
}

form {
	width: 350px;
	margin: 0 auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	gap: 10px;
}

input, button {
	padding: 8px;
	border-radius: 8px;
	border: 1px solid #ccc;
}

button {
	background-color: #e53935;
	color: white;
	border: none;
	cursor: pointer;
	transition: 0.2s;
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
	<h2>Obriši igrača</h2>

	<form action="/footmarket/playerController/delete-player" method="post">
		<label for="name">Ime i prezime igrača:</label>
		<input type="text" id="name" name="name" required />

		<label for="clubName">Klub:</label>
		<input type="text" id="clubName" name="clubName" required />

		<button type="submit">Obriši igrača</button>
	</form>

	<c:if test="${not empty message}">
		<p style="color:green;">${message}</p>
	</c:if>

	<c:if test="${not empty error}">
		<p style="color:red;">${error}</p>
	</c:if>

	<%@ include file="/common/BackToHome.jspf" %>
</body>
</html>
