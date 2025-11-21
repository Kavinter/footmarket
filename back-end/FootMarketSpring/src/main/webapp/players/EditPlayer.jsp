<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Izmena igrača</title>
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
	width: 400px;
	margin: 0 auto;
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	gap: 10px;
}

input, select, button {
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

p {
	text-align: center;
}
</style>
</head>
<body>
	<h2>Izmeni igrača</h2>

	<form action="${pageContext.request.contextPath}/playerController/edit" method="post">
		<input type="hidden" name="id" value="${player.id}" />

		<label>Ime:</label>
		<input type="text" name="name" value="${player.name}" required />

		<label>Pozicija:</label>
		<select name="position">
			<c:forEach var="p" items="${positions}">
				<option value="${p}" ${p == player.position ? 'selected' : ''}>${p}</option>
			</c:forEach>
		</select>

		<sec:authorize access="hasRole('ADMIN')">
			<label>Klub:</label>
			<select name="club.id">
				<c:forEach var="c" items="${clubs}">
					<option value="${c.id}" ${c.id == player.club.id ? 'selected' : ''}>${c.name}</option>
				</c:forEach>
			</select>

			<label>Godine:</label>
			<input type="number" min="15" max="50" name="age" value="${player.age}" />

			<label>Market Value:</label>
			<input type="number" step="0.01" name="marketValue" value="${player.marketValue}" />
		</sec:authorize>

		<button type="submit">Sačuvaj izmene</button>
	</form>

	<p style="color: green;">${message}</p>
	<p style="color: red;">${error}</p>
	
	<%@ include file="/common/BackToHome.jspf" %>
</body>
</html>
