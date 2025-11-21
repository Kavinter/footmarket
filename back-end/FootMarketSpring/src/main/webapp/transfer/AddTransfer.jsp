<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="sr">
<head>
<meta charset="UTF-8">
<title>Dodaj Transfer</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f8;
    margin: 30px;
}
form {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    width: 420px;
    margin: 0 auto;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
h2 {
    text-align: center;
    color: #333;
}
input, select {
    width: 100%;
    padding: 8px;
    margin: 10px 0;
    border: 1px solid #ccc;
    border-radius: 5px;
}
button {
    width: 100%;
    padding: 10px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
}
button:hover {
    background-color: #0056b3;
}
.error {
    color: red;
    font-size: 14px;
}
.success {
    color: green;
    text-align: center;
    margin-bottom: 15px;
}
#fromClubContainer {
    display: none;
}
</style>

</head>
<body>
	<h2>Dodaj Novi Transfer</h2>

	<c:if test="${not empty successMessage}">
		<div class="success">${successMessage}</div>
	</c:if>

	<form:form modelAttribute="transferDTO" method="post"
		action="/footmarket/transferController/new">

		<label>Igrač:</label>
		<form:input path="playerName" placeholder="Ime igrača" />
		<form:errors path="playerName" cssClass="error" />

		<div id="fromClubContainer">
			<label>Izlazni klub:</label>
			<form:select path="fromClubName">
				<form:option value="" label="-- Izaberi klub --" />
				<c:forEach var="club" items="${clubs}">
					<form:option value="${club.name}" label="${club.name}" />
				</c:forEach>
			</form:select>
			<form:errors path="fromClubName" cssClass="error" />
		</div>

		<label>Klub (u koji prelazi):</label>
		<form:select path="toClubName">
			<form:option value="" label="-- Izaberi klub --" />
			<c:forEach var="club" items="${clubs}">
				<form:option value="${club.name}" label="${club.name}" />
			</c:forEach>
		</form:select>
		<form:errors path="toClubName" cssClass="error" />

		<label>Cena transfera (€):</label>
		<form:input path="transferFee" type="number" step="0.01" />
		<form:errors path="transferFee" cssClass="error" />

		<label>Datum transfera:</label>
		<form:input path="transferDate" type="date" id="transferDate" />
		<form:errors path="transferDate" cssClass="error" />

		<label>Sezona (npr. 24/25):</label>
		<form:input path="season" placeholder="24/25" />
		<form:errors path="season" cssClass="error" />

		<button type="submit">Sačuvaj Transfer</button>
	</form:form>

	<%@ include file="/common/BackToHome.jspf"%>

	<script>
    document.addEventListener('DOMContentLoaded', () => {
        const dateInput = document.getElementById('transferDate');
        const fromClubContainer = document.getElementById('fromClubContainer');

        function toggleFromClub() {
            const selectedDate = new Date(dateInput.value);
            const today = new Date();
            today.setHours(0,0,0,0); // uklanjamo vreme radi poređenja

            if (dateInput.value && selectedDate < today) {
                fromClubContainer.style.display = 'block';
            } else {
                fromClubContainer.style.display = 'none';
                const select = fromClubContainer.querySelector('select');
                if (select) select.value = '';
            }
        }

        dateInput.addEventListener('change', toggleFromClub);
        toggleFromClub();
    });
    </script>

</body>
</html>
