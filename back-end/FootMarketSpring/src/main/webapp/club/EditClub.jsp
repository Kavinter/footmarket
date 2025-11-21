<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Izmena kluba</title>
<style>
body {
	font-family: "Segoe UI", Arial, sans-serif;
	background-color: #f5f6fa;
	margin: 0;
	padding: 0;
}

.container {
	width: 90%;
	max-width: 500px;
	margin: 50px auto;
	background: #fff;
	padding: 25px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	color: #1a73e8;
}

label {
	display: block;
	margin-top: 10px;
	font-weight: bold;
}

input {
	width: 100%;
	padding: 8px;
	margin-top: 5px;
	border-radius: 8px;
	border: 1px solid #ccc;
}

.error {
	color: red;
	font-size: 0.9em;
	margin-top: 4px;
}

button {
	margin-top: 20px;
	width: 100%;
	padding: 10px;
	background-color: #1a73e8;
	border: none;
	border-radius: 8px;
	color: white;
	cursor: pointer;
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

	<div class="container">
		<h2>Izmena kluba</h2>

		<form:form modelAttribute="clubDTO"
			action="${pageContext.request.contextPath}/clubController/edit"
			method="post">
			<form:hidden path="id" />

			<label>Ime:</label>
			<form:input path="name" id="name" />
			<form:errors path="name" cssClass="error" />

			<label>Država:</label>
			<form:input path="country" id="country" />
			<form:errors path="country" cssClass="error" />

			<label>Godina osnivanja:</label>
			<form:input path="foundedYear" id="foundedYear" type="number" />
			<form:errors path="foundedYear" cssClass="error" />

			<button type="submit">Sačuvaj izmene</button>
		</form:form>

		<p style="color: green;">${message}</p>
		<p style="color: red;">${error}</p>

		<%@ include file="/common/BackToHome.jspf"%>
	</div>

</body>
</html>
