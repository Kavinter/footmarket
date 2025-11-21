<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dodaj igrača</title>
<style>
body {
	font-family: "Segoe UI", Arial, sans-serif;
	background-color: #eef2f8;
	margin: 0;
	padding: 0;
}

.container {
	width: 90%;
	max-width: 500px;
	margin: 50px auto;
	background: #fff;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #1a73e8;
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
}

button {
	margin-top: 20px;
	padding: 10px;
	background-color: #1a73e8;
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
}

button:hover {
	background-color: #155ec4;
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
		<h2>Dodaj novog igrača</h2>

		<form:form
			action="${pageContext.request.contextPath}/playerController/player-add"
			modelAttribute="playerDTO" method="post">
			<label for="name">Ime igrača:</label>
			<form:input path="name" id="name" />
			<form:errors path="name" cssClass="error" />

			<label for="age">Godine:</label>
			<form:input path="age" type="number" id="age" />
			<form:errors path="age" cssClass="error" />

			<label for="position">Pozicija:</label>
			<form:select path="position" id="position">
				<form:option value="">-- Izaberi poziciju --</form:option>
				<form:option value="GK">GK</form:option>
				<form:option value="DF">DF</form:option>
				<form:option value="MF">MF</form:option>
				<form:option value="FW">FW</form:option>
			</form:select>
			<form:errors path="position" cssClass="error" />

			<label for="clubId">Klub:</label>
			<form:select path="clubId" id="clubId">
				<form:option value="">-- Izaberi klub --</form:option>
				<form:options items="${clubs}" itemValue="id" itemLabel="name" />
			</form:select>
			<form:errors path="clubId" cssClass="error" />


			<label for="marketValue">Market Value (€):</label>
			<form:input path="marketValue" id="marketValue" type="number" />
			<form:errors path="marketValue" cssClass="error" />

			<button type="submit">Dodaj igrača</button>
		</form:form>

		<%@ include file="/common/BackToHome.jspf"%>
	</div>

</body>
</html>
