<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Obriši klub</title>
<style>
body {
	font-family: "Segoe UI", Arial, sans-serif;
	background: #f4f6f9;
	color: #333;
	margin: 0;
	padding: 0;
}

h2 {
	text-align: center;
	color: #1a73e8;
}

.container {
	width: 90%;
	max-width: 400px;
	margin: 40px auto;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

form {
	display: flex;
	flex-direction: column;
}

label {
	margin-top: 10px;
	font-weight: bold;
}

input {
	padding: 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	margin-top: 5px;
}

button {
	margin-top: 20px;
	padding: 10px;
	background-color: #e53935;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: 0.2s;
}

button:hover {
	background-color: #c62828;
}

a {
	color: #1a73e8;
	text-decoration: none;
	display: block;
	text-align: center;
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Obriši klub</h2>
		<form action="/footmarket/clubController/delete-club" method="post">
			<label for="name">Ime kluba:</label> <input type="text" id="name"
				name="name" required />
			<button type="submit">Obriši klub</button>
		</form>
		<c:if test="${not empty message}">
			<p style="color: green; text-align: center;">${message}</p>
		</c:if>
		<c:if test="${not empty error}">
			<p style="color: red; text-align: center;">${error}</p>
		</c:if>
		<%@ include file="/common/BackToHome.jspf" %>
	</div>
</body>
</html>
