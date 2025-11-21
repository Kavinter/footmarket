<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pretraga igrača</title>
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
	flex-wrap: wrap;
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

table {
	width: 90%;
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

.msg, .err, .info {
	text-align: center;
	font-weight: bold;
}

.msg { color: green; }
.err { color: red; }
.info { color: blue; }

.favorite-btn {
	background-color: #f8d7da;
	color: #a30000;
	border: 1px solid #a30000;
	padding: 4px 8px;
	border-radius: 4px;
	cursor: pointer;
}

.favorite-btn:hover {
	background-color: #ffcccc;
}
</style>
</head>
<body>

	<h2>Pretraga igrača</h2>

	<c:if test="${not empty message}">
		<p class="msg">${message}</p>
	</c:if>
	<c:if test="${not empty error}">
		<p class="err">${error}</p>
	</c:if>
	<c:if test="${not empty info}">
		<p class="info">${info}</p>
	</c:if>

	<form action="${pageContext.request.contextPath}/playerController/player-search" method="get">
		<label for="name">Ime igrača:</label>
		<input type="text" id="name" name="name" value="${param.name}" />

		<label for="club">Ime kluba:</label>
		<input type="text" id="club" name="club" value="${param.club}" />

		<label for="position">Pozicija:</label>
		<select id="position" name="position">
			<option value="">-- Sve pozicije --</option>
			<option value="GK" <c:if test="${param.position == 'GK'}">selected</c:if>>GK</option>
			<option value="DF" <c:if test="${param.position == 'DF'}">selected</c:if>>DF</option>
			<option value="MF" <c:if test="${param.position == 'MF'}">selected</c:if>>MF</option>
			<option value="FW" <c:if test="${param.position == 'FW'}">selected</c:if>>FW</option>
		</select>

		<button type="submit">Pretraži</button>
	</form>

	<c:if test="${isFallback}">
		<p class="err">Nema igrača za zadati kriterijum, prikazuju se svi igrači.</p>
	</c:if>

	<table>
		<thead>
			<tr>
				<th>Ime</th>
				<th>Godine</th>
				<th>Pozicija</th>
				<th>Klub</th>
				<th>Market Value</th>
				<th>Akcije</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="player" items="${players}">
				<tr>
					<td>${player.name}</td>
					<td>${player.age}</td>
					<td>${player.position}</td>
					<td>${player.club.name}</td>
					<td>${player.marketValue}€</td>
					<td>
						<sec:authorize access="hasRole('MANAGER')">
							<c:if test="${not (player.club.name == 'Slobodan Igrac' || player.club.name == 'Penzionisan')}">
								<form action="${pageContext.request.contextPath}/watchlistController/add" method="post" style="display: inline;">
									<input type="hidden" name="playerId" value="${player.id}" />
									<button type="submit">Add to Watchlist</button>
								</form>
							</c:if>

							<form action="${pageContext.request.contextPath}/favoritePlayerController/add" method="post" style="display: inline;">
								<input type="hidden" name="playerId" value="${player.id}" />
								<button type="submit" class="favorite-btn">Favorite</button>
							</form>
						</sec:authorize>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<%@ include file="/common/BackToHome.jspf"%>
</body>
</html>
