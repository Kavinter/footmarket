<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pronađi igrača</title>
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
	color: red;
}
</style>
</head>
<body>
	<h2>Pronađi igrača za izmenu</h2>

	<form
		action="${pageContext.request.contextPath}/playerController/findForEdit"
		method="post">
		<label>Ime igrača:</label> <input type="text" name="name" required />

		<label>Pozicija:</label> <select name="position" required>
			<c:forEach var="p" items="${positions}">
				<option value="${p}">${p}</option>
			</c:forEach>
		</select> <label>Klub:</label> <select name="clubId" required>
			<c:forEach var="c" items="${clubs}">
				<option value="${c.id}">${c.name}</option>
			</c:forEach>
		</select>

		<button type="submit">Pronađi</button>
	</form>

	<p>${error}</p>

	<%@ include file="/common/BackToHome.jspf"%>
</body>
</html>
