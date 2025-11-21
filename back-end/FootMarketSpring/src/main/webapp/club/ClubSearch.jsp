<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pretraga klubova</title>
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
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-bottom: 20px;
}

input, button {
	padding: 8px;
	border-radius: 8px;
	border: 1px solid #ccc;
}

button {
	background-color: #1a73e8;
	color: white;
	border: none;
	cursor: pointer;
	transition: 0.2s;
}

button:hover {
	background-color: #155ec4;
}

table {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
	background: white;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

th {
	background-color: #1a73e8;
	color: white;
	padding: 10px;
}

td {
	padding: 8px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

tr:hover {
	background-color: #f1f1f1;
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
	<h2>Pretraga klubova</h2>
	<form action="/footmarket/clubController/club-search" method="get">
		<label for="country">Država:</label> <input type="text" id="country"
			name="country" value="${param.country}" /> <label for="foundedYear">Godina
			osnivanja:</label> <input type="number" id="foundedYear" name="foundedYear"
			value="${param.foundedYear}" />
		<button type="submit">Pretraži</button>
	</form>

	<c:if test="${isFallback}">
		<p style="color: red; text-align: center;">Nema klubova za zadati
			kriterijum, prikazuju se svi klubovi.</p>
	</c:if>

	<table>
		<thead>
			<tr>
				<th>Ime kluba</th>
				<th>Država</th>
				<th>Godina osnivanja</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="club" items="${clubs}">
				<tr>
					<td>${club.name}</td>
					<td>${club.country}</td>
					<td>${club.foundedYear}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@ include file="/common/BackToHome.jspf" %>
</body>
</html>
