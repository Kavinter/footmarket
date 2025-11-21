<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registracija - FootMarket</title>
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

input, select {
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
		<h2>Registracija korisnika</h2>
		<form:form
			action="${pageContext.request.contextPath}/userController/register"
			modelAttribute="userDTO" method="post">
			<label for="username">Korisničko ime:</label>
			<form:input path="username" id="username" />
			<form:errors path="username" cssClass="error" />

			<label for="email">Email:</label>
			<form:input path="email" id="email" />
			<form:errors path="email" cssClass="error" />

			<label for="password">Lozinka:</label>
			<form:password path="password" id="password" />
			<form:errors path="password" cssClass="error" />

			<label for="roleId">Uloga:</label>
			<form:select path="roleId" id="roleId">
				<form:option value="">-- Izaberi ulogu --</form:option>
				<form:options items="${roles}" itemValue="id" itemLabel="name" />
			</form:select>
			<form:errors path="roleId" cssClass="error" />

			<button type="submit">Registruj se</button>
		</form:form>
		<p style="color: red;">${error}</p>
		<p style="color: green;">${message}</p>
		<p style="text-align: center;">
			<a href="${pageContext.request.contextPath}/">Nazad na početnu</a>
		</p>
	</div>
</body>
</html>
