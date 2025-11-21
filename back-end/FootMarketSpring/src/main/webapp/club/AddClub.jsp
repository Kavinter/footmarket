<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dodaj klub</title>
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
}

button {
	margin-top: 20px;
	padding: 10px;
	background-color: #1a73e8;
	color: white;
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

.error {
    color: red;
    font-size: 0.9em;
    margin-top: 4px;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Dodaj novi klub</h2>
		<form:form modelAttribute="clubDTO"
			action="${pageContext.request.contextPath}/clubController/add-club"
			method="post">
			<label for="name">Ime kluba:</label>
			<form:input path="name" id="name" />
			<form:errors path="name" cssClass="error" />

			<label for="country">Zemlja:</label>
			<form:input path="country" id="country" />
			<form:errors path="country" cssClass="error" />

			<label for="foundedYear">Godina osnivanja:</label>
			<form:input path="foundedYear" id="foundedYear" type="number" />
			<form:errors path="foundedYear" cssClass="error" />

			<button type="submit">Dodaj klub</button>
		</form:form>
		<p style="text-align: center; margin-top: 15px;">
			<a href="/footmarket/clubController/all-clubs">Nazad na listu
				klubova</a>
		</p>
	</div>
</body>
</html>
