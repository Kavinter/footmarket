<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Prijava - FootMarket</title>
<style>
body {
	font-family: "Segoe UI", Arial, sans-serif;
	background-color: #f4f6f9;
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
	max-width: 500px;
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
	font-size: 14px;
}

button {
	margin-top: 20px;
	padding: 10px;
	background-color: #1a73e8;
	color: white;
	font-weight: bold;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: 0.2s;
}

button:hover {
	background-color: #155ec4;
}

a {
	color: #1a73e8;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.error {
	color: red;
	font-size: 0.9em;
	margin-top: 4px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Prijava korisnika</h2>
		<form action="${pageContext.request.contextPath}/login" method="post">
			<label for="username">Korisničko ime:</label> <input type="text"
				id="username" name="username" /> <label for="password">Lozinka:</label>
			<input type="password" id="password" name="password" />

			<button type="submit">Prijavi se</button>
		</form>
		<c:if test="${not empty param.error}">
			<p class="error">${param.error}</p>
		</c:if>
		<p style="text-align: center; margin-top: 15px;">
			<a href="${pageContext.request.contextPath}/">Nazad na početnu</a>
		</p>
	</div>
</body>
</html>
